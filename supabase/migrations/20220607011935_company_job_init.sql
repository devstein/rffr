-- This script was generated by the Schema Diff utility in pgAdmin 4
-- For the circular dependencies, the order in which Schema Diff writes the objects is not very sophisticated
-- and may require manual changes to the script to ensure changes are applied in the correct order.
-- Please report an issue for any failure with the reproduction steps.

CREATE TABLE IF NOT EXISTS public.company
(
    company_id uuid NOT NULL DEFAULT uuid_generate_v4(),
    company_name text COLLATE pg_catalog."default" NOT NULL,
    email text COLLATE pg_catalog."default",
    website text COLLATE pg_catalog."default",
    updated_at timestamp with time zone NOT NULL DEFAULT now(),
    created_at timestamp with time zone NOT NULL DEFAULT now(),
    CONSTRAINT company_pkey PRIMARY KEY (company_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.company
    OWNER to postgres;

GRANT ALL ON TABLE public.company TO anon;

GRANT ALL ON TABLE public.company TO authenticated;

GRANT ALL ON TABLE public.company TO postgres;

GRANT ALL ON TABLE public.company TO service_role;

CREATE TRIGGER handle_updated_at_company
    BEFORE UPDATE 
    ON public.company
    FOR EACH ROW
    EXECUTE FUNCTION extensions.moddatetime('updated_at');

CREATE TABLE IF NOT EXISTS public.job
(
    job_id uuid NOT NULL DEFAULT uuid_generate_v4(),
    company_id uuid NOT NULL,
    title text COLLATE pg_catalog."default" NOT NULL,
    reward integer NOT NULL,
    job_description_url text COLLATE pg_catalog."default" NOT NULL,
    updated_at timestamp with time zone NOT NULL DEFAULT now(),
    created_at timestamp with time zone NOT NULL DEFAULT now(),
    CONSTRAINT job_pkey PRIMARY KEY (job_id),
    CONSTRAINT job_company_id_fkey FOREIGN KEY (company_id)
        REFERENCES public.company (company_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT job_reward_positive CHECK (reward > 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.job
    OWNER to postgres;

GRANT ALL ON TABLE public.job TO anon;

GRANT ALL ON TABLE public.job TO authenticated;

GRANT ALL ON TABLE public.job TO postgres;

GRANT ALL ON TABLE public.job TO service_role;

CREATE TRIGGER handle_updated_at_job
    BEFORE UPDATE 
    ON public.job
    FOR EACH ROW
    EXECUTE FUNCTION extensions.moddatetime('updated_at');

CREATE TABLE IF NOT EXISTS public.job_location
(
    job_id uuid NOT NULL,
    location_name text COLLATE pg_catalog."default" NOT NULL,
    updated_at timestamp with time zone NOT NULL DEFAULT now(),
    created_at timestamp with time zone NOT NULL DEFAULT now(),
    CONSTRAINT job_location_pkey PRIMARY KEY (job_id, location_name),
    CONSTRAINT job_location_job_id_fkey FOREIGN KEY (job_id)
        REFERENCES public.job (job_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.job_location
    OWNER to postgres;

GRANT ALL ON TABLE public.job_location TO anon;

GRANT ALL ON TABLE public.job_location TO authenticated;

GRANT ALL ON TABLE public.job_location TO postgres;

GRANT ALL ON TABLE public.job_location TO service_role;

CREATE TRIGGER handle_updated_at_job
    BEFORE UPDATE 
    ON public.job_location
    FOR EACH ROW
    EXECUTE FUNCTION extensions.moddatetime('updated_at');
