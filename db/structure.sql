SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: full_text_searches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.full_text_searches (
    id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    record_id integer NOT NULL,
    record_type character varying NOT NULL,
    value tsvector
);


--
-- Name: full_text_searches_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.full_text_searches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: full_text_searches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.full_text_searches_id_seq OWNED BY public.full_text_searches.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.projects (
    id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    forks_count integer DEFAULT 0 NOT NULL,
    open_issues_count integer DEFAULT 0 NOT NULL,
    stars_count integer DEFAULT 0 NOT NULL,
    subscribers_count integer DEFAULT 0 NOT NULL,
    archived boolean DEFAULT false NOT NULL,
    disabled boolean DEFAULT false NOT NULL,
    name text NOT NULL,
    description text,
    url text,
    repo_url text NOT NULL,
    license_name text,
    license_url text,
    tags text[] DEFAULT '{}'::text[] NOT NULL
);


--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: full_text_searches id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.full_text_searches ALTER COLUMN id SET DEFAULT nextval('public.full_text_searches_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: full_text_searches full_text_searches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.full_text_searches
    ADD CONSTRAINT full_text_searches_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: index_full_text_searches_on_record_type_and_record_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_full_text_searches_on_record_type_and_record_id ON public.full_text_searches USING btree (record_type, record_id);


--
-- Name: index_full_text_searches_on_value; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_full_text_searches_on_value ON public.full_text_searches USING gin (value);


--
-- Name: index_projects_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_name ON public.projects USING btree (name);


--
-- Name: index_projects_on_tags; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_projects_on_tags ON public.projects USING gin (tags);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20200724002532'),
('20200724034425');


