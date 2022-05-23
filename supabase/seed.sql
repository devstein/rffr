-- 1. check if email has an account
-- 2. set initial status and send email
-- 3. on account creation, check for referrals with email and update accordingly
-- 4. on account creation, send email to cadidate
-- 5. MVP have candidate respond to email and manually update email
-- 6. MVP email company and wait for response, update accordingly
-- 7. Connect <>
-- 8. Track candiate

-- create referral statuses
INSERT INTO referral_status (referral_status_name) VALUES 
    ('requires_profile'),
    ('requires_candidate_decision'),
    ('candidate_accepted'),
    ('candidate_rejected'),
    ('requires_company_decision'),
    ('company_accepted'),
    ('company_rejected')
;

-- insert companies and jobs
insert into public.company (
    company_name,
    email,
    website
) values
('Supabase', 'rffr@mailinator.com', 'https://supabase.com/'),
('Formfunction', 'rffr@mailinator.com', 'https://formfunction.xyz/'),
('Pogo', 'rffr@mailinator.com', 'https://app.joinpogo.com/'),
('Viaduct', 'rffr@mailinator.com', 'https://viaduct.ai/'),
('Gravity', 'rffr@mailinator.com', NULL);

insert into public.job (
    company_id,
    title,
    reward,
    job_description_url
) values
(
    (select company_id from public.company where company_name = 'Supabase'),
    'Ex-Founders',
    7500,
    'https://boards.greenhouse.io/supabase/jobs/4253732004'
),
(
    (select company_id from public.company where company_name = 'Formfunction'),
    'Founding Engineer (Full Stack)',
    5000,
    'https://formfunction.notion.site/Founding-Engineer-Full-Stack-2c8c87d6b18b435ab2022b367a1a36f8'
),
(
    (select company_id from public.company where company_name = 'Formfunction'),
    'Founding Engineer (Mobile)',
    5000,
    'https://formfunction.notion.site/Founding-Engineer-Mobile-120b5eeb732445b29b29341213581ab4'
),
(
    (select company_id from public.company where company_name = 'Pogo'),
    'Software Engineer',
    4000,
    'https://app.otta.com/companies/Pogo'
),
(
    (select company_id from public.company where company_name = 'Viaduct'),
    'Head of Design',
    7500,
    'https://www.viaduct.ai/careers'
),
(
    (select company_id from public.company where company_name = 'Gravity'),
    'Full Stack Engineer',
    8000,
    'https://climategravity.com/careers'
);

-- TODO: Join on company
insert into public.job_location (
    job_id,
    location_name
) values
(
    (select job_id from public.job where title = 'Ex-Founders'),
    'Remote'
),
(
    (select job_id from public.job where title = 'Founding Engineer (Full Stack)'),
    'Remote'
),
(
    (select job_id from public.job where title = 'Founding Engineer (Full Stack)'),
    'San Francisco'
),
(
    (select job_id from public.job where title = 'Founding Engineer (Mobile)'),
    'Remote'
),
(
    (select job_id from public.job where title = 'Founding Engineer (Mobile)'),
    'San Francisco'
),
(
    (select job_id from public.job where title = 'Software Engineer'),
    'Brooklyn'
),
(
    (select job_id from public.job where title = 'Software Engineer'),
    'Remote'
),
(
    (select job_id from public.job where title = 'Head of Design'),
    'Menlo Park'
),
(
    (select job_id from public.job where title = 'Full Stack Engineer'),
    'Remote'
),
(
    (select job_id from public.job where title = 'Full Stack Engineer'),
    'Bay Area'
);
