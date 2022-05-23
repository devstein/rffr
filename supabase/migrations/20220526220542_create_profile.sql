-- This script was generated by the Schema Diff utility in pgAdmin 4
-- For the circular dependencies, the order in which Schema Diff writes the objects is not very sophisticated
-- and may require manual changes to the script to ensure changes are applied in the correct order.
-- Please report an issue for any failure with the reproduction steps.

CREATE TABLE IF NOT EXISTS public.profile
(
    user_id uuid NOT NULL,
    first_name text COLLATE pg_catalog."default" NOT NULL,
    last_name text COLLATE pg_catalog."default" NOT NULL,
    linkedin_url text COLLATE pg_catalog."default" NOT NULL,
    survey_response jsonb,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT profile_pkey PRIMARY KEY (user_id),
    CONSTRAINT profile_user_id_fkey FOREIGN KEY (user_id)
        REFERENCES auth.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.profile
    OWNER to postgres;

ALTER TABLE IF EXISTS public.profile
    ENABLE ROW LEVEL SECURITY;

GRANT ALL ON TABLE public.profile TO anon;

GRANT ALL ON TABLE public.profile TO authenticated;

GRANT ALL ON TABLE public.profile TO postgres;

GRANT ALL ON TABLE public.profile TO service_role;
CREATE POLICY "Users can insert their own profile."
    ON public.profile
    AS PERMISSIVE
    FOR INSERT
    TO public
    WITH CHECK ((auth.uid() = user_id));
CREATE POLICY "Users can update own profile."
    ON public.profile
    AS PERMISSIVE
    FOR UPDATE
    TO public
    USING ((auth.uid() = user_id));
CREATE POLICY "Users can view their own profile"
    ON public.profile
    AS PERMISSIVE
    FOR SELECT
    TO public
    USING ((auth.uid() = user_id));
