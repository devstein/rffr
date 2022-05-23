CREATE TABLE profile (
    user_id UUID REFERENCES auth.users(id) NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    linkedin_url TEXT NOT NULL,
    survey_response JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),

    PRIMARY KEY (user_id)
);

alter table profile enable row level security;

create policy "Users can view their own profile"
  on profile for select
  using ( auth.uid() = user_id );

create policy "Users can insert their own profile."
  on profile for insert
  with check ( auth.uid() = user_id );

create policy "Users can update own profile."
  on profile for update
  using ( auth.uid() = user_id );

CREATE TABLE company (
    company_id UUID NOT NULL DEFAULT UUID_GENERATE_V4(),
    company_name TEXT NOT NULL,
    email TEXT,
    website TEXT,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),

    PRIMARY KEY (company_id)
);

CREATE TABLE job (
    job_id UUID NOT NULL DEFAULT UUID_GENERATE_V4(),
    company_id UUID REFERENCES company(company_id) NOT NULL,
    title TEXT NOT NULL,
    reward INTEGER NOT NULL,
    job_description_url TEXT NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),

    PRIMARY KEY (job_id),
    CONSTRAINT job_reward_positive CHECK (reward > 0)
);

CREATE TABLE job_location (
    job_id UUID REFERENCES job(job_id) NOT NULL,
    location_name TEXT NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),

    PRIMARY KEY (job_id, location_name)
);

-- requires_profile
-- requires_candidate_decision
-- candidate_accepted
-- candidate_rejected (FINAL)
-- company_accepted (FINAL)
-- company_rejected (FINAL)

CREATE TABLE referral_status (
    referral_status_id SMALLSERIAL NOT NULL,
    referral_status_name TEXT NOT NULL,

    PRIMARY KEY (referral_status_id)
);

CREATE TABLE referral (
    referral_id UUID NOT NULL DEFAULT UUID_GENERATE_V4(),
    referrer_id UUID REFERENCES profile(user_id) NOT NULL,
    candidate_email TEXT NOT NULL,
    candidate_id UUID REFERENCES profile(user_id),
    job_id UUID REFERENCES job(job_id) NOT NULL,
    referral_status_id SMALLINT REFERENCES referral_status(referral_status_id),
    survey_response JSONB,

    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),

    PRIMARY KEY(referral_id),
    -- only allow one referral per job
    UNIQUE (job_id, candidate_email)
);

alter table referral enable row level security;

-- referrers, candidate, and companies should be able to view their own referrals
-- don't worry about companies for now (need to relate user to companies to do this)
create policy "Referrers and candidates can view their own referrals."
  on referral for select
  using ( auth.uid() = referrer_id or auth.id() = candidate_id );

create policy "Referrers can insert their own referral but not themselves"
  on referral for insert
  with check ( auth.uid() = referrer_id  and auth.email() != candidate_email );

-- user's CANNOT update their referral

create function public.handle_new_referral() 
returns trigger 
language plpgsql 
security definer set search_path = public
as $$
begin
    with profiles_emails as (
        select 
            user_id,
            email 
        from profile
        inner join auth.users 
        on auth.users.id = profile.user_id
    )
    update referral 
    set 
        (candidate_id, referral_status_id) = (
            -- only set candidate_id if profile is setup
            select 
                profiles_emails.user_id,
                CASE
                    WHEN profiles_emails.user_id IS NULL THEN 1
                    ELSE 2
                END
            from referral
            left join profiles_emails
            on profiles_emails.email = referral.candidate_email
            where referral_id = new.referral_id
        )
    where referral_id = new.referral_id;
    return new;
end;
$$;

-- trigger the function every time a new referral is created
create trigger on_new_referral
  after insert on public.referral
  for each row execute procedure public.handle_new_referral();

-- on insert to profile, look to update referrals
create function public.update_referral_on_new_profile() 
returns trigger 
language plpgsql 
security definer set search_path = public
as $$
begin
    update referral 
    set 
        candidate_id = new.user_id,
        referral_status_id = 2
    from auth.users
    where auth.users.id = new.user_id 
    and referral.candidate_email = auth.users.email
    and auth.users.id  = new.user_id;
    return new;
end;
$$;

-- trigger the function every time a new profile is created
create trigger on_new_profile
  after insert on public.profile
  for each row execute procedure public.update_referral_on_new_profile();


-- Add updated_at triggers
create extension if not exists moddatetime schema extensions;

create trigger handle_updated_at_profile before update on profile
  for each row execute procedure moddatetime (updated_at);

create trigger handle_updated_at_company before update on company
  for each row execute procedure moddatetime (updated_at);

create trigger handle_updated_at_job before update on job
  for each row execute procedure moddatetime (updated_at);

create trigger handle_updated_at_job before update on job_location
  for each row execute procedure moddatetime (updated_at);

create trigger handle_updated_at_referral before update on referral
  for each row execute procedure moddatetime (updated_at);


-- enable realtime

alter publication supabase_realtime add table profiles;
alter publication supabase_realtime add table company;
alter publication supabase_realtime add table job;
alter publication supabase_realtime add table job_location;


-- create job board view

create view job_board as
  with
  jobs as (
    select
      job_id,
      title,
      reward,
      company_name 
    from job
    inner join company using (company_id)
  ),
  locations as (
    select 
      job_id,
      array_agg(location_name) as locations 
      from job 
      left join job_location using (job_id) 
      group by job_id
  )
  select
      job_id,
      title,
      reward,
      company_name,
      locations.locations
  from jobs
  left join locations using (job_id)
  order by reward desc;
