--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1 (Debian 16.1-1.pgdg120+1)
-- Dumped by pg_dump version 16.1 (Debian 16.1-1.pgdg120+1)

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

SET default_table_access_method = heap;

--
-- Name: students; Type: TABLE; Schema: public; Owner: zlorg
--

CREATE TABLE public.students (
    id integer NOT NULL,
    full_name character varying(50) NOT NULL,
    email character varying(50) NOT NULL,
    phone character varying(50) NOT NULL,
    address character varying(50) NOT NULL
);


ALTER TABLE public.students OWNER TO zlorg;

--
-- Name: students_id_seq; Type: SEQUENCE; Schema: public; Owner: zlorg
--

ALTER TABLE public.students ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.students_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: zlorg
--

COPY public.students (id, full_name, email, phone, address) FROM stdin;
15      Papa Matar Diop pamatardiop1@gmail.com  769001942       N°8228, Rue SC 153
\.


--
-- Name: students_id_seq; Type: SEQUENCE SET; Schema: public; Owner: zlorg
--

SELECT pg_catalog.setval('public.students_id_seq', 15, true);


--
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: zlorg
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--