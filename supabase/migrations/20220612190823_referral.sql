-- This script was generated by the Schema Diff utility in pgAdmin 4
-- For the circular dependencies, the order in which Schema Diff writes the objects is not very sophisticated
-- and may require manual changes to the script to ensure changes are applied in the correct order.
-- Please report an issue for any failure with the reproduction steps.
CREATE TABLE IF NOT EXISTS public.referral_status
(
    referral_status_id SMALLSERIAL NOT NULL,
    referral_status_name text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT referral_status_pkey PRIMARY KEY (referral_status_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.referral_status
    OWNER to postgres;

GRANT ALL ON TABLE public.referral_status TO anon;

GRANT ALL ON TABLE public.referral_status TO authenticated;

GRANT ALL ON TABLE public.referral_status TO postgres;

GRANT ALL ON TABLE public.referral_status TO service_role;

CREATE TABLE IF NOT EXISTS public.referral
(
    referral_id uuid NOT NULL DEFAULT uuid_generate_v4(),
    referrer_id uuid NOT NULL,
    candidate_email text COLLATE pg_catalog."default" NOT NULL,
    candidate_id uuid,
    job_id uuid NOT NULL,
    referral_status_id smallint,
    survey_response jsonb,
    updated_at timestamp with time zone NOT NULL DEFAULT now(),
    created_at timestamp with time zone NOT NULL DEFAULT now(),
    CONSTRAINT referral_pkey PRIMARY KEY (referral_id),
    CONSTRAINT referral_job_id_candidate_email_key UNIQUE (job_id, candidate_email),
    CONSTRAINT referral_candidate_id_fkey FOREIGN KEY (candidate_id)
        REFERENCES public.profile (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT referral_job_id_fkey FOREIGN KEY (job_id)
        REFERENCES public.job (job_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT referral_referral_status_id_fkey FOREIGN KEY (referral_status_id)
        REFERENCES public.referral_status (referral_status_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT referral_referrer_id_fkey FOREIGN KEY (referrer_id)
        REFERENCES public.profile (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.referral
    OWNER to postgres;

ALTER TABLE IF EXISTS public.referral
    ENABLE ROW LEVEL SECURITY;

GRANT ALL ON TABLE public.referral TO authenticated;

GRANT ALL ON TABLE public.referral TO anon;

GRANT ALL ON TABLE public.referral TO service_role;

GRANT ALL ON TABLE public.referral TO postgres;
CREATE POLICY "Referrers can insert their own referral."
    ON public.referral
    AS PERMISSIVE
    FOR INSERT
    TO public
    WITH CHECK ((auth.uid() = referrer_id));


REVOKE ALL ON TABLE public.job FROM authenticated;
REVOKE ALL ON TABLE public.job FROM postgres;
REVOKE ALL ON TABLE public.job FROM service_role;
GRANT ALL ON TABLE public.job TO authenticated;

GRANT ALL ON TABLE public.job TO service_role;

GRANT ALL ON TABLE public.job TO postgres;
