--
-- PostgreSQL database dump
--

-- Dumped from database version 11.9 (Debian 11.9-1.pgdg90+1)
-- Dumped by pg_dump version 13.0 (Debian 13.0-1.pgdg90+1)

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

ALTER TABLE ONLY public.plot DROP CONSTRAINT fk_bebb8f891bf0861f;
ALTER TABLE ONLY public.house DROP CONSTRAINT fk_67d5399d27676b57;
ALTER TABLE ONLY public.house DROP CONSTRAINT fk_67d5399d24d9b445;
ALTER TABLE ONLY public.house DROP CONSTRAINT fk_67d5399d1ae70cb8;
DROP INDEX public.uniq_8d93d649e7927c74;
DROP INDEX public.uniq_67d5399d5e237e06;
DROP INDEX public.idx_bebb8f891bf0861f;
DROP INDEX public.idx_67d5399d27676b57;
DROP INDEX public.idx_67d5399d24d9b445;
DROP INDEX public.idx_67d5399d1ae70cb8;
ALTER TABLE ONLY public."user" DROP CONSTRAINT user_pkey;
ALTER TABLE ONLY public.plot DROP CONSTRAINT plot_pkey;
ALTER TABLE ONLY public.house_roofing DROP CONSTRAINT house_roofing_pkey;
ALTER TABLE ONLY public.house DROP CONSTRAINT house_pkey;
ALTER TABLE ONLY public.house_model DROP CONSTRAINT house_model_pkey;
ALTER TABLE ONLY public.house_brand DROP CONSTRAINT house_brand_pkey;
ALTER TABLE ONLY public.doctrine_migration_versions DROP CONSTRAINT doctrine_migration_versions_pkey;
ALTER TABLE ONLY public.allotment DROP CONSTRAINT allotment_pkey;
DROP SEQUENCE public.user_id_seq;
DROP TABLE public."user";
DROP SEQUENCE public.plot_id_seq;
DROP TABLE public.plot;
DROP SEQUENCE public.house_roofing_id_seq;
DROP TABLE public.house_roofing;
DROP SEQUENCE public.house_model_id_seq;
DROP TABLE public.house_model;
DROP SEQUENCE public.house_id_seq;
DROP SEQUENCE public.house_brand_id_seq;
DROP TABLE public.house_brand;
DROP TABLE public.house;
DROP TABLE public.doctrine_migration_versions;
DROP SEQUENCE public.allotment_id_seq;
DROP TABLE public.allotment;
SET default_tablespace = '';

--
-- Name: allotment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.allotment (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    postal_code integer NOT NULL,
    city character varying(255) NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone
);


--
-- Name: allotment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.allotment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: doctrine_migration_versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.doctrine_migration_versions (
    version character varying(191) NOT NULL,
    executed_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    execution_time integer
);


--
-- Name: house; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.house (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    living_space double precision NOT NULL,
    annex_surface double precision,
    room_number integer NOT NULL,
    bathroom_number integer NOT NULL,
    selling_price_df double precision NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    length double precision,
    width double precision,
    height double precision,
    house_roofing_id integer,
    house_brand_id integer,
    house_model_id integer,
    selling_price_ati double precision,
    valid boolean NOT NULL,
    plan_filename character varying(255) DEFAULT NULL::character varying
);


--
-- Name: house_brand; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.house_brand (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: house_brand_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.house_brand_id_seq
    START WITH 4
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: house_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.house_id_seq
    START WITH 107
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: house_model; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.house_model (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: house_model_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.house_model_id_seq
    START WITH 4
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: house_roofing; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.house_roofing (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


--
-- Name: house_roofing_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.house_roofing_id_seq
    START WITH 4
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: plot; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.plot (
    id integer NOT NULL,
    allotment_id integer NOT NULL,
    lot character varying(255) NOT NULL,
    surface double precision NOT NULL,
    facade_width double precision,
    selling_price_ati double precision NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone
);


--
-- Name: plot_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.plot_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    email character varying(180) NOT NULL,
    roles json NOT NULL,
    password character varying(255) NOT NULL,
    first_name character varying(255) DEFAULT NULL::character varying,
    last_name character varying(255) DEFAULT NULL::character varying
);


--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Data for Name: allotment; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.allotment (id, name, postal_code, city, created_at, updated_at) FROM stdin;
1	La Côte des Blancs	8	Juniville	2020-11-27 17:41:29	\N
2	Le Bois Montépillois	51350	Cormontreuil	2020-11-29 15:47:35	\N
\.


--
-- Data for Name: doctrine_migration_versions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.doctrine_migration_versions (version, executed_at, execution_time) FROM stdin;
DoctrineMigrations\\Version20201121162100	2020-11-21 16:50:10	19
DoctrineMigrations\\Version20201124213557	2020-11-25 20:48:05	23
DoctrineMigrations\\Version20201126203446	2020-11-26 20:58:10	27
DoctrineMigrations\\Version20201127151517	2020-11-27 17:23:13	143
DoctrineMigrations\\Version20201127154756	2020-11-27 17:23:13	1
DoctrineMigrations\\Version20201128143349	2020-11-28 17:37:24	36
\.


--
-- Data for Name: house; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.house (id, name, living_space, annex_surface, room_number, bathroom_number, selling_price_df, created_at, updated_at, length, width, height, house_roofing_id, house_brand_id, house_model_id, selling_price_ati, valid, plan_filename) FROM stdin;
77	Choqa (Bergamote 3)	93	18	3	1	121800	2020-11-19 16:15:00	2020-11-25 22:25:04	9.80000000000000071	8.80000000000000071	\N	1	1	3	146160	t	Facades-5fbecbb0477232.91289257.pdf
2	REGLISSE 4 - 102	102	16	4	1	104583	2020-11-19 16:15:00	2020-11-27 16:20:52	15	9.59999999999999964	\N	1	2	1	125500	t	REGLISSE-4-5fbfecd8152918.05819225.pdf
18	REGLISSE 2- 82	82	16	2	1	92991	2020-11-19 16:15:00	2020-11-27 16:21:21	13.3100000000000005	9	\N	1	2	1	111590	t	\N
107	SMART-ECO-03	84.1899999999999977	14.5	4	1	83333	2020-11-23 12:40:30	2020-11-23 12:43:53	13.75	8.5	\N	4	2	1	99999.6000000000058	t	\N
3	CERISE 3 - 89	89	22	3	1	96022	2020-11-19 16:15:00	2020-11-23 20:10:22	17.4299999999999997	10.4499999999999993	\N	1	2	2	115226.399999999994	t	\N
41	Perfia (Amande3)	90	16	3	1	108943	2020-11-19 16:15:00	2020-11-24 15:20:36	14	9.80000000000000071	\N	1	1	1	130732	t	\N
4	NATIVIE 4 TRADI	122	0	4	2	117160	2020-11-19 16:15:00	2020-11-21 11:12:26	18.8999999999999986	8.19999999999999929	\N	1	2	1	140592	t	\N
6	AMANDE 4 -100	100	22	4	1	108250	2020-11-19 16:15:00	2020-11-21 11:12:26	16	10.3000000000000007	\N	1	2	1	129900	t	\N
8	CITRONNELLE	96	17.75	4	1	103262	2020-11-19 16:15:00	2020-11-21 11:12:26	\N	\N	\N	1	2	2	123914.399999999994	t	\N
9	ACEROLA 4 -88	88	25	4	1	99203	2020-11-19 16:15:00	2020-11-21 11:12:26	15.8499999999999996	8.5	\N	1	2	1	119043.600000000006	t	\N
10	ALBIZIA	132	20.1600000000000001	4	2	141340	2020-11-19 16:15:00	2020-11-21 11:12:26	16.3000000000000007	17.3000000000000007	\N	1	2	2	169608	t	\N
11	REGLISSE 3 Ð 92	92	17	3	1	100000	2020-11-19 16:15:00	2020-11-21 11:12:26	14.6500000000000004	9.09999999999999964	\N	1	2	1	120000	t	\N
12	CARAMBOLE 4 Ð 105	105	59	4	1	135336	2020-11-19 16:15:00	2020-11-21 11:12:26	15.0500000000000007	9	\N	1	2	2	162403.200000000012	t	\N
14	ACEROLA 3 -80	80	23	3	1	92590	2020-11-19 16:15:00	2020-11-21 11:12:26	15.5199999999999996	8	\N	1	2	1	111108	t	\N
15	Mirantin	133	16	4	2	143666	2020-11-19 16:15:00	2020-11-21 11:12:26	11.75	8	\N	1	1	2	172399.200000000012	t	\N
16	CURCUMA 3 Ð 90	90	18	3	1	101667	2020-11-19 16:15:00	2020-11-21 11:12:26	11.8499999999999996	6.59999999999999964	\N	1	2	2	122000.399999999994	t	\N
17	GROSEILLE	107	22.9600000000000009	4	1	122038	2020-11-19 16:15:00	2020-11-21 11:12:26	\N	\N	\N	1	2	1	146445.600000000006	t	\N
19	ACEROLA 2 -74	74	22	2	1	87860	2020-11-19 16:15:00	2020-11-21 11:12:26	14.5199999999999996	8	\N	1	2	1	105432	t	\N
22	NATIBAN 4 Ð 92	92	0	4	1	97308	2020-11-19 16:15:00	2020-11-21 11:12:26	12.9600000000000009	8.25999999999999979	\N	1	3	1	116769.600000000006	t	\N
24	CANNELLE 4 -106	106	53	4	1	140417	2020-11-19 16:15:00	2020-11-21 11:12:26	16	7.70000000000000018	\N	1	2	2	168500.399999999994	t	\N
26	FRAMBOISE	109	20	4	1	127232	2020-11-19 16:15:00	2020-11-21 11:12:26	17.1999999999999993	15.0999999999999996	\N	1	2	1	152678.399999999994	t	\N
27	NATICEA 3 TT- 91	91	50	3	1	124241	2020-11-19 16:15:00	2020-11-21 11:12:26	14.1199999999999992	8.5600000000000005	\N	1	3	1	149089.200000000012	t	\N
30	QUENETTE 3 -79	79	13	3	1	91771	2020-11-19 16:15:00	2020-11-21 11:12:26	6	11.8000000000000007	\N	1	2	2	110125.199999999997	t	\N
32	NATISUN 4	124	20	4	2	144802	2020-11-19 16:15:00	2020-11-21 11:12:26	23.6999999999999993	11.2300000000000004	\N	1	3	1	173762.399999999994	t	\N
36	NATICEA 3 TM- 91	91	50	3	1	127658	2020-11-19 16:15:00	2020-11-21 11:12:26	14.1199999999999992	8.5600000000000005	\N	2	3	1	153189.600000000006	t	\N
37	NATIKAO 4 - 102	102	16	4	1	120698	2020-11-19 16:15:00	2020-11-21 11:12:26	15.7200000000000006	9.16000000000000014	\N	1	3	1	144837.600000000006	t	\N
38	NATIKAO 3 -92	92	18	3	1	110409	2020-11-19 16:15:00	2020-11-21 11:12:26	15.6199999999999992	8.5600000000000005	\N	1	3	1	132490.799999999988	t	\N
39	KIWANO 3 Ð 95	95	16	3	1	113699	2020-11-19 16:15:00	2020-11-21 11:12:26	15.5399999999999991	9.14000000000000057	\N	1	2	2	136438.799999999988	t	\N
40	NATILYS 4 Ð 103	103	16	4	1	122382	2020-11-19 16:15:00	2020-11-21 11:12:26	15.9199999999999999	10.2300000000000004	\N	1	3	1	146858.399999999994	t	\N
43	NATIVIE 4 - 117	118	0	4	1	131121	2020-11-19 16:15:00	2020-11-21 11:12:26	18.5199999999999996	7.95999999999999996	\N	2	3	1	157345.200000000012	t	\N
44	NATIGREEN 5	151	28	5	2	183733	2020-11-19 16:15:00	2020-11-21 11:12:26	15.2899999999999991	13.8000000000000007	\N	1	3	2	220479.600000000006	t	\N
45	ANIS Toiture Tradi 4 - 100	104	17	4	1	125833	2020-11-19 16:15:00	2020-11-21 11:12:26	16	10.3000000000000007	\N	1	2	1	150999.600000000006	t	\N
46	KIWANO 4 Ð 101	101	16	4	1	121948	2020-11-19 16:15:00	2020-11-21 11:12:26	16.3399999999999999	9.14000000000000057	\N	1	2	2	146337.600000000006	t	\N
47	BERGAMOTE 3 Plan Berdin	93	18	3	1	114246	2020-11-19 16:15:00	2020-11-21 11:12:26	9.80000000000000071	8.80000000000000071	\N	1	2	2	137095.200000000012	t	\N
48	NATIRENA 3 Ð 85	85	14	3	1	104128	2020-11-19 16:15:00	2020-11-21 11:12:26	10.3599999999999994	11.5600000000000005	\N	1	3	1	124953.600000000006	t	\N
49	TONKA 3 Ð 90	90	24	3	1	115144	2020-11-19 16:15:00	2020-11-21 11:12:26	9.15000000000000036	10	\N	1	2	2	138172.799999999988	t	\N
51	NATISOON 4 TT- 104	104	20	4	1	129138	2020-11-19 16:15:00	2020-11-21 11:12:26	11.9199999999999999	12.8100000000000005	\N	1	3	1	154965.600000000006	t	\N
52	LAURIER 4+1	125	26	4	2	157042	2020-11-19 16:15:00	2020-11-21 11:12:26	\N	\N	\N	1	2	2	188450.399999999994	t	\N
53	NATIMIX 4 - 117	117	20	4	1	144215	2020-11-19 16:15:00	2020-11-21 11:12:26	15.7599999999999998	15.5999999999999996	\N	1	3	1	173058	t	\N
54	NATILYS 3 Ð 91	91	20	3	1	115044	2020-11-19 16:15:00	2020-11-21 11:12:26	14.7200000000000006	10.2300000000000004	\N	1	3	1	138052.799999999988	t	\N
55	NATIRENA 4 Ð 92	91	14	4	1	112166	2020-11-19 16:15:00	2020-11-21 11:12:26	10.3599999999999994	11.5600000000000005	\N	1	3	1	134599.200000000012	t	\N
56	MANIGUETTE 3 Ð 76	76	15	3	1	95626	2020-11-19 16:15:00	2020-11-21 11:12:26	7.79999999999999982	11.6999999999999993	\N	1	2	2	114751.199999999997	t	\N
57	NATISUN 3	103	21	3	2	129805	2020-11-19 16:15:00	2020-11-21 11:12:26	21.6499999999999986	11.2300000000000004	\N	1	3	1	155766	t	\N
59	NATIVAL 4 - 128	128	17	4	2	156863	2020-11-19 16:15:00	2020-11-21 11:12:27	14.5600000000000005	8.5600000000000005	\N	1	3	3	188235.600000000006	t	\N
60	LAURIER 4	119	26	4	1	153792	2020-11-19 16:15:00	2020-11-21 11:12:27	\N	\N	\N	1	2	2	184550.399999999994	t	\N
63	NATIBAN 3 Ð 75	75	0	3	1	88322	2020-11-19 16:15:00	2020-11-21 11:12:27	11.1600000000000001	7.95999999999999996	\N	1	3	1	105986.399999999994	t	\N
5	CURCUMA 4 Ð 100	100	17	4	1	105000	2020-11-19 16:15:00	2020-11-21 11:12:26	12.1999999999999993	6.79999999999999982	\N	1	2	2	126000	t	\N
13	CARAMBOLE 3 Ð 96	96	50	3	1	122296	2020-11-19 16:15:00	2020-11-21 11:12:26	13.9499999999999993	9	\N	1	2	2	146755.200000000012	t	\N
23	Meije (Colza 111)	111	16	4	1	126384	2020-11-19 16:15:00	2020-11-27 17:46:36	8.90000000000000036	9.55000000000000071	\N	1	1	2	151661	t	\N
33	MIKENO	108	34	4	1	135833	2020-11-19 16:15:00	2020-11-24 15:28:52	19.25	10.3000000000000007	\N	1	1	1	163000	t	\N
25	Denali (PensŽe 120)	121	23	4	2	140829	2020-11-19 16:15:00	2020-11-24 15:32:39	13.3499999999999996	8.19999999999999929	\N	1	1	2	168995	t	\N
21	LORENTIDES	115	30	4	1	137250	2020-11-19 16:15:00	2020-11-24 15:50:55	13.75	15.8499999999999996	\N	1	1	1	164700	t	\N
34	CHARMETTE	147	21	4	2	170417	2020-11-19 16:15:00	2020-11-24 15:53:51	15.5	9.94999999999999929	\N	1	1	2	204501	t	\N
31	NATIREY 4 - Aménagée	127	0	4	2	136867	2020-11-19 16:15:00	2020-11-24 18:57:32	10.2100000000000009	9.16000000000000014	\N	1	3	3	164241	t	\N
61	BERGAMOTE 4 - 102	102	20	4	1	130906	2020-11-19 16:15:00	2020-11-24 22:01:02	10.4000000000000004	9	\N	1	2	2	157088	t	\N
29	CAPUCINE 4 - 85	85	15	4	1	99103	2020-11-19 16:15:00	2020-11-26 18:38:41	9	9.19999999999999929	\N	1	2	2	118924	t	\N
7	AMANDE 3 - 89	89	22	3	1	98230	2020-11-19 16:15:00	2020-11-26 19:05:54	14.8000000000000007	9.90000000000000036	\N	1	2	1	117876	t	\N
62	WASABI 3-90	90	15	3	1	114146	2020-11-19 16:15:00	2020-11-27 16:21:58	14.8399999999999999	9.51999999999999957	\N	1	2	2	136976	t	\N
20	NATICEA 4 TT- 108	104	58	4	1	138406	2020-11-19 16:15:00	2020-11-21 11:12:26	14.7200000000000006	9.16000000000000014	\N	1	3	1	166087.200000000012	t	\N
28	NATICEA 4 TM-108	104	58	4	1	142405	2020-11-19 16:15:00	2020-11-21 11:12:26	14.7200000000000006	9.16000000000000014	\N	2	3	1	170886	t	\N
35	NATIVIE 4 TT- 117	118	0	4	1	127572	2020-11-19 16:15:00	2020-11-21 11:12:26	18.5199999999999996	7.95999999999999996	\N	1	3	1	153086.399999999994	t	\N
42	CANNELLE 3 Ð 97	97	39	3	1	129083	2020-11-19 16:15:00	2020-11-21 11:12:26	14.6999999999999993	7.70000000000000018	\N	1	2	2	154899.600000000006	t	\N
50	TONKA 4 Ð 99	99	22	4	1	124431	2020-11-19 16:15:00	2020-11-21 11:12:26	10.1500000000000004	9.80000000000000071	\N	1	2	2	149317.200000000012	t	\N
58	ANIS Toiture Tradi 3 Ð 89	94	17	3	1	117500	2020-11-19 16:15:00	2020-11-21 11:12:26	14.8000000000000007	9.90000000000000036	\N	1	2	1	141000	t	\N
64	NATIVIE 4  - 117	118	0	4	1	137685	2020-11-19 16:15:00	2020-11-21 11:12:27	18.5199999999999996	7.95999999999999996	\N	1	3	1	165222	t	\N
65	NATIMIX 3 - 109	109	20	3	1	139537	2020-11-19 16:15:00	2020-11-21 11:12:27	15.7599999999999998	15.5999999999999996	\N	1	3	1	167444.399999999994	t	\N
66	NATISOON 3 TT - 89	89	20	3	1	117628	2020-11-19 16:15:00	2020-11-21 11:12:27	15.2599999999999998	11.9100000000000001	\N	1	3	1	141153.600000000006	t	\N
67	YUZU 3 Ð 90	90	15	3	1	115274	2020-11-19 16:15:00	2020-11-21 11:12:27	7	14	\N	1	2	2	138328.799999999988	t	\N
68	NATIVIE 3 - 101	101	0	3	2	119569	2020-11-19 16:15:00	2020-11-21 11:12:27	17.3200000000000003	7.36000000000000032	\N	1	3	1	143482.799999999988	t	\N
69	NATILIVE 5 - 129	128	15	5	2	159612	2020-11-19 16:15:00	2020-11-21 11:12:27	10.8000000000000007	10.3599999999999994	\N	1	3	2	191534.399999999994	t	\N
70	YUZU 3 Ð 104	104	18	3	1	133775	2020-11-19 16:15:00	2020-11-21 11:12:27	8	14	\N	1	2	2	160530	t	\N
71	NATISOL 4 - 107	109	21	4	2	141425	2020-11-19 16:15:00	2020-11-21 11:12:27	17.9100000000000001	12.3670000000000009	\N	1	3	1	169710	t	\N
72	TAMARILLO 4 -  115	115	25	4	2	151429	2020-11-19 16:15:00	2020-11-21 11:12:27	12.8399999999999999	20.1479999999999997	\N	1	2	2	181714.799999999988	t	\N
73	NATIMAMBA 4 Ð 101	111	24	4	2	146598	2020-11-19 16:15:00	2020-11-21 11:12:27	18.7199999999999989	10.0600000000000005	\N	3	3	1	175917.600000000006	t	\N
75	TAMARILLO 3 Ð 91	91	18	3	1	119021	2020-11-19 16:15:00	2020-11-21 11:12:27	10.3399999999999999	18.1600000000000001	\N	1	2	2	142825.200000000012	t	\N
76	ANIS Toiture Terrasse 4 Ð 100	104	17	4	1	134167	2020-11-19 16:15:00	2020-11-21 11:12:27	16	10.3000000000000007	\N	3	2	1	161000.399999999994	t	\N
78	NATIVAL 3 TT - 111	111	17	3	1	143696	2020-11-19 16:15:00	2020-11-21 11:12:27	11.5600000000000005	8.5600000000000005	\N	1	3	3	172435.200000000012	t	\N
79	NATISOL 3 TT - 97	98	20	3	2	130978	2020-11-19 16:15:00	2020-11-21 11:12:27	17.1099999999999994	12.7300000000000004	\N	1	3	1	157173.600000000006	t	\N
80	NATISHEN 4 Ð 108	108	24	4	1	144835	2020-11-19 16:15:00	2020-11-21 11:12:27	10.2100000000000009	9.16000000000000014	\N	1	3	3	173802	t	\N
81	NATIMOVE 4 - 124	124	17	4	2	160899	2020-11-19 16:15:00	2020-11-21 11:12:27	14.3900000000000006	12.4299999999999997	\N	1	3	2	193078.799999999988	t	\N
82	WASABI 4 Ð 100	100	16	4	1	131337	2020-11-19 16:15:00	2020-11-21 11:12:27	15.5399999999999991	9.91999999999999993	\N	1	2	2	157604.399999999994	t	\N
83	NATIMAMBA 3 Ð 103	103	24	3	1	140468	2020-11-19 16:15:00	2020-11-21 11:12:27	17.5199999999999996	10.0600000000000005	\N	1	3	1	168561.600000000006	t	\N
84	NATIGREEN 4	125	19	4	2	164137	2020-11-19 16:15:00	2020-11-21 11:12:27	15	12	\N	1	3	2	196964.399999999994	t	\N
85	NATIVIE 3 TM- 101	101	0	3	2	123965	2020-11-19 16:15:00	2020-11-21 11:12:27	17.3200000000000003	7.36000000000000032	\N	2	3	1	148758	t	\N
86	NATISOON 4 - 104	104	20	4	1	139941	2020-11-19 16:15:00	2020-11-21 11:12:27	11.9199999999999999	12.8699999999999992	\N	3	3	1	167929.200000000012	t	\N
87	ANIS Toiture Terrasse 3 Ð 89	94	17	3	1	125833	2020-11-19 16:15:00	2020-11-21 11:12:27	14.8000000000000007	9.90000000000000036	\N	3	2	1	150999.600000000006	t	\N
88	NATILINE 4 - 102	111	18	4	1	149863	2020-11-19 16:15:00	2020-11-21 11:12:27	12.3000000000000007	8.35999999999999943	\N	1	3	2	179835.600000000006	t	\N
90	NATIREY 4 - AmŽnagealbe	73	55	1	1	126432	2020-11-19 16:15:00	2020-11-21 11:12:27	10.2100000000000009	9.16000000000000014	\N	1	3	3	151718.399999999994	t	\N
91	NATIGREEN 3	102	17	3	1	139436	2020-11-19 16:15:00	2020-11-21 11:12:27	13.4600000000000009	10.1999999999999993	\N	1	3	2	167323.200000000012	t	\N
92	NATISOON 3 - 89	89	20	3	1	125906	2020-11-19 16:15:00	2020-11-21 11:12:27	15.2599999999999998	11.9100000000000001	\N	3	3	1	151087.200000000012	t	\N
93	NATIVIE 3 TT - 101	101	0	3	2	128572	2020-11-19 16:15:00	2020-11-21 11:12:27	17.3200000000000003	7.36000000000000032	\N	3	3	1	154286.399999999994	t	\N
94	NATIWAY 4	123	21	4	2	170948	2020-11-19 16:15:00	2020-11-21 11:12:27	16.7699999999999996	14.0399999999999991	\N	2	3	1	205137.600000000006	t	\N
95	NATILIVE 4 - 96	96	15	4	2	133306	2020-11-19 16:15:00	2020-11-21 11:12:27	9.3100000000000005	10.0600000000000005	\N	1	3	2	159967.200000000012	t	\N
96	NATIWOOD	139	2	4	2	181414	2020-11-19 16:15:00	2020-11-21 11:12:27	11.2400000000000002	9.64000000000000057	\N	3	3	2	217696.799999999988	t	\N
97	NATISHEN 3 Ð 94	94	19	3	1	134273	2020-11-19 16:15:00	2020-11-21 11:12:27	9.00999999999999979	9.16000000000000014	\N	1	3	3	161127.600000000006	t	\N
98	NATISOL 4 -107	109	21	4	2	155859	2020-11-19 16:15:00	2020-11-21 11:12:27	17.9100000000000001	12.6699999999999999	\N	3	3	1	187030.799999999988	t	\N
99	NATIMOVE 3 - 103	103	17	3	2	149196	2020-11-19 16:15:00	2020-11-21 11:12:27	13.8900000000000006	10.4299999999999997	\N	1	3	2	179035.200000000012	t	\N
100	NATISOL 3 - 97	98	20	3	2	146836	2020-11-19 16:15:00	2020-11-21 11:12:27	17.1099999999999994	12.7300000000000004	\N	3	3	1	176203.200000000012	t	\N
101	NATIWAY 3	102	21	3	2	153679	2020-11-19 16:15:00	2020-11-21 11:12:27	15.2599999999999998	15.3000000000000007	\N	2	3	1	184414.799999999988	t	\N
102	NATILINE 3 - 92	93	16	3	1	138407	2020-11-19 16:15:00	2020-11-21 11:12:27	11.4100000000000001	7.75999999999999979	\N	1	3	2	166088.399999999994	t	\N
103	NATILIVE 3 - 81	81	15	3	2	124236	2020-11-19 16:15:00	2020-11-21 11:12:27	8.41000000000000014	10.0600000000000005	\N	1	3	2	149083.200000000012	t	\N
104	NATISLIM	95	0	3	1	139169	2020-11-19 16:15:00	2020-11-21 11:12:27	5	13.8200000000000003	\N	1	3	2	167002.799999999988	t	\N
105	NATILIVE 2 - 69	69	0	2	1	105815	2020-11-19 16:15:00	2020-11-21 11:12:27	5.41000000000000014	8.5600000000000005	\N	1	3	2	126978	t	\N
106	NATICUBE 3 - 113	109	17	3	2	185162	2020-11-19 16:15:00	2020-11-21 11:12:27	14.8000000000000007	11	\N	3	3	2	222194.399999999994	t	\N
1	CERISE 4 - 101	101	22	4	1	105730	2020-11-19 16:15:00	2020-11-21 11:12:27	18.6999999999999993	11.5	\N	1	2	2	126876	t	\N
108	SMART-ECO-04	90.3299999999999983	14.5	4	1	87500	2020-11-23 12:45:58	\N	14.5999999999999996	8.5	\N	4	2	1	105000	t	\N
89	Tournette 11.05	114	19	4	2	154451	2020-11-19 16:15:00	2020-11-24 15:44:35	11.0500000000000007	13.1999999999999993	\N	1	1	2	185342	t	\N
74	Silki (Canneberge 5)	129	16	5	2	162290	2020-11-19 16:15:00	2020-11-24 15:45:56	14.5	8	\N	1	1	3	194748	t	\N
\.


--
-- Data for Name: house_brand; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.house_brand (id, name) FROM stdin;
1	Maisons Berdin
2	Villas Club
3	Natilia
\.


--
-- Data for Name: house_model; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.house_model (id, name) FROM stdin;
1	Plain-pied
2	Etage
3	Combles Aménagées
\.


--
-- Data for Name: house_roofing; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.house_roofing (id, name) FROM stdin;
1	Toiture Traditionnelle 35°
2	Toiture Monopente
3	Toiture Terrasse
4	Toiture Traditionelle 30°
5	Test
\.


--
-- Data for Name: plot; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.plot (id, allotment_id, lot, surface, facade_width, selling_price_ati, created_at, updated_at) FROM stdin;
1	1	1	687	\N	57400	2020-11-27 17:42:08	\N
2	1	2	635	\N	54000	2020-11-27 17:42:42	\N
4	1	03	11	2112	1111	2020-11-29 00:08:20	\N
5	2	01	450	16	135000	2020-11-29 15:47:35	\N
6	2	02	500	15	145000	2020-11-29 15:47:35	\N
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."user" (id, email, roles, password, first_name, last_name) FROM stdin;
2	tessa@groupeberdin.com	[]	$argon2id$v=19$m=65536,t=4,p=1$IZrHKOyUArOuk/zUomw4qg$WmnkDm6Mb6PnTMnhh5Y4Ermu/rmQaW0+iTlqtfX+00M	\N	\N
1	thibaud.berdin@groupeberdin.com	["ROLE_ADMIN"]	$argon2id$v=19$m=65536,t=4,p=1$+PjFuLYTXn0OO3SYXz+4OQ$KXho91KVe5ij6w36lMZt4YkFnzP+5EbqvMJF3Q1TZH8	Thibaud	Berdin
\.


--
-- Name: allotment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.allotment_id_seq', 2, true);


--
-- Name: house_brand_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.house_brand_id_seq', 1, false);


--
-- Name: house_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.house_id_seq', 110, true);


--
-- Name: house_model_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.house_model_id_seq', 1, false);


--
-- Name: house_roofing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.house_roofing_id_seq', 5, true);


--
-- Name: plot_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.plot_id_seq', 6, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_id_seq', 2, true);


--
-- Name: allotment allotment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.allotment
    ADD CONSTRAINT allotment_pkey PRIMARY KEY (id);


--
-- Name: doctrine_migration_versions doctrine_migration_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.doctrine_migration_versions
    ADD CONSTRAINT doctrine_migration_versions_pkey PRIMARY KEY (version);


--
-- Name: house_brand house_brand_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.house_brand
    ADD CONSTRAINT house_brand_pkey PRIMARY KEY (id);


--
-- Name: house_model house_model_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.house_model
    ADD CONSTRAINT house_model_pkey PRIMARY KEY (id);


--
-- Name: house house_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.house
    ADD CONSTRAINT house_pkey PRIMARY KEY (id);


--
-- Name: house_roofing house_roofing_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.house_roofing
    ADD CONSTRAINT house_roofing_pkey PRIMARY KEY (id);


--
-- Name: plot plot_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plot
    ADD CONSTRAINT plot_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: idx_67d5399d1ae70cb8; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_67d5399d1ae70cb8 ON public.house USING btree (house_model_id);


--
-- Name: idx_67d5399d24d9b445; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_67d5399d24d9b445 ON public.house USING btree (house_roofing_id);


--
-- Name: idx_67d5399d27676b57; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_67d5399d27676b57 ON public.house USING btree (house_brand_id);


--
-- Name: idx_bebb8f891bf0861f; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_bebb8f891bf0861f ON public.plot USING btree (allotment_id);


--
-- Name: uniq_67d5399d5e237e06; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uniq_67d5399d5e237e06 ON public.house USING btree (name);


--
-- Name: uniq_8d93d649e7927c74; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX uniq_8d93d649e7927c74 ON public."user" USING btree (email);


--
-- Name: house fk_67d5399d1ae70cb8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.house
    ADD CONSTRAINT fk_67d5399d1ae70cb8 FOREIGN KEY (house_model_id) REFERENCES public.house_model(id);


--
-- Name: house fk_67d5399d24d9b445; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.house
    ADD CONSTRAINT fk_67d5399d24d9b445 FOREIGN KEY (house_roofing_id) REFERENCES public.house_roofing(id);


--
-- Name: house fk_67d5399d27676b57; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.house
    ADD CONSTRAINT fk_67d5399d27676b57 FOREIGN KEY (house_brand_id) REFERENCES public.house_brand(id);


--
-- Name: plot fk_bebb8f891bf0861f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.plot
    ADD CONSTRAINT fk_bebb8f891bf0861f FOREIGN KEY (allotment_id) REFERENCES public.allotment(id);


--
-- PostgreSQL database dump complete
--

