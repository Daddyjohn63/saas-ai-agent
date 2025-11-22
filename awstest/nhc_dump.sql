--
-- PostgreSQL database dump
--

-- Dumped from database version 16.9 (165f042)
-- Dumped by pg_dump version 17.4

-- Started on 2025-11-05 09:57:21

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 7 (class 2615 OID 24576)
-- Name: drizzle; Type: SCHEMA; Schema: -; Owner: default
--

CREATE SCHEMA drizzle;


ALTER SCHEMA drizzle OWNER TO "default";

--
-- TOC entry 2 (class 3079 OID 32768)
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- TOC entry 3578 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


--
-- TOC entry 903 (class 1247 OID 24587)
-- Name: age_group; Type: TYPE; Schema: public; Owner: default
--

CREATE TYPE public.age_group AS ENUM (
    '18-30',
    '31-40',
    '41-50',
    '51-60',
    '61-70',
    '71-80',
    '80+'
);


ALTER TYPE public.age_group OWNER TO "default";

--
-- TOC entry 936 (class 1247 OID 82314)
-- Name: country; Type: TYPE; Schema: public; Owner: default
--

CREATE TYPE public.country AS ENUM (
    'Afghanistan',
    'Albania',
    'Algeria',
    'Andorra',
    'Angola',
    'Antigua & Deps',
    'Argentina',
    'Armenia',
    'Australia',
    'Austria',
    'Azerbaijan',
    'Bahamas',
    'Bahrain',
    'Bangladesh',
    'Barbados',
    'Belarus',
    'Belgium',
    'Belize',
    'Benin',
    'Bhutan',
    'Bolivia',
    'Bosnia Herzegovina',
    'Botswana',
    'Brazil',
    'Brunei',
    'Bulgaria',
    'Burkina',
    'Burundi',
    'Cambodia',
    'Cameroon',
    'Canada',
    'Cape Verde',
    'Central African Rep',
    'Chad',
    'Chile',
    'China',
    'Colombia',
    'Comoros',
    'Congo',
    'Congo {Democratic Rep}',
    'Costa Rica',
    'Croatia',
    'Cuba',
    'Cyprus',
    'Czech Republic',
    'Denmark',
    'Djibouti',
    'Dominica',
    'Dominican Republic',
    'East Timor',
    'Ecuador',
    'Egypt',
    'El Salvador',
    'Equatorial Guinea',
    'Eritrea',
    'Estonia',
    'Ethiopia',
    'Fiji',
    'Finland',
    'France',
    'Gabon',
    'Gambia',
    'Georgia',
    'Germany',
    'Ghana',
    'Greece',
    'Grenada',
    'Guatemala',
    'Guinea',
    'Guinea-Bissau',
    'Guyana',
    'Haiti',
    'Honduras',
    'Hungary',
    'Iceland',
    'India',
    'Indonesia',
    'Iran',
    'Iraq',
    'Ireland {Republic}',
    'Israel',
    'Italy',
    'Ivory Coast',
    'Jamaica',
    'Japan',
    'Jordan',
    'Kazakhstan',
    'Kenya',
    'Kiribati',
    'Korea North',
    'Korea South',
    'Kosovo',
    'Kuwait',
    'Kyrgyzstan',
    'Laos',
    'Latvia',
    'Lebanon',
    'Lesotho',
    'Liberia',
    'Libya',
    'Liechtenstein',
    'Lithuania',
    'Luxembourg',
    'Macedonia',
    'Madagascar',
    'Malawi',
    'Malaysia',
    'Maldives',
    'Mali',
    'Malta',
    'Marshall Islands',
    'Mauritania',
    'Mauritius',
    'Mexico',
    'Micronesia',
    'Moldova',
    'Monaco',
    'Mongolia',
    'Montenegro',
    'Morocco',
    'Mozambique',
    'Myanmar, {Burma}',
    'Namibia',
    'Nauru',
    'Nepal',
    'Netherlands',
    'New Zealand',
    'Nicaragua',
    'Niger',
    'Nigeria',
    'Norway',
    'Oman',
    'Pakistan',
    'Palau',
    'Panama',
    'Papua New Guinea',
    'Paraguay',
    'Peru',
    'Philippines',
    'Poland',
    'Portugal',
    'Qatar',
    'Romania',
    'Russian Federation',
    'Rwanda',
    'St Kitts & Nevis',
    'St Lucia',
    'Saint Vincent & the Grenadines',
    'Samoa',
    'San Marino',
    'Sao Tome & Principe',
    'Saudi Arabia',
    'Senegal',
    'Serbia',
    'Seychelles',
    'Sierra Leone',
    'Singapore',
    'Slovakia',
    'Slovenia',
    'Solomon Islands',
    'Somalia',
    'South Africa',
    'South Sudan',
    'Spain',
    'Sri Lanka',
    'Sudan',
    'Suriname',
    'Swaziland',
    'Sweden',
    'Switzerland',
    'Syria',
    'Taiwan',
    'Tajikistan',
    'Tanzania',
    'Thailand',
    'Togo',
    'Tonga',
    'Trinidad & Tobago',
    'Tunisia',
    'Turkey',
    'Turkmenistan',
    'Tuvalu',
    'Uganda',
    'Ukraine',
    'United Arab Emirates',
    'United Kingdom',
    'United States',
    'Uruguay',
    'Uzbekistan',
    'Vanuatu',
    'Vatican City',
    'Venezuela',
    'Vietnam',
    'Yemen',
    'Zambia',
    'Zimbabwe',
    'AntiguaDeps',
    'BosniaHerzegovina',
    'CapeVerde',
    'CentralAfricanRep',
    'CostaRica',
    'CzechRepublic',
    'DominicanRepublic',
    'EastTimor',
    'ElSalvador',
    'EquatorialGuinea',
    'GuineaBissau',
    'Ireland',
    'IvoryCoast',
    'KoreaNorth',
    'KoreaSouth',
    'MarshallIslands',
    'Myanmar',
    'NewZealand',
    'PapuaNewGuinea',
    'RussianFederation',
    'StKittsNevis',
    'StLucia',
    'SaintVincenttheGrenadines',
    'SanMarino',
    'SaoTomePrincipe',
    'SaudiArabia',
    'SierraLeone',
    'SolomonIslands',
    'SouthAfrica',
    'SouthSudan',
    'SriLanka',
    'TrinidadTobago',
    'UnitedArabEmirates',
    'UnitedKingdom',
    'UnitedStates',
    'VaticanCity'
);


ALTER TYPE public.country OWNER TO "default";

--
-- TOC entry 957 (class 1247 OID 262145)
-- Name: deleted_by; Type: TYPE; Schema: public; Owner: default
--

CREATE TYPE public.deleted_by AS ENUM (
    'user',
    'admin'
);


ALTER TYPE public.deleted_by OWNER TO "default";

--
-- TOC entry 948 (class 1247 OID 147457)
-- Name: document_type; Type: TYPE; Schema: public; Owner: default
--

CREATE TYPE public.document_type AS ENUM (
    'pdf',
    'jpg',
    'url',
    'jpeg',
    'book'
);


ALTER TYPE public.document_type OWNER TO "default";

--
-- TOC entry 906 (class 1247 OID 24602)
-- Name: gender; Type: TYPE; Schema: public; Owner: default
--

CREATE TYPE public.gender AS ENUM (
    'male',
    'female',
    'other'
);


ALTER TYPE public.gender OWNER TO "default";

--
-- TOC entry 954 (class 1247 OID 212999)
-- Name: languages; Type: TYPE; Schema: public; Owner: default
--

CREATE TYPE public.languages AS ENUM (
    'es',
    'en'
);


ALTER TYPE public.languages OWNER TO "default";

--
-- TOC entry 909 (class 1247 OID 24610)
-- Name: membership_levels; Type: TYPE; Schema: public; Owner: default
--

CREATE TYPE public.membership_levels AS ENUM (
    'personal',
    'business',
    'professional'
);


ALTER TYPE public.membership_levels OWNER TO "default";

--
-- TOC entry 939 (class 1247 OID 106498)
-- Name: success_rating; Type: TYPE; Schema: public; Owner: default
--

CREATE TYPE public.success_rating AS ENUM (
    'A',
    'B',
    'C'
);


ALTER TYPE public.success_rating OWNER TO "default";

--
-- TOC entry 933 (class 1247 OID 49153)
-- Name: treatment_types; Type: TYPE; Schema: public; Owner: default
--

CREATE TYPE public.treatment_types AS ENUM (
    'I used exclusively natural health practices to heal',
    'I used both drugs and natural health practices to heal',
    'I used natural health practices only for drug side effects',
    'I used natural health practices after drugs failed to help',
    'exclusivelynaturalhealthpracticestoheal',
    'bothdrugsandnaturalhealthpracticestoheal',
    'naturalhealthpracticesonlyfordrugsideeffects',
    'naturalhealthpracticesafterdrugsfailedtohelp'
);


ALTER TYPE public.treatment_types OWNER TO "default";

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 24578)
-- Name: __drizzle_migrations; Type: TABLE; Schema: drizzle; Owner: default
--

CREATE TABLE drizzle.__drizzle_migrations (
    id integer NOT NULL,
    hash text NOT NULL,
    created_at bigint
);


ALTER TABLE drizzle.__drizzle_migrations OWNER TO "default";

--
-- TOC entry 217 (class 1259 OID 24577)
-- Name: __drizzle_migrations_id_seq; Type: SEQUENCE; Schema: drizzle; Owner: default
--

CREATE SEQUENCE drizzle.__drizzle_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE drizzle.__drizzle_migrations_id_seq OWNER TO "default";

--
-- TOC entry 3579 (class 0 OID 0)
-- Dependencies: 217
-- Name: __drizzle_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: drizzle; Owner: default
--

ALTER SEQUENCE drizzle.__drizzle_migrations_id_seq OWNED BY drizzle.__drizzle_migrations.id;


--
-- TOC entry 219 (class 1259 OID 24615)
-- Name: nhc_condition; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.nhc_condition (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name public.citext NOT NULL,
    disabled boolean DEFAULT false NOT NULL,
    name_es public.citext DEFAULT ''::public.citext NOT NULL
);


ALTER TABLE public.nhc_condition OWNER TO "default";

--
-- TOC entry 227 (class 1259 OID 139274)
-- Name: nhc_library_item; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.nhc_library_item (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    title public.citext NOT NULL,
    description character varying NOT NULL,
    created_by character varying NOT NULL,
    file character varying NOT NULL,
    poster character varying,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    document_type public.document_type NOT NULL,
    image_dimensions json
);


ALTER TABLE public.nhc_library_item OWNER TO "default";

--
-- TOC entry 229 (class 1259 OID 278528)
-- Name: nhc_policy; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.nhc_policy (
    handle character varying NOT NULL,
    title character varying NOT NULL,
    content character varying NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    content_es character varying DEFAULT ''::character varying NOT NULL,
    title_es character varying DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.nhc_policy OWNER TO "default";

--
-- TOC entry 220 (class 1259 OID 24623)
-- Name: nhc_post; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.nhc_post (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "user" character varying NOT NULL,
    condition uuid NOT NULL,
    treatment_specific_information character varying,
    other_information character varying,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    treatment_type public.treatment_types DEFAULT 'exclusivelynaturalhealthpracticestoheal'::public.treatment_types NOT NULL,
    solved boolean DEFAULT false NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    treatment_specific_information_es character varying,
    other_information_es character varying,
    original_language public.languages DEFAULT 'en'::public.languages NOT NULL,
    deleted_by public.deleted_by,
    dependant uuid
);


ALTER TABLE public.nhc_post OWNER TO "default";

--
-- TOC entry 224 (class 1259 OID 24669)
-- Name: nhc_post_comment; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.nhc_post_comment (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    content character varying NOT NULL,
    "user" character varying,
    post uuid NOT NULL,
    parent_id uuid,
    create_at timestamp without time zone DEFAULT now() NOT NULL,
    content_es character varying DEFAULT ''::character varying NOT NULL,
    original_language public.languages DEFAULT 'en'::public.languages NOT NULL,
    deleted_by public.deleted_by
);


ALTER TABLE public.nhc_post_comment OWNER TO "default";

--
-- TOC entry 223 (class 1259 OID 24656)
-- Name: nhc_post_to_treatment; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.nhc_post_to_treatment (
    post_id uuid NOT NULL,
    treatment_id uuid NOT NULL,
    benefit_of_treatment character varying DEFAULT ''::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    success_rating public.success_rating,
    benefit_of_treatment_es character varying DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.nhc_post_to_treatment OWNER TO "default";

--
-- TOC entry 221 (class 1259 OID 24631)
-- Name: nhc_treatment; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.nhc_treatment (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name public.citext NOT NULL,
    disabled boolean DEFAULT false NOT NULL,
    name_es public.citext DEFAULT ''::public.citext NOT NULL
);


ALTER TABLE public.nhc_treatment OWNER TO "default";

--
-- TOC entry 222 (class 1259 OID 24639)
-- Name: nhc_user; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.nhc_user (
    clerk_id character varying NOT NULL,
    membership_level public.membership_levels,
    age_group public.age_group,
    gender public.gender,
    place_of_residence character varying NOT NULL,
    full_name character varying NOT NULL,
    username character varying NOT NULL,
    business_name character varying,
    stripe_customer_id character varying,
    subscribed_until timestamp without time zone,
    website_url character varying,
    country public.country DEFAULT 'UnitedKingdom'::public.country NOT NULL,
    company_information character varying,
    address character varying[],
    photo character varying,
    email_address character varying NOT NULL,
    address_1 character varying,
    postcode character varying,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    practice_email_address character varying,
    services character varying,
    link json,
    deleted_by public.deleted_by
);


ALTER TABLE public.nhc_user OWNER TO "default";

--
-- TOC entry 226 (class 1259 OID 131072)
-- Name: nhc_user_accreditation; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.nhc_user_accreditation (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying NOT NULL,
    certificate character varying,
    other_info character varying,
    "user" character varying NOT NULL
);


ALTER TABLE public.nhc_user_accreditation OWNER TO "default";

--
-- TOC entry 228 (class 1259 OID 270336)
-- Name: nhc_user_dependant; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.nhc_user_dependant (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id character varying NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.nhc_user_dependant OWNER TO "default";

--
-- TOC entry 225 (class 1259 OID 122880)
-- Name: nhc_user_to_treatment; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.nhc_user_to_treatment (
    user_id character varying NOT NULL,
    treatment_id uuid NOT NULL
);


ALTER TABLE public.nhc_user_to_treatment OWNER TO "default";

--
-- TOC entry 230 (class 1259 OID 335872)
-- Name: nhc_webhook_event; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.nhc_webhook_event (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    source character varying NOT NULL,
    data jsonb NOT NULL
);


ALTER TABLE public.nhc_webhook_event OWNER TO "default";

--
-- TOC entry 3347 (class 2604 OID 24581)
-- Name: __drizzle_migrations id; Type: DEFAULT; Schema: drizzle; Owner: default
--

ALTER TABLE ONLY drizzle.__drizzle_migrations ALTER COLUMN id SET DEFAULT nextval('drizzle.__drizzle_migrations_id_seq'::regclass);


--
-- TOC entry 3560 (class 0 OID 24578)
-- Dependencies: 218
-- Data for Name: __drizzle_migrations; Type: TABLE DATA; Schema: drizzle; Owner: default
--

COPY drizzle.__drizzle_migrations (id, hash, created_at) FROM stdin;
1	71dc2081e7143a4b67b0a8bd91ef767597a64343276602d21c7b944d5b521260	1710258259256
2	59ff52f0adc7047c62d14d47a20369b21e2de2b003f2f1ca17c4d88b02eab3fa	1710418082203
3	20f8e89d4cc4d61fe1ca2e6d9d9242bae30bad6ff00df13aeb2034208fbe2129	1710429937969
4	8fa5df02df8712c95d9e45ab4f5842c12695ac9f7b98cb25401f7744d98de26f	1710430107616
5	98c72f879cd48f0bc90bb040d78ed1a04be45f4164cb8e98af5e7a64ba763a64	1710434087284
6	8df1c00d31cec1610e902e305803b9ea0334c7ed3b12d64457d2beb309618fe3	1710496789042
7	3d0cd2bed369c597da6f7cea9979a7a0ba86a1c2433046043cdc697bd9b07836	1710496805028
8	09e8da98590647333257da6814f60a38c3f1fa61594fcae4a7196e574638d893	1710497687413
9	b5f97e6151b73b05e7bb6fe18426f3cedca47bcd3ead545c33ce890bff4827cf	1710498972154
10	6beca9f25581224c6f1b4cd0b1a465267e8b4d82d93d431172b8e6c590f50395	1710511831912
11	a4455b82e9e23dd1adf9ce2cfa46ce240cbba76efedddf7b5a75e26ad32876fe	1710511963989
12	90e81d5347157d2b3c80750e09a3469f792efda3830800d80f8ed80afc401630	1710515009441
13	4a1268b0ba68b46f871a4cfd48c0e573aad0db8a581ae02811e152caec65f6b6	1710842148217
14	7b7af64605ddf660f93d645749e474cae625d15c2e177b7fa470872454956112	1710842207450
15	e8348173641b31d3ed380a3db862f92d0f0aa0df748b5ee3f2f5c95bfcfc9495	1710942283460
16	3c91cd39966377bc8f9c7deb96b814aae77a442de6bc1a00aef8475819a0cf57	1710946540315
17	09dc3970f03f9752ca13afb2ed9e1ca66ccff629cdccfa70c8ed59fafd122c52	1710947873003
18	3b89c1eec0c59dbef741170ccefab42204d394ee319bc56af3250577ac893ea4	1711104857480
19	9f1f2cdc7fae6769bebfe73afcd763d34928d57ad05e35828fb90da0577c5623	1711124026579
20	cf6868d9fd9637c524743ba1394750b31f5a6d6ac7226ced4217906f864a1f15	1711453373228
21	3f64ecbb1dfe33d2308868dc2203c9aa063c816d6791ec3f8ea1f8df03c8ed60	1711453386349
22	452e1319607fab2d8df964e38e709bb85ccaccec0d8ca06c87f3689dc092b6a7	1711454930986
23	3ad25bc5518be1340d47729d75365b4b8c181c2eebc977fe517cfd55e90a0f92	1711539186078
24	56d05d3c0c9cf729e0216cf9d5768b0f57a709ef079626d99dbd7dda283898dd	1711541646114
25	0023d6a1bc7cea7d468f9157329c329cc7fd401ccc888c1c8626d8c582e1f3a8	1711549142773
26	97fb6d2d24b451829c231fb360fce20991f083020ea93f42508490ebd1d77ca8	1711643665622
27	0434c2bba2ee28dcbcf1ec74ee7e2ff77adaac6fb00ec53765e7ffddb15f2bfb	1712755669942
28	424424e4126a75cf8ec481b2490fdf632c03e24b2c71bf5256b77a9f8529ad0f	1712829351120
29	f770db96efd905719ba6c63e31ad53a4d3672f7d88406368e316243a2197355e	1712829365970
30	cf908632890bb5df4162ba3876238625984b98947e557c2c19cd46fc347ebf2f	1712849514307
31	bd5ca43a4180d18baf761a953bffe4e00da0a9483d940411be796231222df272	1713272802959
32	f725742b7a2f22ba63986b7ef469cc069dbf7214e8ed5873070ef78f239adbaa	1713870189291
33	f9247edaffd1222b6145348a7e1e6f143306852bef4c7181c3879c6e59fc26ad	1713878307270
34	21e04898d0f6a795b068a9fc2bbf9dccaa76ea9c84a4c8ce95b0b0dcb4a04758	1713955926850
35	45c539c099c316e65bbd9715a841bfb2e004e31a301bd38231e0f8d590c19f8e	1713962218207
36	9f0f6d4f58d0f87f6290c8b28fb8a9b33b964da0836222af426c684f6fcd7ca7	1714056200738
37	774bcf56280ea63b74746e1b7d046d7e39c5197d86b4945fef5c287c5d0b12e0	1714057893778
38	c2e66fcdb6ea2725f109369f9bfee0475383a05250842ce18d18a533da9509b1	1715680330623
39	c0b643c4ccfb7b3dda51a0248075872a7bd2fa52f833300cbed670c1b10db026	1715680760171
40	d7e18c2e7e24c3117f72fa0292474e372cbdf72a9dd263c92ccfa8782d2c996a	1715681035327
41	5e44e04d7293d5f1be55608a8ffb05d9e1f71d3a1559138e9ef8a6d7680f8af8	1715781702118
42	50d22bace247c6ba156f04a8bfbcde1a324480df8765dcf9b5bce8cf47c11eb8	1715783797698
43	13e28b52060f4ec8962016e27d399a882e9c8bc4e2be1af85c7eb78c77f117a6	1715787427765
44	d08612374221bdf5974d0b15657b237a08c31cf2fe0f179e9e77d44f0d185dd7	1715851232813
45	cd90190c2fac04b1fdb0971d7d97702fc06c550a8b3163f078a7a68ffb097f43	1716387930997
46	4c56bd717ab3e15c9ea9845d8928d4f26b1c4ba4d3aaf68364da93db7ef65bdd	1717599798668
47	f598b6d4c84b8f5d41779fa5e1f130a1252cbb3bdeb814d107db7e84851994a2	1717600121745
48	566c93c7b441ea5357334111dbd11d49cc9e9145a314687b115bd5f36218baef	1717600423744
49	89a10cd089ddcecab2c097fe2aa2da8d9f3d27464a15774648f64fba2e025b92	1717774425555
50	a7bca7966ee1d169fcf777ef6d779d65dff2bd9dc1059586528111a0eb89d4bb	1718094591077
51	90d39234e53a7da4122129ff4b1a1977f1ddab849f49b7411f57620c30a056c8	1718094972063
52	6415dbd62c7e1c66a709e0ef2daf8c4bc0b3010e6eec69858a5b80b4c2044336	1718097018846
53	0c94d7eeb9257948903c07ab6906c004846f3833c788c4b1e28cb490db5a1b4f	1718294506036
54	1bbc16a337a636ef369931f704b7a234381d04c0ba6121041ac934430373e04d	1718710523930
55	74979af9b6b8885927b085552dd56fc4bb16f1086bd5e6bc909f54694a54ee14	1718710535347
56	1375250db00df2ee08d028b32bc704414e4df76f49af1c9ca984f1eca2f406f5	1718813226839
57	6807222fdff835bfa6a864c7df3f6fe51211923bf8c77cb135a39f625591e912	1719930850489
58	d63626a44f7f80760c20228b4e030115f9261630845b2f092d146b36f876935a	1720012979565
59	59e329a9fae66b214183c99726ff9f33fb0b8ab093270d6e6adb20bd4502c1e9	1720013497467
60	c8693fcc2a12f0a188582ca1cb8495e81159b36a2b386bdc5f2372328fd7b5aa	1720185679717
61	ecaf6f23d0b3ce49e1f06f179ff754fac92f8c0022ff94f97be36823eb13b8e4	1720190389801
62	4ef27e7e8c16c924a8b9ad1fd360099492d5935c77f4fa2f87789ac9adf2deb4	1730997751412
63	9275ebf03bdcb08d058f36b5d12f9f5cafe8e0074a9bd85709e382dd4df53bda	1730997778876
64	92582c3e756c3357024b796e924625ec619c6c85afe3be9f52adec18f8ceb3e5	1731061215716
65	66e73d65830f368f704aca63385d56674f801d0bd80622c58b107d16fe509ffc	1731061896860
66	223788e7db02a5f01971aa9a9e62c038c210fac4bead018a0ba128f8660be56c	1731681170438
67	8f623e32bc19b3c6646bf254013978d4b7aff97b90750ba5aa4e85ff16665cb4	1733313672565
68	c62370abbf4d5d063cf77a2db1ede848e1388c983062958f404eaf3ab31d6cc0	1733321485732
69	77dc1d8d1e4d7ba81e031c8fd908f64b151e593af7a058fbf63d80b87fd65a67	1733321826456
70	ebc56a8e78958ab93da7e6ae52614e2e5cf60399ed6f5469e1bbbc98cff9124b	1733321877084
71	35d7b0b398312fe366168a8e020cf3f9879ac089d9aea7e6379b28c6529a384c	1733398467660
72	5d3cc0d79afac4b83e74cb2699f8d9a3febe8786770c5d23a73729545fd9782f	1733407977103
73	3d0bf0f9f66fd3335abe841ac79956dc3f55b8b5930d78ced6b0e54ee7b8461a	1736262617192
74	6a0e8e222b5b3cea0df148b0677174171481b8d0393eaa728df1eb34ff7c072b	1736262663251
\.


--
-- TOC entry 3561 (class 0 OID 24615)
-- Dependencies: 219
-- Data for Name: nhc_condition; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.nhc_condition (id, name, disabled, name_es) FROM stdin;
b61036e9-a3fc-41fb-b3a3-1b59e33acbf0	Behçet's Disease	f	Enfermedad de Behçet
c9dd4dc9-718e-49c3-94b7-0e5dcdd63b29	Graves’ Disease Or Autoimmune Hyperthyroidism	f	Enfermedad de Graves o hipertiroidismo autoinmune
6c6a619d-a7ee-4e58-94a0-9899fc73cec3	Meningioma	f	Meningioma
c1fdf10c-d06a-4cc3-9331-4820fd3c9c14	Acid Reflux	f	Reflujo Ácido
6ccc3640-675b-4d40-8659-fb7b3d672264	LAM (Lymphangioleiomyomatosis)	f	LAM (Linfangioleiomiomatosis)
f647b6ad-e128-40e2-a181-7ea08f3280d5	Multiple Chemical Sensitivity (MSC)	f	Sensibilidad química múltiple (SCM)
799acc2b-55cf-424c-a075-eadf0cf4e4b8	PFPS (Patellar Femoral Pain Syndrome)	f	PFPS (síndrome de dolor femoral patelar)
2091db14-1d45-4641-b3bb-8456c1fdc941	Sclerosing Cholangitis	f	Colangitis esclerosante
ae9e35ea-f195-4819-b38b-f0ee6ccd9c07	SIBO (Small Intestine Bacterial Overgrowth)	f	Sobrecrecimiento bacteriano del intestino delgado (SIBO)
487a98b4-e98f-45b9-9057-3ab29f4f5c22	Abnormal Liver Enzymes	f	Enzimas hepáticas anormales
f3505f81-f0b9-473c-8580-8faf6c4eee05	Achilles Tendonitis	f	Tendinitis aquílea
fc0a7fe9-03fc-4ea2-a76a-cae51b10761d	Acid-Alkali Balance	f	Equilibrio ácido-alcalino
04ffe464-e0e9-4cd0-95c4-a221c78effd0	ACNES (Abdominal Cutaneous Nerve Entrapment Syndrome)	f	Síndrome de atrapamiento del nervio cutáneo abdominal (ACNES)
18f405b8-9bae-4d5d-ac90-405beaf38736	Acquired Hemophilia	f	Hemofilia adquirida
ef4fcaed-7112-4d6a-ae92-808840cac98f	Acute Motor Axonal Neuropathy	f	Neuropatía axonal motora aguda
ae59b4b7-1f10-4c01-9bd1-aab3cecc1808	Addiction	f	Adicción
2edf56f4-e8ef-4581-a105-78bdc0359d08	Adenomyosis	f	Adenomiosis
b847ae5b-99c4-4fcd-84b5-216c75c9785e	Addison’s Disease	f	Enfermedad de Addison
2eb8a78c-5dd6-4dbe-b84c-8ef831143289	ADHD	f	TDAH
0c77f3ca-2895-4e6e-83d3-fe28c0cfdfe0	Adrenal Fatigue	f	Fatiga suprarrenal
22313d0d-fd6f-4f5d-bb43-f536b0b0e2e5	Adrenal Hyperplasia	f	Hiperplasia suprarrenal
23acf069-cda6-41d7-bf16-6fc30985168d	Adrenal Stress	f	Estrés suprarrenal
39fbe95b-5319-4a87-b1de-8319266339b8	ALS (Amyotrophic Lateral Sclerosis)	f	ELA (Esclerosis lateral amiotrófica)
68d62a1b-593f-4574-8310-105f0b87b0d7	Adult-Onset Still’s Disease	f	Enfermedad de Still del adulto
67f779a4-4117-47b6-a73a-a8e42b246b9a	AGS (Alpha Gal Syndrome)	f	Síndrome de alfa-gal (AGS)
72a6f6d6-1657-4e86-a1ec-69ae6328a201	Akathisia	f	Acatisia
0394e706-420a-4020-b1ab-d8f465f4a47c	Allergic Muscles	f	Músculos alérgicos
2699a11b-ec75-4b1c-bfac-77317b1adc0f	Alopecia	f	Alopecia
7852566b-a4ad-47f1-9fb2-0c286d692a47	Alpha-1 Antitrypsin Deficiency	f	Deficiencia de alfa-1 antitripsina
2dd48dae-3742-4e7e-99bd-377a9994d86a	Alzheimer’s	f	Alzheimer
3ea906ca-0beb-41be-a612-2cf64b3550a2	Amyloidosis	f	Amiloidosis
7b84fb50-ca32-4361-8170-7026b68ad176	Anal And Perianal Fistula	f	Fístula anal y perianal
9ea1024d-093f-4bbe-a1cf-254d969e52fe	Anal Fissure	f	Fisura anal
dcbbdf39-b86f-480a-8296-ec525f72ccad	Anaphylaxis	f	Anafilaxia
7b161f66-9ed7-4af0-b6e9-4ecd6bb41ca1	Acne	f	Acné
a1b06861-c98e-41f0-8504-609506af0b98	ANCA Associated Vasculitis	f	Vasculitis asociada a ANCA
c6b610b7-e098-4ec3-a94b-2eb503773bdb	Anemia	f	Anemia
0ea38c90-28cb-434a-bb72-c8904a2149c1	Angina	f	Angina
c6543109-7a0a-4109-95e1-3b3838345d78	Ankylosing Spondylitis Or Spondyloarthritis	f	Espondilitis anquilosante o espondiloartritis
f2384702-82f0-48ff-9715-f1d82680086d	Anorexia	f	Anorexia
1c3ac722-76b9-45a9-9144-9615c9f2a1ea	Anosmia	f	Anosmia
30224e24-b697-45e6-afbf-ba14476d2097	Anti-GBM Disease Or Goodpasture’S Disease	f	Enfermedad anti-MBG o enfermedad de Goodpasture
b591f7fc-c7a5-4637-95ee-4ae30b8d4292	Anti-NMDA Receptor Encephalitis	f	Encefalitis anti-receptor NMDA
444f7544-da21-4c0b-bd82-48f4c6cce293	Anxiety	f	Ansiedad
46028e1a-d825-4e3f-91e2-8c2fe92fd440	Autoimmune Lymphoproliferative Syndrome	f	Síndrome linfoproliferativo autoinmune
a7cacf8e-8f12-4aa3-8d4d-c6160a2ecd9e	Asthma	f	Asma
adc74399-13a2-41f2-8de6-2fe207dada60	Autoimmune Neutropenia	f	Neutropenia autoinmune
d9d00cf0-ffdd-4c19-946a-9d05ae34c1d8	Aplastic Anemia	f	Anemia aplásica
8a93a267-b96b-490a-9056-58808b94dd03	Apnea	f	Apnea
5d562c81-cfac-413e-91aa-d10aecd481ce	APS (Antiphospholipid Syndrome) Antisynthetase Syndrome	f	Síndrome antifosfolípido (SAF) Síndrome antisintetasa
860337bd-44fd-4abb-a400-b0a4045c5514	Arthrosis	f	Artrosis
f7de84cb-4bc2-4dd8-9756-b4d4dd73cb61	Artery Disease	f	Enfermedad arterial
ae7bdfa8-dab6-4214-9209-707bee0ec930	Arteriosclerosis	f	Arterioesclerosis
6c5563f6-04d5-49e1-91e7-19dd06ace5f6	Arachnoiditis	f	Aracnoiditis
3bf597ca-9d93-4e32-b263-5a7764e7098c	Asherman’s Syndrome	f	Síndrome de Asherman
114ae51c-1d72-4b5e-a0ad-a4d520d37607	Athlete’s Foot	f	Pie de atleta
17ebc64f-efba-4d75-afb8-d5f2e63a5cd9	Atrial Tachycardia	f	Taquicardia auricular
167c3c37-f57a-45b4-9b43-524558179c45	Autism	f	Autismo
827f02dc-864a-4d66-9385-7c4f68a6c174	Autoimmune Angioedema	f	Angioedema autoinmune
af8e2b77-0d83-4e02-9cb8-2a8cc5bb9802	Autoimmune Oophoritis	f	Ooforitis autoinmune
c93281ad-1f5e-4d67-af34-d91f434dd5dc	Autoimmune Cryoglobulinemia	f	Crioglobulinemia autoinmune
85dfe5c6-2bf2-467f-a377-ada499426719	Autoimmune Orchitis	f	Orquitis autoinmune
1e24fd48-4bc9-4399-8725-39a9e1448811	Autoimmune Enteropathy	f	Enteropatía autoinmune
f6fee9e9-096d-437a-8a4e-ac463c43c3c0	Autoimmune Gastritis	f	Gastritis autoinmune
4fdd4893-c83c-4bd5-9a89-9bf8297b7fb4	Autoimmune Pancreatitis	f	Pancreatitis autoinmune
63994c03-8b92-4034-a592-15b4ea30abca	Autoimmune Hepatitis	f	Hepatitis autoinmune
183e8959-5e01-4044-822e-6e8d287faaaa	Autoimmune Inner Ear Disease Or MéNièRe’s Disease	f	Enfermedad autoinmune del oído interno o enfermedad de Ménière
2692c3eb-e205-4208-9cd2-df88d155a957	Autoimmune Polyendocrine Syndrome Or Whitaker Syndrome	f	Síndrome poliendocrino autoinmune o síndrome de Whitaker
9bf91dcf-af1e-48f6-8e99-8e80af930a06	Autoimmune Progesterone Dermatitis	f	Dermatitis autoinmune por progesterona
cf338d45-c4a0-438f-acfc-642558b39ee2	Urinary Infections	f	Infecciones urinarias
7901026f-26c2-4a08-b63a-4d48da8664a9	Autoimmune Retinopathy	f	Retinopatía autoinmune
a306bf7a-eaa7-4860-aca4-0e56f2fdee34	Autoimmune Thyroiditis	f	Tiroiditis autoinmune
1df05524-0060-4fa0-8509-29648750fd3e	Autoimmune Urticaria	f	Urticaria autoinmune
9f94532d-432c-47a6-a727-5d3b3cf32dc9	Autoimmune Uveitis	f	Uveítis autoinmune
0c2173c4-de40-42c2-8528-6419d9fed102	Bacterial Vaginosis	f	Vaginosis bacteriana
2d4b41cc-02bd-4e79-88bc-c08ed27c0f6e	Balo Concentric Sclerosis	f	Esclerosis concéntrica de Balo
c446465d-4b60-4541-a230-4754186c5bd3	Bertolotti Syndrome	f	Síndrome de Bertolotti
fcb4ccef-814e-412c-be14-b06b97610d43	Bickerstaff’S Encephalitis	f	Encefalitis de Bickerstaff
b5db5f4c-72a9-46f4-9e6d-420fab8a7ec4	Bipolar Disorder	f	Trastorno bipolar
4e43ac91-981e-4549-a360-0dd7dbcf0021	Blepharitis	f	Blefaritis
90d5994f-42ca-4dee-a27c-0e0d86916bbf	Blood Clotting	f	Coagulación sanguínea
c28bae7c-a50a-439b-a4f2-34da2f3b9de5	Borderline Personality Disorder	f	Trastorno límite de la personalidad
37e81b2b-8406-443c-98de-7725b7df6cc8	BPH (Prostate Hyperplasia)	f	BPH (Hiperplasia prostática benigna)
ad94ed59-d429-4c6c-ba28-7b6126b6419c	BPPV (Benign Paroxysmal Positional Vertigo)	f	BPPV (Vértigo posicional paroxístico benigno)
3f78360c-07d6-459f-bfb1-61d774d0df0d	Brachial Neuritis	f	Neuritis braquial
8f59ef83-a20f-4665-a837-143a6ff1be6c	Brachioradial Pruritus	f	Prurito braquiorradial
49603587-78cd-4eb7-b663-538a94af38a8	Breast Cancer	f	Cáncer de mama
b7d48d22-7bd0-434b-acd4-8a3bffc73b7d	Bronchiectasis	f	Bronquiectasias
b072271a-aee9-4ea8-bddc-fa46aa87765f	Bronchitis	f	Bronquitis
df069947-5ed3-4e6e-8ad2-a5f55802a239	Bruxism (Teeth Grinding)	f	Bruxismo (Rechinar de dientes)
61b32f3b-d081-4384-8f2f-b290ee0ac14c	Bulimia	f	Bulimia
98243ffc-ae5e-421a-9a0e-37dd18fee3d5	Bullous Pemphigoid	f	Penfigoide ampolloso
bf18d670-3726-44ba-9f06-790ec622ab7d	Burnout	f	Burnout (Síndrome de burnout)
22420891-5513-4659-bc34-d53150b7e56a	BVD (Binocular Vision Dysfunction)	f	BVD (Disfunción de la visión binocular)
962056c2-fb2f-42d1-b2d1-16be5216137b	CADASIL	f	CADASIL
7cfa3ab8-428a-4cde-95cc-d0d0d97c9d3d	Candidiasis	f	Candidiasis
a13cb38e-de6a-4ac3-8b32-0e39b6d245c0	Cannabinoid Hyperemesis Syndrome	f	Síndrome de hiperémesis cannabinoide
1081b0fc-edf7-479d-beb5-20b2adc5ce9c	Cardiac Arrhythimias	f	Arritmias cardíacas
5aed53cd-e54f-4dc9-9f51-f734a7c1c06a	Cardiomyopathy	f	Miocardiopatía
26d1cfc6-df01-4290-8ab6-f796831740b6	Carpal Tunnel Syndrome	f	Síndrome del túnel carpiano
dd09b885-af6b-46c4-9e47-863b1374a075	Carpel Tunnel Syndrome	f	Síndrome del túnel carpiano
728b1c38-572c-482a-b26f-c213d6a2c31c	Cataract	f	Cataratas
5547c2e7-9942-4845-a3c0-2a9e1fe43d0f	Celiac	f	Celiaquía
ac4f6990-e1dd-4976-8f29-6282b948df78	Celiac Disease	f	Enfermedad celíaca
edd3a509-1d76-4aba-8a94-0f60f3791748	Cerebral Palsy	f	Parálisis cerebral
2d2dc89a-a614-46ec-b2b5-f44c265d8a0f	Cervical Dystonia	f	Distonía cervical
f8afd5a3-3d70-47c3-b0ea-597125c191b0	Cervical Stenosis	f	Estenosis cervical
6fc6b4c3-9946-4c47-9548-0a1b98a77785	Charcot Osteoarthropathy	f	Osteoartropatía de Charcot
1070ade4-661c-4fc9-8601-04dd0d597bc1	Chemical Toxicity And Sensitivity	f	Toxicidad y sensibilidad química
0d171992-fb90-473c-bc3b-32c702d2a04f	Chiari Malformation	f	Malformación de Chiari
725fafb7-38f2-4468-a28d-baa3bd7ca474	Chlorioretinopathy	f	Clororretinopatía
7ef8d9de-6b70-4757-8f39-5c9521257de4	Cholesterol Disorder	f	Trastorno del colesterol
8bf7c983-cb6d-4155-934e-2656fc97083d	Chronic Fungal Infection	f	Infección fúngica crónica
62327f11-6289-41a9-bd65-925ad28096f8	Chronic Hepatitis C	f	Hepatitis C crónica
13597548-0a18-47e0-8629-ac05cccd9dd1	Chronic Infections	f	Infecciones crónicas
21943898-19f1-49b7-aebd-8e391623e98c	Chronic Inflammation	f	Inflamación crónica
625cbf62-fc0a-4959-865d-b73774f49234	Chronic Inflammatory Demyelinating Polyneurapathy	f	Polineuropatía desmielinizante inflamatoria crónica
df5532c1-e15a-4c71-a48e-b9dfee3ee500	Chronic Pain	f	Dolor crónico
b61495c3-42e5-450d-b952-4bd6da0c9b8e	Chronic Pathogen Colonization (CPC)	f	Colonización patógena crónica (CPC)
a3eabed8-c381-4fc0-8c16-3bf2c39d37e6	Churg-Strauss Syndrome Or EGPA	f	Síndrome de Churg-Strauss o EGPA
5dae4a50-0951-4145-a95e-8e154ea65924	Cicatricial Pemphigoid	f	Penfigoide cicatricial
4368c0f5-9fc4-4e22-a545-6f5ce977cbb5	Cirrhosis	f	Cirrosis
5ee0487e-6385-48b7-b035-c367aa7c9c40	CIRS (Chronic Inflammatory Response Syndrome)	f	CIRS (síndrome de respuesta inflamatoria crónica)
3d2765d7-82d1-4d59-9bda-aa534d2837ce	Clostridioides Difficile	f	Clostridioides difficile
c961d99f-f67b-4ee6-8b68-54c74ea95cf6	CMT (Charcot-Marie-Tooth Disease)	f	CMT (enfermedad de Charcot-Marie-Tooth)
9ef07934-573d-423d-9d58-59a390408946	Coccygodynia	f	Coccigodinia
00eab1c7-5b3b-4efa-b201-c42ae6bf641f	Cogan Syndrome Or Diffuse Interstitial Keratitis	f	Síndrome de Cogan o queratitis intersticial difusa
fb5eb48a-323f-4b8f-8339-65821ba92e46	Cold Agglutinin Disease	f	Enfermedad por crioaglutininas
99259e43-651e-421f-a510-81e8ae290781	Complex Regional Pain Syndrome	f	Síndrome de dolor regional complejo
e67903fe-53e4-4562-ae4f-2882e1f8557f	Conjunctivitis	f	Conjuntivitis
c3b20f69-5030-4d56-a58c-28b1dc72ff53	Constipation	f	Estreñimiento
a2911abe-3f97-4510-82c9-32881e679856	COPD	f	EPOC
092d1792-bc8e-403b-b3ad-2aca97fc583d	Corneal Erosion	f	Erosión corneal
caa08760-2832-4085-addd-7a34c6c02787	Costochondritis	f	Costocondritis
ba2f46a8-7d45-4e17-90bb-f20cf48831c9	Cranial Arteritis Or Horton’S Disease	f	Arteritis craneal o enfermedad de Horton
eae93db6-e024-4371-88dd-78fa5d17b3a0	Crest Syndrome	f	Síndrome de Crest
0dac6a8f-2971-49ba-88f8-6bc499fc452f	Crohn’S Disease	f	Enfermedad de Crohn
e649f830-8b6e-4dbb-a093-4f1fbda58411	Cryptogenic Organizing Pneumonia	f	Neumonía organizada criptogénica
9ce8c635-6cd4-421b-a93c-fe32acde2df4	Cutaneous Lupus Erythematosus (DLE)	f	Lupus eritematoso cutáneo (LED)
3cfe1bb6-f567-4a54-9fb1-0ae58a67c1b1	CVID (Common Variable Immune Deficiency)	f	IDCV (inmunodeficiencia variable común)
fc3c5efd-afcb-4775-aec1-89c60d75896e	CVST (Cerebral Venous Sinus Thrombosis)	f	TSVC (trombosis de los senos venosos cerebrales)
95444c89-93be-4a53-94d2-64142f0ddd2c	Cyclic Vomiting Syndrome	f	Síndrome de vómitos cíclicos
89a7869c-86fc-4fd2-8188-de9a5306f01a	Cystinuria	f	Cistinuria
82bf24e5-354e-4c8a-80a2-c4f92b03b04c	Cystitis	f	Cistitis
6ddcbb65-9f43-47da-9324-f3651a88f12e	Cytomegalovirus	f	Citomegalovirus
37f424a3-5b1d-4656-8ac6-9bec7208d8d7	Darier Disease	f	Enfermedad de Darier
54baac3e-771b-4d31-8e88-255341730ab3	De Quervain Tenosynovitis	f	Tenosinovitis de De Quervain
644a3021-ce65-4bb0-ac16-5a3994f1a17c	Degenerative Disc Disease	f	Enfermedad degenerativa del disco
e1e55135-85a9-43eb-8966-d9deb887d104	Dementia	f	Demencia
7ebfd5ac-69fc-4969-87ae-b1f202706762	Depression	f	Depresión
8c323561-91b5-4851-9fd0-8bcd9bb01f06	Dermatitis	f	Dermatitis
24633d38-bba1-474b-9ec9-e7c0e4fb8aa1	Dermatitis Herpetiformis	f	Dermatitis herpetiforme
9a0108c6-5018-4279-8352-405575b85cfe	Dermatomyositis	f	Dermatomiositis
167568c2-ee22-4176-8d45-e1ef2d8b8be6	Diabetes Mellitus T1	f	Diabetes mellitus T1
8d0eb6ed-d6d5-4228-a29d-4c71380da303	Diabetes: T1 And T2	f	Diabetes: T1 y T2
2708f698-15e6-494e-affd-8da2473c96d0	DISH (Diffuse Idiopathic Skeletal Hyperostosis)	f	DISH (Hiperostosis esquelética idiopática difusa)
c0012550-a2d8-4b7e-9d74-368c569e1932	Diverticulitis	f	Diverticulitis
d469625b-8e72-4c0a-9d30-5137e4a066da	Diverticulosis	f	Diverticulosis
8cc45387-6664-4d3c-b1aa-e82eb8c44997	DMDD	f	DMDD
633e612f-7bfc-4981-aeef-4e1949b6a991	Drug Side Effects	f	Efectos secundarios de medicamentos
1da9663f-d23a-4b6f-80a5-02a843ce1b5d	Dry Mouth	f	Boca seca
63a29cca-23d5-4bec-a1c8-a5eb2bb84d0b	Dumping Syndrome	f	Síndrome de dumping
98bc2ff5-7d9c-44a6-b480-cc8c2d3f0c6d	Dysbiosis	f	Disbiosis
9b406829-43a4-4524-9f87-e9d67d33c296	Dyshidrotic Eczema	f	Eczema dishidrótico
06866090-42d8-44b2-89f4-7a22cc8a3f8e	Dysmenorrhoea	f	Dismenorrea
78f0d7d0-9bd6-4421-9ae6-ca188288d81e	Dyspepsia	f	Dispepsia
cb9d862c-4857-497a-9a4b-d238b9691040	Dysrhythmias	f	Arritmias
94e1590a-b722-4ac2-a1fc-f80b96fe0069	Eczema	f	Eczema
6643226e-b9a9-47b4-81b5-275947c0b12e	EDS (Ehlers-Danlos Syndrome)	f	EDS (Síndrome de Ehlers-Danlos)
a80bd39a-921b-4c17-9aaa-588c79202b52	EMF Related Diseases.	f	Enfermedades relacionadas con los campos electromagnéticos
668327d1-24da-4359-b21c-1ad21ec22d58	Emphysema	f	Enfisema
e54a279d-ee0a-4ef0-be76-a57600f97e23	Encephalomyelitis	f	Encefalomielitis
b45c2e72-ed4d-474e-988b-e935289dc280	Encephalopathy From Autoimmune Thyroid Disease	f	Encefalopatía por enfermedad tiroidea autoinmune
8780cce4-f399-4638-98a3-444a74805e81	Endometrial Cancer	f	Cáncer de endometrio
1a7422c0-104a-48d4-9b60-39a287788117	Endometriosis	f	Endometriosis
837d6869-3a74-472f-82fe-7f0d438c296b	Enthesitis-Related Arthritis Or Rheumatoid Arthritis	f	Artritis relacionada con entesitis o artritis reumatoide
ce3f0649-ca88-4c3e-a2a4-974343a7989f	Enzyme Deficiency	f	Deficiencia enzimática
559ba96f-ad09-40f1-a53f-7e874b18770a	Eosinophilic Esophagitis	f	Esofagitis eosinofílica
d8c70582-a478-45b2-ba83-ba2feff52199	Eosinophilic Faciitis	f	Fascitis eosinofílica
5da2f8f2-1cd1-47f3-b6c7-cbce320b6067	Epidermolysis Bullosa Acquisita	f	Epidermólisis ampollosa adquirida
8117bf5f-aec5-4ed8-b2df-b8b40cd7328d	Epilepsy	f	Epilepsia
560141af-cfec-4737-9e72-b9caca093fdc	Episcleritis	f	Epiescleritis
1d37bc87-8b8b-41b7-9232-0f3406aff86a	Epstein-Barr Virus (EBV)	f	Virus de Epstein-Barr (VEB)
48127b05-5b3c-4527-89c3-0bb4f7a33a2e	Erythema Nodosum	f	Eritema nodoso
bf2807a4-50c0-40cd-89af-e882b1d9a9ac	Esophagitis	f	Esofagitis
2fb041a8-7a00-4f9f-9d12-e5c5d13db75f	Essential Tremor	f	Temblor esencial
684002d6-e66d-4d5a-977e-2257e8e8f01c	Evans Syndrome	f	Síndrome de Evans
4d40b420-7206-4976-9a1d-2bba21228d65	Ewing Sarcoma	f	Sarcoma de Ewing
dc009341-f450-4773-a26b-2e642bd9c0aa	Excoriation Disorder	f	Trastorno de excoriación
286727d2-ed20-471d-b167-79985025f11d	Eye Floaters	f	Moscas volantes
b81047d8-e3ea-4f2c-ae80-82546f1b9f87	Fabry Disease	f	Enfermedad de Fabry
08ffdcea-22be-48c9-b57f-675cd769512a	Facioscapulohumeral Muscular Dystrophy	f	Distrofia muscular facioescapulohumeral
33175168-39c5-43ec-a0da-84e5682fe203	Familial Mediterranean Fever	f	Fiebre mediterránea familiar
66961033-849c-4248-8e27-6e706606a77f	Fasciculation Syndrome	f	Síndrome de fasciculación
31c11b6a-0465-4f95-9db5-f6113b44e91f	Felty Syndrome	f	Síndrome de Felty
c3074a2c-19d9-4511-8528-c1c2d366cac2	Femoroacetabular Impingement	f	Pinzamiento femoroacetabular
d344123b-56c8-4546-ac39-b7c17e0eec71	Fermenting Gut	f	Intestino fermentador
37c20d2b-0aec-4739-8bee-645083c657c4	Fibroids	f	Fibromas
274bdd82-44e5-4996-a08b-dc83d2d451b0	Fibromuscular Dysplasia	f	Displasia fibromuscular
0b3aab5b-4650-4cb0-9914-72be1f0e9195	Fibromyalgia	f	Fibromialgia
abef9804-3355-46b6-a45f-2b93ddc12f1e	Fluoride Toxicity	f	Toxicidad por flúor
ef6172ec-f6f3-4585-8fba-699e11473524	Fluoroquinolone Toxicity	f	Toxicidad por fluoroquinolonas
d0d5ebe8-10bc-4a6c-809d-3a80f5b164c1	FND (Functional Neurological Disorder)	f	Trastorno neurológico funcional (FND)
d530eb1b-3091-4b34-b4e7-96d825b33d92	Folliculitis	f	Foliculitis
f713df24-18d5-40b4-8943-ee2a9f3d6256	Food Allergy	f	Alergia alimentaria
5fc79a9a-f69c-4e80-a0d2-fc3c8f16424c	Fowler’S Syndrome	f	Síndrome de Fowler
b67eb8b2-ab28-43d7-9ca1-b6e3d18741a3	Frontal Fibrosis	f	Frontal Fibrosis
edcd75a8-c90d-4918-b1f0-852bb33ed50e	Frozen Shoulder	f	Hombro congelado
b6d69af0-b215-48e1-8121-d4dde4c3f575	Gallbladder Disease	f	Enfermedad de la vesícula biliar
d640aff2-c75d-41db-af88-889bf84a2973	Gallstones	f	Cálculos biliares
5879935f-da00-44bf-b034-ca73853fbb06	Gastroenteritis	f	Gastroenteritis
7f430468-5905-4a4a-8ce8-8ca68061932a	Gastroparesis	f	Gastroparesia
a9a4f1ee-6a89-40bd-9ce1-fac11c859aed	Gestational Pemphigoid	f	Penfigoide gestacional
74b86ab3-4329-4454-8667-4705d015030a	Gilbert Syndrome	f	Síndrome de Gilbert
8cd3d04f-5fe4-40f1-bcbc-6d116966b4d7	Gitelman Syndrome	f	Síndrome de Gitelman
d04d20e8-6b51-4898-b3d0-28c9961075ec	Glaucoma	f	Glaucoma
92b9d167-bbdb-4216-81ab-3e5cf2920517	Glioblastoma	f	Glioblastoma
a99b14b4-86ad-4b49-9a17-a58f739f680f	Gout	f	Gota
3e141ef9-0124-4a82-a5e2-3256562f9fd6	Granuloma Annulare	f	Granuloma anular
f9b510f2-c71b-4f57-ac64-a00ad1163f2d	Granulomatosis Polyangiitis	f	Poliangeítis granulomatosa
28ae733c-3d77-40ba-893a-749fd1218dc2	Granulomatous Mastitis	f	Mastitis granulomatosa
ce9f50bc-41e3-4251-93db-beaadb71ec53	Graves Orbitopathy	f	Orbitopatía de Graves
d80dbeef-7a40-4a72-9bd0-0c23cda59310	Graves Orbitopathy Or Ophthalmopathy	f	Orbitopatía de Graves u oftalmopatía
cbc04798-8544-4dc5-af98-1f62a646ee5a	Graves’ Disease	f	Enfermedad de Graves
d7a627ac-8da5-4fc7-8d06-22ec7b27c7f8	Grierson-Gopalan Syndrome (Burning Feet)	f	Síndrome de Grierson-Gopalan (ardor en los pies)
d7b42b78-b393-4eff-b3df-ae28ee9874f6	Guillain-Barré Syndrome	f	Síndrome de Guillain-Barré
ddc0c24b-97b5-42ca-851a-b9f5d3b76673	Gum Disease	f	Enfermedad de las encías
6bb84047-568a-4fd4-89d7-8e508cf398be	Hailey-Hailey Disease	f	Enfermedad de Hailey-Hailey
77afa62e-17e3-4371-9014-c0355052a76e	Halitosis	f	Halitosis
58d8c5fa-f934-47b6-b089-c344e8eac006	Hallux Valgus (Bunion)	f	Hallux valgus (juanete)
f14aa4c2-00b4-43e8-b8ba-bd748538d5c6	Hashimoto’S	f	Hashimoto
a4376687-e4c9-4195-bcca-6dd7a879e8e2	Hashimoto’S Encephalopathy	f	Encefalopatía de Hashimoto
91a7f9b2-d9dd-4b79-959e-6fd5238f6a82	Hashimoto’S Thyroiditis	f	Tiroiditis de Hashimoto
ec0c5e58-e46a-4d6a-acfc-fbbc5e06e36f	HDHD	f	HDHD
1fcdf727-1668-4e52-b4e2-323db99517a2	Headaches	f	Dolores de cabeza
f65daaa8-afb0-4e6c-9036-7eb6ea444ee4	Heart Block	f	Bloqueo cardíaco
7329be54-6e25-43c5-87cc-4cbe0229ee05	Heavy Metal Poisoning	f	Intoxicación por metales pesados
77adcbb3-ec68-4b7b-959a-fb448dc0405b	Helicobacter Pylori	f	Helicobacter pylori
9e29a353-64e6-44fd-af6a-40ba4c8d8445	Hematuria Syndrome	f	Síndrome de hematuria
f18d3a12-cc9f-4fb6-8c29-ea51a15054e8	Hemochromatosis	f	Hemocromatosis
60dcd31e-f940-4cdb-a279-88fca6f40aa2	Hemolytic Anemia	f	Anemia hemolítica
11ef7cf3-449e-42c7-808d-269882ddcc8e	Hemorrhoids	f	Hemorroides
002c6d89-a543-4217-8ea0-bb9b47e2da68	Henoch-Schonlein Keloids And Hypertrophic Scars	f	Queloides de Henoch-Schonlein y Cicatrices hipertróficas
a06b8259-f3e9-49e7-99ed-7acec4ac38d3	Hepatitis B	f	Hepatitis B
052ea5e9-fede-4caa-8fb5-bb7e1db49a39	Hernia	f	Hernia
fb19a94e-d4a1-4ab2-9331-9fcfda5c82c6	Herniated Disc	f	Hernia de disco
2d0850d4-be19-4a65-bf71-dda92d0b0ad8	Herpes Virus (HHV)	f	Virus del herpes (HHV)
9f904652-4ddc-42c3-920e-f4a42ad6b0d8	HHT Or Osler-Weber-Rendu Syndrome	f	Síndrome de Osler-Weber-Rendu o HHT
842be67c-454d-404e-9ad4-41dee91cdd9a	Hidradenitis Suppurativa	f	Hidradenitis supurativa
3a348996-2b5c-4661-a6dd-c2c42ed20d3c	Hip Dysplasia	f	Displasia de cadera
37f97c99-bf78-4988-a47d-6a242f741343	Histamine Intolerance	f	Intolerancia a la histamina
d8cc0e55-79a2-4146-975b-759328dd763b	HIV	f	VIH
c7fb655b-7f0f-4178-80f2-ed4d7fb01e53	HSD (Hypermobility Spectrum Disorder)	f	Trastorno del espectro de hipermovilidad (HSD)
bf3ab79f-22a5-469f-9152-72b5be80a23a	Huntington’S Disease	f	Enfermedad de Huntington
8527a61a-9c06-404c-b7c9-6c252323df95	Hydrocephalus	f	Hidrocefalia
92b5e8dd-2225-42fc-952c-2417809c14c3	Hyperacusis	f	Hiperacusia
aeb3e72d-b8a9-43fa-8e72-31c932310f49	Hyperemesis Gravidarum	f	Hiperemesis gravídica
b580627f-6dfa-4fa8-b7ef-e6c654cb0e08	Hyperglicemia	f	Hiperglucemia
e2fa4365-0876-454e-b408-1b4d5b535eb3	Hyperhidrosis	f	Hiperhidrosis
7306a39b-e0e3-4867-aba1-952bea7d1c72	Hypertension	f	Hipertensión
77e678fc-4d4d-4849-9042-cbe86f279e81	Hypochondriasis	f	Hipocondría
e763b4ed-d635-4a7c-9e79-37e1dac35d66	Hypogammaglobulinemia	f	Hipogammaglobulinemia
99851d8a-145c-4544-965c-da1ed9025224	Hypophosphatasia	f	Hipofosfatasia
d4be3c82-a93f-4be7-83cb-19477033e32d	Hypothalamic Obesity	f	Obesidad hipotalámica
202379af-53d5-4bc6-a870-979c1c997ab9	Hypothyroidism	f	Hipotiroidismo
9a6d4af9-4a70-417f-9593-6c087468c952	IBM (Inclusion Body Myositis)	f	IBM (Miositis por cuerpos de inclusión)
ea18af48-299f-4f8a-9ac4-c24742449713	IBS (Irritable Bowel Syndrome) Or IBD (Inflammatory Bowel Disease)	f	SII (síndrome del intestino irritable) o EII (enfermedad inflamatoria intestinal)
91ad7411-5b55-48cb-a954-db1622db35ad	Idiopathic Dilated Cardiomyopathy	f	Miocardiopatía dilatada idiopática
2cbef1c7-52c9-4a38-a711-e7cd6b87bf3a	Idiopathic Pulmonary Fibrosis	f	Fibrosis pulmonar idiopática
f0942d1f-625d-48f2-b0f8-696e48e810e8	IgA Deficiency	f	Deficiencia de IgA
e25fe801-8111-47df-806e-7d0fa49493b6	IgA Nephropathy	f	Nefropatía por IgA
07f133cb-b6fe-46ec-9a9f-2fce80a6fe60	IgG4-Related Disease	f	Enfermedad relacionada con IgG4
56a238e8-6df2-42b9-bd8d-859db817999a	ILD (Interstitial Lung Disease)	f	EPI (enfermedad pulmonar intersticial)
fcc37af7-09bb-4c81-9de4-2bc017d02fe8	Impaired Taste	f	Alteración del gusto
5bd04a4c-cd14-4383-a5e6-8aef1aabaa3b	Incontinence	f	Incontinencia
c4e5f360-b1df-426d-a7e2-44fa87ca7a5c	Infertility	f	Infertilidad
35080694-d81c-4123-bb62-8e70eb8914a5	Inflammation	f	Inflamación
7f63f696-3b4a-4f56-9341-96a034c6bf38	Inhalant Allergies	f	Alergias a inhalantes
ba1b8699-dd3e-4780-a127-d0408d1f3be8	Intermediate Uveitis	f	Uveítis intermedia
3b2a1335-1357-4755-a65a-9cdcf0597b62	Interstitial Cystitis	f	Cistitis intersticial
dc4b4c40-385e-4e18-b125-20b921e1f06b	Intestinal Adhesions	f	Adherencias intestinales
fca8002d-52e5-4344-a599-e6d32b184966	Intracellular Oxidative Stress	f	Estrés oxidativo intracelular
25f546f7-ae2e-4917-891a-e1e4c1ea3c2b	Intracranial Hypertension	f	Hipertensión intracraneal
e809015d-8429-47f6-a8f4-2a3128631d72	Iodine Deficiency Thyrodism	f	Deficiencia de yodo Tiroidismo
65547a54-7cbb-4510-827a-85f63169b6d0	Irlen Syndrome	f	Síndrome de Irlen
53d68376-e6c5-4470-8766-b9bd6b51b266	Irritable Bladder Syndrome	f	Síndrome de vejiga irritable
5673b52d-c5d2-44da-8c6b-d80971cb7a78	ITP (Immune Thrombocytopenia)	f	PTI (trombocitopenia inmunitaria)
f3d4c256-11ef-4ba1-9883-d56eadf63524	Jacob’S Disease	f	Enfermedad de Jacob
de55f2be-840b-4681-8945-2240c31e52d7	Kaposi Sarcoma	f	Sarcoma de Kaposi
df9a7ea5-26e6-45b4-96d4-f0360e9b963a	Kawasaki’S Disease	f	Enfermedad de Kawasaki
83175310-6ca7-44f2-bce4-e47cd03fabaa	Keratoconjunctivitis	f	Queratoconjuntivitis
3e4586c8-22d4-40a2-89cd-69ef5d316e38	Keratoconus	f	Queratocono
1a2fe62d-5280-4a14-832e-7c8bf8fb4945	Keratosis Pilaris	f	Queratosis pilaris
1cd144d5-418a-47f9-aa7d-56f16442453e	Kidney Disease	f	Enfermedad renal
bce2e653-83a2-43cc-933f-88f1351f1ae4	Kidney Stones	f	Cálculos renales
8460a34d-d6b0-4898-bab9-ebf86a6be74f	Kienbock’S Disease	f	Enfermedad de Kienbock
e78b354b-55a4-4696-b34a-2d790f28bc2f	Kleine-Levin Syndrome	f	Síndrome de Kleine-Levin
21c66117-efdd-42aa-88aa-9298e67070a2	Knee Arthritis	f	Artritis de rodilla
5b369056-673f-433f-8746-d94140c3b2cc	Lactose Intolerance	f	Intolerancia a la lactosa
64f1a48b-e2c3-47eb-80b9-77ebf733b629	Postherpetic Neuralgia	f	Neuralgia posherpética
a1047a64-177d-4062-af6a-714d0bdbc50d	Lambert-Eaton Myasthenic Syndrome	f	Síndrome miasténico de Lambert-Eaton
390fd58d-7aa6-40c1-a3dc-82f16b31112a	Laryngopharyngeal Reflux	f	Reflujo laringofaríngeo
a0748eb3-1e36-49dc-9de9-fa71d7130458	Leaky Gut Syndrome	f	Síndrome del intestino permeable
b9228951-6895-4070-96ca-b566c886eb52	Ledderhose Disease	f	Enfermedad de Ledderhose
882e331c-24a0-4a0d-8483-ac6baf6441d3	Legg-Calve-Perthes Disease	f	Enfermedad de Legg-Calvé-Perthes
3e0d0a33-9a65-4168-a2da-bccd5fde7a04	Leukocytoclastic Vasculitis	f	Vasculitis leucocitoclástica
5ef46463-de19-463b-9421-08b03e26191a	Lewy Body Dementia	f	Demencia por cuerpos de Lewy
28526d59-dd26-400d-8635-72d11a65b43d	Lichen Planus	f	Liquen plano
5e6c945b-9365-4456-b93a-9134034cd7d0	Lichen Sclerosus	f	Liquen escleroso
b0d98fcd-528e-4477-aea3-9dbbbdc5de59	Ligneous Conjunctivitis	f	Conjuntivitis leñosa
a06176fd-0575-4a34-ac3b-a835465cb61c	Limb Girdle Muscular Dystrophy	f	Distrofia muscular de cinturas escapulares
522305f9-1cf7-477c-ae08-dc7e58eec8fe	Linear IgA Disease	f	Enfermedad por IgA lineal
8eebe203-4888-4a24-bee8-4087b6987e3b	Lipid Disorder	f	Trastorno lipídico
a2b97bc8-af8e-45e5-811e-2dfcd1210ffb	Lipo Lymphedema	f	Lipolinfedema
8045a64f-da99-4c53-9de0-dfae8443a668	Lipoma	f	Lipoma
09e5f366-7050-436f-b056-3b3ae2068b90	Liver Disease	f	Enfermedad hepática
5974cfd2-80c3-4dd8-bd55-ddba699c0f92	Loeys-Dietz Syndrome	f	Síndrome de Loeys-Dietz
6da6fa1d-6566-4962-a50b-f11003835d44	Long Covid	f	Covid prolongado
30b027b4-9fed-4fea-998f-f5b8c2dbbd34	Low Blood Pressure	f	Presión arterial baja
48667811-27ae-4793-99c9-f270e15505ed	Low Blood Sugar	f	Nivel bajo de azúcar en sangre
22b1af4d-0ca9-4026-9f22-71e0c3ce0966	Lower Back Pain	f	Dolor lumbar
d84f807a-4126-41ff-aeb2-155abb484ea5	Lung Cancer	f	Cáncer de pulmón
760b430d-6f16-4a1b-872f-04af320d6871	Lupus	f	Lupus
97298a36-ea52-443f-a965-09247d17c51d	Lupus Nephritis	f	Lupus Nefritis
5aeac5f5-2a23-4aad-8557-93f5938ce2c2	Lupus Vasculitis	f	Vasculitis lúpica
8c12cef6-7738-4fb0-9dc2-6c798a02da3f	Lyme Disease Or Borreliosis	f	Enfermedad de Lyme o borreliosis
97374916-17b0-404b-9eb9-5b7badc3fee4	Lymphedema	f	Linfedema
0932bc62-f6cb-45a5-a817-71712982ab77	Lymphocytic Colitis	f	Colitis linfocítica
a0979fd9-e44b-4b5b-b616-ef848f527c00	Macular Degeneration	f	Degeneración macular
16c44ec0-2c41-4d9b-9a03-35355a60f1cc	Mal De Debarquement Syndrome (MdDS)	f	Síndrome de Mal de Debarquement (SMD)
fd6f69f8-4011-4282-b178-8aa1aaaca624	Malabsorption	f	Malabsorción
c8fd340b-e993-4b49-b7d3-e956dbe50a94	Malaise	f	Malestar general
7b92ee73-dfbc-4e93-97cd-7c2a0f12bc04	MALS (Median Arcuate Ligament Syndrome)	f	SMAL (síndrome del ligamento arqueado medio)
0d09b878-f078-4c8b-8a1a-43bd9cd0b124	Marfan Syndrome	f	Síndrome de Marfan
2fb5090f-06cc-46f9-b12a-4d9414fde438	Mary-Thurner Syndrome	f	Síndrome de Mary-Thurner
d80921aa-53a7-4a6c-ac0c-3887d143fba0	Mastocytosis	f	Mastocitosis
eb0fbb6d-816a-4f8c-9c96-39112378925b	MCAS (Mast Cell Activation Syndrome)	f	SAM (síndrome de activación de mastocitos)
319fb470-cb3b-4902-941f-71e4b6441708	MCS (Multiple Chemical Sensitivity)	f	SAM (síndrome de sensibilidad química múltiple)
66b71bcd-97e3-4fb8-9555-331ff4c203a1	Measles	f	Sarampión
d562bae4-4507-4038-8c6f-8ce7d0c02ffd	ME Or CFS (Myalgic Encephalomyelitis Or Chronic Fatigue Syndrome)	f	EM (encefalomielitis miálgica o síndrome de fatiga crónica)
a410b169-7f0f-43a1-85dd-1430799951bc	MCTD (Mixed Connective Tissue Disease)	f	Enfermedad mixta del tejido conjuntivo (EMTC)
e5f01b96-ef98-4cad-b645-436e9deae3e3	Medullary Sponge Kidney	f	Riñón en esponja medular
186b92d7-9ff5-4a9e-a0e9-adf76c2ca738	Medulloblastoma	f	Meduloblastoma
99e94803-7872-4055-8d08-6db01eb4926b	Melasma	f	Melasma
4cec057f-ccf1-468e-827d-0355351d6218	Menopause	f	Menopausia
f78d1da7-3bb2-40d6-94ca-692e9a9114dc	Menorrhagia	f	Menorragia
a38eff7c-a75f-466f-8100-b13ecf54ffad	Meralgia Paresthetica	f	Meralgia parestésica
1319bf62-6e3f-42c8-a6a8-e72f3ac5e9ba	Mercury Toxicity	f	Toxicidad por mercurio
de544fde-dc6f-43e6-b674-614e1a0a1032	Mesenteric Panniculitis	f	Paniculitis mesentérica
105b815c-04e0-4b74-b833-a1ee554fa322	Metabolic Syndrome Or Syndrome X	f	Síndrome metabólico o síndrome X
eb90831f-5f94-4171-ab26-61f712c14ffe	MFC (Multifocal Choroiditis)	f	CMF (coroiditis multifocal)
b375eaf6-84e4-49c7-b90b-d768b1388d68	MGD (Meibomian Gland Dysfunction)	f	DMG (disfunción de la glándula de Meibomio)
81636a62-7a0c-457e-8d95-26d6a97ad217	MGUS (Monoclonal Gammopathy)	f	GMSI (gammapatía monoclonal)
0d509a5c-d34d-4fb7-bbc7-bc6a3eb6d8f7	Microscopic Colitis	f	Colitis microscópica
cbd5e49c-fece-4ad5-9656-b3a9ee8252af	Microscopic Polyangiitis	f	Poliangeítis microscópica
37cb0dbb-2b4a-4436-8e8b-49b33f417d31	Microvascular Angina	f	Angina microvascular
982a8c4d-d80f-474b-a04a-43b00c305b6b	Migraine	f	Migraña
ac9aa980-617a-4fc6-a643-ec82b421cee7	Miscarriage	f	Aborto espontáneo
9bb8beef-3f77-4a4e-afbd-b94cb145b636	Misophonia	f	Misofonía
01bad0f2-fb4f-49d8-bd95-556aaea628f2	MOG (Myelin Oligodendrocyte Glycoprotein Disease)	f	MOG (enfermedad de la glucoproteína de los oligodendrocito de mielina)
4bec2765-ee4c-42e2-81ef-2ee2ac06c55f	Mold Toxicity Or Sensitivity	f	Toxicidad o sensibilidad al moho
60523396-3759-468c-ade2-3e9cd0525d85	Mooren’S Ulcer	f	Úlcera de Mooren
7131b107-ad09-4c2e-ac64-b5324c8ad6a2	Morgellons Disease	f	Enfermedad de Morgellons
67871a53-4612-450c-8563-fc7d1b5d55f3	Morphea Or Scleroderma	f	Morfea o esclerodermia
07220db3-3feb-4f1d-8068-a71d309ec9ac	Morphoea	f	Morfea
cbf38caf-f2c4-43f9-b3a5-d12eccea127f	Morton’S Neuroma	f	Neuroma de Morton
a1a5a149-d169-403d-a19c-531614b9820d	Motor Neurone Disease (MND)	f	Enfermedad de la neurona motora (EMN)
a91d48dc-33da-44fc-b69d-1175a37ba7ce	Mould Sensitivity	f	Sensibilidad al moho
fd372521-b385-4355-b0d3-12376876722b	Mouth Ulcers	f	Úlceras bucales
c968d02a-bac1-4ad8-8dad-e39cf53efb93	Moyamoya Disease	f	Enfermedad de Moyamoya
fdf42cc9-78e6-4f43-9cbd-a266b14b2254	MRKH (Mayer-Rokitansky-Kuster-Hauser Syndrome)	f	MRKH (síndrome de Mayer-Rokitansky-Kuster-Hauser)
747bd595-a748-4891-94f4-c2d80d205076	MS (Multiple Sclerosis)	f	EM (esclerosis múltiple)
a96ac0cd-0214-4ce7-9235-ae9156345a6b	MTHFR Gene Variant	f	Variante del gen MTHFR
63738b2b-4322-4429-8cd8-4f814719da12	Mucha-Habermann Disease	f	Enfermedad de Mucha-Habermann
93348dce-6fbc-492d-8d4a-9ec404e8691e	Multiple Chemical Sensitivity (MCS)	f	Sensibilidad química múltiple (SQM)
34d522ac-6522-44ff-903b-a962727dc616	Multiple Myeloma	f	Mieloma múltiple
1d86496d-becf-4d13-9124-0c0e4693f744	Muscle Stiffness	f	Rigidez muscular
5566e3dc-c005-4937-9713-1263270ea5e7	Myalgia	f	Mialgia
1216cc6e-f894-4435-97b0-c7a9ac25eaa9	Myasthenia Gravis	f	Miastenia gravis
41ab0a86-1664-4553-84b7-9d42a917bed0	Mycoplasma Infections	f	Infecciones por micoplasma
f6113d7a-726c-498e-9681-2f8bc82bbf18	Myelofibrosis	f	Mielofibrosis
3557728e-d556-4961-a3fe-04ca452a8d12	Myelopathy	f	Mielopatía
d2fc6a28-1684-465c-84bf-fcf848fb5d5d	Myocarditis	f	Miocarditis
d617da72-562a-487b-b011-2c5235915be4	Myofascial Pain Syndrome	f	Síndrome de dolor miofascial
1b86827b-2408-4213-9709-99321757a6a0	Myotonic Dystrophy	f	Distrofia miotónica
0d709413-7878-457a-adb0-1270917dd73f	NAFLD (Non Alcoholic Fatty Liver)	f	EHGNA (hígado graso no alcohólico)
dd03df99-c420-4954-b007-7950fc57224b	Nail Fungus	f	Hongos
672a0140-7abc-4172-bd44-5d2278eca1a9	Nail Patella Syndrome	f	Síndrome de la rótula ungueal
1431e05e-2057-4e37-9d03-2f728361e1ad	NAM (Necrotizing Autoimmune Myopathy)	f	NAM (miopatía autoinmune necrosante)
3eafc44f-37fd-43b3-8690-107aa375170d	Narcolepsy	f	Narcolepsia
34c51251-2d26-4354-8dc3-dbe779d06c60	Narcolepsy With Cataplexy	f	Narcolepsia con cataplejía
fa4e5510-fa7e-429e-b1cc-3fc87814dccf	Nasal Polyp	f	Pólipo nasal
8230934f-400d-4d1f-8263-64b13236a878	NCGS (Non Celiac Gluten Sensitivity)	f	NCGS (sensibilidad al gluten no celíaca)
0e75176e-ea57-4383-836a-c95583ae5402	Nephritis	f	Nefritis
4a1de6de-3eab-464e-93f7-e8f024529f0a	Nephrotic Syndrome	f	Síndrome nefrótico
2505e2ef-1f70-4991-a3a9-0b84d0b02a41	Neurocognitive Disorder	f	Trastorno neurocognitivo
14df2568-3d0e-47d6-9cb0-033506d7c5e2	Neuroendocrine Tumor	f	Tumor neuroendocrino
a4999a99-9936-4194-90c2-daeb9ca665fb	Neurofibromatosis	f	Neurofibromatosis
d311bde6-c35d-4d74-83be-e31d6758f9e9	Neuromyelitis Optica	f	Neuromielitis óptica
a0c08260-e961-4666-8cd6-68b66e7997df	Neuromyotonia Or Isaac’S Syndrome	f	Neuromiotonía o síndrome de Isaac
2b11535b-bb16-4d53-be53-91459086cea3	Nightmare Disorder	f	Trastorno de pesadillas
6a8f02d0-c81a-4f04-8c4c-2f9019338868	No Periods	f	Ausencia de períodos menstruales
4ef01ba4-fd07-47e9-8ae6-16ba8aa29c3a	Nodular Prurigo	f	Prurigo nodular
fb7fbc8c-48e3-4ee5-bde5-3e5a19bd79e8	NOP (Neuropathic Ocular Pain	f	NOP (dolor ocular neuropático)
249efdef-8879-42a6-89f7-0c366d72628c	Nutcracker Syndrome	f	Síndrome del cascanueces
80413333-850b-40c2-b71d-40ca30ec0261	Obesity	f	Obesidad
fcfcc8e1-ae10-49a8-b9db-44b619d125a2	OCD	f	TOC
f6393b66-8ac2-4238-92c9-ab800e79043a	Opioid Addiction	f	Adicción a opioides
f4f29b55-eb28-4194-aa4a-d9e3a1d3898e	Opsoclonus Myoclonus Syndrome Or POMA	f	Síndrome opsoclono mioclono o POMA
3c0b8421-9bf6-4e89-bd93-6b4faa2ad6b3	Optic Neuritis	f	Neuritis óptica
07d12176-5424-4064-81d9-41e4d47b53b4	Oral Allergy Syndrome	f	Síndrome de alergia oral
cc72eecd-6c06-449e-afc1-d9542e662654	Ord’S Thyroiditis	f	Tiroiditis de Ord
fdf85ce1-6014-415e-a4a6-e057ee6fdf0c	Orofacial Granulomatosis	f	Granulomatosis orofacial
89242f1d-2993-4bdc-93f4-a1f3fb0c3370	Orthostatic Hypotension	f	Hipotensión ortostática
dbe70374-34e3-4150-9df4-b077919e1ff0	Orthostatic Tremor	f	Temblor ortostático
a4e94879-dce1-442d-aea0-4fe72ef2a52a	OSFED (Eating Disorders)	f	Trastornos de la alimentación (OSFED)
44d6dba5-5c39-47c1-b583-e61eee66460d	Osgood-Schlatter Disease	f	Enfermedad de Osgood-Schlatter
0ece28cc-8213-4e13-8c76-d67eee233c16	Osteitis Condensans	f	Osteítis condensante
5fc0c6a2-daac-4c02-96a7-86604e932ce6	Osteoarthritis	f	Osteoartritis
6e1d795a-4dd5-4454-a613-76c8e9d601d9	Osteogenesis Imperfecta	f	Osteogénesis imperfecta
5df5ea53-d0e9-49bb-820f-9d648665f409	Osteomyelitis	f	Osteomielitis
ddb54457-04d8-47c8-b765-b3d623a42751	Osteonecrosis	f	Osteonecrosis
6f71a8e8-bed8-4b8d-a455-c1efa1724900	Osteoporosis	f	Osteoporosis
15357350-f2b4-4ec4-ad2a-99671f70fee9	Osteosarcoma	f	Osteosarcoma
14dec971-d6da-4ffd-a329-c13c5f47d90f	Ovarian Cancer	f	Cáncer de ovario
75d2e425-eadf-4900-957f-fdeac6533ab0	Ovarian Cysts	f	Quistes ováricos
c11670ee-2f85-45d6-8421-9bf9b395822b	Overactive Bladder	f	Vejiga hiperactiva
81dece6a-5a05-496d-9b99-6d1fcc0bd578	Palindromic Rheumatism	f	Reumatismo palindrómico
8449e13b-7d64-4f95-bc02-e2e406e102e0	Palmoplantar Pustular Psoriasis	f	Psoriasis pustulosa palmoplantar
13c29be2-be45-415e-bcbc-d9da5436079c	Pancreatic Cancer	f	Cáncer de páncreas
5ef84081-25c2-4d53-b5b4-302fc78b3e9e	Pancreatitis	f	Pancreatitis
8fb40aa2-ebf3-4823-b398-c777d0813cce	Panhypopituitarism	f	Panhipopituitarismo
e1b81ea9-971d-4809-bba8-90f3c69616e9	Panic Attacks	f	Ataques de pánico
3572a97d-e7ff-4e31-aeb8-4f030ce17aef	Papillomavirus	f	Virus del papiloma humano
a9d32635-57fa-4e45-a91d-8496beec62d6	Paraneoplastic Cerebellar Degeneration	f	Degeneración cerebelosa paraneoplásica
edaea03a-e2eb-467c-be13-82a662d3ebb8	Parkinson’S (PD)	f	Parkinson (PD)
078307ba-2778-4ccc-8169-59eb37a909ac	Parosmia	f	Parosmia
2d409b70-9afb-4c50-815b-8dec12391b84	Parry Romberg Syndrome	f	Síndrome de Parry Romberg
76ec884c-2751-4775-8770-9485abffcdbe	Parsonage-Turner Syndrome	f	Síndrome de Parsonage-Turner
07f64178-d2e1-4ada-8913-e6fd31226b29	PC In The Gut	f	PC en el intestino
8d8ac5cb-3866-40d0-bcd6-c979c7880d5a	PCOS (Polycystic Ovary Syndrome)	f	SOP (síndrome de ovario poliquístico)
47b9b4d4-993a-46a9-93ae-8542afe5dab2	Pelvic Congestion Syndrome	f	Pélvico Síndrome de congestión
dfeac542-2486-4927-9c6e-85899f059855	Pelvic Floor Dysfunction	f	Disfunción del suelo pélvico
e5e120a2-96ad-4470-a7da-f6a9350810b8	Pelvic Inflammatory Disease	f	Enfermedad inflamatoria pélvica
b1111a89-9cf4-411d-8e62-48ff604ac248	Pemphigus Vulgaris	f	Pénfigo vulgar
992a2baa-ddb7-4950-85ae-82f00a9bcd6b	Performance Anxiety	f	Ansiedad por el rendimiento
e0a5f516-20dd-43ad-b566-dfbfbf16de07	Pericarditis	f	Pericarditis
79107053-7b92-4d8a-b449-3fce74e726ac	Perimenopause	f	Perimenopausia
c3f77adf-e6f2-41bb-9219-20732a1da634	Periodic Limb Movement Disorder	f	Trastorno del movimiento periódico de las extremidades
1bf8f1e8-3698-44ed-ab33-dbc17b8a4b0c	Periodontal Disease	f	Enfermedad periodontal
36cb54e0-443d-4b76-8871-8917616cb644	Peripheral Neuropathy	f	Neuropatía periférica
0c048893-e0b3-4ebe-9541-398db6453f1a	Pernicious Anemia	f	Anemia perniciosa
2c0a7e88-dfd0-43f9-9dd6-564f9ff3bec9	Phantom Limb Syndrome	f	Síndrome del miembro fantasma
9b7178b4-5f77-4401-bcca-595ed488997f	Piles	f	Hemorroides
577bdfa1-e40f-4032-af0b-7ee7acfca016	Phobias	f	Fobias
04884613-406e-4175-a8c1-497126dfd865	Phlebitis	f	Flebitis
88c127da-79ba-400c-858b-495430437e46	Pilonidal Cyst	f	Quiste pilonidal
9ff8adeb-f56f-4b3e-8f2f-020e81884021	Piriformis Syndrome	f	Síndrome del piriforme
b3e52150-8570-4782-a824-c18ebfd7ff7b	Pituitary Adenoma	f	Adenoma hipofisario
8adf0d68-8cfe-4e80-807a-f844f864b9bf	Pityriasis Lichenoides Et Varioliformis Acuta	f	Pitiriasis liquenoide y varioliforme aguda
dc9e524e-56c8-4ed1-b80f-a2197647988f	Plantar Fasciitis	f	Fascitis plantar
1c93e51b-9d72-44c2-a476-7f4321da51df	Plantar Warts	f	Verrugas plantares
d2de0d60-d7de-46dc-a1ad-3677ee68f481	PMS	f	PMS
d1ec4c62-b9f8-41a9-8b71-e52ba4384ede	PNES Or NEAD (Non-Epilectic Seizures)	f	PNES o NEAD (convulsiones no epilépticas)
1c9b9590-caba-44e7-998f-003e8def01ca	POEMS Syndrome	f	Síndrome POEMS
bc136557-7e1c-4f71-a210-e81f74230d91	Polyarteritis Nodosa	f	Poliarteritis nodosa
6eafa078-bb05-4ff5-87fc-a518be4ce707	Polycystic Kidney Disease	f	Enfermedad renal poliquística
cb94c360-cbce-48f3-9bf2-734aaad9e902	Polycystic Liver Disease	f	Enfermedad hepática poliquística
2d99fab3-04eb-4795-8a8f-78c2abf12dad	Polycythemia Vera	f	Policitemia vera
af069bb5-1ea3-4f38-b45e-4b1c4a110994	Polymorphic Light Eruption	f	Erupción lumínica polimórfica
7ccc4048-beb2-4f12-9287-dea34f1d34b0	Polymyalgia Rheumatica	f	Polimialgia reumática
b426af64-bc87-4eb0-9070-fdb7dbf551df	Polymyositis	f	Polimiositis
c275be57-a28c-4308-94f4-4cb66e36d3d9	Porphyria	f	Porfiria
691f158d-b973-4b65-b55d-6bc3f56e7f8b	Post-Mastectomy Pain Syndrome	f	Síndrome de dolor posmastectomía
f3b0b248-029f-433e-a1aa-5882dff28708	Post-SSRI Sexual Dysfunction	f	Disfunción sexual pos-ISRS
c5b2c732-d695-4aa4-8713-99ab110f9407	Postmyocardial Infarction Syndrome	f	Infarto posmiocardio Síndrome
4247d2b5-7ace-4971-bf43-f79497e054e5	Postpartum Depression	f	Depresión posparto
2de84714-7a72-4504-8958-a3286fa9122b	Postpericardiotomy Syndrome	f	Síndrome pospericardiotomía
3ec7b60a-5970-4645-a2bb-c0a84f23cc93	POTS	f	POTS
8b3fe2d6-73da-4014-847a-e1bfaf90955d	PPMS (Primary Progressive Multiple Sclerosis)	f	PPMS (esclerosis múltiple progresiva primaria)
adf8ea2a-91b3-4d93-986d-b910207f02e7	Pre-Eclampsia	f	Preeclampsia
e91dfc1c-0c16-4304-8a43-cd13bb2a81d7	Premature Ventricular Contractions	f	Contracciones ventriculares prematuras
196bbd80-d67a-46f1-8235-34a745625075	Primary Biliary Cholangitis	f	Colangitis biliar primaria
29ee113a-ded7-4ff0-b556-eef61bf8ca39	Proctalgia Fugax	f	Proctalgia fugaz
fcb9f87f-f760-4662-8143-28f91c712ab9	Proctitis	f	Proctitis
5c648e7e-b831-4683-9e4d-78d37168c1a3	Prolactinoma	f	Prolactinoma
96743d0e-fdde-4a89-9469-68677e47e383	Prostate Cancer	f	Cáncer de próstata
34192a98-9924-4d98-9110-7bff8d4a61c9	Prostate Problems	f	Problemas de próstata
62dbd3c4-f3dd-4ec9-871d-cf3c5b58c03b	Pruritus	f	Prurito
303e6c9a-ea38-4521-b5d5-60023d96aab9	Pseudotumor Cerebri	f	Pseudotumor cerebral
c6951e6e-515d-46f6-8d60-db343374a445	Psoriasis	f	Psoriasis
21deac90-a17c-4391-91d1-7154d8a95866	Psoriatic Arthritis	f	Artritis psoriásica
95849e61-d842-4245-b150-551870c36bd3	PTSD (Post Traumatic Stress Disorder)	f	TEPT (trastorno de estrés postraumático)
a099c560-29d0-4773-9e48-ba87ef71faed	Pulmonary Fibrosis	f	Fibrosis pulmonar
e7871519-86bf-4d1f-8f26-8a77d80a7e28	Pulmonary Hypertension	f	Hipertensión pulmonar
9dadfe67-3d44-4960-9661-f068bc967583	Pulmonary Thromboembolism	f	Tromboembolia pulmonar
d68fab36-ee4d-425c-817b-4177c1aa26dc	Pulsatile Tinnitus	f	Acúfenos pulsátiles
e6484ea1-675f-4cbc-a75b-f143eae5cbd2	Punctate Inner Choroiditis	f	Coroiditis puntiforme interna
a62d3528-b8a6-4dd5-927f-5fe2ae95c238	Pure Red Cell Aplasia	f	Aplasia pura de glóbulos rojos
38295660-41dc-4892-a267-f6b49c4101b3	Purpura Rheumatica	f	Púrpura reumática
f67c3fab-b2aa-4ba8-af31-6775499d3aa6	PVD (Peripheral Vascular Disease)	f	PVD (enfermedad vascular periférica)
4d8959f9-4c1e-4cc9-8e69-40d6af3a0d6a	PVD (Posterior Vitreous Detachment)	f	PVD (desprendimiento del vítreo posterior)
54467930-9460-4450-a683-078b3db4d5c9	PVNS (Pigmented Villonodular Synovitis)	f	PVNS (sinovitis villonodular pigmentada)
49df34f2-c16d-44bf-8fae-8cd8dc77c647	Pyoderma Gangrenosum	f	Pioderma gangrenoso
0148d514-e258-4886-915b-ee7af518e2a7	RA	f	AR
f894e30d-f77f-467b-9b15-ef401df45720	Ramsay Hung Syndrome T2	f	Síndrome de Ramsay Hung T2
3c21b2f7-792d-4c07-b15c-569e5262b16a	RCPD (Retrograde Cricopharyngeus Dysfunction	f	Disfunción cricofaríngea retrógrada
c87330b4-20bb-4051-9108-c8622b84f57b	Reactive Hypoglycemia	f	Hipoglucemia reactiva
f2b82f98-4b0a-41c0-b373-5a02411d7d6a	Reflex Syncope	f	Síncope reflejo
0518245b-ee8d-4c84-a733-2f58922a5c67	Relapsing Polychondritis	f	Policondritis recidivante
b05dd707-05d9-4050-b861-a66909936566	Renal Cell Carcinoma	f	Carcinoma de células renales
186d6815-1034-41ca-adc8-c2422e3e37a4	Residual Limb Pain	f	Dolor en el miembro residual
a3846bca-ceff-4e4f-bfe0-9c05557f2eff	Restless Legs Syndrome	f	Síndrome de piernas inquietas
85db5bb5-a9ad-46eb-92d0-25e0482c6951	Retinitis Pigmentosa	f	Retinosis pigmentaria
20e562de-842a-474e-90e9-05d29b24df09	Rhabdomyosarcoma	f	Rabdomiosarcoma
98633f01-a5f1-4710-b01e-2ce1fc056064	Rheumatism	f	Reumatismo
347f655f-22ec-49a9-b639-a785d15da362	Rhinitis	f	Rinitis
a9ffd6ef-cda7-4505-b96d-d283ffa0dc1f	Rosacea	f	Rosácea
25977882-767a-4362-a758-01ef49d9bd5a	Ross River Disease	f	Enfermedad del río Ross
4d6c3ed6-6430-42a0-b4d3-3bc603586147	Rumination Syndrome	f	Síndrome de rumiación
1181a358-4f18-47ba-9417-d21da7e58724	Sacroiliitis	f	Sacroileítis
aec5dade-629a-4e6a-b34e-a243e78275f5	SAD (Seasonal Affective Disorder)	f	Trastorno afectivo estacional (TAE)
c48f25e4-e169-462f-bfaa-f267f842e983	Sapho Syndrome	f	Síndrome de Sapho
2e5ae7f4-c4b4-4f90-bc5d-d1f18d34cada	Schizophrenia	f	Esquizofrenia
dc863f9b-a5bd-45e2-8006-5b0325ba5280	Sarcoidosis	f	Sarcoidosis
d03ed702-3f03-4b7c-a45b-5b047153e6e0	Schnitzler Syndrome Or Chronic Urticaria With Gammopathy	f	Síndrome de Schnitzler o urticaria crónica con gammapatía
43ce7c66-56fc-4691-8a24-7130bed2c01b	Sciatica	f	Ciática
83eaa41b-11b6-468a-8c2d-f58c7a12f6d3	Scleritis	f	Escleritis
6c119559-e420-4c48-a1ca-fd796f4bd339	Scoliosis	f	Escoliosis
9852d274-ba31-457c-bfcc-5f309b148858	Seasonal Allergy	f	Alergia estacional
e0372066-b3ed-470e-9ed4-1146235d0bd6	Seborrhea	f	Seborrea
33106cb9-0352-43ab-b483-03ba2d7cf60a	Shingles	f	Herpes zóster o culebrilla
62bc3a53-1a51-4435-af64-c78da4c65920	Sickle Dell Disease	f	Enfermedad falciforme de Dell
c424913c-e727-48ef-a0de-7c0b4ce2a930	Sjogren’S Syndrome	f	Síndrome de Sjögren
59718eee-94f3-42c0-a635-622fb8966e46	Sleep Leg Cramps	f	Calambres en las piernas durante el sueño
77e58ce4-b71b-4e68-9021-333558d349b8	Sleeping Disorders	f	Trastornos del sueño
81489f70-7dbe-4f0d-ba5f-256311afecd6	Sluggish Cognitive Tempo	f	Ritmo cognitivo lento
610d1fc0-b964-4b6c-8c8c-78d64cee2122	Small Fibre Neuropathy	f	Neuropatía de fibras pequeñas
7f5cbc68-f701-40b3-b5c7-b4577b2f46e9	Spasmodic Dysphonia	f	Disfonía espasmódica
80a037b2-a47e-4f79-a245-6b7f5e476b2a	Spastic Paraplegia	f	Paraplejia espástica
1a8215a8-ed21-4e26-b51a-898ce574a6e8	Spherocytosis	f	Esferocitosis
ec12189d-cf8b-44a8-83a7-6e6d968e3daf	SPD (Sensory Processing Disorder)	f	Trastorno del procesamiento sensorial (SPD)
f5e7df30-579c-426e-80a1-7f49c122df30	Spinal Cord Injury	f	Lesión de la médula espinal
331e4f54-db00-4521-9f01-93b803d2a70e	Spinal Inflammation	f	Inflamación espinal
6bb88f07-39d2-4e55-a11f-4ae859cc4d8e	Spinal Muscular Atrophy	f	Atrofia muscular espinal
c4d7cae1-affc-45c1-9b8c-60155c16518e	Spinal Stenosis	f	Estenosis espinal
1d27a0f4-729f-4b4b-8fba-42ddcd0f3844	Spinocerebellar Ataxia	f	Ataxia espinocerebelosa
2cde9d76-b950-4514-9382-888c4dbdce39	SPMS (Secondary Progressive Multiple Sclerosis) Brain Fog	f	Esclerosis múltiple progresiva secundaria (SPMS) Niebla mental
5bf867e5-0f5c-4eeb-8a02-036cba7f9279	Spondylolisthesis	f	Espondilolistesis
4f19ac24-5daf-453c-a7f2-d17fca2ec409	Stiff Person Syndrome	f	Síndrome de la persona rígida
dea54fab-80f6-41a9-961c-ecc5f68acf3e	Stroke	f	Accidente cerebrovascular
14639011-4053-490e-81a9-a02f43db678e	Subacute Bacterial Endocarditis	f	Endocarditis bacteriana subaguda
c9f7b109-c366-4e2e-ad5b-623ad5a88464	Subarachnoid Hemorrhage	f	Hemorragia subaracnoidea
8cb65a95-94fb-42cb-83ff-148a94cb0e9f	Superior Canal Dehiscence Syndrome	f	Síndrome de dehiscencia del canal superior
c6765e3a-fbef-4b36-9659-136a807bc611	Superior Mesenteric Artery Syndrome	f	Síndrome de la arteria mesentérica superior
b8fbf5ef-93d6-42ab-8589-7cf5d234b832	Supraventricular Tachycardia	f	Taquicardia supraventricular
6a056194-58e6-4fed-954e-9bbd91994936	Susac’S Syndrome	f	Síndrome de Susac
4f04558e-405c-4f09-a11b-12ea1acba27e	Sydenham Chorea	f	Corea de Sydenham
3d368ac5-e473-486b-9628-237faf11f7da	Sympathetic Ophthalmia	f	Oftalmía simpática
6d3eb549-ad5e-4bf0-8db4-ecbab9b685cf	Syringomyelia	f	Siringomielia
b66a18d9-82f9-4d4b-b720-4be3243324fa	Systemic Lupus Erythematosus	f	Lupus eritematoso sistémico
278d36de-ed7c-4310-8edf-7e2eeb25a204	Systemic Scleroderma	f	Esclerodermia sistémica
810f54d2-3974-41fe-ac53-409a0ce6bb79	Takayasu Arteritis	f	Arteritis de Takayasu
eb1c60ec-e1b4-495c-9fcd-df93e6fd30c6	Tarlov Cyst	f	Quiste de Tarlov
087cec71-edfe-4fcc-abde-e6f0a4015975	Tardive Dyskinesia	f	Discinesia tardía
92526864-fd92-46e2-9b7d-f717b652e45e	Tarsal Coalition	f	Tarsal coalition
1bbc18e8-5900-42d3-893b-e573c5210fd0	Temporal Arteritis	f	Arteritis temporal
9ba6110c-208b-4709-9e00-ad53d778742b	Tendonitis	f	Tendinitis
f946e5c2-2960-4dd2-a995-6c6275792ae6	Tennis Elbow	f	Codo de tenista
03466697-a87d-4416-bcf1-59db7b8e7a06	Thoracic Outlet Syndrome	f	Síndrome del desfiladero torácico
3c688f4c-6a62-4c00-9ecc-c83305ea0d98	Thrombocythemia	f	Trombocitemia
cd2a4104-5e29-4146-812b-82fcd1960c65	Thrombophilia	f	Trombofilia
161742fd-6883-418f-853e-d61886f69ba0	Thyroid Cancer	f	Cáncer de tiroides
d2628be4-07ff-438f-a177-85edd825171d	Tic Disorder	f	Trastorno de tics
bbab0d3e-8624-4877-8d28-e96a123170c7	Tinea Versicolor	f	Tiña versicolor
1ea816f1-39ba-4e94-b4e4-51a3f56bea6a	Tinnitus	f	Acúfenos
77192382-9223-41da-be88-e353e3415def	TMD (Temporomandibular Joint Disorder)	f	Trastorno de la articulación temporomandibular (TMD)
fe831efc-da76-4f34-8ffb-5112e199af20	Tolosa-Hunt Syndrome	f	Síndrome de Tolosa-Hunt
d8e2ee27-aa09-4154-b2f4-da2be28da761	Tourette Syndrome	f	Síndrome de Tourette
88ac649a-25cb-4be4-9ee2-75f4bfe37c5d	Transient Global Amnesia	f	Amnesia global transitoria
eb81746a-dfca-42e8-8a5e-950305a765b8	Transverse Myelitis	f	Mielitis transversa
a60065e8-f87c-4ab3-8e7a-e69825bb24b4	Trichotillomania	f	Tricotilomanía
18965778-3981-4ece-b91b-6d62ea24f42e	Trigeminal Neuralgia	f	Neuralgia del trigémino
363307e3-8534-421e-9d5a-2412685dd887	Trigger Finger	f	Dedo en gatillo
760ab1b9-0c81-4479-b6c0-3ac4c47bea23	Tronchanteric Bursitis	f	Bursitis troncanterica
cfab801d-3010-454c-96a6-e671f7fcd8af	Tuberous Sclerosis	f	Esclerosis tuberosa
27561bb4-39f7-4d88-ab68-400129fe2f7e	UCTD (Undifferentiated Connective Tissue Disease)	f	UCTD (Enfermedad del tejido conectivo indiferenciada)
ae4eeb97-77e9-41e7-9e42-84bc9f714a9e	Ulcer	f	Úlcera
011c84f8-5c51-4cc6-80a5-59916f28424a	Ulcerative Colitis	f	Colitis ulcerosa
e8cc9948-5058-416a-a20e-7f5aeefc392d	Upper/Middle Back Pain	f	Dolor de espalda superior/media
29fd34ef-9f54-4cf9-94f8-06432e104120	Urticaria	f	Urticaria
692fadf4-e80e-491a-b78c-c5999d67bb50	Urticarial Vasculitis	f	Vasculitis urticarial
0c973cb1-31ed-4cd1-adab-237bf44e1b43	Vaginal Bleeding	f	Sangrado vaginal
39989ff8-fb73-4c28-be74-91fb81f09e99	Vaginal Thrush	f	Candidiasis vaginal
0b7f8e1c-1d2e-49ee-abfc-f6489e626b3e	Vaginismus	f	Vaginismo
347ffec3-2261-498a-bd95-50599268760f	VAIDS (Vaccine Acquired Immunity Deficiency Syndrome)	f	VAIDS (Síndrome de inmunodeficiencia adquirida por la vacuna)
fd64f4f4-3bfc-4034-a5b8-208cbd47ecab	Varicose Veins	f	Venas varicosas
032a66af-fa8d-4b2f-b2f5-e9b0971482e9	Vasculitis	f	Vasculitis
8396867f-dd95-4c1e-a9bf-db9d305ff754	Venous Insufficiency	f	Insuficiencia venosa
d70e92b4-3498-4c65-b2c1-2e1c746022f5	Vertigo (Vestibular Neuronitis)	f	Vértigo (Neuronitis vestibular)
9cede7fd-a23a-40d0-9e5d-a5b34e001d19	Vestibular Schwannoma	f	Schwannoma vestibular
a08ccb93-09cc-4d56-a311-38b59c599092	Viral Hepatitis	f	Hepatitis viral
b2b3e1f1-0908-404d-a346-600ea9630f7f	Viral Meningitis	f	Meningitis viral
f0a6c8da-a0ef-42b8-b550-92eda72182ca	Viral Pneumonia	f	Neumonía viral
d6969c35-a47d-4c89-90f4-399edb9ea0f4	Other	f	otra
43a719c8-7425-482f-8cf5-ead967a7a9bf	Visual Snow Syndrome	f	Síndrome de nieve visual
8ff46dfb-8f7c-42b0-adb8-e658d065000a	Vitiligo	f	Vitíligo
8c3b4155-2dec-4c9b-a91e-cbefa508aebc	Vocal Cord Dysfunction	f	Disfunción de las cuerdas vocales
ba6a9aa4-9a04-480e-9744-6e466c86fb32	Von Willebrand Disease	f	Enfermedad de von Willebrand
9e7762b1-045c-4e78-bbb8-92986157259a	Vulvodynia	f	Vulvodinia
759e274b-786e-4030-8f42-bb943af66d74	Warm Autoimmune Hemolytic Anemia.	f	Anemia hemolítica autoinmune caliente
5d91b71a-5be3-4e3d-bb1a-206064f71fbb	X-Linked Hypophosphatemia	f	Hipofosfatemia ligada al cromosoma X
019c1576-07e4-469d-9e36-8ffd514c1683	XMRV	f	XMRV
c748c666-e79b-40d3-8cf8-064c8b356c5c	Yeast Overgrowth	f	 Crecimiento excesivo de levadura
b35693e0-9492-47d0-a57f-578b2755faf4	Yeast Problems	f	 Problemas de levadura
\.


--
-- TOC entry 3569 (class 0 OID 139274)
-- Dependencies: 227
-- Data for Name: nhc_library_item; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.nhc_library_item (id, title, description, created_by, file, poster, created_at, updated_at, document_type, image_dimensions) FROM stdin;
880d347a-3b4c-4bba-9f3e-0b86386556a4	JPEG Test		user_2eEFfRxWdyrdXmELZTndFkY0hIm	library/1716458503596/file	library/1716458503596/poster	2024-05-23 10:01:46.470287	2024-05-23 10:01:46.470287	jpeg	"{\\"height\\":1069,\\"width\\":1920}"
baab7cde-6503-4d66-b90e-d40d9eb71676	PDF Test		user_2eEFfRxWdyrdXmELZTndFkY0hIm	library/1716458734660/file	library/1716458734660/poster	2024-05-23 10:05:36.231998	2024-05-23 10:05:36.231998	pdf	\N
056447c0-71df-45e2-b2d1-aa221918e959	Learning Typescript: Enhance Your Web Development Skills		user_2eEFfRxWdyrdXmELZTndFkY0hIm	https://www.amazon.co.uk/Learning-Typescript-Development-Type-Safe-JavaScript/dp/1098110331/ref=sr_1_3	library/1719930864424/poster	2024-07-02 14:34:25.586694	2024-07-02 14:34:25.586694	book	\N
fa57d55c-c3c6-4fd7-9731-8b5f08d59c46	Effective Typescript		user_2eEFfRxWdyrdXmELZTndFkY0hIm	https://www.amazon.co.uk/Effective-TypeScript-Specific-Ways-Improve/dp/1492053740/ref=pd_bxgy_d_sccl_2/261-4968878-9429058	library/1719933815530/poster	2024-07-02 15:23:37.173691	2024-07-02 15:23:37.173691	book	\N
517c0016-ce44-4abc-b412-ee207d15ccfd	URL Test		user_2eEFfRxWdyrdXmELZTndFkY0hIm	https://vercel.com/	library/1752585291408/poster	2025-07-15 13:14:50.768928	2025-07-15 13:14:50.768928	url	\N
\.


--
-- TOC entry 3571 (class 0 OID 278528)
-- Dependencies: 229
-- Data for Name: nhc_policy; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.nhc_policy (handle, title, content, updated_at, created_at, content_es, title_es) FROM stdin;
terms-of-use	Terms of Use	Accessing [www.naturalhealingcommune.com](http://www.naturalhealingcommune.com) (the ‘Site’) constitutes use of the Site and your agreement to be bound by these Terms of Use the [Privacy Policy](/policies/privacy-policy) on the Site and any additional terms and conditions that may operate for other services provided by the Site.\n\nThe ‘Site’ is owned and operated by Natural Healing Commune (‘We’ or ‘Us’).\n\n‘You’ and/or ‘Member’ or ‘Subscriber’ mean any ‘User’ of the Site. For all Users accessing the Site whether Members, Subscribers or not, all Terms of Use apply.\n\nWe reserve the right to change these Terms of Use or to publish new Terms of use of the Site, at any time. The revised Terms of Use will be posted on the Site and any revised or amended Terms of Use apply as We post those changes.\n\n## Site Use\n\nThe Natural Healing Commune Site is an online platform for User Members and Subscribers to access and share information, experiences and conclusions resulting from Members use of natural health practices, treatments, therapies and remedies. For this purpose, the Site implements a Survey with tick-box options and text boxes. A database of information and statistics derived from it is created to be shared amongst Members and Subscribers. The Site intends to encourage and create community through the sharing of natural health information and practices used by its Members. The Site allows Members to communicate with each other and create community. The Members’ Survey and Database is not for the use of healthcare providers or companies to contact Members or for any other commercial or non-personal purpose. By registering as a Member, you acknowledge to be aged 16 or over.\n\n## Registration\n\nTo register and access the Site, the minimum requirement is for You to provide a Username and password and a valid registered email address. We may ask you to provide certain demographic information including your gender, age group, city of residence and country for the purposes of profiling statistics. For the purpose of sharing information provided by You through the survey, to be known as ‘My Journey’ in your account, only your chosen Username will be visible to other Members. Your email address will be kept anonymous, unless you decide to pass it on to another Member. No personally identifiable information such as your real name (if you choose to use it as Username) and email address will be made available through the Natural Healing Commune Site to other Members unless you have chosen to pass it on yourself at your own risk.\n\nYou agree to provide true, accurate, current and complete information about yourself as prompted by the Site's registration form and Survey. Our use of any personally identifiable information you provide to us as part of the registration process is governed by the terms of our Privacy Policy.\n\nBy filling the Survey and sharing your experience on the Site, you accept Natural Healing Commune to use, display, compile, translate, distribute, share and create derived materials of your Member natural health experiences. If you breach in anyway the Terms of Use and your account is cancelled, we may remove all your contents and information provided in the Site and have no obligation to provide you with your data after your Membership is cancelled.\n\nBy registering in the Site, ticking your health options and filling the information box, You give the Natural Healing Commune consent to share the anonymous information provided through its Database, statistical analysis, graphics, maps and reports with the community of Members and Subscribers on the Site.\n\nYou are responsible for maintaining the confidentiality of the password and Your membership details, and You are responsible for all actions under your password or account. You agree to notify us immediately of any unauthorized use of your password any breach of security. We will not be liable for any loss or damage arising from your failure to protect your password or account information.\n\n## Member Interaction and Conduct\n\nThe Site uses interactive features, such as Member health information Survey with tick-box answers and information text boxes, all of which generate a crowdsourced Database from the information provided by Members to be shared by Members, allowing feedback and real-time interaction between Members. Responsibility for what is posted on the Site, or in private between Members lies with each User. We do not check messages, information or files that you or others may share through the Site. It is a condition of use of the Site that you:\n\n* Do not engage in any abusive, threatening, libellous, defamatory, obscene or indecent communications in the Site, or promote physical, mental or psychological harm against any other Member, Subscriber or User of the Site.\n* Do not communicate through the Site any information or material that infringes the rights of others, including invasion of privacy.\n* Do not constrain or impede the use of the Site to anyone.\n* Do not impersonate anyone or any organisation or your connection to either.\n* Do not create disruption or damage to any networks or servers that provide the Site or its functioning.\n* Do not hack or use illicit ways to obtain passwords, email addresses or Member information or obtain unauthorised access to the Site.\n* Do not access the Site to spread materials that contain harmful elements or viruses, or commercial materials, like products or services for advertising purposes, unless We have given You prior authorization.\n\nAny User who fails to comply with the Terms of Use may be denied access to the Site or other forums. on the grounds of violation of the spirit of these Terms of Use, fraudulent, harassing or abusive behaviour to the Site or to other Members and/or third parties or the violation of privacy of Members. In the event of cancellation, you will no longer be authorized to access the Site. The disclaimers and limitations of liabilities set in these Terms of Use, will continue to be valid.\n\n## Copyright\n\nAll elements and materials contained on the Site, including text, design, logo, graphics and images are the property of Us, and are protected by copyright and intellectual property laws. The Site is provided solely for your personal use. You may not use any materials on the Site without prior explicit authorization by Us. Any modification, copy, reproduction, republishing, uploading, post, translation, derivative work from replication or distribution of the material is not allowed.\n\n## Disclaimers\n\nThe Site may make available to its Users contacting information of functional medicine, integrative medicine and natural health holistic professionals from various disciplines and modalities i.e. homeopathy, acupuncture, naturopathy, nutrition, osteopathy, aromatherapy, herbalism, energy therapies, etc. Through the use of the Site, you may have access to and communication with other Users, whether Personal Members or subscribing Professional Members and/or Natural Health Organisations. Natural Healing Commune shall not be liable or responsible in any way for any damage, loss, liability, cost or claim related to any advice or information exchanged amongst Subscribers and/or Members, including without limitation the trustworthiness, quality, accuracy or efficacy of such advice or information, or in relation to the identity, qualifications or credentials of the User or Professional/Company Member.\n\nThe Natural Healing Commune equally and expressly shall not be liable or responsible for the authenticity of opinions, advice, information or testimonials made or offered in the Site. We shall not be liable for any loss or damage caused by You trusting in any information obtained through these forums. The opinions expressed by Members are solely the opinions of the Users.\n\nAny information found in the Site, any advice or recommendations, information and conclusions or results shared by Members, including Professional/Company Members but not restricted to them, are not expressly recommended or endorsed by Us and its use lies at Your own risk and discretion.\n\nThe Natural Healing Commune has no obligation to monitor any of the content or postings on the Sites. However, You acknowledge and agree that we have the right to monitor the information provided at our discretion. We reserve the right to refuse to post or remove any postings or content, in whole or in part, to protect the Site, our Users, Members and Subscribers.\n\nNatural Healing Commune is not a health care provider and does not provide medical advice. All content published on the Site by Us or by our Users, registered Members or Subscribers, including answers, text, treatments, dosages, outcomes, charts, user profiles, testimonials, graphics, advice, recommendations, messages, other postings, and any other content or material found in the Site are intended for information purposes. Natural Healing Commune is a platform for Members to share natural health experiences, healing modalities used and information crowdsourced for the purpose of creating community. The Site is not intended to diagnose, treat, cure of prevent disease or otherwise assist in the provision of professional health advice or medical diagnoses. Therefore, the Site does not constitute a substitute for medical or professional advice, diagnosis or treatment.\n\nThe Site is a community and information-sharing networking platform for the creation of community and the advancement of natural health modalities, integrative and functional medicine practices and their positive results. You should always speak to a healthcare professional about any condition and/or treatment for proper diagnosis and healthcare professional advice, including but not limited to professional mental healthcare advice. Users of the Site acknowledge and agree that the use of the Site is for exchange of information and sharing natural health practice, modalities, experiences and results.\n\nThroughout the Site, we may provide links to Internet sites maintained by third parties. Our linking to such sites does not imply an endorsement of such sites, or the information, products or services offered on or through the sites. In addition, We do not operate or control any information, products or services that third parties may provide on or through the Site or on websites linked to by us on the Site.\n\nWe do not guarantee that the Site or any of its functions will be uninterrupted or that any errors will be corrected, or that any part of the Site or the servers that make it available are free of viruses or other harmful components. We are not liable for any direct, indirect or incidental damage that may result from the use or the inability to use the Site, including messaging, blogs, chat rooms, links, emails, Site resources such as stats, database, survey information, or third party materials, products or services made available through the Site. You acknowledge that we are not liable for any defamatory, offensive or illegal conduct of any User.	2024-12-05 14:48:15.861	2024-12-04 16:54:42.365273	Acceder a [www.naturalhealingcommune.com](http://www.naturalhealingcommune.com) (el Sitio) constituye el uso del Sitio y la total aceptación de estas Condiciones de uso, la [Política de privacidad](/policies/privacy-policy) (link) del Sitio y cualquier condición adicional operante para otros servicios suministrados por el Sitio.\n\nEl “Sitio”) es propiedad de Natural Healing Commune (“Nosotros” o “Nos”).\n\nLos términos “Usted” y/o “Miembro” o “Suscriptor” se refieren a cualquier “Usuario” del Sitio. Para todos los Usuarios que accedan al Sitio, ya sea Miembros, Suscriptores o no, se aplican todos las Condiciones de uso.\n\nNos reservamos el derecho de cambiar estas Condiciones de uso o de publicar nuevas Condiciones de uso del Sitio, en cualquier momento. Las Condiciones de uso revisadas o modificadas se publicarán en el Sitio y se aplicarán a medida que publiquemos dichas modificaciones.\n\n## Uso del sitio\n\nEl Sitio de Natural Healing Commune es una plataforma en línea para sus Usuarios, ya sea Miembros o Suscriptores, para acceder a y compartir información, experiencias y resultados de los tratamientos, terapias y remedios naturales para la salud utilizados por los Miembros de la comunidad. Con este propósito, el Sitio tiene a disposición un cuestionario con opciones para marcar casillas y cuadros de texto. A partir de esta información suministrada por el Usuario se crea una base de datos y estadísticas derivadas de ella para ser compartida entre Miembros y Suscriptores. El Sitio tiene la intención de crear una comunidad a través del intercambio de información sobre las prácticas de salud natural utilizadas por sus Miembros. El Sitio permite a los Miembros comunicarse entre sí y crear una comunidad. El cuestionario y la base de datos no tienen como función que los proveedores de atención médica o las empresas puedan contactar a los miembros para ningún propósito comercial. Al inscribirse como Miembro, confirma no ser menor de edad.\n\n## Inscripción\n\nPara inscribirse y acceder al Sitio, el requisito mínimo es que proporcione un nombre de usuario, una contraseña y una dirección de correo electrónico válida. Es posible que le pidamos que proporcione cierta información demográfica, incluido género, grupo etario, lugar de residencia y país, a los efectos de elaborar estadísticas. Con el fin de compartir la información proporcionada en el cuestionario, conocida como "Mi Trayectoria", solo el nombre de Usuario que ha elegido quedará a la vista de otros miembros. La dirección de correo electrónico se mantendrá anónima, a menos que decida pasársela a otro miembro de manera privada. Ninguna información de identificación personal, como su nombre real (si elige usarlo como nombre de usuario) y la dirección de correo electrónico, estarán disponibles o visibles a otros miembros, a menos que haya elegido pasarla usted mismo bajo su responsabilidad.\n\nUsted acepta proporcionar información verdadera, precisa, actual y completa según lo solicite el formulario de inscripción y el cuestionario del Sitio. El uso de cualquier información de identificación personal que nos proporcione como parte del proceso de registro se rige por los términos de nuestra Política de privacidad.\n\nAl completar su información y compartir su experiencia de salud en el Sitio, acepta que Natural Healing Commune muestre, compile, traduzca, distribuya, comparta y cree materiales derivados de las experiencias de salud natural de sus Miembros. Si incumple de alguna manera las Condiciones de uso y se cancela su cuenta, podremos eliminar todos sus contenidos e información proporcionados en el Sitio y no tendremos la obligación de proporcionarle estos datos después de que se cancele su Membresía.\n\nAl inscribirse en el Sitio y completar el cuestionario, usted da su consentimiento a Natural Healing Commune para compartir la información proporcionada a través de su base de datos, análisis estadísticos, gráficos, mapas e informes con la comunidad de Miembros en el Sitio.\n\nUsted es responsable de mantener la confidencialidad de la contraseña y los detalles de su membresía, y es responsable de las acciones realizadas con su contraseña o cuenta. Acepta notificarnos de inmediato sobre cualquier uso no autorizado de su contraseña o cualquier violación de la seguridad. No seremos responsables de ninguna pérdida o daño que surja de su descuido con la contraseña o la información de cuenta.\n\n## Interacción y conducta entre los miembros\n\nEl Sitio utiliza funciones interactivas, como el cuestionario de información de salud de los Miembros con respuestas con marcado de casillas y cuadros con llenado de texto, todo lo cual genera una base de datos proporcionada por los Miembros para ser compartida entre Miembros, lo que permite comentarios e interacción en tiempo real entre los Usuarios. La responsabilidad de lo que se publica y las respuestas en el cuestionario o en privado entre los miembros, recae en cada usuario. No verificamos los mensajes, la información o los archivos que usted u otras personas puedan compartir a través del Sitio. Es una condición de uso del Sitio que usted:\n\n* No participe en comunicaciones abusivas, amenazantes, calumniosas, difamatorias, obscenas o indecentes en el Sitio, ni promueva daños físicos, mentales o psicológicos contra ningún otro Miembro, Suscriptor o Usuario del Sitio.\n* No comunique a través del Sitio ninguna información o material que infrinja los derechos de otros, incluida la invasión de la privacidad.\n* No restrinja ni impida el uso del Sitio a nadie.\n* No se haga pasar por nadie ni por una organización.\n* No interrumpa ni dañe ninguna red o servidor que proporcione el Sitio o su funcionamiento.\n* No piratee ni use formas ilícitas para obtener contraseñas, direcciones de correo electrónico o información de los Miembros ni obtenga acceso no autorizado al Sitio.\n* No acceda al Sitio para difundir materiales que contengan elementos dañinos o virus, o materiales comerciales, como productos o servicios con fines publicitarios, a menos que le hayamos dado autorización previa.\n\nA cualquier Usuario que no cumpla con las Condiciones de Uso se le puede negar el acceso al Sitio u otros foros por motivos de violación del espíritu de estas Condiciones de uso, comportamiento fraudulento, acosador o abusivo hacia el Sitio o hacia otros Miembros y/o terceros o la violación de la privacidad de los Miembros. En caso de cancelación, ya no estará autorizado a acceder al Sitio. Las limitaciones de responsabilidad establecidas en estas Condiciones de Uso seguirán siendo válidas.\n\n## Propiedad intelectual\n\nTodos los elementos y materiales contenidos en el Sitio, incluidos el texto, el diseño, el logotipo, los gráficos y las imágenes, son de nuestra propiedad y están protegidos por las leyes de copyright y propiedad intelectual. El Sitio se facilita únicamente para su uso personal. No puede usar ningún material en el Sitio sin nuestra autorización previa y explícita. No se permite ninguna modificación, copia, reproducción, subida, posteo, publicación, traducción, trabajo derivado de duplicación o distribución del material.\n\n## Exención de responsabilidad\n\nEl Sitio pone a disposición de sus Usuarios información de contacto de profesionales holísticos de la medicina funcional, medicina integrativa y salud natural de diversas disciplinas y modalidades, es decir, homeopatía, acupuntura, naturopatía, nutrición, osteopatía, aromaterapia, herbolaria, terapias energéticas, etc. Mediante el uso del Sitio, usted podrá tener acceso y comunicación con otros Usuarios, ya sea Miembros personales o Miembros profesionales o Suscritores. Natural Healing Commune no será responsable de ninguna manera por ningún daño, pérdida, responsabilidad, costo o reclamo relacionado con ningún consejo o información intercambiada entre Suscriptores y/o Miembros, incluida, entre otras, la confiabilidad, calidad, precisión o eficacia de tal asesoramiento o información, o en relación con la identidad, certificación o acreditación del Usuario o Miembro Profesional y/o Compañía de salud natural.\n\nNatural Healing Commune igualmente y expresamente no será responsable por la autenticidad de las opiniones, consejos, información o testimonios hechos u ofrecidos. No seremos responsables de ninguna pérdida o daño causado por su confianza en la información obtenida a través de estos foros. Las opiniones vertidas son únicamente opiniones de los Usuarios.\n\nCualquier información que se encuentre en el Sitio, cualquier consejo o recomendación, información, conclusiones o resultados compartidos por los Miembros, incluidos los Miembros profesionales y/o compañías, pero sin limitarse a ellos, no son recomendados ni respaldados expresamente por Nosotros y su uso queda bajo Su responsabilidad y discreción.\n\nNatural Healing Commune no tiene la obligación de monitorear los contenidos o publicaciones y posteos en el Sitio. Sin embargo, reconoce y acepta que tenemos el derecho de monitorear posteos a nuestra discreción. Nos reservamos el derecho de negarnos a publicar o eliminar cualquier publicación o contenido, en su totalidad o en parte, para proteger al Sitio, a nuestros Usuarios, Miembros y Suscriptores.\n\nNatural Healing Commune no es un proveedor de atención médica y no brinda asesoramiento médico. Todo el contenido publicado en el Sitio por Nosotros o por nuestros Usuarios, Miembros registrados o Suscriptores, incluidas respuestas en los cuestionarios, texto, tratamientos, dosis, resultados, gráficos, perfiles de usuario, testimonios, gráficos, consejos, recomendaciones, mensajes, publicaciones y cualquier otro contenido o material que se encuentre en el Sitio tienen un fin informativo. Natural Healing Commune es una plataforma para que los miembros compartan experiencias de salud natural, modalidades de curación utilizadas e información compartida con el fin de crear una comunidad. El Sitio no tiene la intención de diagnosticar, tratar, curar o prevenir enfermedades o ayudar en la provisión de consejos de salud profesionales o diagnósticos médicos. Por lo tanto, el Sitio no constituye un sustituto del asesoramiento, diagnóstico o tratamiento médico o profesional.\n\nEl Sitio es una comunidad y una plataforma de redes para compartir información con la intención de crear una comunidad y apoyar el avance de las modalidades de salud natural, las prácticas de medicina integrativa y funcional y sus resultados positivos. Siempre debe hablar con un profesional de la salud sobre cualquier afección y/o tratamiento para obtener un diagnóstico adecuado y el asesoramiento adecuado de un profesional de la salud, incluido, entre otros, el asesoramiento profesional para la salud mental. Los usuarios del Sitio reconocen y aceptan que el uso del Sitio es para intercambiar información y compartir el uso de prácticas, modalidades, experiencias y resultados de salud natural.\n\nPodemos proporcionar enlaces a sitios de Internet mantenidos por terceros. Nuestro enlace a dichos sitios no implica un respaldo a dichos sitios, o la información, productos o servicios ofrecidos en o a través de los sitios. Además, no operamos ni controlamos ninguna información, productos o servicios que terceros puedan ofrecer en o a través del Sitio o en los sitios web vinculados por nosotros en el Sitio.\n\nNo garantizamos que el Sitio o cualquiera de sus funciones puedan ser ininterrumpidas o que se corrijan los errores, o que cualquier parte del Sitio o los servidores que lo ponen a disposición estén libres de virus u otros componentes dañinos. No somos responsables de ningún daño directo, indirecto o incidental que pueda resultar del uso o la incapacidad de usar el Sitio, incluidos mensajes, blogs, enlaces, correos electrónicos, recursos del Sitio, como estadísticas, bases de datos, información de cuestionarios o materiales, productos o servicios de terceros disponibles a través del Sitio. Usted acepta que no somos responsables de ninguna conducta difamatoria, ofensiva o ilegal de ningún Usuario.	Condiciones de Uso
privacy-policy	Privacy Policy	The Natural Healing Commune is committed to maintaining strong privacy protections for its Users. Our Privacy Policy is designed to help you understand how we collect, use and safeguard the information provided by you.\n\nFor the purposes of this Agreement, ‘Site’ refers to the website Natural Healing Commune which can be accessed at [www.naturalhealingcommune.com](http://www.naturalhealingcommune.com) or through our mobile application. The terms ‘We’ or ‘Us’ refer to the Natural Healing Commune, the Site. ‘You’ refers to the User, Member or Subscriber of the Site.\n\nBy accessing our Site, You accept our Privacy Policy and [Terms of Use](/policies/terms-of-use) and you consent to our collection, storage, and anonymous use and disclosure of the information You provide Us as described in this Privacy Policy.\n\n## Information we collect\n\nWe collect information that cannot be used to personally identify you, such as anonymous usage data, general demographic information, referring/exit pages and URLs, platform types, preferences you submit and preferences that are generated based on the data you submit and number of clicks.\n\nTo register and activate the use of the Site by becoming a Member, you do not need to submit any identifiable personal information other than your email address or your real name if you choose to register it as your Username. To use the Site thereafter, you are required to create a Username and complete a survey, using tick-box options and text boxes.\n\nTo register on our Site, you will create a personal profile, by entering your email address and creating a username and password. Apart from the email address required at registration, the other personal information we collect thereafter includes your age group and name (only if you choose to register your real name as Username) through the registration process at the Site. You can also choose to use a nickname as Username, if you prefer your real name not to be registered. Only your chosen Username will be linked to the Database and the information collected from you through the Survey, later identified in your account as ‘My Journey.’\n\nBy registering, you authorise Us to collect, store and use your email address in accordance with this Privacy Policy.\n\nIn an effort to improve the quality of the service at the Site, we track information provided to us by your browser or by our software application when you view or use the Site, such as the website you came from, the type of browser you use, the device from which you connected to the Site, the time and date of access, and other information that does not personally identify you. We track this information using cookies. Sending a cookie to a user’s browser enables us to collect Non-Personal information about that user and keep a record of the user’s preferences when utilizing our Site.\n\n## How we use and share information\n\nWe do not sell, trade, rent or otherwise share your personal information with third parties for marketing purposes without your consent.\n\nWe may share personal information with outside parties if we have good-faith belief that access, use or disclosure of the information is necessary to meet any legal process including investigation of potential violations, email address fraud, security or technical concerns, or to protect against harm to the rights, property, or safety of our Users.\n\n### About your personal health information collected through the Survey\n\nThis information provided through the Survey (tick-box options and text boxes) is collected for the purpose of the creation of a Database. This information will be shared only with other Members and/or Subscribers for the purposes of feedback, community sharing experiences, research and statistical analysis.\n\nThe personal health information held in the Natural Healing Commune Survey will not be linked to Your email address provided but only to Your chosen Username and therefore will be anonymous, if your Username is not your full name.\n\nIn the event of the Database created being of interest for natural health research, statistics will be drawn from the Database for the creation of anonymous reports to be made available to natural health practitioners with the intention of advancing, disseminating and supporting the use of natural health, functional medicine and other natural healing therapies.\n\nYour membership is protected by your account password and we urge you to take steps to keep your personal information safe by not disclosing your password and by logging out of your account after each use.\n\nWe may provide links to other websites or applications. However, we are not responsible for the privacy practices employed by those websites or the information or content they contain. This Privacy Policy applies only to information collected by Us through the Site.\n\nThe Natural Healing Commune Site reserves the right to change this policy and the Terms of Use at any time. We will notify you of any significant changes to our Privacy Policy by sending a notice to the primary email address specified in your account or by placing a notice on our Site. Changes will go into effect 30 days following notification.\n\nIf you have any questions regarding this Privacy Policy or the practices on this Site, please contact us by sending an email to [info@naturalhealingcommune.com](mailto:info@naturalhealingcommune.com).\n\n## Newsletters\n\nOur e-newsletters will give you news we think will be of interest to you. We may use a third-party provider to send you newsletters.\n\nWe will not sell, rent or lease our newsletter subscription lists to any third parties. We may use code within our e-newsletter template to identify which messages you have opened and which links you have clicked on within it to better tailor any future communications.\n\n## External links\n\nThe Natural Healing Commune website contains links to other websites. We are not responsible for the privacy practices of these and you should read their own privacy information. The information and usage described here applies only to personal data collected by the Natural Healing Commune.	2024-12-05 14:50:35.085	2024-12-05 14:22:12.764938	Natural Healing Commune se compromete a mantener normas estrictas de privacidad para sus Usuarios. Nuestras normas de privacidad están diseñadas para informarlo cómo recopilamos, usamos y protegemos la información que usted proporciona.\n\nA los efectos de este acuerdo, "Sitio" se refiere al sitio web de Natural Healing Commune al que se puede acceder en [www.naturalhealingcommune.com](http://www.naturalhealingcommune.com) o a través de nuestra aplicación móvil. Los términos “Nosotros” o “Nos” se refieren a Natural Healing Commune, el Sitio. “Usted” se refiere al Usuario, Miembro o Suscriptor del Sitio.\n\nAl acceder a nuestro Sitio, usted acepta nuestras Normas de privacidad y [Condiciones de uso](/policies/terms-of-use) y acepta la recopilación, almacenamiento, uso y divulgación anónimos de la información que nos proporciona como se describe en estas Normas de privacidad.\n\n## Información recopilada\n\nRecopilamos información que no se puede usar para identificarlo personalmente, como datos de uso anónimos, información demográfica general, páginas y URL de referencia/salida, tipos de plataforma, preferencias que envía y preferencias que se generan en función de los datos que envía y la cantidad de clics.\n\nPara inscribirse como Miembro y activar el uso del Sitio, no necesita enviar ninguna información personal identificable, solamente su dirección de correo electrónico y/o su nombre si decide usarlo como Nombre de usuario. A partir de allí, para usar el Sitio, debe crear un Nombre de usuario y completar el cuestionario, en el que marcará las casillas correspondientes y llenará cuadros de texto.\n\nAl inscribirse en nuestro Sitio, se creará un perfil personal, ingresando su dirección de correo electrónico y creando su Nombre de usuario y una contraseña. Además de la dirección de correo electrónico requerida en la inscripción, la información personal que recopilamos posteriormente incluye su género, grupo etario, lugar y país de residencia y su nombre real (solo si elige inscribirse con su nombre real como Nombre de usuario) a través del proceso de inscripción en el Sitio. También puede optar por utilizar un apodo como Nombre de usuario, si lo prefiere. Solo su Nombre de Usuario elegido se vinculará a la base de datos y la información recopilada a través del cuestionario, y se conocerá como "Mi trayectoria."\n\nAl inscribirse, nos autoriza a recopilar, almacenar y utilizar su dirección de correo electrónico de acuerdo con estas Normas de privacidad.\n\nEn un esfuerzo por mejorar la calidad del servicio en el Sitio, rastreamos la información que nos proporciona su navegador o nuestra aplicación de software cuando ve o usa el Sitio, como el sitio web del que proviene, el tipo de navegador que usa, el dispositivo desde el que se conectó al Sitio, la hora y fecha de acceso y otra información que no lo identifica personalmente. Hacemos un seguimiento de esta información utilizando cookies. Enviar cookies al navegador de un usuario nos permite recopilar información no personal sobre ese usuario y mantener un registro de las preferencias del usuario cuando utiliza nuestro Sitio.\n\n## Cómo usamos y compartimos la información\n\nNo vendemos, comercializamos, arrendamos ni compartimos su información personal con terceros con fines de marketing sin su consentimiento.\n\nPodemos compartir información personal con terceros si creemos de buena fe que el acceso, el uso o la divulgación de la información son necesarios para responder a un pleito legal, incluida la investigación de posibles violaciones, fraude de direcciones de correo electrónico, asuntos técnicos o de seguridad, o para proteger los derechos, la propiedad o la seguridad de nuestros Usuarios.\n\n### Acerca de su información de salud personal recopilada a través del cuestionario\n\nEsta información proporcionada a través de marca de casillas y cuadros de texto, se recopila con el fin de crear una Base de datos. Esta información se compartirá únicamente con otros Miembros y/o Suscriptores con fines de retroalimentación e intercambio de experiencias con la comunidad, investigación y análisis estadístico.\n\nLa información de salud personal contenida en el cuestionario de Natural Healing Commune no se vinculará a su dirección de correo electrónico, sino solo a su Nombre de usuario y, por lo tanto, será anónimo, si su Nombre de usuario no es su nombre completo.\n\nEn caso de que la Base de datos creada sea de interés para la investigación de las prácticas de salud natural, se extraerán estadísticas de la Base de datos para la creación de informes anónimos que se pondrán a disposición de los beneficiarios de las prácticas y tratamientos para la salud natural con la intención de avanzar, difundir y apoyar el uso de estas prácticas, de la medicina funcional y otras terapias curativas naturales.\n\nSu membresía está protegida por la contraseña de su cuenta y lo instamos a que tome medidas para mantener segura su información personal no revelando su contraseña y cerrando su cuenta después de cada uso.\n\nFacilitamos enlaces a otros sitios web o aplicaciones. Sin embargo, no somos responsables de las prácticas de privacidad empleadas por esos sitios web ni de la información o el contenido que contengan. Estas Normas de privacidad se aplican únicamente a la información recopilada por Nosotros a través del Sitio.\n\nEl Sitio Natural Healing Commune se reserva el derecho de cambiar estas Normas y los Términos de uso en cualquier momento. Le notificaremos sobre cualquier cambio significativo en nuestras Normas de privacidad, enviando un aviso a su dirección de correo electrónico de su cuenta o colocando un aviso en nuestro Sitio. Los cambios entrarán en vigor 30 días después de la notificación.\n\nSi tiene alguna pregunta con respecto a estas Normas de privacidad o cualquier módulo en este Sitio, comuníquese con nosotros enviando un correo electrónico a [info@naturalhealingcommune.com](mailto:info@naturalhealingcommune.com).\n\n## Boletines\n\nNuestros boletines electrónicos le brindarán informes que creemos que serán de su interés. Podremos utilizar un proveedor externo para enviarle boletines.\n\nNo venderemos, alquilaremos ni arrendaremos nuestras listas de suscripción de boletines a terceros. Podremos usar código dentro de nuestra plantilla de boletín electrónico para identificar qué mensajes ha abierto y en qué enlaces ha hecho clic para adaptar mejor cualquier comunicación futura.\n\n## Enlaces externos\n\nEl sitio web de Natural Healing Commune contiene enlaces a otros sitios web. No somos responsables de las prácticas de privacidad de estos y debe leer su propia información de privacidad. La información y el uso descritos aquí se aplican solo a los datos personales recopilados por Natural Healing Commune.	Normas de Privacidad
\.


--
-- TOC entry 3562 (class 0 OID 24623)
-- Dependencies: 220
-- Data for Name: nhc_post; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.nhc_post (id, "user", condition, treatment_specific_information, other_information, created_at, treatment_type, solved, updated_at, treatment_specific_information_es, other_information_es, original_language, deleted_by, dependant) FROM stdin;
ad6a3dad-4f0a-45df-80c5-815acf6f2a02	user_2i0YUJmUCVdti46BzCpsojU2o3k	a7cacf8e-8f12-4aa3-8d4d-c6160a2ecd9e			2024-06-17 13:39:11.866473	bothdrugsandnaturalhealthpracticestoheal	f	2024-06-17 13:39:11.866473	\N	\N	en	\N	\N
5fe19970-9f56-4b87-bf85-90d85838b30c	user_2i0YUJmUCVdti46BzCpsojU2o3k	a7cacf8e-8f12-4aa3-8d4d-c6160a2ecd9e			2024-06-17 13:39:11.904862	bothdrugsandnaturalhealthpracticestoheal	f	2024-06-17 13:45:05.861	\N	\N	en	\N	\N
99c49070-470c-4501-b1d8-65444c325d1a	user_2eEFfRxWdyrdXmELZTndFkY0hIm	7b161f66-9ed7-4af0-b6e9-4ecd6bb41ca1		123	2024-07-02 13:47:10.044438	exclusivelynaturalhealthpracticestoheal	f	2025-01-16 16:57:42.365	\N	\N	en	\N	579e05d1-6ab2-403e-b745-a47738d8f44f
14b5b08d-4cae-4754-892a-d8273d53bc4d	user_2rtJna94DM6TeBR6HCTocRLnucu	ae59b4b7-1f10-4c01-9bd1-aab3cecc1808	Only had the one session		2025-11-03 20:39:39.417882	exclusivelynaturalhealthpracticestoheal	f	2025-11-03 20:40:24.859	Solo tuve una sesión.		en	\N	\N
cd97f34b-f90b-4835-ab93-90765e7dd148	user_2i0YUJmUCVdti46BzCpsojU2o3k	7b161f66-9ed7-4af0-b6e9-4ecd6bb41ca1			2025-01-20 11:20:11.101002	exclusivelynaturalhealthpracticestoheal	f	2025-01-20 11:20:11.101002			en	\N	85e0bb99-79c7-444e-8d30-68f3f1d7e0e9
fdaeb2b3-cf04-48ac-8883-4cdf7ae3e8e3	user_2rtJna94DM6TeBR6HCTocRLnucu	5547c2e7-9942-4845-a3c0-2a9e1fe43d0f			2025-11-03 13:05:33.26557	naturalhealthpracticesonlyfordrugsideeffects	f	2025-11-03 13:05:33.26557			en	\N	d85c8f89-8dde-4122-ab36-cdada0320374
63424270-2354-4c68-90da-c3024927c74f	user_2sZjQd7MEkoaLKlBU2am4HE9X2S	2eb8a78c-5dd6-4dbe-b84c-8ef831143289			2025-02-04 14:29:33.440001	exclusivelynaturalhealthpracticestoheal	f	2025-02-04 14:29:33.440001			en	\N	\N
5027fe87-ff0a-4978-8bf7-a277ba62322a	user_2rtJna94DM6TeBR6HCTocRLnucu	444f7544-da21-4c0b-bd82-48f4c6cce293	I&#39;m also taking CBD oil.		2025-11-03 13:10:19.643642	exclusivelynaturalhealthpracticestoheal	f	2025-11-03 13:10:19.643642	Estoy también tomando aceite CBD		es	\N	\N
45f2a177-1764-41bd-af46-dc004f2abbfe	user_2i0YUJmUCVdti46BzCpsojU2o3k	c1fdf10c-d06a-4cc3-9331-4820fd3c9c14			2025-04-02 15:00:51.232655	exclusivelynaturalhealthpracticestoheal	f	2025-04-02 15:02:04.421			en	\N	3ec828aa-9b1d-41ae-91a6-5bca59c79fc4
802a6cd3-044f-4d9e-b0bc-011a4cca79b5	user_2i0YUJmUCVdti46BzCpsojU2o3k	7b161f66-9ed7-4af0-b6e9-4ecd6bb41ca1	To use in combination with Bach Flowers		2025-04-02 15:03:27.517288	bothdrugsandnaturalhealthpracticestoheal	f	2025-04-02 15:03:59.36	Para utilizar en combinación con Flores de Bach.		en	\N	85e0bb99-79c7-444e-8d30-68f3f1d7e0e9
1a4d2c9f-3b2e-4cf9-8ae8-ba2bf9d84bb6	user_2rtJna94DM6TeBR6HCTocRLnucu	8a93a267-b96b-490a-9056-58808b94dd03			2025-04-02 15:22:41.427877	exclusivelynaturalhealthpracticestoheal	f	2025-04-02 15:22:41.427877			es	\N	\N
de4deb7e-2db2-4de5-a4de-5180d89aa156	user_2eEFfRxWdyrdXmELZTndFkY0hIm	7b161f66-9ed7-4af0-b6e9-4ecd6bb41ca1	This is a test in English	This is another test in English	2024-07-24 15:07:13.938688	exclusivelynaturalhealthpracticestoheal	f	2024-07-24 15:32:53.519	Esta es una prueba en inglés.	Esta es otra prueba en inglés.	en	admin	\N
cbf311ee-548c-4a2e-98ef-9ccc8596e35a	user_2sZjQd7MEkoaLKlBU2am4HE9X2S	c1fdf10c-d06a-4cc3-9331-4820fd3c9c14			2025-05-29 15:22:46.197218	exclusivelynaturalhealthpracticestoheal	f	2025-05-30 09:55:26.879			en	\N	8d9eeefd-38ea-47bd-b194-ffc5d6e14c33
d236047f-e17d-4485-9819-ff6806f23eab	user_2eEFfRxWdyrdXmELZTndFkY0hIm	b847ae5b-99c4-4fcd-84b5-216c75c9785e	Typical information	Other information	2025-10-22 12:47:06.991233	naturalhealthpracticesafterdrugsfailedtohelp	f	2025-10-22 12:47:06.991233	Información típica	Otra información	en	\N	6dfee312-a371-42dc-b7b4-415a07cdb03d
3a11a523-d6bb-43c8-a719-2f51200c189d	user_2rtJna94DM6TeBR6HCTocRLnucu	0c77f3ca-2895-4e6e-83d3-fe28c0cfdfe0			2025-10-22 15:44:19.269376	exclusivelynaturalhealthpracticestoheal	f	2025-10-22 15:44:19.269376			en	\N	\N
fa608a7e-a57b-4223-9d48-fef79f087c7a	user_2i0YUJmUCVdti46BzCpsojU2o3k	5fc0c6a2-daac-4c02-96a7-86604e932ce6	Had great success using a massage oil with turmeric. Massaged directly into the knees.		2024-06-17 13:49:15.818769	exclusivelynaturalhealthpracticestoheal	f	2025-10-26 17:49:06.073	\N	\N	en	\N	\N
19324eab-2b41-4e49-9fc9-bf1507ca85f1	user_2rtJna94DM6TeBR6HCTocRLnucu	4cec057f-ccf1-468e-827d-0355351d6218	blah blah	Expensive	2025-10-22 15:50:53.028209	exclusivelynaturalhealthpracticestoheal	f	2025-11-03 20:34:02.537			en	\N	\N
e01ee99f-743a-46f7-acaa-301569f1762d	user_2i0YUJmUCVdti46BzCpsojU2o3k	c1fdf10c-d06a-4cc3-9331-4820fd3c9c14	The best for me was to balance my microbiome with specific diet for a while and then reintroduced elements back again when symptoms were relieved		2024-06-17 14:03:54.393531	exclusivelynaturalhealthpracticestoheal	f	2025-10-26 17:52:55.303	\N	\N	en	\N	\N
a3d47aaf-6764-4ff1-a461-e2297c5340e5	user_2eEFfRxWdyrdXmELZTndFkY0hIm	c1fdf10c-d06a-4cc3-9331-4820fd3c9c14			2024-11-20 16:51:16.864141	exclusivelynaturalhealthpracticestoheal	f	2024-11-20 16:51:16.864141			en	\N	579e05d1-6ab2-403e-b745-a47738d8f44f
3591468b-9209-4faa-9459-8db1477b142d	user_2saDE9oZAjHgmENRgFUPG2hVN7v	f3505f81-f0b9-473c-8580-8faf6c4eee05			2025-02-06 10:13:02.042145	naturalhealthpracticesafterdrugsfailedtohelp	f	2025-10-26 17:56:40.501			en	\N	\N
7f6d68e1-3c76-4f69-a030-57de70e2405a	user_2eEFfRxWdyrdXmELZTndFkY0hIm	c1fdf10c-d06a-4cc3-9331-4820fd3c9c14			2024-06-19 15:21:52.872374	exclusivelynaturalhealthpracticestoheal	f	2024-11-26 13:50:22.846	\N	\N	en	\N	\N
c4f849a2-61b2-40f4-90e6-c9019715f245	user_2rtJna94DM6TeBR6HCTocRLnucu	cf338d45-c4a0-438f-acfc-642558b39ee2		In two weeks I was completely recovered.	2025-10-27 10:25:49.882757	exclusivelynaturalhealthpracticestoheal	f	2025-10-27 10:25:49.882757		En dos semanas estaba completamente restablecida	es	\N	\N
44f5b00b-c482-4270-86a0-225339d69a5f	user_2i0YUJmUCVdti46BzCpsojU2o3k	8c323561-91b5-4851-9fd0-8bcd9bb01f06			2024-08-18 19:25:21.522941	naturalhealthpracticesafterdrugsfailedtohelp	f	2024-08-18 19:25:21.522941			en	\N	3ec828aa-9b1d-41ae-91a6-5bca59c79fc4
0e7ad017-847f-47aa-9918-a01276646bc0	user_34jRfRPxab2hR9GYJbOr6HImQQN	1fcdf727-1668-4e52-b4e2-323db99517a2			2025-10-29 08:07:36.36805	bothdrugsandnaturalhealthpracticestoheal	f	2025-10-29 08:07:36.36805			en	\N	\N
21314289-6927-4ea7-85a8-e21d1b1002e5	user_2i0YUJmUCVdti46BzCpsojU2o3k	f3505f81-f0b9-473c-8580-8faf6c4eee05			2025-11-03 12:29:31.609917	exclusivelynaturalhealthpracticestoheal	f	2025-11-03 12:29:31.609917			en	\N	\N
9cbd1747-2217-4742-bada-cf697df51604	user_2rtJna94DM6TeBR6HCTocRLnucu	c1fdf10c-d06a-4cc3-9331-4820fd3c9c14	I mostly had a change in diet and also some supplements	I was given enzymes, that were missing in my gut and that balanced my microbiome once and for all	2025-10-26 17:41:33.545735	naturalhealthpracticesafterdrugsfailedtohelp	f	2025-11-03 20:37:14.133	Principalmente tuve un cambio en la dieta y también algunos suplementos.	Me dieron enzimas que faltaban en mi intestino y que equilibraron mi microbioma de una vez por todas.	en	\N	\N
\.


--
-- TOC entry 3566 (class 0 OID 24669)
-- Dependencies: 224
-- Data for Name: nhc_post_comment; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.nhc_post_comment (id, content, "user", post, parent_id, create_at, content_es, original_language, deleted_by) FROM stdin;
6cbe25f8-2166-4422-a3c2-5d12bc3ae62f	Can you let me know what was the type of protein you had please?	user_2rtJna94DM6TeBR6HCTocRLnucu	e01ee99f-743a-46f7-acaa-301569f1762d	\N	2025-10-26 17:42:56.241568	Can you let me know what was the type of protein you had please?	en	\N
5940d642-4294-49f4-90e1-7d80d60b1038	Please let me know what kind of massage oil you used. Thanks	user_2rtJna94DM6TeBR6HCTocRLnucu	fa608a7e-a57b-4223-9d48-fef79f087c7a	\N	2025-10-26 17:44:06.180319	Please let me know what kind of massage oil you used. Thanks	en	\N
adfc753a-9221-4c57-b974-e70ed8840abc	It's a turmeric oil for topical use. I can let you know the company that makes it.	user_2i0YUJmUCVdti46BzCpsojU2o3k	fa608a7e-a57b-4223-9d48-fef79f087c7a	5940d642-4294-49f4-90e1-7d80d60b1038	2025-10-26 17:49:06.0681		en	\N
129647bf-7bd2-408c-a7ea-af6868f4cc31	I cut on dairy and introduced more fish and organic chicken in my diet	user_2i0YUJmUCVdti46BzCpsojU2o3k	e01ee99f-743a-46f7-acaa-301569f1762d	6cbe25f8-2166-4422-a3c2-5d12bc3ae62f	2025-10-26 17:50:16.077314		en	\N
3fcfbd1a-841e-4211-b64e-a01bba89a09d	It seems that you did quite a lot of work to get over it. What was wrong with your microbiome?	user_2i0YUJmUCVdti46BzCpsojU2o3k	9cbd1747-2217-4742-bada-cf697df51604	\N	2025-10-26 17:53:47.2793	It seems that you did quite a lot of work to get over it. What was wrong with your microbiome?	en	\N
f39f5104-17dc-43a8-aaab-323c3b2aff25	Have your hot flushes improved with massage therapy?	user_2i0YUJmUCVdti46BzCpsojU2o3k	19324eab-2b41-4e49-9fc9-bf1507ca85f1	\N	2025-10-26 17:55:03.609603	Have your hot flushes improved with massage therapy?	en	\N
80b0f600-18be-4cd8-a026-0af5d79fd3f7	You haven't used any natural health practices. Can you please let me know what did you use that helped?	user_2i0YUJmUCVdti46BzCpsojU2o3k	3591468b-9209-4faa-9459-8db1477b142d	\N	2025-10-26 17:56:40.497714	You haven't used any natural health practices. Can you please let me know what did you use that helped?	en	\N
9804541a-4d24-426a-86bc-10fa2584708e	Can you let me know what exactly was your best result	user_2i0YUJmUCVdti46BzCpsojU2o3k	9cbd1747-2217-4742-bada-cf697df51604	\N	2025-11-03 12:57:56.785322	Can you let me know what exactly was your best result	en	\N
bc89c3bb-ca18-4c2b-a298-1f90e2f270f7	I'm starting menopause and will like to know about your experience please.	user_2i0YUJmUCVdti46BzCpsojU2o3k	19324eab-2b41-4e49-9fc9-bf1507ca85f1	\N	2025-11-03 12:59:00.050177	I'm starting menopause and will like to know about your experience please.	en	\N
3eace7f2-725d-406a-b54a-8ce19144333d	I will contact you briefly. No problem	user_2rtJna94DM6TeBR6HCTocRLnucu	19324eab-2b41-4e49-9fc9-bf1507ca85f1	bc89c3bb-ca18-4c2b-a298-1f90e2f270f7	2025-11-03 13:01:20.049686		en	\N
ff60ae04-1252-449e-aa08-3b1f32edbd0c	Waiting for your reply	user_2rtJna94DM6TeBR6HCTocRLnucu	9cbd1747-2217-4742-bada-cf697df51604	\N	2025-11-03 20:36:46.59069	Waiting for your reply	en	\N
3bab3d33-7d70-40ac-b5bc-5d3ed82c70de	I used more than the 4 therapies listed but these were the main ones	user_2i0YUJmUCVdti46BzCpsojU2o3k	5fe19970-9f56-4b87-bf85-90d85838b30c	\N	2024-06-17 13:45:05.854987		en	\N
69fb77de-3c88-446b-928b-88e3abb0bec7	Test	user_2eEFfRxWdyrdXmELZTndFkY0hIm	99c49070-470c-4501-b1d8-65444c325d1a	\N	2024-07-04 12:42:27.290316		en	\N
12fb5003-6127-445e-9606-bb15bcd3cfa1	Another test reply	user_2eEFfRxWdyrdXmELZTndFkY0hIm	99c49070-470c-4501-b1d8-65444c325d1a	69fb77de-3c88-446b-928b-88e3abb0bec7	2024-07-04 12:45:58.751974		en	\N
618d6522-c8aa-4649-9ad3-98c185f669d2	I sent it an hour ago . check spam.	user_2rtJna94DM6TeBR6HCTocRLnucu	9cbd1747-2217-4742-bada-cf697df51604	ff60ae04-1252-449e-aa08-3b1f32edbd0c	2025-11-03 20:37:14.124341		en	\N
eed915f8-cae2-4d20-9164-2ecf22d8cb73	Thank you	user_2eEFfRxWdyrdXmELZTndFkY0hIm	de4deb7e-2db2-4de5-a4de-5180d89aa156	\N	2024-07-24 15:32:53.578902	Gracias	es	\N
455b3ae8-a7dc-44d0-9ee1-c01003e17bc8	Looking to share this experience with others	user_2i0YUJmUCVdti46BzCpsojU2o3k	45f2a177-1764-41bd-af46-dc004f2abbfe	\N	2025-04-02 15:01:34.092271	Looking to share this experience with others	en	\N
53f444b7-c14a-4b55-b893-b7bd96c1b8fb	Would like to share this with other children's parents	user_2i0YUJmUCVdti46BzCpsojU2o3k	802a6cd3-044f-4d9e-b0bc-011a4cca79b5	\N	2025-04-02 15:03:59.355608	Would like to share this with other children's parents	en	\N
\.


--
-- TOC entry 3565 (class 0 OID 24656)
-- Dependencies: 223
-- Data for Name: nhc_post_to_treatment; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.nhc_post_to_treatment (post_id, treatment_id, benefit_of_treatment, created_at, success_rating, benefit_of_treatment_es) FROM stdin;
ad6a3dad-4f0a-45df-80c5-815acf6f2a02	149f83c6-ab6e-43ba-b244-60280f6fc9b9	No significant improvement was noticed	2024-06-17 13:39:11.891143	\N	
ad6a3dad-4f0a-45df-80c5-815acf6f2a02	c2241408-ec8f-46c6-9095-77cd5f8d53d1	Good nutrition helped keep the symptoms calm	2024-06-17 13:39:11.891143	C	
ad6a3dad-4f0a-45df-80c5-815acf6f2a02	f9baaa24-f0b8-4b85-a350-7c6dfebb5d77	Noticeable improvement after 1 week. Targeted healthy gut and drying out lungs	2024-06-17 13:39:11.891143	B	
5fe19970-9f56-4b87-bf85-90d85838b30c	149f83c6-ab6e-43ba-b244-60280f6fc9b9	No significant improvement was noticed	2024-06-17 13:39:11.923631	\N	
5fe19970-9f56-4b87-bf85-90d85838b30c	c2241408-ec8f-46c6-9095-77cd5f8d53d1	Good nutrition helped keep the symptoms calm	2024-06-17 13:39:11.923631	C	
5fe19970-9f56-4b87-bf85-90d85838b30c	f9baaa24-f0b8-4b85-a350-7c6dfebb5d77	Noticeable improvement after 1 week. Targeted healthy gut and drying out lungs	2024-06-17 13:39:11.923631	B	
5fe19970-9f56-4b87-bf85-90d85838b30c	50a58357-6f88-4453-a9b9-9b70290d3c0a	A regular deep tissue massage really helps keep the muscles around the ribs loose, which helps the breathing	2024-06-17 13:43:38.743527	B	
fa608a7e-a57b-4223-9d48-fef79f087c7a	a50a081b-4545-4a30-9627-f209c0bdf9b6	This helped in keeping the stresses out of the knee joints	2024-06-17 13:49:15.828568	C	
fa608a7e-a57b-4223-9d48-fef79f087c7a	f9baaa24-f0b8-4b85-a350-7c6dfebb5d77	Really made a difference after about 1 month	2024-06-17 13:49:15.828568	B	
e01ee99f-743a-46f7-acaa-301569f1762d	c2241408-ec8f-46c6-9095-77cd5f8d53d1	Change of diet to a healthy, veg rich and organic diet made this go away	2024-06-17 14:03:54.410134	A	
7f6d68e1-3c76-4f69-a030-57de70e2405a	6a4e7d2d-499d-4230-a17d-1f35300b06c8	Very successful	2024-06-19 15:21:53.131568	B	
99c49070-470c-4501-b1d8-65444c325d1a	0eb451ca-d1ef-4378-8f53-47227ae2b9b4	Total success	2024-07-02 13:47:10.225785	A	
99c49070-470c-4501-b1d8-65444c325d1a	cf343e69-5a7e-4ff9-9973-01ee39110e8c	Didnt work very well, only assisted in the symptoms.	2024-07-02 13:47:10.225785	C	
de4deb7e-2db2-4de5-a4de-5180d89aa156	571c9061-bd6b-4de1-a67d-d122b136fc26	Somewhat successful	2024-07-24 15:07:14.283167	B	Algo exitoso
de4deb7e-2db2-4de5-a4de-5180d89aa156	149f83c6-ab6e-43ba-b244-60280f6fc9b9	Not much help	2024-07-24 15:07:14.283167	C	No hay mucha ayuda
44f5b00b-c482-4270-86a0-225339d69a5f	6a4e7d2d-499d-4230-a17d-1f35300b06c8	Completely healed	2024-08-18 19:25:21.539214	A	Completamente curado
44f5b00b-c482-4270-86a0-225339d69a5f	149f83c6-ab6e-43ba-b244-60280f6fc9b9	Just helped	2024-08-18 19:25:21.539214	C	Solo ayudó
a3d47aaf-6764-4ff1-a461-e2297c5340e5	1c2504cd-ad0b-40a0-85fd-d1edc1ab88e0	Somewhat successful	2024-11-20 16:51:17.238612	B	Algo exitoso
7f6d68e1-3c76-4f69-a030-57de70e2405a	1c2504cd-ad0b-40a0-85fd-d1edc1ab88e0	Very successful	2024-11-22 17:13:01.44833	A	
99c49070-470c-4501-b1d8-65444c325d1a	149f83c6-ab6e-43ba-b244-60280f6fc9b9	This was very successful for handling the symptoms	2025-01-10 15:04:21.440276	C	
99c49070-470c-4501-b1d8-65444c325d1a	78a05708-2ed0-4048-a21e-0f77a1c62757	This was very successful	2025-01-10 16:32:23.706295	B	
99c49070-470c-4501-b1d8-65444c325d1a	28db6508-6f77-42c5-b910-55966fa25312	Test	2025-01-16 16:57:42.772874	A	
cd97f34b-f90b-4835-ab93-90765e7dd148	b196812e-92e4-4628-b611-67f9f68e490f	three months treatment	2025-01-20 11:20:11.11411	A	tratamiento de tres meses
cd97f34b-f90b-4835-ab93-90765e7dd148	83c164ce-c27b-4e70-a073-fe9c60286f1b	Started helping after two months	2025-01-20 11:20:11.11411	A	Comenzó a ayudar después de dos meses.
63424270-2354-4c68-90da-c3024927c74f	ec422c78-b147-452c-9112-0f0928bf9c65	Very successful	2025-02-04 14:29:33.766807	A	Muy exitoso
45f2a177-1764-41bd-af46-dc004f2abbfe	0eb451ca-d1ef-4378-8f53-47227ae2b9b4	six months of acupuncuter	2025-04-02 15:00:51.249595	A	seis meses de acupuntura
45f2a177-1764-41bd-af46-dc004f2abbfe	83c164ce-c27b-4e70-a073-fe9c60286f1b	Still using ayurvedic technics	2025-04-02 15:00:51.249595	B	Todavía utilizando técnicas ayurvédicas
802a6cd3-044f-4d9e-b0bc-011a4cca79b5	1c2504cd-ad0b-40a0-85fd-d1edc1ab88e0	Still looking for right therapy	2025-04-02 15:03:27.536109	C	Todavía buscando la terapia adecuada
1a4d2c9f-3b2e-4cf9-8ae8-ba2bf9d84bb6	1c2504cd-ad0b-40a0-85fd-d1edc1ab88e0	I have to try again	2025-04-02 15:22:41.450409	C	tengo que intentarlo nuevamente
1a4d2c9f-3b2e-4cf9-8ae8-ba2bf9d84bb6	17ec076d-f17c-4d87-ba89-f1641371c199	It's the best for apnea	2025-04-02 15:22:41.450409	A	Es lo mejor para la apnea
cbf311ee-548c-4a2e-98ef-9ccc8596e35a	0eb451ca-d1ef-4378-8f53-47227ae2b9b4	Worked great	2025-05-30 09:55:27.596437	B	
d236047f-e17d-4485-9819-ff6806f23eab	cf343e69-5a7e-4ff9-9973-01ee39110e8c	Only helped symptoms	2025-10-22 12:47:07.301524	B	Sólo ayudaron los síntomas
3a11a523-d6bb-43c8-a719-2f51200c189d	149f83c6-ab6e-43ba-b244-60280f6fc9b9	This has been effective all along	2025-10-22 15:44:19.331088	B	Esto ha sido efectivo todo el tiempo.
3a11a523-d6bb-43c8-a719-2f51200c189d	50a58357-6f88-4453-a9b9-9b70290d3c0a	Symptoms were alleviated	2025-10-22 15:44:19.331088	C	Los síntomas se aliviaron
3a11a523-d6bb-43c8-a719-2f51200c189d	c2241408-ec8f-46c6-9095-77cd5f8d53d1	Nutritional therapy has allowed complete recovery	2025-10-22 15:44:19.331088	A	La terapia nutricional ha permitido una recuperación completa.
19324eab-2b41-4e49-9fc9-bf1507ca85f1	0eb451ca-d1ef-4378-8f53-47227ae2b9b4	Had some sessions sporadically 	2025-10-22 15:50:53.045779	B	Tuve algunas sesiones esporádicamente 
19324eab-2b41-4e49-9fc9-bf1507ca85f1	50a58357-6f88-4453-a9b9-9b70290d3c0a	Keep doing massage therapy for symptoms 	2025-10-22 15:50:53.045779	C	Continúe con la terapia de masaje para los síntomas. 
19324eab-2b41-4e49-9fc9-bf1507ca85f1	c2241408-ec8f-46c6-9095-77cd5f8d53d1	Helps with hot flushes	2025-10-22 15:50:53.045779	B	Ayuda con los sofocos.
9cbd1747-2217-4742-bada-cf697df51604	c2241408-ec8f-46c6-9095-77cd5f8d53d1	I took the typical acid reflux tablets for months. I only got a bit of instant relief but then the symptoms would be worse and more often. So a balanced diet made the change.	2025-10-26 17:41:33.585239	A	Tomé las típicas pastillas para el reflujo ácido durante meses. Solo sentí un alivio leve al instante, pero luego los síntomas empeoraban y se hacían más frecuentes. Así que una dieta equilibrada me ayudó a cambiar.
e01ee99f-743a-46f7-acaa-301569f1762d	149f83c6-ab6e-43ba-b244-60280f6fc9b9	Homeopathy also helped with balancing the energetic aspect of my symptoms	2025-10-26 17:51:47.782923	B	
c4f849a2-61b2-40f4-90e6-c9019715f245	149f83c6-ab6e-43ba-b244-60280f6fc9b9	With two homeopathic remedies I managed to relieve the symptoms.	2025-10-27 10:25:49.954808	A	Con dos remedios homeopáticos consegui aliviar los síntomas
c4f849a2-61b2-40f4-90e6-c9019715f245	c2241408-ec8f-46c6-9095-77cd5f8d53d1	Two essential supplements for urinary tract infections	2025-10-27 10:25:49.954808	A	Dos suplementos fundamentales para la infección urinaria
0e7ad017-847f-47aa-9918-a01276646bc0	28c0d9c7-bf3c-483b-a884-df71040cf19d	blah blah	2025-10-29 08:07:36.397951	C	bla bla bla
0e7ad017-847f-47aa-9918-a01276646bc0	1ebe8789-c2da-41b4-92f9-53f5001ef32c	blah blah	2025-10-29 08:07:36.397951	B	bla bla bla
0e7ad017-847f-47aa-9918-a01276646bc0	de5c9cca-64f4-4e9b-b736-dbff6dcedf62	blah blah	2025-10-29 08:07:36.397951	\N	bla bla bla
21314289-6927-4ea7-85a8-e21d1b1002e5	0eb451ca-d1ef-4378-8f53-47227ae2b9b4	Seven Moksa treatments managed to sort it out.	2025-11-03 12:29:31.637777	A	Siete tratamientos de Moksa lograron solucionarlo.
fdaeb2b3-cf04-48ac-8883-4cdf7ae3e8e3	c2241408-ec8f-46c6-9095-77cd5f8d53d1	No more progress for now	2025-11-03 13:05:33.287128	B	Por el momento no hay más avances.
5027fe87-ff0a-4978-8bf7-a277ba62322a	02e02716-0795-43c4-aef4-126f6b5ab8df	Bach flower remedies help me stay calm	2025-11-03 13:10:19.658761	B	Me ayudan las flores de Bach para mantenerme calma
19324eab-2b41-4e49-9fc9-bf1507ca85f1	28db6508-6f77-42c5-b910-55966fa25312	Very soothing	2025-11-03 20:33:56.843082	\N	
\.


--
-- TOC entry 3563 (class 0 OID 24631)
-- Dependencies: 221
-- Data for Name: nhc_treatment; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.nhc_treatment (id, name, disabled, name_es) FROM stdin;
55bd18fb-43db-4fae-877b-600f58e5fb81	Alexander Technique	f	Técnica de Alexander
0163bc87-e8fd-441a-9ea1-4ed46b6055a1	Alpha-Wave Therapy	f	Terapia de ondas alfa 
08677e30-499e-4115-b5d0-5b5177e86e9e	Anthroposophical Medicine	f	Medicina antroposófica
de094b13-3bfc-472d-9ed1-1db44aa0314a	Ascorbazone Protocol	f	Protocolo Ascórbico
841b047a-2f3f-4073-a3f7-3bd7c66cfabc	Authentic Reiki Healing	f	Curación Auténtica de Reiki
6c7dd82f-38a8-4b1b-ae1d-c96cae9f1716	Autoimmune Protocol (AIP)	f	Protocolo Autoinmune 
83c164ce-c27b-4e70-a073-fe9c60286f1b	Ayurvedic Medicine	f	Medicina ayurvédica
1c2504cd-ad0b-40a0-85fd-d1edc1ab88e0	Bach Flower Remedies	f	Remedios florales de Bach o Flores de Bach
3be36eba-7cfe-4fbd-ba8e-bc71f21dadcb	Bio-Oxidative Therapy	f	Terapia bio-oxidativa
83cffbfd-8913-410f-b585-a5268454d174	Bio-regulatory Drug-Free Medicine	f	Medicina biorreguladora
b4907862-5bd3-46c8-a80a-58e9a680743f	Biological Medicine	f	Medicina biológica
1ca4c718-b1f7-4636-a74b-e9898bc88283	Dowsing	f	Radiestesia o Rabdomancia
83a400ee-4ddd-4b38-a824-fb5481c16bd8	Bio Magnetic Therapy	f	
fe8b51e8-9c6f-4526-81cf-13cd7b67f126	The Lifeline Technique	f	
131dad44-21e1-4fdb-b78f-3d141de389e8	Theta Healing	f	
7c30260b-67e4-462b-9a62-8dcc555709eb	The Yuen Method	f	
df9bab93-3225-4c0b-8662-8670c7b1feae	ZPoint Therapy	f	
553b821e-f090-4094-b691-8ad10eda2edb	Bio Decoding	f	
04636109-8818-4f19-8dc7-80bde9c911d7	Bioenergetic Therapy	f	
0eb451ca-d1ef-4378-8f53-47227ae2b9b4	Acupuncture	f	Acupuntura
b196812e-92e4-4628-b611-67f9f68e490f	Aromatherapy	f	Aromaterapia
28db6508-6f77-42c5-b910-55966fa25312	Body Talk	f	Conversación corporal
6a4e7d2d-499d-4230-a17d-1f35300b06c8	Chelation Therapy	f	Terapia de quelación
52a60a76-bf9e-4184-a7ff-11d2760a322c	Colour Therapy	f	Terapia de color
ae1f29a6-4fd4-4b98-a094-50c166551cb7	Craniosacral Therapy	f	Terapia Craneosacral
ecc0f093-161a-4789-aa23-9344c0464ab4	Crystal Therapy	f	Terapia con cristales o cristaloterapia
24e4ce01-1131-4a14-a4ad-3ac8fbc4fb09	Cupping Therapy	f	Terapia de catación o de ventosas
eccd4fa5-4c06-4cdf-b19c-345fc29749ec	Earthing	f	Terapia de puesta a tierra
8822a5b3-ea12-48a2-882a-d67e2c498f9d	EFT	f	EFT
1ebe8789-c2da-41b4-92f9-53f5001ef32c	Electrical Stimulation Therapy	f	Terapia de estimulación eléctrica o Estimulación de electroterapia craneal
50ffedb4-8407-48c4-9396-35f31112959f	EMDR	f	EMDR o desensibilización y reprocesamiento por movimientos oculares
bb4202f3-0b1d-45c5-acdd-d350e9f6b598	Enema Therapy	f	Terapia de enema
ec422c78-b147-452c-9112-0f0928bf9c65	Energy Psychology (holographic repatterning)	f	Psicología energética (rediseño holográfico)
de5c9cca-64f4-4e9b-b736-dbff6dcedf62	Energy Therapy	f	Terapia energética
78a05708-2ed0-4048-a21e-0f77a1c62757	Essiac Herbs	f	Hierbas Essiac
cf343e69-5a7e-4ff9-9973-01ee39110e8c	Ethnobotany Medicine	f	Medicina etnobotánica
fa7d5b3c-a164-4042-9924-66c05dfd84ad	Far-Infrared Sauna	f	Sauna de infrarrojo lejano
7ebc0996-a8bf-4d35-9787-7bb191a748db	H202	f	H202 o peróxido de hidrogeno o agua oxigenada
571c9061-bd6b-4de1-a67d-d122b136fc26	Heartmath Therapy	f	Terapia Heartmath o matemática del corazón
62845adb-6234-42c5-9bc8-6a6cd5200397	Herbalism (traditional & medical)	f	Herboristería (tradicional y médica)
02e02716-0795-43c4-aef4-126f6b5ab8df	Homeobotanicals	f	Terapia botánica o floral botánica o fitoterapia
149f83c6-ab6e-43ba-b244-60280f6fc9b9	Homeopathy	f	Homeopatía
b5393f23-8ef0-4321-85c3-f54411652b6d	Hyperbaric Oxygen Treatment (HBOT)	f	Tratamiento de Oxígeno Hiperbárico (TOHB)
5b8db25b-bdc6-4d45-a79d-300feb21ab4b	Hypnotherapy	f	Hipnoterapia o Hipnosis terapéutica
0c6aa975-ad6c-4f39-9395-969d323ca670	Infoceuticals	f	Terapia infoceutica
607ddaad-a93b-452c-b775-2cdf81d5cb7c	Infrared Therapy	f	Terapia infrarroja
f0d3ea8c-c2c9-47e7-a1c5-bf894a516dfb	IV Therapy	f	Terapia intravenosa
c3712ba5-20b4-4fca-af0a-bef2cd2894fd	Kinesiology	f	Kinesiología
3dab545b-6655-46c8-bdd0-2cb410ec1730	Limbic Retraining	f	Entrenamiento del sistema límbico
50a58357-6f88-4453-a9b9-9b70290d3c0a	Massage Therapy	f	Quiromasaje
c893ee17-8f05-4455-bffd-085a2e6f9161	McTimoney Chiropractic	f	Quiropráctica McTimoney
d4a0119f-a4eb-41c4-b76b-1818fe373b8d	Mindfulness Based Stress Reduction Techniques	f	Técnicas de mindfulness o atención plena
15ebbf80-51ee-47b6-aeb3-a4c1d7bc508a	MMS or Master Mineral Solution	f	Suplemento Mineral Milagroso o SMM
741d6a38-56d4-423b-a855-23a3e7fb48c3	Moxibustion	f	Moxibustión con Moxa
d99b49a9-7777-4827-a210-280efb8bdee0	Mud Therapy	f	Fangoterapia
b03253b5-6e2c-4b36-90a0-121600fdd81a	Neuroplasticity Treatment	f	Tratamiento de Neuroplasticidad
c2241408-ec8f-46c6-9095-77cd5f8d53d1	Nutrition & Naturopathy	f	Terapia nutricional o naturopatía
a50a081b-4545-4a30-9627-f209c0bdf9b6	Osteopathy	f	Osteopatía
53811474-9fa0-4050-a728-43ef683f6273	OTC HP	t	OTC HP (to translate)
17ec076d-f17c-4d87-ba89-f1641371c199	Pranayama Breathing Techniques	f	Respiración Pranayama
1747c6a3-91da-4248-9dc1-8201258f0831	Pranic Healing	f	Sanación Pránica
65ac5148-df4a-4ce0-b2c3-16183beb08e4	PRP (Platelet-Rich Plasma) Therapy	f	Tratamiento plasma rico en plaquetas (PRP)
92d9c2d4-ea58-4f2a-b544-98f59996ef01	PSYCH K	f	PSYCH-K 
3b7856f8-1028-40d3-a218-184c47b707b1	Psychedelics	f	Psicodélicos
a8c411fb-8079-4862-ad2c-1ef858a0628b	Qigong Healing	f	Curación Qi Gong O Chi Kung
1fef842c-8790-4dca-a9fa-ff453127b5c9	Quantum Healing	f	Sanación Cuántica
d03dabd0-1f4c-4955-9da7-2e35f312383b	Radiance Technique	f	Técnica de Radiancia Reiki
f9f08833-433b-4cd3-84ab-251b5418e53a	Rebirthing or Conscious Connected Breathing	f	Rebirthing o Respiración conectada consciente
2e64581b-97dc-4dbe-989f-6c40fda94eea	Reflexology	f	Reflexología
94bdbbcd-4038-46fd-b31c-939b1b8dba3f	Remote Energy Healing or Radionics	f	Sanación Energética Remota o Radiónica
3d238080-9e74-4db0-8468-fa251c15189d	Rolfing Therapy	f	Terapia Rolfing
7e253348-a0b7-4540-8892-ef5ebf3c8031	Royal Rife Frequency Therapy	f	Terapia de frecuencia Royal Rife
ba427e47-cd89-4bc2-80d7-6c0efc8c5ccf	Salt Water Therapy	f	Talasoterapia
b9669830-7641-47b6-9c94-b6eb1c0ff824	Shiatsu Therapy	f	Terapia Shiatsu
80928f76-2918-4772-902c-1a8a877f3dd7	Sound Therapy	f	Terapia de sonido
82292e65-b3dd-4cf5-92d1-7e5024c12ef8	Spiritual and Shamanic Healing	f	Sanación espiritual y chamánica o shamánica 
b9781ba2-ee15-42d3-a04d-323fdee86d54	Talking Therapies	f	Terapias de conversación
41420527-8235-4dc8-ae29-8bc5996cfb5e	Tapping Therapy	f	Terapia de tapping
be24e73d-356a-4fc0-9c21-07e21254248d	The Bates Method	f	El Método Bates
827c4700-aadc-4704-81cb-831d02f3da79	The Bowen Technique	f	La técnica de Bowen
efe676f1-02c5-420b-a437-7bb3d37370ce	The Metamorphic Technique	f	Técnica metamórfica
f9baaa24-f0b8-4b85-a350-7c6dfebb5d77	Traditional Chinese Medicine	f	Medicina tradicional china
edde4860-929c-4af1-aa49-a7d887d241a1	Tuina	f	Tuina
6ca77c58-b81b-4a71-a153-9ed0f0dabafe	Vibrational Therapy	f	Terapia vibracional
2cdffc28-351d-4a54-814e-214353772026	Whole-Body Vibration Therapy	f	Terapia de vibración de cuerpo entero
fe97da9d-aa94-4464-a313-044ed4d94f3c	Yoga	f	Yoga 
21d7d725-7944-41ed-ae45-1ca54abcf283	Zero Balancing	f	Equilibrio cero
28c0d9c7-bf3c-483b-a884-df71040cf19d	Eden Energy Medicine	f	
71c7b991-0a2d-45b9-99cd-0c6d9c7a8064	EE System (Energy Enhancement System)	f	
c7ee145b-341e-4bab-81cf-7f0f7a246cb5	Halotherapy	f	
4674fd8d-72c6-4066-8b65-1a92ce304273	Holoenergetic Healing	f	
8a62bb18-c8ba-4a23-8e3f-d00a80dd1b83	Holotropic Breathwork	f	
0a8e80e5-1025-42a5-87e1-36e6146ea343	Hakomi	f	
eac3e9f6-bd3a-440d-a4b3-a6c3a63c45a3	Hakomi	t	
13fcf549-49f9-4206-b58b-de59fb4f43c5	Matrix Energetics	f	
1f4e9462-17b3-4199-b434-c13d8a6bd0cb	Nutri-Energetics System (NES)	f	
e9d4ca47-9313-4d13-afd7-2df8c93e5142	Quantum Shiatsu	f	
05b5a41f-d53a-4969-b627-3602de053bb3	NLP (Neuro-Linguistic Programming)	f	
\.


--
-- TOC entry 3564 (class 0 OID 24639)
-- Dependencies: 222
-- Data for Name: nhc_user; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.nhc_user (clerk_id, membership_level, age_group, gender, place_of_residence, full_name, username, business_name, stripe_customer_id, subscribed_until, website_url, country, company_information, address, photo, email_address, address_1, postcode, created_at, practice_email_address, services, link, deleted_by) FROM stdin;
user_2eEFfRxWdyrdXmELZTndFkY0hIm	personal	18-30	male	Darlington	Louis Hartley	louisi9	\N	cus_PoEdmiAddYCLUk	\N	\N	UnitedKingdom	\N	\N	\N	louis@dashmedia.co.uk	\N	\N	2024-06-11 08:29:53.411192	\N	\N	\N	\N
user_2gVfQM9cF1GsVebtBRlwZpmm6I2	professional	41-50	female	London	Ale Riera		Natural Health	cus_Q6yLNOdLefjhGD	2024-06-16 16:10:00	https://www.naturalhealth.com/	UnitedKingdom	<p>I am a qualified nutritionist and have been practicing for 20 years. I also do tapping therapy to compliment the nutrition. I offer in office, video calls and voice call appointments.</p>	\N	user_2gVfQM9cF1GsVebtBRlwZpmm6I2/profile-photo-1715790291214	alegriera58@gmail.com	\N	\N	2024-06-11 08:29:53.411192	\N	\N	\N	\N
user_2farHnmhd3GYqjDfAoXywTadgYQ	business	\N	\N	Darlington	Louis Hartley	lhartley	Dash Media LTD	cus_QWoivUflCndslZ	2025-02-18 10:19:24	https://dashmedia.co.uk/	UnitedKingdom	<p>This is some content</p>	\N	user_2farHnmhd3GYqjDfAoXywTadgYQ/profile-photo-1721750181134	lhartley777@gmail.com	1 Barkers Haugh	DH1 5TE	2024-07-23 15:56:23.456773	lhartley777@gmail.com	We provide websites.	[{"label":"Contact Us","link":"https://dashmedia.co.uk/contact/"}]	\N
user_2sZjQd7MEkoaLKlBU2am4HE9X2S	personal	18-30	male	Darlington	null null	louisi9999	\N	\N	\N	\N	UnitedKingdom	\N	\N	\N	louis@louishartley.com	\N	\N	2025-02-04 11:57:48.543843	\N	\N	\N	\N
user_2hsIvbZXY5GicIBc9tIr4O2SYlP	business	\N	\N	Brighton	NHC null		NHC	cus_QJJ446x6LNAYMx	2024-07-18 14:23:07	https://www.naturalhealingcommune.com/	UnitedKingdom	\N	\N	user_2hsIvbZXY5GicIBc9tIr4O2SYlP/profile-photo-1718634184669	aleguibert@btinternet.com	1 High St	BN1 	2024-06-17 14:23:05.268436	aleguibert@btinternet.com	\N	\N	\N
user_2saDE9oZAjHgmENRgFUPG2hVN7v	personal	18-30	male	Darlington	null null	harrisonwalker	\N	\N	\N	\N	UnitedKingdom	\N	\N	\N	harrison@dashmedia.co.uk	\N	\N	2025-02-04 15:58:20.175002	\N	\N	\N	\N
user_2i0YUJmUCVdti46BzCpsojU2o3k	personal	51-60	female	Hove	null null	hab15	\N	\N	\N	\N	UnitedKingdom	\N	\N	\N	hazelbonner@yahoo.com	\N	\N	2024-06-17 13:00:06.283617	\N	\N	\N	\N
user_346Cocd3nMMOYxxldRvQBqBL9Ze	personal	31-40	female	DL1 4RL	null null	cdtest	\N	\N	\N	\N	UnitedKingdom	\N	\N	\N	cheryl@dashmedia.co.uk	\N	\N	2025-10-15 10:40:20.279157	\N	\N	\N	\N
user_2rtJna94DM6TeBR6HCTocRLnucu	personal	61-70	female	Brighton	null null	alex	\N	\N	\N	\N	UnitedKingdom	\N	\N	\N	a.guibert@yahoo.com	\N	\N	2025-01-20 11:31:55.199693	\N	\N	\N	\N
user_34EipLUzmye3vVDhkN9mBiUwYbF	professional	\N	\N	Hove	Martina null		Martina	cus_TG45bsyyPR2k0V	2025-11-19 11:05:22	https://www.martinasmassage.co.uk/	UnitedKingdom	\N	\N	user_34EipLUzmye3vVDhkN9mBiUwYbF/profile-photo-1760785519559	martina@martinasmassage.co.uk			2025-10-18 11:05:20.207985	martina@martinasmassage.co.uk	\N	\N	\N
user_34jRfRPxab2hR9GYJbOr6HImQQN	personal	51-60	male	Haywards Heath	null null	daddyjohn	\N	\N	\N	\N	UnitedKingdom	\N	\N	\N	johnspaul63@gmail.com	\N	\N	2025-10-29 08:05:22.028605	\N	\N	\N	\N
user_34jSnE07nFP1zywInBfZsYIK2fa	professional	\N	\N	Ardingly	Tim the Osteopath		Tim the Osteopath	cus_TK8pTALvZqu7bu	\N	https://johnpaulweb.dev/	UnitedKingdom	\N	\N	user_34jSnE07nFP1zywInBfZsYIK2fa/profile-photo-1761725759074	johnpaulwebdev@gmail.com	Monks Meadow	RH17 6DZ	2025-10-29 08:15:59.653131	johnpaulwebdev@gmail.com	\N	\N	\N
user_34z4x8DfWl0CGRpY3NfJnLmEvdg	business	\N	\N	Haywards Heath	We Help You		We help you	cus_TMDEMsyfOanrnf	\N	https://webandprosper.co.uk/	UnitedKingdom	\N	\N	user_34z4x8DfWl0CGRpY3NfJnLmEvdg/profile-photo-1762203397778	jwebandprospertest@gmail.com	9 Monks Meadow	RH17 6DZ	2025-11-03 20:56:38.234997	jwebandprospertest@gmail.com	\N	\N	\N
\.


--
-- TOC entry 3568 (class 0 OID 131072)
-- Dependencies: 226
-- Data for Name: nhc_user_accreditation; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.nhc_user_accreditation (id, name, certificate, other_info, "user") FROM stdin;
\.


--
-- TOC entry 3570 (class 0 OID 270336)
-- Dependencies: 228
-- Data for Name: nhc_user_dependant; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.nhc_user_dependant (id, user_id, name) FROM stdin;
6dfee312-a371-42dc-b7b4-415a07cdb03d	user_2eEFfRxWdyrdXmELZTndFkY0hIm	Jess
85e0bb99-79c7-444e-8d30-68f3f1d7e0e9	user_2i0YUJmUCVdti46BzCpsojU2o3k	Leo
3ec828aa-9b1d-41ae-91a6-5bca59c79fc4	user_2i0YUJmUCVdti46BzCpsojU2o3k	Luna
579e05d1-6ab2-403e-b745-a47738d8f44f	user_2eEFfRxWdyrdXmELZTndFkY0hIm	Michael
8d9eeefd-38ea-47bd-b194-ffc5d6e14c33	user_2sZjQd7MEkoaLKlBU2am4HE9X2S	Harry
d85c8f89-8dde-4122-ab36-cdada0320374	user_2rtJna94DM6TeBR6HCTocRLnucu	vic
\.


--
-- TOC entry 3567 (class 0 OID 122880)
-- Dependencies: 225
-- Data for Name: nhc_user_to_treatment; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.nhc_user_to_treatment (user_id, treatment_id) FROM stdin;
user_2farHnmhd3GYqjDfAoXywTadgYQ	0eb451ca-d1ef-4378-8f53-47227ae2b9b4
user_2farHnmhd3GYqjDfAoXywTadgYQ	83c164ce-c27b-4e70-a073-fe9c60286f1b
user_2gVfQM9cF1GsVebtBRlwZpmm6I2	c2241408-ec8f-46c6-9095-77cd5f8d53d1
user_2gVfQM9cF1GsVebtBRlwZpmm6I2	41420527-8235-4dc8-ae29-8bc5996cfb5e
user_2gVfQM9cF1GsVebtBRlwZpmm6I2	c2241408-ec8f-46c6-9095-77cd5f8d53d1
user_2gVfQM9cF1GsVebtBRlwZpmm6I2	41420527-8235-4dc8-ae29-8bc5996cfb5e
user_2gVfQM9cF1GsVebtBRlwZpmm6I2	c2241408-ec8f-46c6-9095-77cd5f8d53d1
user_2gVfQM9cF1GsVebtBRlwZpmm6I2	41420527-8235-4dc8-ae29-8bc5996cfb5e
\.


--
-- TOC entry 3572 (class 0 OID 335872)
-- Dependencies: 230
-- Data for Name: nhc_webhook_event; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.nhc_webhook_event (id, source, data) FROM stdin;
1e99729f-c465-4f1f-a638-a5a3872852a3	clerk	{"evt": {"data": {"id": "ema_2rJC1bPDq7m4mFQFQR79z8YDkm8", "body": "<!DOCTYPE html PUBLIC \\"-//W3C//DTD XHTML 1.0 Strict//EN\\" \\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\\">\\n<html xmlns=\\"http://www.w3.org/1999/xhtml\\">\\n\\n    <head>\\n        <meta http-equiv=\\"Content-Type\\" content=\\"text/html; charset=utf-8\\">\\n        <meta name=\\"viewport\\" content=\\"width=device-width, initial-scale=1.0\\">\\n        <title>253503 is your Natural Healing Commune verification code</title>\\n        <style type=\\"text/css\\">\\n            #outlook a {\\n                padding: 0\\n            }\\n\\n            .ExternalClass {\\n                width: 100%\\n            }\\n\\n            .ExternalClass,\\n            .ExternalClass p,\\n            .ExternalClass span,\\n            .ExternalClass font,\\n            .ExternalClass td,\\n            .ExternalClass div {\\n                line-height: 100%\\n            }\\n\\n            body,\\n            table,\\n            td,\\n            a {\\n                -webkit-text-size-adjust: 100%;\\n                -ms-text-size-adjust: 100%\\n            }\\n\\n            table,\\n            td {\\n                mso-table-lspace: 0;\\n                mso-table-rspace: 0\\n            }\\n\\n            img {\\n                -ms-interpolation-mode: bicubic\\n            }\\n\\n            img {\\n                border: 0;\\n                outline: none;\\n                text-decoration: none\\n            }\\n\\n            a img {\\n                border: none\\n            }\\n\\n            td img {\\n                vertical-align: top\\n            }\\n\\n            table,\\n            table td {\\n                border-collapse: collapse\\n            }\\n\\n            body {\\n                margin: 0;\\n                padding: 0;\\n                width: 100% !important\\n            }\\n\\n            .mobile-spacer {\\n                width: 0;\\n                display: none\\n            }\\n\\n            @media all and (max-width:639px) {\\n                .container {\\n                    width: 100% !important;\\n                    max-width: 600px !important\\n                }\\n\\n                .mobile {\\n                    width: auto !important;\\n                    max-width: 100% !important;\\n                    display: block !important\\n                }\\n\\n                .mobile-center {\\n                    text-align: center !important\\n                }\\n\\n                .mobile-right {\\n                    text-align: right !important\\n                }\\n\\n                .mobile-left {\\n                    text-align: left !important;\\n                }\\n\\n                .mobile-hidden {\\n                    max-height: 0;\\n                    display: none !important;\\n                    mso-hide: all;\\n                    overflow: hidden\\n                }\\n\\n                .mobile-spacer {\\n                    width: auto !important;\\n                    display: table !important\\n                }\\n\\n                .mobile-image,\\n                .mobile-image img {\\n                    height: auto !important;\\n                    max-width: 600px !important;\\n                    width: 100% !important\\n                }\\n            }\\n        </style>\\n        <!--[if mso]><style type=\\"text/css\\">body, table, td, a { font-family: Arial, Helvetica, sans-serif !important; }</style><![endif]-->\\n    </head>\\n\\n    <body style=\\"font-family: Helvetica, Arial, sans-serif; margin: 0px; padding: 0px; background-color: #ffffff;\\">\\n        <span style=\\"color: transparent; display: none; height: 0px; max-height: 0px; max-width: 0px; opacity: 0; overflow: hidden; visibility: hidden; width: 0px;\\">Your Natural Healing Commune verification code</span>\\n        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"body\\" style=\\"width: 100%;\\">\\n            <tbody>\\n                <tr>\\n                    <td align=\\"center\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 48px 32px;\\">\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"header container\\" style=\\"width: 600px;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 16px 32px;\\">\\n                                        <p style=\\"padding: 0px; margin: 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 24px; line-height: 36px;\\">\\n                                            Natural Healing Commune\\n                                        </p>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"main container\\" style=\\"width: 600px; border-collapse: separate;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#fff\\" style=\\"vertical-align: top; line-height: 1; background-color: #ffffff; border-radius: 0px;\\">\\n                                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"block\\" style=\\"width: 100%; border-collapse: separate;\\">\\n                                            <tbody>\\n                                                <tr>\\n                                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#ffffff\\" style=\\"vertical-align: top; line-height: 1; padding: 32px 32px 48px; background-color: #ffffff; border-radius: 0px;\\">\\n                                                        <h1 class=\\"h1\\" align=\\"left\\" style=\\"padding: 0px; margin: 0px; font-style: normal; font-family: Helvetica, Arial, sans-serif; font-size: 32px; line-height: 39px; color: #000000; font-weight: bold;\\"> Verification code </h1>\\n                                                        <p align=\\"left\\" style=\\"padding: 0px; margin: 32px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> Enter the following verification code when prompted: </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 40px; line-height: 60px;\\">\\n                                                            <b>253503</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> To protect your account, do not share this code. </p>\\n                                                        <p style=\\"padding: 0px; margin: 64px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\">\\n                                                            <b>Didn't request this?</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 4px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> This code was requested from <b>169.150.196.37, Amsterdam, NL</b> at <b>07 January 2025, 16:32 UTC</b>. If you didn't make this request, you can safely ignore this email. </p>\\n                                                    </td>\\n                                                </tr>\\n                                            </tbody>\\n                                        </table>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                    </td>\\n                </tr>\\n            </tbody>\\n        </table>\\n    </body>\\n\\n</html>", "data": {"app": {"url": "https://settling-monarch-25.accounts.dev", "name": "Natural Healing Commune", "logo_url": null, "domain_name": "settling.monarch-25.lcl.dev", "logo_image_url": ""}, "user": {"public_metadata": null, "public_metadata_fallback": ""}, "theme": {"primary_color": "#6c47ff", "button_text_color": "#ffffff", "show_clerk_branding": true}, "otp_code": "253503", "requested_at": "07 January 2025, 16:32 UTC", "requested_by": "Chrome, Windows", "requested_from": "169.150.196.37, Amsterdam, NL"}, "slug": "verification_code", "object": "email", "status": "queued", "subject": "[Development] 253503 is your verification code", "user_id": null, "body_plain": "253503 is your OTP code for Natural Healing Commune.\\n\\nDo not share this with anyone.\\n\\nIt was requested at 07 January 2025, 16:32 UTC. If you did not request this, please ignore this email.\\n", "from_email_name": "notifications", "email_address_id": "idn_2rJC1eA0rGU0u1yRZPDu0d0WS1V", "to_email_address": "test3@example.com", "delivered_by_clerk": true, "reply_to_email_name": null}, "type": "email.created", "object": "event", "timestamp": 1736267576626, "event_attributes": {"http_request": {"client_ip": "169.150.196.37", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36"}}}, "svix_headers": {"svix-id": "msg_2rJC1fibq8Z7vTGdLyao71D7MS4", "svix-signature": "v1,MqnZKX7vBF4ATaCD2GcKozwHgGKhGB3nfqcrPHj84pU=", "svix-timestamp": "1736267576"}}
6dd1c901-74ce-478a-a096-21ab1088d30a	clerk	{"evt": {"data": {"id": "ema_2rJC1bPDq7m4mFQFQR79z8YDkm8", "body": "<!DOCTYPE html PUBLIC \\"-//W3C//DTD XHTML 1.0 Strict//EN\\" \\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\\">\\n<html xmlns=\\"http://www.w3.org/1999/xhtml\\">\\n\\n    <head>\\n        <meta http-equiv=\\"Content-Type\\" content=\\"text/html; charset=utf-8\\">\\n        <meta name=\\"viewport\\" content=\\"width=device-width, initial-scale=1.0\\">\\n        <title>253503 is your Natural Healing Commune verification code</title>\\n        <style type=\\"text/css\\">\\n            #outlook a {\\n                padding: 0\\n            }\\n\\n            .ExternalClass {\\n                width: 100%\\n            }\\n\\n            .ExternalClass,\\n            .ExternalClass p,\\n            .ExternalClass span,\\n            .ExternalClass font,\\n            .ExternalClass td,\\n            .ExternalClass div {\\n                line-height: 100%\\n            }\\n\\n            body,\\n            table,\\n            td,\\n            a {\\n                -webkit-text-size-adjust: 100%;\\n                -ms-text-size-adjust: 100%\\n            }\\n\\n            table,\\n            td {\\n                mso-table-lspace: 0;\\n                mso-table-rspace: 0\\n            }\\n\\n            img {\\n                -ms-interpolation-mode: bicubic\\n            }\\n\\n            img {\\n                border: 0;\\n                outline: none;\\n                text-decoration: none\\n            }\\n\\n            a img {\\n                border: none\\n            }\\n\\n            td img {\\n                vertical-align: top\\n            }\\n\\n            table,\\n            table td {\\n                border-collapse: collapse\\n            }\\n\\n            body {\\n                margin: 0;\\n                padding: 0;\\n                width: 100% !important\\n            }\\n\\n            .mobile-spacer {\\n                width: 0;\\n                display: none\\n            }\\n\\n            @media all and (max-width:639px) {\\n                .container {\\n                    width: 100% !important;\\n                    max-width: 600px !important\\n                }\\n\\n                .mobile {\\n                    width: auto !important;\\n                    max-width: 100% !important;\\n                    display: block !important\\n                }\\n\\n                .mobile-center {\\n                    text-align: center !important\\n                }\\n\\n                .mobile-right {\\n                    text-align: right !important\\n                }\\n\\n                .mobile-left {\\n                    text-align: left !important;\\n                }\\n\\n                .mobile-hidden {\\n                    max-height: 0;\\n                    display: none !important;\\n                    mso-hide: all;\\n                    overflow: hidden\\n                }\\n\\n                .mobile-spacer {\\n                    width: auto !important;\\n                    display: table !important\\n                }\\n\\n                .mobile-image,\\n                .mobile-image img {\\n                    height: auto !important;\\n                    max-width: 600px !important;\\n                    width: 100% !important\\n                }\\n            }\\n        </style>\\n        <!--[if mso]><style type=\\"text/css\\">body, table, td, a { font-family: Arial, Helvetica, sans-serif !important; }</style><![endif]-->\\n    </head>\\n\\n    <body style=\\"font-family: Helvetica, Arial, sans-serif; margin: 0px; padding: 0px; background-color: #ffffff;\\">\\n        <span style=\\"color: transparent; display: none; height: 0px; max-height: 0px; max-width: 0px; opacity: 0; overflow: hidden; visibility: hidden; width: 0px;\\">Your Natural Healing Commune verification code</span>\\n        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"body\\" style=\\"width: 100%;\\">\\n            <tbody>\\n                <tr>\\n                    <td align=\\"center\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 48px 32px;\\">\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"header container\\" style=\\"width: 600px;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 16px 32px;\\">\\n                                        <p style=\\"padding: 0px; margin: 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 24px; line-height: 36px;\\">\\n                                            Natural Healing Commune\\n                                        </p>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"main container\\" style=\\"width: 600px; border-collapse: separate;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#fff\\" style=\\"vertical-align: top; line-height: 1; background-color: #ffffff; border-radius: 0px;\\">\\n                                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"block\\" style=\\"width: 100%; border-collapse: separate;\\">\\n                                            <tbody>\\n                                                <tr>\\n                                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#ffffff\\" style=\\"vertical-align: top; line-height: 1; padding: 32px 32px 48px; background-color: #ffffff; border-radius: 0px;\\">\\n                                                        <h1 class=\\"h1\\" align=\\"left\\" style=\\"padding: 0px; margin: 0px; font-style: normal; font-family: Helvetica, Arial, sans-serif; font-size: 32px; line-height: 39px; color: #000000; font-weight: bold;\\"> Verification code </h1>\\n                                                        <p align=\\"left\\" style=\\"padding: 0px; margin: 32px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> Enter the following verification code when prompted: </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 40px; line-height: 60px;\\">\\n                                                            <b>253503</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> To protect your account, do not share this code. </p>\\n                                                        <p style=\\"padding: 0px; margin: 64px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\">\\n                                                            <b>Didn't request this?</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 4px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> This code was requested from <b>169.150.196.37, Amsterdam, NL</b> at <b>07 January 2025, 16:32 UTC</b>. If you didn't make this request, you can safely ignore this email. </p>\\n                                                    </td>\\n                                                </tr>\\n                                            </tbody>\\n                                        </table>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                    </td>\\n                </tr>\\n            </tbody>\\n        </table>\\n    </body>\\n\\n</html>", "data": {"app": {"url": "https://settling-monarch-25.accounts.dev", "name": "Natural Healing Commune", "logo_url": null, "domain_name": "settling.monarch-25.lcl.dev", "logo_image_url": ""}, "user": {"public_metadata": null, "public_metadata_fallback": ""}, "theme": {"primary_color": "#6c47ff", "button_text_color": "#ffffff", "show_clerk_branding": true}, "otp_code": "253503", "requested_at": "07 January 2025, 16:32 UTC", "requested_by": "Chrome, Windows", "requested_from": "169.150.196.37, Amsterdam, NL"}, "slug": "verification_code", "object": "email", "status": "queued", "subject": "[Development] 253503 is your verification code", "user_id": null, "body_plain": "253503 is your OTP code for Natural Healing Commune.\\n\\nDo not share this with anyone.\\n\\nIt was requested at 07 January 2025, 16:32 UTC. If you did not request this, please ignore this email.\\n", "from_email_name": "notifications", "email_address_id": "idn_2rJC1eA0rGU0u1yRZPDu0d0WS1V", "to_email_address": "test3@example.com", "delivered_by_clerk": true, "reply_to_email_name": null}, "type": "email.created", "object": "event", "timestamp": 1736267576626, "event_attributes": {"http_request": {"client_ip": "169.150.196.37", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36"}}}, "svix_headers": {"svix-id": "msg_2rJC1fibq8Z7vTGdLyao71D7MS4", "svix-signature": "v1,3w9fW78gey5H8CZQW7CjgEvAgSIwG1+XUSYwXoNPRj0=", "svix-timestamp": "1736267587"}}
264b3358-029d-4de0-9a2c-853e30d64889	clerk	{"evt": {"data": {"id": "ema_2rJC1bPDq7m4mFQFQR79z8YDkm8", "body": "<!DOCTYPE html PUBLIC \\"-//W3C//DTD XHTML 1.0 Strict//EN\\" \\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\\">\\n<html xmlns=\\"http://www.w3.org/1999/xhtml\\">\\n\\n    <head>\\n        <meta http-equiv=\\"Content-Type\\" content=\\"text/html; charset=utf-8\\">\\n        <meta name=\\"viewport\\" content=\\"width=device-width, initial-scale=1.0\\">\\n        <title>253503 is your Natural Healing Commune verification code</title>\\n        <style type=\\"text/css\\">\\n            #outlook a {\\n                padding: 0\\n            }\\n\\n            .ExternalClass {\\n                width: 100%\\n            }\\n\\n            .ExternalClass,\\n            .ExternalClass p,\\n            .ExternalClass span,\\n            .ExternalClass font,\\n            .ExternalClass td,\\n            .ExternalClass div {\\n                line-height: 100%\\n            }\\n\\n            body,\\n            table,\\n            td,\\n            a {\\n                -webkit-text-size-adjust: 100%;\\n                -ms-text-size-adjust: 100%\\n            }\\n\\n            table,\\n            td {\\n                mso-table-lspace: 0;\\n                mso-table-rspace: 0\\n            }\\n\\n            img {\\n                -ms-interpolation-mode: bicubic\\n            }\\n\\n            img {\\n                border: 0;\\n                outline: none;\\n                text-decoration: none\\n            }\\n\\n            a img {\\n                border: none\\n            }\\n\\n            td img {\\n                vertical-align: top\\n            }\\n\\n            table,\\n            table td {\\n                border-collapse: collapse\\n            }\\n\\n            body {\\n                margin: 0;\\n                padding: 0;\\n                width: 100% !important\\n            }\\n\\n            .mobile-spacer {\\n                width: 0;\\n                display: none\\n            }\\n\\n            @media all and (max-width:639px) {\\n                .container {\\n                    width: 100% !important;\\n                    max-width: 600px !important\\n                }\\n\\n                .mobile {\\n                    width: auto !important;\\n                    max-width: 100% !important;\\n                    display: block !important\\n                }\\n\\n                .mobile-center {\\n                    text-align: center !important\\n                }\\n\\n                .mobile-right {\\n                    text-align: right !important\\n                }\\n\\n                .mobile-left {\\n                    text-align: left !important;\\n                }\\n\\n                .mobile-hidden {\\n                    max-height: 0;\\n                    display: none !important;\\n                    mso-hide: all;\\n                    overflow: hidden\\n                }\\n\\n                .mobile-spacer {\\n                    width: auto !important;\\n                    display: table !important\\n                }\\n\\n                .mobile-image,\\n                .mobile-image img {\\n                    height: auto !important;\\n                    max-width: 600px !important;\\n                    width: 100% !important\\n                }\\n            }\\n        </style>\\n        <!--[if mso]><style type=\\"text/css\\">body, table, td, a { font-family: Arial, Helvetica, sans-serif !important; }</style><![endif]-->\\n    </head>\\n\\n    <body style=\\"font-family: Helvetica, Arial, sans-serif; margin: 0px; padding: 0px; background-color: #ffffff;\\">\\n        <span style=\\"color: transparent; display: none; height: 0px; max-height: 0px; max-width: 0px; opacity: 0; overflow: hidden; visibility: hidden; width: 0px;\\">Your Natural Healing Commune verification code</span>\\n        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"body\\" style=\\"width: 100%;\\">\\n            <tbody>\\n                <tr>\\n                    <td align=\\"center\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 48px 32px;\\">\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"header container\\" style=\\"width: 600px;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 16px 32px;\\">\\n                                        <p style=\\"padding: 0px; margin: 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 24px; line-height: 36px;\\">\\n                                            Natural Healing Commune\\n                                        </p>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"main container\\" style=\\"width: 600px; border-collapse: separate;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#fff\\" style=\\"vertical-align: top; line-height: 1; background-color: #ffffff; border-radius: 0px;\\">\\n                                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"block\\" style=\\"width: 100%; border-collapse: separate;\\">\\n                                            <tbody>\\n                                                <tr>\\n                                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#ffffff\\" style=\\"vertical-align: top; line-height: 1; padding: 32px 32px 48px; background-color: #ffffff; border-radius: 0px;\\">\\n                                                        <h1 class=\\"h1\\" align=\\"left\\" style=\\"padding: 0px; margin: 0px; font-style: normal; font-family: Helvetica, Arial, sans-serif; font-size: 32px; line-height: 39px; color: #000000; font-weight: bold;\\"> Verification code </h1>\\n                                                        <p align=\\"left\\" style=\\"padding: 0px; margin: 32px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> Enter the following verification code when prompted: </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 40px; line-height: 60px;\\">\\n                                                            <b>253503</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> To protect your account, do not share this code. </p>\\n                                                        <p style=\\"padding: 0px; margin: 64px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\">\\n                                                            <b>Didn't request this?</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 4px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> This code was requested from <b>169.150.196.37, Amsterdam, NL</b> at <b>07 January 2025, 16:32 UTC</b>. If you didn't make this request, you can safely ignore this email. </p>\\n                                                    </td>\\n                                                </tr>\\n                                            </tbody>\\n                                        </table>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                    </td>\\n                </tr>\\n            </tbody>\\n        </table>\\n    </body>\\n\\n</html>", "data": {"app": {"url": "https://settling-monarch-25.accounts.dev", "name": "Natural Healing Commune", "logo_url": null, "domain_name": "settling.monarch-25.lcl.dev", "logo_image_url": ""}, "user": {"public_metadata": null, "public_metadata_fallback": ""}, "theme": {"primary_color": "#6c47ff", "button_text_color": "#ffffff", "show_clerk_branding": true}, "otp_code": "253503", "requested_at": "07 January 2025, 16:32 UTC", "requested_by": "Chrome, Windows", "requested_from": "169.150.196.37, Amsterdam, NL"}, "slug": "verification_code", "object": "email", "status": "queued", "subject": "[Development] 253503 is your verification code", "user_id": null, "body_plain": "253503 is your OTP code for Natural Healing Commune.\\n\\nDo not share this with anyone.\\n\\nIt was requested at 07 January 2025, 16:32 UTC. If you did not request this, please ignore this email.\\n", "from_email_name": "notifications", "email_address_id": "idn_2rJC1eA0rGU0u1yRZPDu0d0WS1V", "to_email_address": "test3@example.com", "delivered_by_clerk": true, "reply_to_email_name": null}, "type": "email.created", "object": "event", "timestamp": 1736267576626, "event_attributes": {"http_request": {"client_ip": "169.150.196.37", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36"}}}, "svix_headers": {"svix-id": "msg_2rJC1fibq8Z7vTGdLyao71D7MS4", "svix-signature": "v1,iXuXnz3C1RifrkPVaLPjDzx/KqPRkRIEkzZ4rfnKn5U=", "svix-timestamp": "1736267760"}}
0d59e006-c3d4-4109-b463-e8f3d67cad02	clerk	{"evt": {"data": {"id": "ema_2rJC1bPDq7m4mFQFQR79z8YDkm8", "body": "<!DOCTYPE html PUBLIC \\"-//W3C//DTD XHTML 1.0 Strict//EN\\" \\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\\">\\n<html xmlns=\\"http://www.w3.org/1999/xhtml\\">\\n\\n    <head>\\n        <meta http-equiv=\\"Content-Type\\" content=\\"text/html; charset=utf-8\\">\\n        <meta name=\\"viewport\\" content=\\"width=device-width, initial-scale=1.0\\">\\n        <title>253503 is your Natural Healing Commune verification code</title>\\n        <style type=\\"text/css\\">\\n            #outlook a {\\n                padding: 0\\n            }\\n\\n            .ExternalClass {\\n                width: 100%\\n            }\\n\\n            .ExternalClass,\\n            .ExternalClass p,\\n            .ExternalClass span,\\n            .ExternalClass font,\\n            .ExternalClass td,\\n            .ExternalClass div {\\n                line-height: 100%\\n            }\\n\\n            body,\\n            table,\\n            td,\\n            a {\\n                -webkit-text-size-adjust: 100%;\\n                -ms-text-size-adjust: 100%\\n            }\\n\\n            table,\\n            td {\\n                mso-table-lspace: 0;\\n                mso-table-rspace: 0\\n            }\\n\\n            img {\\n                -ms-interpolation-mode: bicubic\\n            }\\n\\n            img {\\n                border: 0;\\n                outline: none;\\n                text-decoration: none\\n            }\\n\\n            a img {\\n                border: none\\n            }\\n\\n            td img {\\n                vertical-align: top\\n            }\\n\\n            table,\\n            table td {\\n                border-collapse: collapse\\n            }\\n\\n            body {\\n                margin: 0;\\n                padding: 0;\\n                width: 100% !important\\n            }\\n\\n            .mobile-spacer {\\n                width: 0;\\n                display: none\\n            }\\n\\n            @media all and (max-width:639px) {\\n                .container {\\n                    width: 100% !important;\\n                    max-width: 600px !important\\n                }\\n\\n                .mobile {\\n                    width: auto !important;\\n                    max-width: 100% !important;\\n                    display: block !important\\n                }\\n\\n                .mobile-center {\\n                    text-align: center !important\\n                }\\n\\n                .mobile-right {\\n                    text-align: right !important\\n                }\\n\\n                .mobile-left {\\n                    text-align: left !important;\\n                }\\n\\n                .mobile-hidden {\\n                    max-height: 0;\\n                    display: none !important;\\n                    mso-hide: all;\\n                    overflow: hidden\\n                }\\n\\n                .mobile-spacer {\\n                    width: auto !important;\\n                    display: table !important\\n                }\\n\\n                .mobile-image,\\n                .mobile-image img {\\n                    height: auto !important;\\n                    max-width: 600px !important;\\n                    width: 100% !important\\n                }\\n            }\\n        </style>\\n        <!--[if mso]><style type=\\"text/css\\">body, table, td, a { font-family: Arial, Helvetica, sans-serif !important; }</style><![endif]-->\\n    </head>\\n\\n    <body style=\\"font-family: Helvetica, Arial, sans-serif; margin: 0px; padding: 0px; background-color: #ffffff;\\">\\n        <span style=\\"color: transparent; display: none; height: 0px; max-height: 0px; max-width: 0px; opacity: 0; overflow: hidden; visibility: hidden; width: 0px;\\">Your Natural Healing Commune verification code</span>\\n        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"body\\" style=\\"width: 100%;\\">\\n            <tbody>\\n                <tr>\\n                    <td align=\\"center\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 48px 32px;\\">\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"header container\\" style=\\"width: 600px;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 16px 32px;\\">\\n                                        <p style=\\"padding: 0px; margin: 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 24px; line-height: 36px;\\">\\n                                            Natural Healing Commune\\n                                        </p>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"main container\\" style=\\"width: 600px; border-collapse: separate;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#fff\\" style=\\"vertical-align: top; line-height: 1; background-color: #ffffff; border-radius: 0px;\\">\\n                                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"block\\" style=\\"width: 100%; border-collapse: separate;\\">\\n                                            <tbody>\\n                                                <tr>\\n                                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#ffffff\\" style=\\"vertical-align: top; line-height: 1; padding: 32px 32px 48px; background-color: #ffffff; border-radius: 0px;\\">\\n                                                        <h1 class=\\"h1\\" align=\\"left\\" style=\\"padding: 0px; margin: 0px; font-style: normal; font-family: Helvetica, Arial, sans-serif; font-size: 32px; line-height: 39px; color: #000000; font-weight: bold;\\"> Verification code </h1>\\n                                                        <p align=\\"left\\" style=\\"padding: 0px; margin: 32px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> Enter the following verification code when prompted: </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 40px; line-height: 60px;\\">\\n                                                            <b>253503</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> To protect your account, do not share this code. </p>\\n                                                        <p style=\\"padding: 0px; margin: 64px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\">\\n                                                            <b>Didn't request this?</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 4px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> This code was requested from <b>169.150.196.37, Amsterdam, NL</b> at <b>07 January 2025, 16:32 UTC</b>. If you didn't make this request, you can safely ignore this email. </p>\\n                                                    </td>\\n                                                </tr>\\n                                            </tbody>\\n                                        </table>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                    </td>\\n                </tr>\\n            </tbody>\\n        </table>\\n    </body>\\n\\n</html>", "data": {"app": {"url": "https://settling-monarch-25.accounts.dev", "name": "Natural Healing Commune", "logo_url": null, "domain_name": "settling.monarch-25.lcl.dev", "logo_image_url": ""}, "user": {"public_metadata": null, "public_metadata_fallback": ""}, "theme": {"primary_color": "#6c47ff", "button_text_color": "#ffffff", "show_clerk_branding": true}, "otp_code": "253503", "requested_at": "07 January 2025, 16:32 UTC", "requested_by": "Chrome, Windows", "requested_from": "169.150.196.37, Amsterdam, NL"}, "slug": "verification_code", "object": "email", "status": "queued", "subject": "[Development] 253503 is your verification code", "user_id": null, "body_plain": "253503 is your OTP code for Natural Healing Commune.\\n\\nDo not share this with anyone.\\n\\nIt was requested at 07 January 2025, 16:32 UTC. If you did not request this, please ignore this email.\\n", "from_email_name": "notifications", "email_address_id": "idn_2rJC1eA0rGU0u1yRZPDu0d0WS1V", "to_email_address": "test3@example.com", "delivered_by_clerk": true, "reply_to_email_name": null}, "type": "email.created", "object": "event", "timestamp": 1736267576626, "event_attributes": {"http_request": {"client_ip": "169.150.196.37", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36"}}}, "svix_headers": {"svix-id": "msg_2rJC1fibq8Z7vTGdLyao71D7MS4", "svix-signature": "v1,umQy/pIP2Ef4DKUjOpCz5Na/cOxtZ7AdnnhSuXhe7i4=", "svix-timestamp": "1736267836"}}
3b977271-d45d-47c4-a11c-f06f6f98bec1	clerk	{"evt": {"data": {"id": "ema_2rJC1bPDq7m4mFQFQR79z8YDkm8", "body": "<!DOCTYPE html PUBLIC \\"-//W3C//DTD XHTML 1.0 Strict//EN\\" \\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\\">\\n<html xmlns=\\"http://www.w3.org/1999/xhtml\\">\\n\\n    <head>\\n        <meta http-equiv=\\"Content-Type\\" content=\\"text/html; charset=utf-8\\">\\n        <meta name=\\"viewport\\" content=\\"width=device-width, initial-scale=1.0\\">\\n        <title>253503 is your Natural Healing Commune verification code</title>\\n        <style type=\\"text/css\\">\\n            #outlook a {\\n                padding: 0\\n            }\\n\\n            .ExternalClass {\\n                width: 100%\\n            }\\n\\n            .ExternalClass,\\n            .ExternalClass p,\\n            .ExternalClass span,\\n            .ExternalClass font,\\n            .ExternalClass td,\\n            .ExternalClass div {\\n                line-height: 100%\\n            }\\n\\n            body,\\n            table,\\n            td,\\n            a {\\n                -webkit-text-size-adjust: 100%;\\n                -ms-text-size-adjust: 100%\\n            }\\n\\n            table,\\n            td {\\n                mso-table-lspace: 0;\\n                mso-table-rspace: 0\\n            }\\n\\n            img {\\n                -ms-interpolation-mode: bicubic\\n            }\\n\\n            img {\\n                border: 0;\\n                outline: none;\\n                text-decoration: none\\n            }\\n\\n            a img {\\n                border: none\\n            }\\n\\n            td img {\\n                vertical-align: top\\n            }\\n\\n            table,\\n            table td {\\n                border-collapse: collapse\\n            }\\n\\n            body {\\n                margin: 0;\\n                padding: 0;\\n                width: 100% !important\\n            }\\n\\n            .mobile-spacer {\\n                width: 0;\\n                display: none\\n            }\\n\\n            @media all and (max-width:639px) {\\n                .container {\\n                    width: 100% !important;\\n                    max-width: 600px !important\\n                }\\n\\n                .mobile {\\n                    width: auto !important;\\n                    max-width: 100% !important;\\n                    display: block !important\\n                }\\n\\n                .mobile-center {\\n                    text-align: center !important\\n                }\\n\\n                .mobile-right {\\n                    text-align: right !important\\n                }\\n\\n                .mobile-left {\\n                    text-align: left !important;\\n                }\\n\\n                .mobile-hidden {\\n                    max-height: 0;\\n                    display: none !important;\\n                    mso-hide: all;\\n                    overflow: hidden\\n                }\\n\\n                .mobile-spacer {\\n                    width: auto !important;\\n                    display: table !important\\n                }\\n\\n                .mobile-image,\\n                .mobile-image img {\\n                    height: auto !important;\\n                    max-width: 600px !important;\\n                    width: 100% !important\\n                }\\n            }\\n        </style>\\n        <!--[if mso]><style type=\\"text/css\\">body, table, td, a { font-family: Arial, Helvetica, sans-serif !important; }</style><![endif]-->\\n    </head>\\n\\n    <body style=\\"font-family: Helvetica, Arial, sans-serif; margin: 0px; padding: 0px; background-color: #ffffff;\\">\\n        <span style=\\"color: transparent; display: none; height: 0px; max-height: 0px; max-width: 0px; opacity: 0; overflow: hidden; visibility: hidden; width: 0px;\\">Your Natural Healing Commune verification code</span>\\n        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"body\\" style=\\"width: 100%;\\">\\n            <tbody>\\n                <tr>\\n                    <td align=\\"center\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 48px 32px;\\">\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"header container\\" style=\\"width: 600px;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 16px 32px;\\">\\n                                        <p style=\\"padding: 0px; margin: 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 24px; line-height: 36px;\\">\\n                                            Natural Healing Commune\\n                                        </p>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"main container\\" style=\\"width: 600px; border-collapse: separate;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#fff\\" style=\\"vertical-align: top; line-height: 1; background-color: #ffffff; border-radius: 0px;\\">\\n                                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"block\\" style=\\"width: 100%; border-collapse: separate;\\">\\n                                            <tbody>\\n                                                <tr>\\n                                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#ffffff\\" style=\\"vertical-align: top; line-height: 1; padding: 32px 32px 48px; background-color: #ffffff; border-radius: 0px;\\">\\n                                                        <h1 class=\\"h1\\" align=\\"left\\" style=\\"padding: 0px; margin: 0px; font-style: normal; font-family: Helvetica, Arial, sans-serif; font-size: 32px; line-height: 39px; color: #000000; font-weight: bold;\\"> Verification code </h1>\\n                                                        <p align=\\"left\\" style=\\"padding: 0px; margin: 32px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> Enter the following verification code when prompted: </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 40px; line-height: 60px;\\">\\n                                                            <b>253503</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> To protect your account, do not share this code. </p>\\n                                                        <p style=\\"padding: 0px; margin: 64px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\">\\n                                                            <b>Didn't request this?</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 4px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> This code was requested from <b>169.150.196.37, Amsterdam, NL</b> at <b>07 January 2025, 16:32 UTC</b>. If you didn't make this request, you can safely ignore this email. </p>\\n                                                    </td>\\n                                                </tr>\\n                                            </tbody>\\n                                        </table>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                    </td>\\n                </tr>\\n            </tbody>\\n        </table>\\n    </body>\\n\\n</html>", "data": {"app": {"url": "https://settling-monarch-25.accounts.dev", "name": "Natural Healing Commune", "logo_url": null, "domain_name": "settling.monarch-25.lcl.dev", "logo_image_url": ""}, "user": {"public_metadata": null, "public_metadata_fallback": ""}, "theme": {"primary_color": "#6c47ff", "button_text_color": "#ffffff", "show_clerk_branding": true}, "otp_code": "253503", "requested_at": "07 January 2025, 16:32 UTC", "requested_by": "Chrome, Windows", "requested_from": "169.150.196.37, Amsterdam, NL"}, "slug": "verification_code", "object": "email", "status": "queued", "subject": "[Development] 253503 is your verification code", "user_id": null, "body_plain": "253503 is your OTP code for Natural Healing Commune.\\n\\nDo not share this with anyone.\\n\\nIt was requested at 07 January 2025, 16:32 UTC. If you did not request this, please ignore this email.\\n", "from_email_name": "notifications", "email_address_id": "idn_2rJC1eA0rGU0u1yRZPDu0d0WS1V", "to_email_address": "test3@example.com", "delivered_by_clerk": true, "reply_to_email_name": null}, "type": "email.created", "object": "event", "timestamp": 1736267576626, "event_attributes": {"http_request": {"client_ip": "169.150.196.37", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36"}}}, "svix_headers": {"svix-id": "msg_2rJC1fibq8Z7vTGdLyao71D7MS4", "svix-signature": "v1,BQc5WIXYgmVcZf35bdK7eWNpFF4kQRbYKA+XO2YcVBw=", "svix-timestamp": "1736267927"}}
d4b5a563-497c-4467-9722-6081246fd674	clerk	{"evt": {"data": {"id": "ema_2rJC1bPDq7m4mFQFQR79z8YDkm8", "body": "<!DOCTYPE html PUBLIC \\"-//W3C//DTD XHTML 1.0 Strict//EN\\" \\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\\">\\n<html xmlns=\\"http://www.w3.org/1999/xhtml\\">\\n\\n    <head>\\n        <meta http-equiv=\\"Content-Type\\" content=\\"text/html; charset=utf-8\\">\\n        <meta name=\\"viewport\\" content=\\"width=device-width, initial-scale=1.0\\">\\n        <title>253503 is your Natural Healing Commune verification code</title>\\n        <style type=\\"text/css\\">\\n            #outlook a {\\n                padding: 0\\n            }\\n\\n            .ExternalClass {\\n                width: 100%\\n            }\\n\\n            .ExternalClass,\\n            .ExternalClass p,\\n            .ExternalClass span,\\n            .ExternalClass font,\\n            .ExternalClass td,\\n            .ExternalClass div {\\n                line-height: 100%\\n            }\\n\\n            body,\\n            table,\\n            td,\\n            a {\\n                -webkit-text-size-adjust: 100%;\\n                -ms-text-size-adjust: 100%\\n            }\\n\\n            table,\\n            td {\\n                mso-table-lspace: 0;\\n                mso-table-rspace: 0\\n            }\\n\\n            img {\\n                -ms-interpolation-mode: bicubic\\n            }\\n\\n            img {\\n                border: 0;\\n                outline: none;\\n                text-decoration: none\\n            }\\n\\n            a img {\\n                border: none\\n            }\\n\\n            td img {\\n                vertical-align: top\\n            }\\n\\n            table,\\n            table td {\\n                border-collapse: collapse\\n            }\\n\\n            body {\\n                margin: 0;\\n                padding: 0;\\n                width: 100% !important\\n            }\\n\\n            .mobile-spacer {\\n                width: 0;\\n                display: none\\n            }\\n\\n            @media all and (max-width:639px) {\\n                .container {\\n                    width: 100% !important;\\n                    max-width: 600px !important\\n                }\\n\\n                .mobile {\\n                    width: auto !important;\\n                    max-width: 100% !important;\\n                    display: block !important\\n                }\\n\\n                .mobile-center {\\n                    text-align: center !important\\n                }\\n\\n                .mobile-right {\\n                    text-align: right !important\\n                }\\n\\n                .mobile-left {\\n                    text-align: left !important;\\n                }\\n\\n                .mobile-hidden {\\n                    max-height: 0;\\n                    display: none !important;\\n                    mso-hide: all;\\n                    overflow: hidden\\n                }\\n\\n                .mobile-spacer {\\n                    width: auto !important;\\n                    display: table !important\\n                }\\n\\n                .mobile-image,\\n                .mobile-image img {\\n                    height: auto !important;\\n                    max-width: 600px !important;\\n                    width: 100% !important\\n                }\\n            }\\n        </style>\\n        <!--[if mso]><style type=\\"text/css\\">body, table, td, a { font-family: Arial, Helvetica, sans-serif !important; }</style><![endif]-->\\n    </head>\\n\\n    <body style=\\"font-family: Helvetica, Arial, sans-serif; margin: 0px; padding: 0px; background-color: #ffffff;\\">\\n        <span style=\\"color: transparent; display: none; height: 0px; max-height: 0px; max-width: 0px; opacity: 0; overflow: hidden; visibility: hidden; width: 0px;\\">Your Natural Healing Commune verification code</span>\\n        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"body\\" style=\\"width: 100%;\\">\\n            <tbody>\\n                <tr>\\n                    <td align=\\"center\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 48px 32px;\\">\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"header container\\" style=\\"width: 600px;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 16px 32px;\\">\\n                                        <p style=\\"padding: 0px; margin: 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 24px; line-height: 36px;\\">\\n                                            Natural Healing Commune\\n                                        </p>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"main container\\" style=\\"width: 600px; border-collapse: separate;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#fff\\" style=\\"vertical-align: top; line-height: 1; background-color: #ffffff; border-radius: 0px;\\">\\n                                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"block\\" style=\\"width: 100%; border-collapse: separate;\\">\\n                                            <tbody>\\n                                                <tr>\\n                                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#ffffff\\" style=\\"vertical-align: top; line-height: 1; padding: 32px 32px 48px; background-color: #ffffff; border-radius: 0px;\\">\\n                                                        <h1 class=\\"h1\\" align=\\"left\\" style=\\"padding: 0px; margin: 0px; font-style: normal; font-family: Helvetica, Arial, sans-serif; font-size: 32px; line-height: 39px; color: #000000; font-weight: bold;\\"> Verification code </h1>\\n                                                        <p align=\\"left\\" style=\\"padding: 0px; margin: 32px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> Enter the following verification code when prompted: </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 40px; line-height: 60px;\\">\\n                                                            <b>253503</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> To protect your account, do not share this code. </p>\\n                                                        <p style=\\"padding: 0px; margin: 64px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\">\\n                                                            <b>Didn't request this?</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 4px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> This code was requested from <b>169.150.196.37, Amsterdam, NL</b> at <b>07 January 2025, 16:32 UTC</b>. If you didn't make this request, you can safely ignore this email. </p>\\n                                                    </td>\\n                                                </tr>\\n                                            </tbody>\\n                                        </table>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                    </td>\\n                </tr>\\n            </tbody>\\n        </table>\\n    </body>\\n\\n</html>", "data": {"app": {"url": "https://settling-monarch-25.accounts.dev", "name": "Natural Healing Commune", "logo_url": null, "domain_name": "settling.monarch-25.lcl.dev", "logo_image_url": ""}, "user": {"public_metadata": null, "public_metadata_fallback": ""}, "theme": {"primary_color": "#6c47ff", "button_text_color": "#ffffff", "show_clerk_branding": true}, "otp_code": "253503", "requested_at": "07 January 2025, 16:32 UTC", "requested_by": "Chrome, Windows", "requested_from": "169.150.196.37, Amsterdam, NL"}, "slug": "verification_code", "object": "email", "status": "queued", "subject": "[Development] 253503 is your verification code", "user_id": null, "body_plain": "253503 is your OTP code for Natural Healing Commune.\\n\\nDo not share this with anyone.\\n\\nIt was requested at 07 January 2025, 16:32 UTC. If you did not request this, please ignore this email.\\n", "from_email_name": "notifications", "email_address_id": "idn_2rJC1eA0rGU0u1yRZPDu0d0WS1V", "to_email_address": "test3@example.com", "delivered_by_clerk": true, "reply_to_email_name": null}, "type": "email.created", "object": "event", "timestamp": 1736267576626, "event_attributes": {"http_request": {"client_ip": "169.150.196.37", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36"}}}, "svix_headers": {"svix-id": "msg_2rJC1fibq8Z7vTGdLyao71D7MS4", "svix-signature": "v1,19xdbjr9WIlAtvlrhY00zxBen9IwXDtbN+3vzbz2iK0=", "svix-timestamp": "1736267960"}}
df253dff-8ff9-4b7d-9b3b-ed8e3e17f912	clerk	{"evt": {"data": {"id": "ema_2rJC1bPDq7m4mFQFQR79z8YDkm8", "body": "<!DOCTYPE html PUBLIC \\"-//W3C//DTD XHTML 1.0 Strict//EN\\" \\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\\">\\n<html xmlns=\\"http://www.w3.org/1999/xhtml\\">\\n\\n    <head>\\n        <meta http-equiv=\\"Content-Type\\" content=\\"text/html; charset=utf-8\\">\\n        <meta name=\\"viewport\\" content=\\"width=device-width, initial-scale=1.0\\">\\n        <title>253503 is your Natural Healing Commune verification code</title>\\n        <style type=\\"text/css\\">\\n            #outlook a {\\n                padding: 0\\n            }\\n\\n            .ExternalClass {\\n                width: 100%\\n            }\\n\\n            .ExternalClass,\\n            .ExternalClass p,\\n            .ExternalClass span,\\n            .ExternalClass font,\\n            .ExternalClass td,\\n            .ExternalClass div {\\n                line-height: 100%\\n            }\\n\\n            body,\\n            table,\\n            td,\\n            a {\\n                -webkit-text-size-adjust: 100%;\\n                -ms-text-size-adjust: 100%\\n            }\\n\\n            table,\\n            td {\\n                mso-table-lspace: 0;\\n                mso-table-rspace: 0\\n            }\\n\\n            img {\\n                -ms-interpolation-mode: bicubic\\n            }\\n\\n            img {\\n                border: 0;\\n                outline: none;\\n                text-decoration: none\\n            }\\n\\n            a img {\\n                border: none\\n            }\\n\\n            td img {\\n                vertical-align: top\\n            }\\n\\n            table,\\n            table td {\\n                border-collapse: collapse\\n            }\\n\\n            body {\\n                margin: 0;\\n                padding: 0;\\n                width: 100% !important\\n            }\\n\\n            .mobile-spacer {\\n                width: 0;\\n                display: none\\n            }\\n\\n            @media all and (max-width:639px) {\\n                .container {\\n                    width: 100% !important;\\n                    max-width: 600px !important\\n                }\\n\\n                .mobile {\\n                    width: auto !important;\\n                    max-width: 100% !important;\\n                    display: block !important\\n                }\\n\\n                .mobile-center {\\n                    text-align: center !important\\n                }\\n\\n                .mobile-right {\\n                    text-align: right !important\\n                }\\n\\n                .mobile-left {\\n                    text-align: left !important;\\n                }\\n\\n                .mobile-hidden {\\n                    max-height: 0;\\n                    display: none !important;\\n                    mso-hide: all;\\n                    overflow: hidden\\n                }\\n\\n                .mobile-spacer {\\n                    width: auto !important;\\n                    display: table !important\\n                }\\n\\n                .mobile-image,\\n                .mobile-image img {\\n                    height: auto !important;\\n                    max-width: 600px !important;\\n                    width: 100% !important\\n                }\\n            }\\n        </style>\\n        <!--[if mso]><style type=\\"text/css\\">body, table, td, a { font-family: Arial, Helvetica, sans-serif !important; }</style><![endif]-->\\n    </head>\\n\\n    <body style=\\"font-family: Helvetica, Arial, sans-serif; margin: 0px; padding: 0px; background-color: #ffffff;\\">\\n        <span style=\\"color: transparent; display: none; height: 0px; max-height: 0px; max-width: 0px; opacity: 0; overflow: hidden; visibility: hidden; width: 0px;\\">Your Natural Healing Commune verification code</span>\\n        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"body\\" style=\\"width: 100%;\\">\\n            <tbody>\\n                <tr>\\n                    <td align=\\"center\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 48px 32px;\\">\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"header container\\" style=\\"width: 600px;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 16px 32px;\\">\\n                                        <p style=\\"padding: 0px; margin: 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 24px; line-height: 36px;\\">\\n                                            Natural Healing Commune\\n                                        </p>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"main container\\" style=\\"width: 600px; border-collapse: separate;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#fff\\" style=\\"vertical-align: top; line-height: 1; background-color: #ffffff; border-radius: 0px;\\">\\n                                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"block\\" style=\\"width: 100%; border-collapse: separate;\\">\\n                                            <tbody>\\n                                                <tr>\\n                                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#ffffff\\" style=\\"vertical-align: top; line-height: 1; padding: 32px 32px 48px; background-color: #ffffff; border-radius: 0px;\\">\\n                                                        <h1 class=\\"h1\\" align=\\"left\\" style=\\"padding: 0px; margin: 0px; font-style: normal; font-family: Helvetica, Arial, sans-serif; font-size: 32px; line-height: 39px; color: #000000; font-weight: bold;\\"> Verification code </h1>\\n                                                        <p align=\\"left\\" style=\\"padding: 0px; margin: 32px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> Enter the following verification code when prompted: </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 40px; line-height: 60px;\\">\\n                                                            <b>253503</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> To protect your account, do not share this code. </p>\\n                                                        <p style=\\"padding: 0px; margin: 64px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\">\\n                                                            <b>Didn't request this?</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 4px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> This code was requested from <b>169.150.196.37, Amsterdam, NL</b> at <b>07 January 2025, 16:32 UTC</b>. If you didn't make this request, you can safely ignore this email. </p>\\n                                                    </td>\\n                                                </tr>\\n                                            </tbody>\\n                                        </table>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                    </td>\\n                </tr>\\n            </tbody>\\n        </table>\\n    </body>\\n\\n</html>", "data": {"app": {"url": "https://settling-monarch-25.accounts.dev", "name": "Natural Healing Commune", "logo_url": null, "domain_name": "settling.monarch-25.lcl.dev", "logo_image_url": ""}, "user": {"public_metadata": null, "public_metadata_fallback": ""}, "theme": {"primary_color": "#6c47ff", "button_text_color": "#ffffff", "show_clerk_branding": true}, "otp_code": "253503", "requested_at": "07 January 2025, 16:32 UTC", "requested_by": "Chrome, Windows", "requested_from": "169.150.196.37, Amsterdam, NL"}, "slug": "verification_code", "object": "email", "status": "queued", "subject": "[Development] 253503 is your verification code", "user_id": null, "body_plain": "253503 is your OTP code for Natural Healing Commune.\\n\\nDo not share this with anyone.\\n\\nIt was requested at 07 January 2025, 16:32 UTC. If you did not request this, please ignore this email.\\n", "from_email_name": "notifications", "email_address_id": "idn_2rJC1eA0rGU0u1yRZPDu0d0WS1V", "to_email_address": "test3@example.com", "delivered_by_clerk": true, "reply_to_email_name": null}, "type": "email.created", "object": "event", "timestamp": 1736267576626, "event_attributes": {"http_request": {"client_ip": "169.150.196.37", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36"}}}, "svix_headers": {"svix-id": "msg_2rJC1fibq8Z7vTGdLyao71D7MS4", "svix-signature": "v1,tt7ixBA6fjFEVis5fGxfnGBDM92SrDCJshLaUeLWXXk=", "svix-timestamp": "1736268016"}}
b91cfdc2-5c8f-447b-bfaf-95ba6b5096c8	clerk	{"evt": {"data": {"id": "ema_2rJC1bPDq7m4mFQFQR79z8YDkm8", "body": "<!DOCTYPE html PUBLIC \\"-//W3C//DTD XHTML 1.0 Strict//EN\\" \\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\\">\\n<html xmlns=\\"http://www.w3.org/1999/xhtml\\">\\n\\n    <head>\\n        <meta http-equiv=\\"Content-Type\\" content=\\"text/html; charset=utf-8\\">\\n        <meta name=\\"viewport\\" content=\\"width=device-width, initial-scale=1.0\\">\\n        <title>253503 is your Natural Healing Commune verification code</title>\\n        <style type=\\"text/css\\">\\n            #outlook a {\\n                padding: 0\\n            }\\n\\n            .ExternalClass {\\n                width: 100%\\n            }\\n\\n            .ExternalClass,\\n            .ExternalClass p,\\n            .ExternalClass span,\\n            .ExternalClass font,\\n            .ExternalClass td,\\n            .ExternalClass div {\\n                line-height: 100%\\n            }\\n\\n            body,\\n            table,\\n            td,\\n            a {\\n                -webkit-text-size-adjust: 100%;\\n                -ms-text-size-adjust: 100%\\n            }\\n\\n            table,\\n            td {\\n                mso-table-lspace: 0;\\n                mso-table-rspace: 0\\n            }\\n\\n            img {\\n                -ms-interpolation-mode: bicubic\\n            }\\n\\n            img {\\n                border: 0;\\n                outline: none;\\n                text-decoration: none\\n            }\\n\\n            a img {\\n                border: none\\n            }\\n\\n            td img {\\n                vertical-align: top\\n            }\\n\\n            table,\\n            table td {\\n                border-collapse: collapse\\n            }\\n\\n            body {\\n                margin: 0;\\n                padding: 0;\\n                width: 100% !important\\n            }\\n\\n            .mobile-spacer {\\n                width: 0;\\n                display: none\\n            }\\n\\n            @media all and (max-width:639px) {\\n                .container {\\n                    width: 100% !important;\\n                    max-width: 600px !important\\n                }\\n\\n                .mobile {\\n                    width: auto !important;\\n                    max-width: 100% !important;\\n                    display: block !important\\n                }\\n\\n                .mobile-center {\\n                    text-align: center !important\\n                }\\n\\n                .mobile-right {\\n                    text-align: right !important\\n                }\\n\\n                .mobile-left {\\n                    text-align: left !important;\\n                }\\n\\n                .mobile-hidden {\\n                    max-height: 0;\\n                    display: none !important;\\n                    mso-hide: all;\\n                    overflow: hidden\\n                }\\n\\n                .mobile-spacer {\\n                    width: auto !important;\\n                    display: table !important\\n                }\\n\\n                .mobile-image,\\n                .mobile-image img {\\n                    height: auto !important;\\n                    max-width: 600px !important;\\n                    width: 100% !important\\n                }\\n            }\\n        </style>\\n        <!--[if mso]><style type=\\"text/css\\">body, table, td, a { font-family: Arial, Helvetica, sans-serif !important; }</style><![endif]-->\\n    </head>\\n\\n    <body style=\\"font-family: Helvetica, Arial, sans-serif; margin: 0px; padding: 0px; background-color: #ffffff;\\">\\n        <span style=\\"color: transparent; display: none; height: 0px; max-height: 0px; max-width: 0px; opacity: 0; overflow: hidden; visibility: hidden; width: 0px;\\">Your Natural Healing Commune verification code</span>\\n        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"body\\" style=\\"width: 100%;\\">\\n            <tbody>\\n                <tr>\\n                    <td align=\\"center\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 48px 32px;\\">\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"header container\\" style=\\"width: 600px;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 16px 32px;\\">\\n                                        <p style=\\"padding: 0px; margin: 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 24px; line-height: 36px;\\">\\n                                            Natural Healing Commune\\n                                        </p>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"main container\\" style=\\"width: 600px; border-collapse: separate;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#fff\\" style=\\"vertical-align: top; line-height: 1; background-color: #ffffff; border-radius: 0px;\\">\\n                                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"block\\" style=\\"width: 100%; border-collapse: separate;\\">\\n                                            <tbody>\\n                                                <tr>\\n                                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#ffffff\\" style=\\"vertical-align: top; line-height: 1; padding: 32px 32px 48px; background-color: #ffffff; border-radius: 0px;\\">\\n                                                        <h1 class=\\"h1\\" align=\\"left\\" style=\\"padding: 0px; margin: 0px; font-style: normal; font-family: Helvetica, Arial, sans-serif; font-size: 32px; line-height: 39px; color: #000000; font-weight: bold;\\"> Verification code </h1>\\n                                                        <p align=\\"left\\" style=\\"padding: 0px; margin: 32px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> Enter the following verification code when prompted: </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 40px; line-height: 60px;\\">\\n                                                            <b>253503</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> To protect your account, do not share this code. </p>\\n                                                        <p style=\\"padding: 0px; margin: 64px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\">\\n                                                            <b>Didn't request this?</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 4px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> This code was requested from <b>169.150.196.37, Amsterdam, NL</b> at <b>07 January 2025, 16:32 UTC</b>. If you didn't make this request, you can safely ignore this email. </p>\\n                                                    </td>\\n                                                </tr>\\n                                            </tbody>\\n                                        </table>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                    </td>\\n                </tr>\\n            </tbody>\\n        </table>\\n    </body>\\n\\n</html>", "data": {"app": {"url": "https://settling-monarch-25.accounts.dev", "name": "Natural Healing Commune", "logo_url": null, "domain_name": "settling.monarch-25.lcl.dev", "logo_image_url": ""}, "user": {"public_metadata": null, "public_metadata_fallback": ""}, "theme": {"primary_color": "#6c47ff", "button_text_color": "#ffffff", "show_clerk_branding": true}, "otp_code": "253503", "requested_at": "07 January 2025, 16:32 UTC", "requested_by": "Chrome, Windows", "requested_from": "169.150.196.37, Amsterdam, NL"}, "slug": "verification_code", "object": "email", "status": "queued", "subject": "[Development] 253503 is your verification code", "user_id": null, "body_plain": "253503 is your OTP code for Natural Healing Commune.\\n\\nDo not share this with anyone.\\n\\nIt was requested at 07 January 2025, 16:32 UTC. If you did not request this, please ignore this email.\\n", "from_email_name": "notifications", "email_address_id": "idn_2rJC1eA0rGU0u1yRZPDu0d0WS1V", "to_email_address": "test3@example.com", "delivered_by_clerk": true, "reply_to_email_name": null}, "type": "email.created", "object": "event", "timestamp": 1736267576626, "event_attributes": {"http_request": {"client_ip": "169.150.196.37", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36"}}}, "svix_headers": {"svix-id": "msg_2rJC1fibq8Z7vTGdLyao71D7MS4", "svix-signature": "v1,+8GQIAL7m6m6BJvc5MObHZCMjf7XKrlgI7F9DRTz53k=", "svix-timestamp": "1736268100"}}
cb2eabc3-cfde-46d4-a078-03df09835c61	clerk	{"evt": {"data": {"id": "user_2hotYcHE7N6t7jApjRcdmVsstip", "object": "user", "deleted": true}, "type": "user.deleted", "object": "event", "timestamp": 1738669017150, "event_attributes": {"http_request": {"client_ip": "", "user_agent": "clerk/clerk-sdk-go@v3.0.0"}}}, "svix_headers": {"svix-id": "msg_2sZhUCr7RghBXyMb9AZNvEymWJV", "svix-signature": "v1,MSUbn45pOK7AvRl3dtt32+jYJNTj+/y7Rm3hkynX49g=", "svix-timestamp": "1738669017"}}
c1d61f4a-704f-40d9-9d6b-d8feefe794b2	clerk	{"evt": {"data": {"id": "user_2hotYcHE7N6t7jApjRcdmVsstip", "object": "user", "deleted": true}, "type": "user.deleted", "object": "event", "timestamp": 1738669017150, "event_attributes": {"http_request": {"client_ip": "", "user_agent": "clerk/clerk-sdk-go@v3.0.0"}}}, "svix_headers": {"svix-id": "msg_2sZhUCr7RghBXyMb9AZNvEymWJV", "svix-signature": "v1,qbn+vJKwgDm8OLauzQytffAE5Rmv8/6OvRhmRLy3If8=", "svix-timestamp": "1738669023"}}
b1d020bf-27f5-47c3-be89-338e7717b5dd	clerk	{"evt": {"data": {"id": "user_2hotYcHE7N6t7jApjRcdmVsstip", "object": "user", "deleted": true}, "type": "user.deleted", "object": "event", "timestamp": 1738669017150, "event_attributes": {"http_request": {"client_ip": "", "user_agent": "clerk/clerk-sdk-go@v3.0.0"}}}, "svix_headers": {"svix-id": "msg_2sZhUCr7RghBXyMb9AZNvEymWJV", "svix-signature": "v1,Y65AspjNtbMAukdd0XIBYka9bVllRXP93APHYegYN7Y=", "svix-timestamp": "1738669351"}}
55c76e24-42a1-4d1f-a87b-df52b98b00a0	clerk	{"evt": {"data": {"id": "ema_2sZiFqwDukLJcpRuYZaa1aPENyx", "body": "<!DOCTYPE html PUBLIC \\"-//W3C//DTD XHTML 1.0 Strict//EN\\" \\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\\">\\n<html xmlns=\\"http://www.w3.org/1999/xhtml\\">\\n\\n    <head>\\n        <meta http-equiv=\\"Content-Type\\" content=\\"text/html; charset=utf-8\\">\\n        <meta name=\\"viewport\\" content=\\"width=device-width, initial-scale=1.0\\">\\n        <title>594837 is your Natural Healing Commune verification code</title>\\n        <style type=\\"text/css\\">\\n            #outlook a {\\n                padding: 0\\n            }\\n\\n            .ExternalClass {\\n                width: 100%\\n            }\\n\\n            .ExternalClass,\\n            .ExternalClass p,\\n            .ExternalClass span,\\n            .ExternalClass font,\\n            .ExternalClass td,\\n            .ExternalClass div {\\n                line-height: 100%\\n            }\\n\\n            body,\\n            table,\\n            td,\\n            a {\\n                -webkit-text-size-adjust: 100%;\\n                -ms-text-size-adjust: 100%\\n            }\\n\\n            table,\\n            td {\\n                mso-table-lspace: 0;\\n                mso-table-rspace: 0\\n            }\\n\\n            img {\\n                -ms-interpolation-mode: bicubic\\n            }\\n\\n            img {\\n                border: 0;\\n                outline: none;\\n                text-decoration: none\\n            }\\n\\n            a img {\\n                border: none\\n            }\\n\\n            td img {\\n                vertical-align: top\\n            }\\n\\n            table,\\n            table td {\\n                border-collapse: collapse\\n            }\\n\\n            body {\\n                margin: 0;\\n                padding: 0;\\n                width: 100% !important\\n            }\\n\\n            .mobile-spacer {\\n                width: 0;\\n                display: none\\n            }\\n\\n            @media all and (max-width:639px) {\\n                .container {\\n                    width: 100% !important;\\n                    max-width: 600px !important\\n                }\\n\\n                .mobile {\\n                    width: auto !important;\\n                    max-width: 100% !important;\\n                    display: block !important\\n                }\\n\\n                .mobile-center {\\n                    text-align: center !important\\n                }\\n\\n                .mobile-right {\\n                    text-align: right !important\\n                }\\n\\n                .mobile-left {\\n                    text-align: left !important;\\n                }\\n\\n                .mobile-hidden {\\n                    max-height: 0;\\n                    display: none !important;\\n                    mso-hide: all;\\n                    overflow: hidden\\n                }\\n\\n                .mobile-spacer {\\n                    width: auto !important;\\n                    display: table !important\\n                }\\n\\n                .mobile-image,\\n                .mobile-image img {\\n                    height: auto !important;\\n                    max-width: 600px !important;\\n                    width: 100% !important\\n                }\\n            }\\n        </style>\\n        <!--[if mso]><style type=\\"text/css\\">body, table, td, a { font-family: Arial, Helvetica, sans-serif !important; }</style><![endif]-->\\n    </head>\\n\\n    <body style=\\"font-family: Helvetica, Arial, sans-serif; margin: 0px; padding: 0px; background-color: #ffffff;\\">\\n        <span style=\\"color: transparent; display: none; height: 0px; max-height: 0px; max-width: 0px; opacity: 0; overflow: hidden; visibility: hidden; width: 0px;\\">Your Natural Healing Commune verification code</span>\\n        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"body\\" style=\\"width: 100%;\\">\\n            <tbody>\\n                <tr>\\n                    <td align=\\"center\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 48px 32px;\\">\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"header container\\" style=\\"width: 600px;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 16px 32px;\\">\\n                                        <p style=\\"padding: 0px; margin: 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 24px; line-height: 36px;\\">\\n                                            Natural Healing Commune\\n                                        </p>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"main container\\" style=\\"width: 600px; border-collapse: separate;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#fff\\" style=\\"vertical-align: top; line-height: 1; background-color: #ffffff; border-radius: 0px;\\">\\n                                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"block\\" style=\\"width: 100%; border-collapse: separate;\\">\\n                                            <tbody>\\n                                                <tr>\\n                                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#ffffff\\" style=\\"vertical-align: top; line-height: 1; padding: 32px 32px 48px; background-color: #ffffff; border-radius: 0px;\\">\\n                                                        <h1 class=\\"h1\\" align=\\"left\\" style=\\"padding: 0px; margin: 0px; font-style: normal; font-family: Helvetica, Arial, sans-serif; font-size: 32px; line-height: 39px; color: #000000; font-weight: bold;\\"> Verification code </h1>\\n                                                        <p align=\\"left\\" style=\\"padding: 0px; margin: 32px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> Enter the following verification code when prompted: </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 40px; line-height: 60px;\\">\\n                                                            <b>594837</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> To protect your account, do not share this code. </p>\\n                                                        <p style=\\"padding: 0px; margin: 64px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\">\\n                                                            <b>Didn't request this?</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 4px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> This code was requested from <b>146.70.119.17, Canary Wharf, GB</b> at <b>04 February 2025, 11:43 UTC</b>. If you didn't make this request, you can safely ignore this email. </p>\\n                                                    </td>\\n                                                </tr>\\n                                            </tbody>\\n                                        </table>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                    </td>\\n                </tr>\\n            </tbody>\\n        </table>\\n    </body>\\n\\n</html>", "data": {"app": {"url": "https://settling-monarch-25.accounts.dev", "name": "Natural Healing Commune", "logo_url": null, "domain_name": "settling.monarch-25.lcl.dev", "logo_image_url": ""}, "user": {"public_metadata": null, "public_metadata_fallback": ""}, "theme": {"primary_color": "#6c47ff", "button_text_color": "#ffffff", "show_clerk_branding": true}, "otp_code": "594837", "requested_at": "04 February 2025, 11:43 UTC", "requested_by": "Chrome, Windows", "requested_from": "146.70.119.17, Canary Wharf, GB"}, "slug": "verification_code", "object": "email", "status": "queued", "subject": "[Development] 594837 is your verification code", "user_id": null, "body_plain": "594837 is your OTP code for Natural Healing Commune.\\n\\nDo not share this with anyone.\\n\\nIt was requested at 04 February 2025, 11:43 UTC. If you did not request this, please ignore this email.\\n", "from_email_name": "notifications", "email_address_id": "idn_2sZiFsg5HslQCurPlf8hz2VB10A", "to_email_address": "louis@louishartley.com", "delivered_by_clerk": true, "reply_to_email_name": null}, "type": "email.created", "object": "event", "timestamp": 1738669396960, "event_attributes": {"http_request": {"client_ip": "146.70.119.17", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36"}}}, "svix_headers": {"svix-id": "msg_2sZiGCVhFJHo1ChlLhEL76pIzcP", "svix-signature": "v1,UY6ltaWSwByPqqXgV/3h4669Te1TJIKAogtMSzZKsFs=", "svix-timestamp": "1738669399"}}
cf6973fb-db2d-4d0d-be6b-da8d3ebf1a52	clerk	{"evt": {"data": {"id": "user_2sZjQd7MEkoaLKlBU2am4HE9X2S", "banned": false, "locked": false, "object": "user", "passkeys": [], "username": "louisi9999", "has_image": false, "image_url": "https://img.clerk.com/eyJ0eXBlIjoiZGVmYXVsdCIsImlpZCI6Imluc18yZEpKaXBKS0FnY2YzNEpzdUxkZlhRU212aWwiLCJyaWQiOiJ1c2VyXzJzWmpRZDdNRWtvYUxLbEJVMmFtNEhFOVgyUyJ9", "last_name": null, "created_at": 1738669975807, "first_name": null, "updated_at": 1738669975830, "external_id": null, "totp_enabled": false, "web3_wallets": [], "phone_numbers": [], "saml_accounts": [], "last_active_at": 1738669975807, "mfa_enabled_at": null, "email_addresses": [{"id": "idn_2sZiFsg5HslQCurPlf8hz2VB10A", "object": "email_address", "reserved": false, "linked_to": [], "created_at": 1738669396534, "updated_at": 1738669975817, "verification": {"status": "verified", "attempts": 1, "strategy": "email_code", "expire_at": 1738669996945}, "email_address": "louis@louishartley.com", "matches_sso_connection": false}], "last_sign_in_at": null, "mfa_disabled_at": null, "public_metadata": {}, "unsafe_metadata": {"language": "en", "membershipType": "personal"}, "password_enabled": true, "private_metadata": {}, "external_accounts": [], "legal_accepted_at": null, "profile_image_url": "https://www.gravatar.com/avatar?d=mp", "two_factor_enabled": false, "backup_code_enabled": false, "delete_self_enabled": true, "enterprise_accounts": [], "primary_web3_wallet_id": null, "primary_phone_number_id": null, "primary_email_address_id": "idn_2sZiFsg5HslQCurPlf8hz2VB10A", "lockout_expires_in_seconds": null, "create_organization_enabled": true, "verification_attempts_remaining": 100}, "type": "user.created", "object": "event", "timestamp": 1738669975845, "event_attributes": {"http_request": {"client_ip": "146.70.119.17", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36"}}}, "svix_headers": {"svix-id": "msg_2sZjQhOTdlVWSYRXDMXDL0WRd6s", "svix-signature": "v1,bneLFtFf6k9CdheJayi+N8O+/T0cbS0u0Y2BWzRb7R4=", "svix-timestamp": "1738669976"}}
bb2acb07-5af9-4654-b844-77944f2f1764	clerk	{"evt": {"data": {"id": "user_2hotYcHE7N6t7jApjRcdmVsstip", "object": "user", "deleted": true}, "type": "user.deleted", "object": "event", "timestamp": 1738669017150, "event_attributes": {"http_request": {"client_ip": "", "user_agent": "clerk/clerk-sdk-go@v3.0.0"}}}, "svix_headers": {"svix-id": "msg_2sZhUCr7RghBXyMb9AZNvEymWJV", "svix-signature": "v1,dUVM9lMnkf9hElCG6VR8yqye5oywC6CDJpKPnt3HaZI=", "svix-timestamp": "1738670865"}}
0db0b425-4740-44cf-9b82-54f56a388dbd	clerk	{"evt": {"data": {"id": "user_2hotYcHE7N6t7jApjRcdmVsstip", "object": "user", "deleted": true}, "type": "user.deleted", "object": "event", "timestamp": 1738669017150, "event_attributes": {"http_request": {"client_ip": "", "user_agent": "clerk/clerk-sdk-go@v3.0.0"}}}, "svix_headers": {"svix-id": "msg_2sZhUCr7RghBXyMb9AZNvEymWJV", "svix-signature": "v1,DmTjRFmUTNS8x2en+x4wpX3vumX/ZJ1jSKSpdsB/G7w=", "svix-timestamp": "1738678967"}}
fc331c94-0fe1-496f-8483-4215f6e984b9	clerk	{"evt": {"data": {"id": "user_2sZjQd7MEkoaLKlBU2am4HE9X2S", "banned": false, "locked": false, "object": "user", "passkeys": [], "username": "louisi9999", "has_image": false, "image_url": "https://img.clerk.com/eyJ0eXBlIjoiZGVmYXVsdCIsImlpZCI6Imluc18yZEpKaXBKS0FnY2YzNEpzdUxkZlhRU212aWwiLCJyaWQiOiJ1c2VyXzJzWmpRZDdNRWtvYUxLbEJVMmFtNEhFOVgyUyJ9", "last_name": null, "created_at": 1738669975807, "first_name": null, "updated_at": 1738681935519, "external_id": null, "totp_enabled": false, "web3_wallets": [], "phone_numbers": [], "saml_accounts": [], "last_active_at": 1738669975807, "mfa_enabled_at": null, "email_addresses": [{"id": "idn_2sZiFsg5HslQCurPlf8hz2VB10A", "object": "email_address", "reserved": false, "linked_to": [], "created_at": 1738669396534, "updated_at": 1738669975817, "verification": {"status": "verified", "attempts": 1, "strategy": "email_code", "expire_at": 1738669996945}, "email_address": "louis@louishartley.com", "matches_sso_connection": false}], "last_sign_in_at": 1738669975810, "mfa_disabled_at": null, "public_metadata": {"isAdmin": true}, "unsafe_metadata": {"language": "en", "membershipType": "personal"}, "password_enabled": true, "private_metadata": {}, "external_accounts": [], "legal_accepted_at": null, "profile_image_url": "https://www.gravatar.com/avatar?d=mp", "two_factor_enabled": false, "backup_code_enabled": false, "delete_self_enabled": true, "enterprise_accounts": [], "primary_web3_wallet_id": null, "primary_phone_number_id": null, "primary_email_address_id": "idn_2sZiFsg5HslQCurPlf8hz2VB10A", "lockout_expires_in_seconds": null, "create_organization_enabled": true, "verification_attempts_remaining": 100}, "type": "user.updated", "object": "event", "timestamp": 1738681935525, "event_attributes": {"http_request": {"client_ip": "", "user_agent": "clerk/clerk-sdk-go@v3.0.0"}}}, "svix_headers": {"svix-id": "msg_2sa7g1r95FqwsBneHXh5VRAGQ2N", "svix-signature": "v1,evZ8MF99t7vIPcFB2TWYAoq9w9zdHYBebhoXFiMpW44=", "svix-timestamp": "1738681939"}}
63016bb7-aa2f-488e-b88f-771895e68d62	clerk	{"evt": {"data": {"id": "ema_2saDCXWzXFJWEqmYCwTEAqWjpLg", "body": "<!DOCTYPE html PUBLIC \\"-//W3C//DTD XHTML 1.0 Strict//EN\\" \\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\\">\\n<html xmlns=\\"http://www.w3.org/1999/xhtml\\">\\n\\n    <head>\\n        <meta http-equiv=\\"Content-Type\\" content=\\"text/html; charset=utf-8\\">\\n        <meta name=\\"viewport\\" content=\\"width=device-width, initial-scale=1.0\\">\\n        <title>261012 is your Natural Healing Commune verification code</title>\\n        <style type=\\"text/css\\">\\n            #outlook a {\\n                padding: 0\\n            }\\n\\n            .ExternalClass {\\n                width: 100%\\n            }\\n\\n            .ExternalClass,\\n            .ExternalClass p,\\n            .ExternalClass span,\\n            .ExternalClass font,\\n            .ExternalClass td,\\n            .ExternalClass div {\\n                line-height: 100%\\n            }\\n\\n            body,\\n            table,\\n            td,\\n            a {\\n                -webkit-text-size-adjust: 100%;\\n                -ms-text-size-adjust: 100%\\n            }\\n\\n            table,\\n            td {\\n                mso-table-lspace: 0;\\n                mso-table-rspace: 0\\n            }\\n\\n            img {\\n                -ms-interpolation-mode: bicubic\\n            }\\n\\n            img {\\n                border: 0;\\n                outline: none;\\n                text-decoration: none\\n            }\\n\\n            a img {\\n                border: none\\n            }\\n\\n            td img {\\n                vertical-align: top\\n            }\\n\\n            table,\\n            table td {\\n                border-collapse: collapse\\n            }\\n\\n            body {\\n                margin: 0;\\n                padding: 0;\\n                width: 100% !important\\n            }\\n\\n            .mobile-spacer {\\n                width: 0;\\n                display: none\\n            }\\n\\n            @media all and (max-width:639px) {\\n                .container {\\n                    width: 100% !important;\\n                    max-width: 600px !important\\n                }\\n\\n                .mobile {\\n                    width: auto !important;\\n                    max-width: 100% !important;\\n                    display: block !important\\n                }\\n\\n                .mobile-center {\\n                    text-align: center !important\\n                }\\n\\n                .mobile-right {\\n                    text-align: right !important\\n                }\\n\\n                .mobile-left {\\n                    text-align: left !important;\\n                }\\n\\n                .mobile-hidden {\\n                    max-height: 0;\\n                    display: none !important;\\n                    mso-hide: all;\\n                    overflow: hidden\\n                }\\n\\n                .mobile-spacer {\\n                    width: auto !important;\\n                    display: table !important\\n                }\\n\\n                .mobile-image,\\n                .mobile-image img {\\n                    height: auto !important;\\n                    max-width: 600px !important;\\n                    width: 100% !important\\n                }\\n            }\\n        </style>\\n        <!--[if mso]><style type=\\"text/css\\">body, table, td, a { font-family: Arial, Helvetica, sans-serif !important; }</style><![endif]-->\\n    </head>\\n\\n    <body style=\\"font-family: Helvetica, Arial, sans-serif; margin: 0px; padding: 0px; background-color: #ffffff;\\">\\n        <span style=\\"color: transparent; display: none; height: 0px; max-height: 0px; max-width: 0px; opacity: 0; overflow: hidden; visibility: hidden; width: 0px;\\">Your Natural Healing Commune verification code</span>\\n        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"body\\" style=\\"width: 100%;\\">\\n            <tbody>\\n                <tr>\\n                    <td align=\\"center\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 48px 32px;\\">\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"header container\\" style=\\"width: 600px;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 16px 32px;\\">\\n                                        <p style=\\"padding: 0px; margin: 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 24px; line-height: 36px;\\">\\n                                            Natural Healing Commune\\n                                        </p>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"main container\\" style=\\"width: 600px; border-collapse: separate;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#fff\\" style=\\"vertical-align: top; line-height: 1; background-color: #ffffff; border-radius: 0px;\\">\\n                                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"block\\" style=\\"width: 100%; border-collapse: separate;\\">\\n                                            <tbody>\\n                                                <tr>\\n                                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#ffffff\\" style=\\"vertical-align: top; line-height: 1; padding: 32px 32px 48px; background-color: #ffffff; border-radius: 0px;\\">\\n                                                        <h1 class=\\"h1\\" align=\\"left\\" style=\\"padding: 0px; margin: 0px; font-style: normal; font-family: Helvetica, Arial, sans-serif; font-size: 32px; line-height: 39px; color: #000000; font-weight: bold;\\"> Verification code </h1>\\n                                                        <p align=\\"left\\" style=\\"padding: 0px; margin: 32px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> Enter the following verification code when prompted: </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 40px; line-height: 60px;\\">\\n                                                            <b>261012</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> To protect your account, do not share this code. </p>\\n                                                        <p style=\\"padding: 0px; margin: 64px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\">\\n                                                            <b>Didn't request this?</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 4px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> This code was requested from <b>2.96.245.234, North Shields, GB</b> at <b>04 February 2025, 15:57 UTC</b>. If you didn't make this request, you can safely ignore this email. </p>\\n                                                    </td>\\n                                                </tr>\\n                                            </tbody>\\n                                        </table>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                    </td>\\n                </tr>\\n            </tbody>\\n        </table>\\n    </body>\\n\\n</html>", "data": {"app": {"url": "https://settling-monarch-25.accounts.dev", "name": "Natural Healing Commune", "logo_url": null, "domain_name": "settling.monarch-25.lcl.dev", "logo_image_url": ""}, "user": {"public_metadata": null, "public_metadata_fallback": ""}, "theme": {"primary_color": "#6c47ff", "button_text_color": "#ffffff", "show_clerk_branding": true}, "otp_code": "261012", "requested_at": "04 February 2025, 15:57 UTC", "requested_by": "Chrome, Windows", "requested_from": "2.96.245.234, North Shields, GB"}, "slug": "verification_code", "object": "email", "status": "queued", "subject": "[Development] 261012 is your verification code", "user_id": null, "body_plain": "261012 is your OTP code for Natural Healing Commune.\\n\\nDo not share this with anyone.\\n\\nIt was requested at 04 February 2025, 15:57 UTC. If you did not request this, please ignore this email.\\n", "from_email_name": "notifications", "email_address_id": "idn_2saDCPMUI6AI1oFEkBgAAqcx4xA", "to_email_address": "harrison@dashmedia.co.uk", "delivered_by_clerk": true, "reply_to_email_name": null}, "type": "email.created", "object": "event", "timestamp": 1738684664411, "event_attributes": {"http_request": {"client_ip": "2.96.245.234", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36"}}}, "svix_headers": {"svix-id": "msg_2saDCZBJLnfS7fftyOFmJKgTrPB", "svix-signature": "v1,m18UmGzdG2+P6fporAHXgoXHTvfaLK026iAq9zutwcI=", "svix-timestamp": "1738684664"}}
04381e35-02d8-451f-b6dd-820b300fb741	clerk	{"evt": {"data": {"id": "user_2saDE9oZAjHgmENRgFUPG2hVN7v", "banned": false, "locked": false, "object": "user", "passkeys": [], "username": "harrisonwalker", "has_image": false, "image_url": "https://img.clerk.com/eyJ0eXBlIjoiZGVmYXVsdCIsImlpZCI6Imluc18yZEpKaXBKS0FnY2YzNEpzdUxkZlhRU212aWwiLCJyaWQiOiJ1c2VyXzJzYURFOW9aQWpIZ21FTlJnRlVQRzJoVk43diJ9", "last_name": null, "created_at": 1738684677835, "first_name": null, "updated_at": 1738684677861, "external_id": null, "totp_enabled": false, "web3_wallets": [], "phone_numbers": [], "saml_accounts": [], "last_active_at": 1738684677835, "mfa_enabled_at": null, "email_addresses": [{"id": "idn_2saDCPMUI6AI1oFEkBgAAqcx4xA", "object": "email_address", "reserved": false, "linked_to": [], "created_at": 1738684663752, "updated_at": 1738684677847, "verification": {"status": "verified", "attempts": 1, "strategy": "email_code", "expire_at": 1738685264395}, "email_address": "harrison@dashmedia.co.uk", "matches_sso_connection": false}], "last_sign_in_at": null, "mfa_disabled_at": null, "public_metadata": {}, "unsafe_metadata": {"language": "en", "membershipType": "personal"}, "password_enabled": true, "private_metadata": {}, "external_accounts": [], "legal_accepted_at": null, "profile_image_url": "https://www.gravatar.com/avatar?d=mp", "two_factor_enabled": false, "backup_code_enabled": false, "delete_self_enabled": true, "enterprise_accounts": [], "primary_web3_wallet_id": null, "primary_phone_number_id": null, "primary_email_address_id": "idn_2saDCPMUI6AI1oFEkBgAAqcx4xA", "lockout_expires_in_seconds": null, "create_organization_enabled": true, "verification_attempts_remaining": 100}, "type": "user.created", "object": "event", "timestamp": 1738684677878, "event_attributes": {"http_request": {"client_ip": "2.96.245.234", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36"}}}, "svix_headers": {"svix-id": "msg_2saDEUlyhjjIl3mN28kKOt5LvdH", "svix-signature": "v1,Q39TJVYVtjqM6HEFfGAQ1Cii0loTK61WvgseC13zHsA=", "svix-timestamp": "1738684680"}}
d1b28e87-f8f0-4dac-9892-eaa959aae75c	clerk	{"evt": {"data": {"id": "user_2saDE9oZAjHgmENRgFUPG2hVN7v", "banned": false, "locked": false, "object": "user", "passkeys": [], "username": "harrisonwalker", "has_image": false, "image_url": "https://img.clerk.com/eyJ0eXBlIjoiZGVmYXVsdCIsImlpZCI6Imluc18yZEpKaXBKS0FnY2YzNEpzdUxkZlhRU212aWwiLCJyaWQiOiJ1c2VyXzJzYURFOW9aQWpIZ21FTlJnRlVQRzJoVk43diJ9", "last_name": null, "created_at": 1738684677835, "first_name": null, "updated_at": 1738684889060, "external_id": null, "totp_enabled": false, "web3_wallets": [], "phone_numbers": [], "saml_accounts": [], "last_active_at": 1738684677835, "mfa_enabled_at": null, "email_addresses": [{"id": "idn_2saDCPMUI6AI1oFEkBgAAqcx4xA", "object": "email_address", "reserved": false, "linked_to": [], "created_at": 1738684663752, "updated_at": 1738684677847, "verification": {"status": "verified", "attempts": 1, "strategy": "email_code", "expire_at": 1738685264395}, "email_address": "harrison@dashmedia.co.uk", "matches_sso_connection": false}], "last_sign_in_at": 1738684677839, "mfa_disabled_at": null, "public_metadata": {"isAdmin": true}, "unsafe_metadata": {"language": "en", "membershipType": "personal"}, "password_enabled": true, "private_metadata": {}, "external_accounts": [], "legal_accepted_at": null, "profile_image_url": "https://www.gravatar.com/avatar?d=mp", "two_factor_enabled": false, "backup_code_enabled": false, "delete_self_enabled": true, "enterprise_accounts": [], "primary_web3_wallet_id": null, "primary_phone_number_id": null, "primary_email_address_id": "idn_2saDCPMUI6AI1oFEkBgAAqcx4xA", "lockout_expires_in_seconds": null, "create_organization_enabled": true, "verification_attempts_remaining": 100}, "type": "user.updated", "object": "event", "timestamp": 1738684889064, "event_attributes": {"http_request": {"client_ip": "", "user_agent": "clerk/clerk-sdk-go@v3.0.0"}}}, "svix_headers": {"svix-id": "msg_2saDesveIu6vNiZFNHLfzHu1DV4", "svix-signature": "v1,gNpEiuSIdW4Rb1FJDT1vB4qLHKIQCLyTqefqQRDnOSs=", "svix-timestamp": "1738684890"}}
bd15997f-a6a9-4f75-af96-8d8fee671e6d	clerk	{"evt": {"data": {"id": "user_2hotYcHE7N6t7jApjRcdmVsstip", "object": "user", "deleted": true}, "type": "user.deleted", "object": "event", "timestamp": 1738669017150, "event_attributes": {"http_request": {"client_ip": "", "user_agent": "clerk/clerk-sdk-go@v3.0.0"}}}, "svix_headers": {"svix-id": "msg_2sZhUCr7RghBXyMb9AZNvEymWJV", "svix-signature": "v1,+JxtOJBwv2BSPLgkSJdAKPV9Zl/ahTjMqlrSKXfHRLE=", "svix-timestamp": "1738695631"}}
44b2982a-0158-4c2a-97e5-7a3e62ffddeb	clerk	{"evt": {"data": {"id": "user_2hotYcHE7N6t7jApjRcdmVsstip", "object": "user", "deleted": true}, "type": "user.deleted", "object": "event", "timestamp": 1738669017150, "event_attributes": {"http_request": {"client_ip": "", "user_agent": "clerk/clerk-sdk-go@v3.0.0"}}}, "svix_headers": {"svix-id": "msg_2sZhUCr7RghBXyMb9AZNvEymWJV", "svix-signature": "v1,Fgf2rltn8zzuPxK89R+G4bLmx5u2Oce3ZOqu31PS9NE=", "svix-timestamp": "1738727989"}}
3ef08753-59ca-4825-98e8-5fd109fce0f5	clerk	{"evt": {"data": {"id": "user_2hotYcHE7N6t7jApjRcdmVsstip", "object": "user", "deleted": true}, "type": "user.deleted", "object": "event", "timestamp": 1738669017150, "event_attributes": {"http_request": {"client_ip": "", "user_agent": "clerk/clerk-sdk-go@v3.0.0"}}}, "svix_headers": {"svix-id": "msg_2sZhUCr7RghBXyMb9AZNvEymWJV", "svix-signature": "v1,ElLm8kD/eSsZoF6OTtwxy0b1AwxJR2QN1wVhoxBwnRE=", "svix-timestamp": "1738764398"}}
e2ad6cb6-0b77-4a47-8c3a-09cdb80c245e	clerk	{"evt": {"data": {"id": "ema_2tGieYoQqBgihjvddV5cNxm9Ev8", "body": "<!DOCTYPE html PUBLIC \\"-//W3C//DTD XHTML 1.0 Strict//EN\\" \\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\\">\\n<html xmlns=\\"http://www.w3.org/1999/xhtml\\">\\n\\n    <head>\\n        <meta http-equiv=\\"Content-Type\\" content=\\"text/html; charset=utf-8\\">\\n        <meta name=\\"viewport\\" content=\\"width=device-width, initial-scale=1.0\\">\\n        <title>036164 is your Natural Healing Commune verification code</title>\\n        <style type=\\"text/css\\">\\n            #outlook a {\\n                padding: 0\\n            }\\n\\n            .ExternalClass {\\n                width: 100%\\n            }\\n\\n            .ExternalClass,\\n            .ExternalClass p,\\n            .ExternalClass span,\\n            .ExternalClass font,\\n            .ExternalClass td,\\n            .ExternalClass div {\\n                line-height: 100%\\n            }\\n\\n            body,\\n            table,\\n            td,\\n            a {\\n                -webkit-text-size-adjust: 100%;\\n                -ms-text-size-adjust: 100%\\n            }\\n\\n            table,\\n            td {\\n                mso-table-lspace: 0;\\n                mso-table-rspace: 0\\n            }\\n\\n            img {\\n                -ms-interpolation-mode: bicubic\\n            }\\n\\n            img {\\n                border: 0;\\n                outline: none;\\n                text-decoration: none\\n            }\\n\\n            a img {\\n                border: none\\n            }\\n\\n            td img {\\n                vertical-align: top\\n            }\\n\\n            table,\\n            table td {\\n                border-collapse: collapse\\n            }\\n\\n            body {\\n                margin: 0;\\n                padding: 0;\\n                width: 100% !important\\n            }\\n\\n            .mobile-spacer {\\n                width: 0;\\n                display: none\\n            }\\n\\n            @media all and (max-width:639px) {\\n                .container {\\n                    width: 100% !important;\\n                    max-width: 600px !important\\n                }\\n\\n                .mobile {\\n                    width: auto !important;\\n                    max-width: 100% !important;\\n                    display: block !important\\n                }\\n\\n                .mobile-center {\\n                    text-align: center !important\\n                }\\n\\n                .mobile-right {\\n                    text-align: right !important\\n                }\\n\\n                .mobile-left {\\n                    text-align: left !important;\\n                }\\n\\n                .mobile-hidden {\\n                    max-height: 0;\\n                    display: none !important;\\n                    mso-hide: all;\\n                    overflow: hidden\\n                }\\n\\n                .mobile-spacer {\\n                    width: auto !important;\\n                    display: table !important\\n                }\\n\\n                .mobile-image,\\n                .mobile-image img {\\n                    height: auto !important;\\n                    max-width: 600px !important;\\n                    width: 100% !important\\n                }\\n            }\\n        </style>\\n        <!--[if mso]><style type=\\"text/css\\">body, table, td, a { font-family: Arial, Helvetica, sans-serif !important; }</style><![endif]-->\\n    </head>\\n\\n    <body style=\\"font-family: Helvetica, Arial, sans-serif; margin: 0px; padding: 0px; background-color: #ffffff;\\">\\n        <span style=\\"color: transparent; display: none; height: 0px; max-height: 0px; max-width: 0px; opacity: 0; overflow: hidden; visibility: hidden; width: 0px;\\">Your Natural Healing Commune verification code</span>\\n        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"body\\" style=\\"width: 100%;\\">\\n            <tbody>\\n                <tr>\\n                    <td align=\\"center\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 48px 32px;\\">\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"header container\\" style=\\"width: 600px;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 16px 32px;\\">\\n                                        <p style=\\"padding: 0px; margin: 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 24px; line-height: 36px;\\">\\n                                            Natural Healing Commune\\n                                        </p>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"main container\\" style=\\"width: 600px; border-collapse: separate;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#fff\\" style=\\"vertical-align: top; line-height: 1; background-color: #ffffff; border-radius: 0px;\\">\\n                                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"block\\" style=\\"width: 100%; border-collapse: separate;\\">\\n                                            <tbody>\\n                                                <tr>\\n                                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#ffffff\\" style=\\"vertical-align: top; line-height: 1; padding: 32px 32px 48px; background-color: #ffffff; border-radius: 0px;\\">\\n                                                        <h1 class=\\"h1\\" align=\\"left\\" style=\\"padding: 0px; margin: 0px; font-style: normal; font-family: Helvetica, Arial, sans-serif; font-size: 32px; line-height: 39px; color: #000000; font-weight: bold;\\"> Verification code </h1>\\n                                                        <p align=\\"left\\" style=\\"padding: 0px; margin: 32px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> Enter the following verification code when prompted: </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 40px; line-height: 60px;\\">\\n                                                            <b>036164</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> To protect your account, do not share this code. </p>\\n                                                        <p style=\\"padding: 0px; margin: 64px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\">\\n                                                            <b>Didn't request this?</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 4px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> This code was requested from <b>86.13.192.233, Brighton, GB</b> at <b>19 February 2025, 17:08 UTC</b>. If you didn't make this request, you can safely ignore this email. </p>\\n                                                    </td>\\n                                                </tr>\\n                                            </tbody>\\n                                        </table>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                    </td>\\n                </tr>\\n            </tbody>\\n        </table>\\n    </body>\\n\\n</html>", "data": {"app": {"url": "https://settling-monarch-25.accounts.dev", "name": "Natural Healing Commune", "logo_url": null, "domain_name": "settling.monarch-25.lcl.dev", "logo_image_url": ""}, "user": {"public_metadata": null, "public_metadata_fallback": ""}, "theme": {"primary_color": "#6c47ff", "button_text_color": "#ffffff", "show_clerk_branding": true}, "otp_code": "036164", "requested_at": "19 February 2025, 17:08 UTC", "requested_by": "Safari, Macintosh", "requested_from": "86.13.192.233, Brighton, GB"}, "slug": "verification_code", "object": "email", "status": "queued", "subject": "[Development] 036164 is your verification code", "user_id": null, "body_plain": "036164 is your OTP code for Natural Healing Commune.\\n\\nDo not share this with anyone.\\n\\nIt was requested at 19 February 2025, 17:08 UTC. If you did not request this, please ignore this email.\\n", "from_email_name": "notifications", "email_address_id": "idn_2tGieZsNt3rgS76be6NqELJZton", "to_email_address": "info@naturalhealingcommune.com", "delivered_by_clerk": true, "reply_to_email_name": null}, "type": "email.created", "object": "event", "timestamp": 1739984907938, "instance_id": "ins_2dJJipJKAgcf34JsuLdfXQSmvil", "event_attributes": {"http_request": {"client_ip": "86.13.192.233", "user_agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6 Safari/605.1.15"}}}, "svix_headers": {"svix-id": "msg_2tGieiytrONvuxa6w3kzd5pjOyk", "svix-signature": "v1,HzWvAHpLNqnumsvv8Z7lAXE1Jmimu56LEc+6LFbrfyQ=", "svix-timestamp": "1739984908"}}
e0243039-b32a-46c9-96bd-caebbdcef813	clerk	{"evt": {"data": {"id": "ema_346Clxkj3GfY8F9sHE5RSJWMVOU", "body": "<!DOCTYPE html PUBLIC \\"-//W3C//DTD XHTML 1.0 Strict//EN\\" \\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\\">\\n<html xmlns=\\"http://www.w3.org/1999/xhtml\\">\\n\\n    <head>\\n        <meta http-equiv=\\"Content-Type\\" content=\\"text/html; charset=utf-8\\">\\n        <meta name=\\"viewport\\" content=\\"width=device-width, initial-scale=1.0\\">\\n        <title>295819 is your Natural Healing Commune verification code</title>\\n        <style type=\\"text/css\\">\\n            #outlook a {\\n                padding: 0\\n            }\\n\\n            .ExternalClass {\\n                width: 100%\\n            }\\n\\n            .ExternalClass,\\n            .ExternalClass p,\\n            .ExternalClass span,\\n            .ExternalClass font,\\n            .ExternalClass td,\\n            .ExternalClass div {\\n                line-height: 100%\\n            }\\n\\n            body,\\n            table,\\n            td,\\n            a {\\n                -webkit-text-size-adjust: 100%;\\n                -ms-text-size-adjust: 100%\\n            }\\n\\n            table,\\n            td {\\n                mso-table-lspace: 0;\\n                mso-table-rspace: 0\\n            }\\n\\n            img {\\n                -ms-interpolation-mode: bicubic\\n            }\\n\\n            img {\\n                border: 0;\\n                outline: none;\\n                text-decoration: none\\n            }\\n\\n            a img {\\n                border: none\\n            }\\n\\n            td img {\\n                vertical-align: top\\n            }\\n\\n            table,\\n            table td {\\n                border-collapse: collapse\\n            }\\n\\n            body {\\n                margin: 0;\\n                padding: 0;\\n                width: 100% !important\\n            }\\n\\n            .mobile-spacer {\\n                width: 0;\\n                display: none\\n            }\\n\\n            @media all and (max-width:639px) {\\n                .container {\\n                    width: 100% !important;\\n                    max-width: 600px !important\\n                }\\n\\n                .mobile {\\n                    width: auto !important;\\n                    max-width: 100% !important;\\n                    display: block !important\\n                }\\n\\n                .mobile-center {\\n                    text-align: center !important\\n                }\\n\\n                .mobile-right {\\n                    text-align: right !important\\n                }\\n\\n                .mobile-left {\\n                    text-align: left !important;\\n                }\\n\\n                .mobile-hidden {\\n                    max-height: 0;\\n                    display: none !important;\\n                    mso-hide: all;\\n                    overflow: hidden\\n                }\\n\\n                .mobile-spacer {\\n                    width: auto !important;\\n                    display: table !important\\n                }\\n\\n                .mobile-image,\\n                .mobile-image img {\\n                    height: auto !important;\\n                    max-width: 600px !important;\\n                    width: 100% !important\\n                }\\n            }\\n        </style>\\n        <!--[if mso]><style type=\\"text/css\\">body, table, td, a { font-family: Arial, Helvetica, sans-serif !important; }</style><![endif]-->\\n    </head>\\n\\n    <body style=\\"font-family: Helvetica, Arial, sans-serif; margin: 0px; padding: 0px; background-color: #ffffff;\\">\\n        <span style=\\"color: transparent; display: none; height: 0px; max-height: 0px; max-width: 0px; opacity: 0; overflow: hidden; visibility: hidden; width: 0px;\\">Your Natural Healing Commune verification code</span>\\n        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"body\\" style=\\"width: 100%;\\">\\n            <tbody>\\n                <tr>\\n                    <td align=\\"center\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 48px 32px;\\">\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"header container\\" style=\\"width: 600px;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 16px 32px;\\">\\n                                        <p style=\\"padding: 0px; margin: 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 24px; line-height: 36px;\\">\\n                                            Natural Healing Commune\\n                                        </p>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"main container\\" style=\\"width: 600px; border-collapse: separate;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#fff\\" style=\\"vertical-align: top; line-height: 1; background-color: #ffffff; border-radius: 0px;\\">\\n                                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"block\\" style=\\"width: 100%; border-collapse: separate;\\">\\n                                            <tbody>\\n                                                <tr>\\n                                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#ffffff\\" style=\\"vertical-align: top; line-height: 1; padding: 32px 32px 48px; background-color: #ffffff; border-radius: 0px;\\">\\n                                                        <h1 class=\\"h1\\" align=\\"left\\" style=\\"padding: 0px; margin: 0px; font-style: normal; font-family: Helvetica, Arial, sans-serif; font-size: 32px; line-height: 39px; color: #000000; font-weight: bold;\\"> Verification code </h1>\\n                                                        <p align=\\"left\\" style=\\"padding: 0px; margin: 32px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> Enter the following verification code when prompted: </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 40px; line-height: 60px;\\">\\n                                                            <b>295819</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> To protect your account, do not share this code. </p>\\n                                                        <p style=\\"padding: 0px; margin: 64px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\">\\n                                                            <b>Didn't request this?</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 4px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> This code was requested from <b>188.95.206.220, Darlington, GB</b> at <b>15 October 2025, 10:39 UTC</b>. If you didn't make this request, you can safely ignore this email. </p>\\n                                                    </td>\\n                                                </tr>\\n                                            </tbody>\\n                                        </table>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                    </td>\\n                </tr>\\n            </tbody>\\n        </table>\\n    </body>\\n\\n</html>", "data": {"app": {"url": "https://settling-monarch-25.accounts.dev", "name": "Natural Healing Commune", "logo_url": null, "domain_name": "settling.monarch-25.lcl.dev", "logo_image_url": ""}, "user": {"public_metadata": null, "public_metadata_fallback": ""}, "theme": {"primary_color": "#6c47ff", "button_text_color": "#ffffff", "show_clerk_branding": true}, "otp_code": "295819", "requested_at": "15 October 2025, 10:39 UTC", "requested_by": "Chrome, Windows", "requested_from": "188.95.206.220, Darlington, GB"}, "slug": "verification_code", "object": "email", "status": "queued", "subject": "[Development] 295819 is your verification code", "user_id": null, "body_plain": "295819 is your OTP code for Natural Healing Commune.\\n\\nDo not share this with anyone.\\n\\nIt was requested at 15 October 2025, 10:39 UTC. If you did not request this, please ignore this email.\\n", "from_email_name": "notifications", "email_address_id": "idn_346Cm1hSdv4aU8V0k1lM0Li8RNc", "to_email_address": "cheryl@dashmedia.co.uk", "delivered_by_clerk": true, "reply_to_email_name": null}, "type": "email.created", "object": "event", "timestamp": 1760524789556, "instance_id": "ins_2dJJipJKAgcf34JsuLdfXQSmvil", "event_attributes": {"http_request": {"client_ip": "188.95.206.220", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36"}}}, "svix_headers": {"svix-id": "msg_346Cm3FncPUYMzvGqVcAQfJoatT", "svix-signature": "v1,cxyF9yyjJ1AfQBm4vi4vBv50VM/sbZ2Iwazozs+GDfs=", "svix-timestamp": "1760524789"}}
1e1a06e6-3d3f-420b-80a7-1c82b2728198	clerk	{"evt": {"data": {"id": "user_346Cocd3nMMOYxxldRvQBqBL9Ze", "banned": false, "locale": null, "locked": false, "object": "user", "passkeys": [], "username": "cdtest", "has_image": false, "image_url": "https://img.clerk.com/eyJ0eXBlIjoiZGVmYXVsdCIsImlpZCI6Imluc18yZEpKaXBKS0FnY2YzNEpzdUxkZlhRU212aWwiLCJyaWQiOiJ1c2VyXzM0NkNvY2Qzbk1NT1l4eGxkUnZRQnFCTDlaZSJ9", "last_name": null, "created_at": 1760524810366, "first_name": null, "updated_at": 1760524810387, "external_id": null, "totp_enabled": false, "web3_wallets": [], "phone_numbers": [], "saml_accounts": [], "last_active_at": 1760524810365, "mfa_enabled_at": null, "email_addresses": [{"id": "idn_346Cm1hSdv4aU8V0k1lM0Li8RNc", "object": "email_address", "reserved": false, "linked_to": [], "created_at": 1760524789162, "updated_at": 1760524810370, "verification": {"object": "verification_otp", "status": "verified", "attempts": 1, "strategy": "email_code", "expire_at": 1760525389544}, "email_address": "cheryl@dashmedia.co.uk", "matches_sso_connection": false}], "last_sign_in_at": null, "mfa_disabled_at": null, "public_metadata": {}, "unsafe_metadata": {"language": "en", "membershipType": "personal"}, "password_enabled": true, "private_metadata": {}, "external_accounts": [], "legal_accepted_at": null, "profile_image_url": "https://www.gravatar.com/avatar?d=mp", "two_factor_enabled": false, "backup_code_enabled": false, "delete_self_enabled": true, "enterprise_accounts": [], "primary_web3_wallet_id": null, "primary_phone_number_id": null, "primary_email_address_id": "idn_346Cm1hSdv4aU8V0k1lM0Li8RNc", "lockout_expires_in_seconds": null, "create_organization_enabled": true, "verification_attempts_remaining": 100}, "type": "user.created", "object": "event", "timestamp": 1760524810408, "instance_id": "ins_2dJJipJKAgcf34JsuLdfXQSmvil", "event_attributes": {"http_request": {"client_ip": "188.95.206.220", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36"}}}, "svix_headers": {"svix-id": "msg_346CofRjkj5Me0zWo30EYHUEAbH", "svix-signature": "v1,j0b2dh7peoaSZ9HRfJxrXXyeUC7ROd7OPaYNJ1uoz3U=", "svix-timestamp": "1760524810"}}
2ab3a229-57ea-4e4a-8e25-9e07e95c76c5	clerk	{"evt": {"data": {"id": "ema_34Eim44MSX0IpMEsnlMkAIGXVCA", "body": "<!DOCTYPE html PUBLIC \\"-//W3C//DTD XHTML 1.0 Strict//EN\\" \\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\\">\\n<html xmlns=\\"http://www.w3.org/1999/xhtml\\">\\n\\n    <head>\\n        <meta http-equiv=\\"Content-Type\\" content=\\"text/html; charset=utf-8\\">\\n        <meta name=\\"viewport\\" content=\\"width=device-width, initial-scale=1.0\\">\\n        <title>792144 is your Natural Healing Commune verification code</title>\\n        <style type=\\"text/css\\">\\n            #outlook a {\\n                padding: 0\\n            }\\n\\n            .ExternalClass {\\n                width: 100%\\n            }\\n\\n            .ExternalClass,\\n            .ExternalClass p,\\n            .ExternalClass span,\\n            .ExternalClass font,\\n            .ExternalClass td,\\n            .ExternalClass div {\\n                line-height: 100%\\n            }\\n\\n            body,\\n            table,\\n            td,\\n            a {\\n                -webkit-text-size-adjust: 100%;\\n                -ms-text-size-adjust: 100%\\n            }\\n\\n            table,\\n            td {\\n                mso-table-lspace: 0;\\n                mso-table-rspace: 0\\n            }\\n\\n            img {\\n                -ms-interpolation-mode: bicubic\\n            }\\n\\n            img {\\n                border: 0;\\n                outline: none;\\n                text-decoration: none\\n            }\\n\\n            a img {\\n                border: none\\n            }\\n\\n            td img {\\n                vertical-align: top\\n            }\\n\\n            table,\\n            table td {\\n                border-collapse: collapse\\n            }\\n\\n            body {\\n                margin: 0;\\n                padding: 0;\\n                width: 100% !important\\n            }\\n\\n            .mobile-spacer {\\n                width: 0;\\n                display: none\\n            }\\n\\n            @media all and (max-width:639px) {\\n                .container {\\n                    width: 100% !important;\\n                    max-width: 600px !important\\n                }\\n\\n                .mobile {\\n                    width: auto !important;\\n                    max-width: 100% !important;\\n                    display: block !important\\n                }\\n\\n                .mobile-center {\\n                    text-align: center !important\\n                }\\n\\n                .mobile-right {\\n                    text-align: right !important\\n                }\\n\\n                .mobile-left {\\n                    text-align: left !important;\\n                }\\n\\n                .mobile-hidden {\\n                    max-height: 0;\\n                    display: none !important;\\n                    mso-hide: all;\\n                    overflow: hidden\\n                }\\n\\n                .mobile-spacer {\\n                    width: auto !important;\\n                    display: table !important\\n                }\\n\\n                .mobile-image,\\n                .mobile-image img {\\n                    height: auto !important;\\n                    max-width: 600px !important;\\n                    width: 100% !important\\n                }\\n            }\\n        </style>\\n        <!--[if mso]><style type=\\"text/css\\">body, table, td, a { font-family: Arial, Helvetica, sans-serif !important; }</style><![endif]-->\\n    </head>\\n\\n    <body style=\\"font-family: Helvetica, Arial, sans-serif; margin: 0px; padding: 0px; background-color: #ffffff;\\">\\n        <span style=\\"color: transparent; display: none; height: 0px; max-height: 0px; max-width: 0px; opacity: 0; overflow: hidden; visibility: hidden; width: 0px;\\">Your Natural Healing Commune verification code</span>\\n        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"body\\" style=\\"width: 100%;\\">\\n            <tbody>\\n                <tr>\\n                    <td align=\\"center\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 48px 32px;\\">\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"header container\\" style=\\"width: 600px;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 16px 32px;\\">\\n                                        <p style=\\"padding: 0px; margin: 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 24px; line-height: 36px;\\">\\n                                            Natural Healing Commune\\n                                        </p>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"main container\\" style=\\"width: 600px; border-collapse: separate;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#fff\\" style=\\"vertical-align: top; line-height: 1; background-color: #ffffff; border-radius: 0px;\\">\\n                                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"block\\" style=\\"width: 100%; border-collapse: separate;\\">\\n                                            <tbody>\\n                                                <tr>\\n                                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#ffffff\\" style=\\"vertical-align: top; line-height: 1; padding: 32px 32px 48px; background-color: #ffffff; border-radius: 0px;\\">\\n                                                        <h1 class=\\"h1\\" align=\\"left\\" style=\\"padding: 0px; margin: 0px; font-style: normal; font-family: Helvetica, Arial, sans-serif; font-size: 32px; line-height: 39px; color: #000000; font-weight: bold;\\"> Verification code </h1>\\n                                                        <p align=\\"left\\" style=\\"padding: 0px; margin: 32px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> Enter the following verification code when prompted: </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 40px; line-height: 60px;\\">\\n                                                            <b>792144</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> To protect your account, do not share this code. </p>\\n                                                        <p style=\\"padding: 0px; margin: 64px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\">\\n                                                            <b>Didn't request this?</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 4px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> This code was requested from <b>86.13.192.233, Brighton, GB</b> at <b>18 October 2025, 11:01 UTC</b>. If you didn't make this request, you can safely ignore this email. </p>\\n                                                    </td>\\n                                                </tr>\\n                                            </tbody>\\n                                        </table>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                    </td>\\n                </tr>\\n            </tbody>\\n        </table>\\n    </body>\\n\\n</html>", "data": {"app": {"url": "https://settling-monarch-25.accounts.dev", "name": "Natural Healing Commune", "logo_url": null, "domain_name": "settling.monarch-25.lcl.dev", "logo_image_url": ""}, "user": {"email_address": "martina@martinasmassage.co.uk", "public_metadata": null, "public_metadata_fallback": ""}, "theme": {"primary_color": "#6c47ff", "button_text_color": "#ffffff", "show_clerk_branding": true}, "otp_code": "792144", "requested_at": "18 October 2025, 11:01 UTC", "requested_by": "Safari, Macintosh", "requested_from": "86.13.192.233, Brighton, GB"}, "slug": "verification_code", "object": "email", "status": "queued", "subject": "[Development] 792144 is your verification code", "user_id": null, "body_plain": "792144 is your OTP code for Natural Healing Commune.\\n\\nDo not share this with anyone.\\n\\nIt was requested at 18 October 2025, 11:01 UTC. If you did not request this, please ignore this email.\\n", "from_email_name": "notifications", "email_address_id": "idn_34Eim31ci5k5NslkhsVb64VXMO3", "to_email_address": "martina@martinasmassage.co.uk", "delivered_by_clerk": true, "reply_to_email_name": null}, "type": "email.created", "object": "event", "timestamp": 1760785287523, "instance_id": "ins_2dJJipJKAgcf34JsuLdfXQSmvil", "event_attributes": {"http_request": {"client_ip": "86.13.192.233", "user_agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15"}}}, "svix_headers": {"svix-id": "msg_34Eim7nOoQNYawMvltqCrfpGlEF", "svix-signature": "v1,Y4DlJtMaQXEGZW9ZRzXiSn/k0t1kn16sp0DE/hpuyE0=", "svix-timestamp": "1760785287"}}
9686383d-6dfe-42f8-aa16-a35d50786fcb	clerk	{"evt": {"data": {"id": "user_34EipLUzmye3vVDhkN9mBiUwYbF", "banned": false, "locale": null, "locked": false, "object": "user", "passkeys": [], "username": null, "has_image": false, "image_url": "https://img.clerk.com/eyJ0eXBlIjoiZGVmYXVsdCIsImlpZCI6Imluc18yZEpKaXBKS0FnY2YzNEpzdUxkZlhRU212aWwiLCJyaWQiOiJ1c2VyXzM0RWlwTFV6bXllM3ZWRGhrTjltQmlVd1liRiIsImluaXRpYWxzIjoiTSJ9", "last_name": null, "created_at": 1760785313595, "first_name": "Martina", "updated_at": 1760785313611, "external_id": null, "totp_enabled": false, "web3_wallets": [], "phone_numbers": [], "saml_accounts": [], "last_active_at": 1760785313594, "mfa_enabled_at": null, "email_addresses": [{"id": "idn_34Eim31ci5k5NslkhsVb64VXMO3", "object": "email_address", "reserved": false, "linked_to": [], "created_at": 1760785287125, "updated_at": 1760785313599, "verification": {"object": "verification_otp", "status": "verified", "attempts": 1, "strategy": "email_code", "expire_at": 1760785887514}, "email_address": "martina@martinasmassage.co.uk", "matches_sso_connection": false}], "last_sign_in_at": null, "mfa_disabled_at": null, "public_metadata": {}, "unsafe_metadata": {"language": "en", "membershipType": "professional"}, "password_enabled": true, "private_metadata": {}, "external_accounts": [], "legal_accepted_at": null, "profile_image_url": "https://www.gravatar.com/avatar?d=mp", "two_factor_enabled": false, "backup_code_enabled": false, "delete_self_enabled": true, "enterprise_accounts": [], "primary_web3_wallet_id": null, "primary_phone_number_id": null, "primary_email_address_id": "idn_34Eim31ci5k5NslkhsVb64VXMO3", "lockout_expires_in_seconds": null, "create_organization_enabled": true, "verification_attempts_remaining": 100}, "type": "user.created", "object": "event", "timestamp": 1760785313629, "instance_id": "ins_2dJJipJKAgcf34JsuLdfXQSmvil", "event_attributes": {"http_request": {"client_ip": "86.13.192.233", "user_agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.6 Safari/605.1.15"}}}, "svix_headers": {"svix-id": "msg_34EipOmghQROftkICUlV1qQY8Gl", "svix-signature": "v1,JOECwWwjfKuIJEs0sofe6ImuhScOuorZXf+OPgZ83m8=", "svix-timestamp": "1760785313"}}
c68c4876-498d-489d-9fd1-a1107686b566	clerk	{"evt": {"data": {"id": "ema_34jRcDe3K7uS9688iWLqicjf88Q", "body": "<!DOCTYPE html PUBLIC \\"-//W3C//DTD XHTML 1.0 Strict//EN\\" \\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\\">\\n<html xmlns=\\"http://www.w3.org/1999/xhtml\\">\\n\\n    <head>\\n        <meta http-equiv=\\"Content-Type\\" content=\\"text/html; charset=utf-8\\">\\n        <meta name=\\"viewport\\" content=\\"width=device-width, initial-scale=1.0\\">\\n        <title>510420 is your Natural Healing Commune verification code</title>\\n        <style type=\\"text/css\\">\\n            #outlook a {\\n                padding: 0\\n            }\\n\\n            .ExternalClass {\\n                width: 100%\\n            }\\n\\n            .ExternalClass,\\n            .ExternalClass p,\\n            .ExternalClass span,\\n            .ExternalClass font,\\n            .ExternalClass td,\\n            .ExternalClass div {\\n                line-height: 100%\\n            }\\n\\n            body,\\n            table,\\n            td,\\n            a {\\n                -webkit-text-size-adjust: 100%;\\n                -ms-text-size-adjust: 100%\\n            }\\n\\n            table,\\n            td {\\n                mso-table-lspace: 0;\\n                mso-table-rspace: 0\\n            }\\n\\n            img {\\n                -ms-interpolation-mode: bicubic\\n            }\\n\\n            img {\\n                border: 0;\\n                outline: none;\\n                text-decoration: none\\n            }\\n\\n            a img {\\n                border: none\\n            }\\n\\n            td img {\\n                vertical-align: top\\n            }\\n\\n            table,\\n            table td {\\n                border-collapse: collapse\\n            }\\n\\n            body {\\n                margin: 0;\\n                padding: 0;\\n                width: 100% !important\\n            }\\n\\n            .mobile-spacer {\\n                width: 0;\\n                display: none\\n            }\\n\\n            @media all and (max-width:639px) {\\n                .container {\\n                    width: 100% !important;\\n                    max-width: 600px !important\\n                }\\n\\n                .mobile {\\n                    width: auto !important;\\n                    max-width: 100% !important;\\n                    display: block !important\\n                }\\n\\n                .mobile-center {\\n                    text-align: center !important\\n                }\\n\\n                .mobile-right {\\n                    text-align: right !important\\n                }\\n\\n                .mobile-left {\\n                    text-align: left !important;\\n                }\\n\\n                .mobile-hidden {\\n                    max-height: 0;\\n                    display: none !important;\\n                    mso-hide: all;\\n                    overflow: hidden\\n                }\\n\\n                .mobile-spacer {\\n                    width: auto !important;\\n                    display: table !important\\n                }\\n\\n                .mobile-image,\\n                .mobile-image img {\\n                    height: auto !important;\\n                    max-width: 600px !important;\\n                    width: 100% !important\\n                }\\n            }\\n        </style>\\n        <!--[if mso]><style type=\\"text/css\\">body, table, td, a { font-family: Arial, Helvetica, sans-serif !important; }</style><![endif]-->\\n    </head>\\n\\n    <body style=\\"font-family: Helvetica, Arial, sans-serif; margin: 0px; padding: 0px; background-color: #ffffff;\\">\\n        <span style=\\"color: transparent; display: none; height: 0px; max-height: 0px; max-width: 0px; opacity: 0; overflow: hidden; visibility: hidden; width: 0px;\\">Your Natural Healing Commune verification code</span>\\n        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"body\\" style=\\"width: 100%;\\">\\n            <tbody>\\n                <tr>\\n                    <td align=\\"center\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 48px 32px;\\">\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"header container\\" style=\\"width: 600px;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 16px 32px;\\">\\n                                        <p style=\\"padding: 0px; margin: 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 24px; line-height: 36px;\\">\\n                                            Natural Healing Commune\\n                                        </p>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"main container\\" style=\\"width: 600px; border-collapse: separate;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#fff\\" style=\\"vertical-align: top; line-height: 1; background-color: #ffffff; border-radius: 0px;\\">\\n                                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"block\\" style=\\"width: 100%; border-collapse: separate;\\">\\n                                            <tbody>\\n                                                <tr>\\n                                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#ffffff\\" style=\\"vertical-align: top; line-height: 1; padding: 32px 32px 48px; background-color: #ffffff; border-radius: 0px;\\">\\n                                                        <h1 class=\\"h1\\" align=\\"left\\" style=\\"padding: 0px; margin: 0px; font-style: normal; font-family: Helvetica, Arial, sans-serif; font-size: 32px; line-height: 39px; color: #000000; font-weight: bold;\\"> Verification code </h1>\\n                                                        <p align=\\"left\\" style=\\"padding: 0px; margin: 32px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> Enter the following verification code when prompted: </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 40px; line-height: 60px;\\">\\n                                                            <b>510420</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> To protect your account, do not share this code. </p>\\n                                                        <p style=\\"padding: 0px; margin: 64px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\">\\n                                                            <b>Didn't request this?</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 4px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> This code was requested from <b>2a00:23c5:d02c:2b01:7da2:f00c:8e67:e0a8, London, GB</b> at <b>29 October 2025, 08:04 UTC</b>. If you didn't make this request, you can safely ignore this email. </p>\\n                                                    </td>\\n                                                </tr>\\n                                            </tbody>\\n                                        </table>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                    </td>\\n                </tr>\\n            </tbody>\\n        </table>\\n    </body>\\n\\n</html>", "data": {"app": {"url": "https://settling-monarch-25.accounts.dev", "name": "Natural Healing Commune", "logo_url": null, "domain_name": "settling.monarch-25.lcl.dev", "logo_image_url": ""}, "user": {"email_address": "johnspaul63@gmail.com", "public_metadata": null, "public_metadata_fallback": ""}, "theme": {"primary_color": "#6c47ff", "button_text_color": "#ffffff", "show_clerk_branding": true}, "otp_code": "510420", "requested_at": "29 October 2025, 08:04 UTC", "requested_by": "Chrome, Windows", "requested_from": "2a00:23c5:d02c:2b01:7da2:f00c:8e67:e0a8, London, GB"}, "slug": "verification_code", "object": "email", "status": "queued", "subject": "[Development] 510420 is your verification code", "user_id": null, "body_plain": "510420 is your OTP code for Natural Healing Commune.\\n\\nDo not share this with anyone.\\n\\nIt was requested at 29 October 2025, 08:04 UTC. If you did not request this, please ignore this email.\\n", "from_email_name": "notifications", "email_address_id": "idn_34jRcElCpaJtKAJvDn1IkMwYTWF", "to_email_address": "johnspaul63@gmail.com", "delivered_by_clerk": true, "reply_to_email_name": null}, "type": "email.created", "object": "event", "timestamp": 1761725071809, "instance_id": "ins_2dJJipJKAgcf34JsuLdfXQSmvil", "event_attributes": {"http_request": {"client_ip": "2a00:23c5:d02c:2b01:7da2:f00c:8e67:e0a8", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36"}}}, "svix_headers": {"svix-id": "msg_34jRcH5IHcYzlRIphVC490bF6qt", "svix-signature": "v1,YJRJ/vIxBeMIs+2lVDnkRIrZeu4QguWoa2w+TjlAeCA=", "svix-timestamp": "1761725072"}}
ae622fe9-2846-4cb6-aff9-3ec339c74737	clerk	{"evt": {"data": {"id": "user_34jRfRPxab2hR9GYJbOr6HImQQN", "banned": false, "locale": null, "locked": false, "object": "user", "passkeys": [], "username": "daddyjohn", "has_image": false, "image_url": "https://img.clerk.com/eyJ0eXBlIjoiZGVmYXVsdCIsImlpZCI6Imluc18yZEpKaXBKS0FnY2YzNEpzdUxkZlhRU212aWwiLCJyaWQiOiJ1c2VyXzM0alJmUlB4YWIyaFI5R1lKYk9yNkhJbVFRTiJ9", "last_name": null, "created_at": 1761725097933, "first_name": null, "updated_at": 1761725097982, "external_id": null, "totp_enabled": false, "web3_wallets": [], "phone_numbers": [], "saml_accounts": [], "last_active_at": 1761725097932, "mfa_enabled_at": null, "email_addresses": [{"id": "idn_34jRcElCpaJtKAJvDn1IkMwYTWF", "object": "email_address", "reserved": false, "linked_to": [], "created_at": 1761725071414, "updated_at": 1761725097937, "verification": {"object": "verification_otp", "status": "verified", "attempts": 1, "strategy": "email_code", "expire_at": 1761725671796}, "email_address": "johnspaul63@gmail.com", "matches_sso_connection": false}], "last_sign_in_at": null, "mfa_disabled_at": null, "public_metadata": {}, "unsafe_metadata": {"language": "en", "membershipType": "personal"}, "password_enabled": true, "private_metadata": {}, "external_accounts": [], "legal_accepted_at": null, "profile_image_url": "https://www.gravatar.com/avatar?d=mp", "two_factor_enabled": false, "backup_code_enabled": false, "delete_self_enabled": true, "enterprise_accounts": [], "primary_web3_wallet_id": null, "primary_phone_number_id": null, "primary_email_address_id": "idn_34jRcElCpaJtKAJvDn1IkMwYTWF", "lockout_expires_in_seconds": null, "create_organization_enabled": true, "verification_attempts_remaining": 100}, "type": "user.created", "object": "event", "timestamp": 1761725098013, "instance_id": "ins_2dJJipJKAgcf34JsuLdfXQSmvil", "event_attributes": {"http_request": {"client_ip": "2a00:23c5:d02c:2b01:7da2:f00c:8e67:e0a8", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36"}}}, "svix_headers": {"svix-id": "msg_34jRfYkRP21YpoN3U5V51Ivui47", "svix-signature": "v1,c8oJR3O5FRUiY9gy1JJB4GJ9J6Mg/428XPuhXdNqXTs=", "svix-timestamp": "1761725098"}}
cc26e61a-824b-4459-95ad-35837dfaa994	clerk	{"evt": {"data": {"id": "ema_34jSgzL54T2tbDYrDUAc7EluR8I", "body": "<!DOCTYPE html PUBLIC \\"-//W3C//DTD XHTML 1.0 Strict//EN\\" \\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\\">\\n<html xmlns=\\"http://www.w3.org/1999/xhtml\\">\\n\\n    <head>\\n        <meta http-equiv=\\"Content-Type\\" content=\\"text/html; charset=utf-8\\">\\n        <meta name=\\"viewport\\" content=\\"width=device-width, initial-scale=1.0\\">\\n        <title>106435 is your Natural Healing Commune verification code</title>\\n        <style type=\\"text/css\\">\\n            #outlook a {\\n                padding: 0\\n            }\\n\\n            .ExternalClass {\\n                width: 100%\\n            }\\n\\n            .ExternalClass,\\n            .ExternalClass p,\\n            .ExternalClass span,\\n            .ExternalClass font,\\n            .ExternalClass td,\\n            .ExternalClass div {\\n                line-height: 100%\\n            }\\n\\n            body,\\n            table,\\n            td,\\n            a {\\n                -webkit-text-size-adjust: 100%;\\n                -ms-text-size-adjust: 100%\\n            }\\n\\n            table,\\n            td {\\n                mso-table-lspace: 0;\\n                mso-table-rspace: 0\\n            }\\n\\n            img {\\n                -ms-interpolation-mode: bicubic\\n            }\\n\\n            img {\\n                border: 0;\\n                outline: none;\\n                text-decoration: none\\n            }\\n\\n            a img {\\n                border: none\\n            }\\n\\n            td img {\\n                vertical-align: top\\n            }\\n\\n            table,\\n            table td {\\n                border-collapse: collapse\\n            }\\n\\n            body {\\n                margin: 0;\\n                padding: 0;\\n                width: 100% !important\\n            }\\n\\n            .mobile-spacer {\\n                width: 0;\\n                display: none\\n            }\\n\\n            @media all and (max-width:639px) {\\n                .container {\\n                    width: 100% !important;\\n                    max-width: 600px !important\\n                }\\n\\n                .mobile {\\n                    width: auto !important;\\n                    max-width: 100% !important;\\n                    display: block !important\\n                }\\n\\n                .mobile-center {\\n                    text-align: center !important\\n                }\\n\\n                .mobile-right {\\n                    text-align: right !important\\n                }\\n\\n                .mobile-left {\\n                    text-align: left !important;\\n                }\\n\\n                .mobile-hidden {\\n                    max-height: 0;\\n                    display: none !important;\\n                    mso-hide: all;\\n                    overflow: hidden\\n                }\\n\\n                .mobile-spacer {\\n                    width: auto !important;\\n                    display: table !important\\n                }\\n\\n                .mobile-image,\\n                .mobile-image img {\\n                    height: auto !important;\\n                    max-width: 600px !important;\\n                    width: 100% !important\\n                }\\n            }\\n        </style>\\n        <!--[if mso]><style type=\\"text/css\\">body, table, td, a { font-family: Arial, Helvetica, sans-serif !important; }</style><![endif]-->\\n    </head>\\n\\n    <body style=\\"font-family: Helvetica, Arial, sans-serif; margin: 0px; padding: 0px; background-color: #ffffff;\\">\\n        <span style=\\"color: transparent; display: none; height: 0px; max-height: 0px; max-width: 0px; opacity: 0; overflow: hidden; visibility: hidden; width: 0px;\\">Your Natural Healing Commune verification code</span>\\n        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"body\\" style=\\"width: 100%;\\">\\n            <tbody>\\n                <tr>\\n                    <td align=\\"center\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 48px 32px;\\">\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"header container\\" style=\\"width: 600px;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 16px 32px;\\">\\n                                        <p style=\\"padding: 0px; margin: 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 24px; line-height: 36px;\\">\\n                                            Natural Healing Commune\\n                                        </p>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"main container\\" style=\\"width: 600px; border-collapse: separate;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#fff\\" style=\\"vertical-align: top; line-height: 1; background-color: #ffffff; border-radius: 0px;\\">\\n                                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"block\\" style=\\"width: 100%; border-collapse: separate;\\">\\n                                            <tbody>\\n                                                <tr>\\n                                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#ffffff\\" style=\\"vertical-align: top; line-height: 1; padding: 32px 32px 48px; background-color: #ffffff; border-radius: 0px;\\">\\n                                                        <h1 class=\\"h1\\" align=\\"left\\" style=\\"padding: 0px; margin: 0px; font-style: normal; font-family: Helvetica, Arial, sans-serif; font-size: 32px; line-height: 39px; color: #000000; font-weight: bold;\\"> Verification code </h1>\\n                                                        <p align=\\"left\\" style=\\"padding: 0px; margin: 32px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> Enter the following verification code when prompted: </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 40px; line-height: 60px;\\">\\n                                                            <b>106435</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> To protect your account, do not share this code. </p>\\n                                                        <p style=\\"padding: 0px; margin: 64px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\">\\n                                                            <b>Didn't request this?</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 4px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> This code was requested from <b>2a00:23c5:d02c:2b01:7da2:f00c:8e67:e0a8, London, GB</b> at <b>29 October 2025, 08:13 UTC</b>. If you didn't make this request, you can safely ignore this email. </p>\\n                                                    </td>\\n                                                </tr>\\n                                            </tbody>\\n                                        </table>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                    </td>\\n                </tr>\\n            </tbody>\\n        </table>\\n    </body>\\n\\n</html>", "data": {"app": {"url": "https://settling-monarch-25.accounts.dev", "name": "Natural Healing Commune", "logo_url": null, "domain_name": "settling.monarch-25.lcl.dev", "logo_image_url": ""}, "user": {"email_address": "johnpaulwebdev@gmail.com", "public_metadata": null, "public_metadata_fallback": ""}, "theme": {"primary_color": "#6c47ff", "button_text_color": "#ffffff", "show_clerk_branding": true}, "otp_code": "106435", "requested_at": "29 October 2025, 08:13 UTC", "requested_by": "Chrome, Windows", "requested_from": "2a00:23c5:d02c:2b01:7da2:f00c:8e67:e0a8, London, GB"}, "slug": "verification_code", "object": "email", "status": "queued", "subject": "[Development] 106435 is your verification code", "user_id": null, "body_plain": "106435 is your OTP code for Natural Healing Commune.\\n\\nDo not share this with anyone.\\n\\nIt was requested at 29 October 2025, 08:13 UTC. If you did not request this, please ignore this email.\\n", "from_email_name": "notifications", "email_address_id": "idn_34jSgoNiGXLOsPGPwn9PXXVIOEx", "to_email_address": "johnpaulwebdev@gmail.com", "delivered_by_clerk": true, "reply_to_email_name": null}, "type": "email.created", "object": "event", "timestamp": 1761725602154, "instance_id": "ins_2dJJipJKAgcf34JsuLdfXQSmvil", "event_attributes": {"http_request": {"client_ip": "2a00:23c5:d02c:2b01:7da2:f00c:8e67:e0a8", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36"}}}, "svix_headers": {"svix-id": "msg_34jSgvPStVZXaFCwZsHYslYHiCl", "svix-signature": "v1,7/H1K3PRvjTa2t88Y36jKh38sB/c8ZAhXHhivnStZNM=", "svix-timestamp": "1761725602"}}
3cfb61ac-185f-49f4-8f98-6cdb70088a99	clerk	{"evt": {"data": {"id": "user_34jSnE07nFP1zywInBfZsYIK2fa", "banned": false, "locale": null, "locked": false, "object": "user", "passkeys": [], "username": null, "has_image": false, "image_url": "https://img.clerk.com/eyJ0eXBlIjoiZGVmYXVsdCIsImlpZCI6Imluc18yZEpKaXBKS0FnY2YzNEpzdUxkZlhRU212aWwiLCJyaWQiOiJ1c2VyXzM0alNuRTA3bkZQMXp5d0luQmZac1lJSzJmYSIsImluaXRpYWxzIjoiVFQifQ", "last_name": "the Osteopath", "created_at": 1761725652498, "first_name": "Tim", "updated_at": 1761725652515, "external_id": null, "totp_enabled": false, "web3_wallets": [], "phone_numbers": [], "saml_accounts": [], "last_active_at": 1761725652497, "mfa_enabled_at": null, "email_addresses": [{"id": "idn_34jSgoNiGXLOsPGPwn9PXXVIOEx", "object": "email_address", "reserved": false, "linked_to": [], "created_at": 1761725601773, "updated_at": 1761725652502, "verification": {"object": "verification_otp", "status": "verified", "attempts": 1, "strategy": "email_code", "expire_at": 1761726202141}, "email_address": "johnpaulwebdev@gmail.com", "matches_sso_connection": false}], "last_sign_in_at": null, "mfa_disabled_at": null, "public_metadata": {}, "unsafe_metadata": {"language": "en", "membershipType": "professional"}, "password_enabled": true, "private_metadata": {}, "external_accounts": [], "legal_accepted_at": null, "profile_image_url": "https://www.gravatar.com/avatar?d=mp", "two_factor_enabled": false, "backup_code_enabled": false, "delete_self_enabled": true, "enterprise_accounts": [], "primary_web3_wallet_id": null, "primary_phone_number_id": null, "primary_email_address_id": "idn_34jSgoNiGXLOsPGPwn9PXXVIOEx", "lockout_expires_in_seconds": null, "create_organization_enabled": true, "verification_attempts_remaining": 100}, "type": "user.created", "object": "event", "timestamp": 1761725652540, "instance_id": "ins_2dJJipJKAgcf34JsuLdfXQSmvil", "event_attributes": {"http_request": {"client_ip": "2a00:23c5:d02c:2b01:7da2:f00c:8e67:e0a8", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36"}}}, "svix_headers": {"svix-id": "msg_34jSnFMx24uyoXXBOIZgt3DzVLb", "svix-signature": "v1,btlCldvpxJmgMLiwBliUQi6lJaXW1tgj9+Sk7woYriE=", "svix-timestamp": "1761725652"}}
19819fcd-3c40-4941-9600-7448b6d3b497	clerk	{"evt": {"data": {"id": "ema_34z0pUuAB4imvEpo3vxPlbnIqwh", "body": "<!DOCTYPE html PUBLIC \\"-//W3C//DTD XHTML 1.0 Strict//EN\\" \\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\\">\\n<html xmlns=\\"http://www.w3.org/1999/xhtml\\">\\n\\n    <head>\\n        <meta http-equiv=\\"Content-Type\\" content=\\"text/html; charset=utf-8\\">\\n        <meta name=\\"viewport\\" content=\\"width=device-width, initial-scale=1.0\\">\\n        <title>755508 is your Natural Healing Commune verification code</title>\\n        <style type=\\"text/css\\">\\n            #outlook a {\\n                padding: 0\\n            }\\n\\n            .ExternalClass {\\n                width: 100%\\n            }\\n\\n            .ExternalClass,\\n            .ExternalClass p,\\n            .ExternalClass span,\\n            .ExternalClass font,\\n            .ExternalClass td,\\n            .ExternalClass div {\\n                line-height: 100%\\n            }\\n\\n            body,\\n            table,\\n            td,\\n            a {\\n                -webkit-text-size-adjust: 100%;\\n                -ms-text-size-adjust: 100%\\n            }\\n\\n            table,\\n            td {\\n                mso-table-lspace: 0;\\n                mso-table-rspace: 0\\n            }\\n\\n            img {\\n                -ms-interpolation-mode: bicubic\\n            }\\n\\n            img {\\n                border: 0;\\n                outline: none;\\n                text-decoration: none\\n            }\\n\\n            a img {\\n                border: none\\n            }\\n\\n            td img {\\n                vertical-align: top\\n            }\\n\\n            table,\\n            table td {\\n                border-collapse: collapse\\n            }\\n\\n            body {\\n                margin: 0;\\n                padding: 0;\\n                width: 100% !important\\n            }\\n\\n            .mobile-spacer {\\n                width: 0;\\n                display: none\\n            }\\n\\n            @media all and (max-width:639px) {\\n                .container {\\n                    width: 100% !important;\\n                    max-width: 600px !important\\n                }\\n\\n                .mobile {\\n                    width: auto !important;\\n                    max-width: 100% !important;\\n                    display: block !important\\n                }\\n\\n                .mobile-center {\\n                    text-align: center !important\\n                }\\n\\n                .mobile-right {\\n                    text-align: right !important\\n                }\\n\\n                .mobile-left {\\n                    text-align: left !important;\\n                }\\n\\n                .mobile-hidden {\\n                    max-height: 0;\\n                    display: none !important;\\n                    mso-hide: all;\\n                    overflow: hidden\\n                }\\n\\n                .mobile-spacer {\\n                    width: auto !important;\\n                    display: table !important\\n                }\\n\\n                .mobile-image,\\n                .mobile-image img {\\n                    height: auto !important;\\n                    max-width: 600px !important;\\n                    width: 100% !important\\n                }\\n            }\\n        </style>\\n        <!--[if mso]><style type=\\"text/css\\">body, table, td, a { font-family: Arial, Helvetica, sans-serif !important; }</style><![endif]-->\\n    </head>\\n\\n    <body style=\\"font-family: Helvetica, Arial, sans-serif; margin: 0px; padding: 0px; background-color: #ffffff;\\">\\n        <span style=\\"color: transparent; display: none; height: 0px; max-height: 0px; max-width: 0px; opacity: 0; overflow: hidden; visibility: hidden; width: 0px;\\">Your Natural Healing Commune verification code</span>\\n        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"body\\" style=\\"width: 100%;\\">\\n            <tbody>\\n                <tr>\\n                    <td align=\\"center\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 48px 32px;\\">\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"header container\\" style=\\"width: 600px;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 16px 32px;\\">\\n                                        <p style=\\"padding: 0px; margin: 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 24px; line-height: 36px;\\">\\n                                            Natural Healing Commune\\n                                        </p>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"main container\\" style=\\"width: 600px; border-collapse: separate;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#fff\\" style=\\"vertical-align: top; line-height: 1; background-color: #ffffff; border-radius: 0px;\\">\\n                                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"block\\" style=\\"width: 100%; border-collapse: separate;\\">\\n                                            <tbody>\\n                                                <tr>\\n                                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#ffffff\\" style=\\"vertical-align: top; line-height: 1; padding: 32px 32px 48px; background-color: #ffffff; border-radius: 0px;\\">\\n                                                        <h1 class=\\"h1\\" align=\\"left\\" style=\\"padding: 0px; margin: 0px; font-style: normal; font-family: Helvetica, Arial, sans-serif; font-size: 32px; line-height: 39px; color: #000000; font-weight: bold;\\"> Verification code </h1>\\n                                                        <p align=\\"left\\" style=\\"padding: 0px; margin: 32px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> Enter the following verification code when prompted: </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 40px; line-height: 60px;\\">\\n                                                            <b>755508</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> To protect your account, do not share this code. </p>\\n                                                        <p style=\\"padding: 0px; margin: 64px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\">\\n                                                            <b>Didn't request this?</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 4px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> This code was requested from <b>2a00:23c5:d02c:2b01:c0c4:6fd3:e5a7:a49c, London, GB</b> at <b>03 November 2025, 20:21 UTC</b>. If you didn't make this request, you can safely ignore this email. </p>\\n                                                    </td>\\n                                                </tr>\\n                                            </tbody>\\n                                        </table>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                    </td>\\n                </tr>\\n            </tbody>\\n        </table>\\n    </body>\\n\\n</html>", "data": {"app": {"url": "https://settling-monarch-25.accounts.dev", "name": "Natural Healing Commune", "logo_url": null, "domain_name": "settling.monarch-25.lcl.dev", "logo_image_url": ""}, "user": {"email_address": "johnspaul631@gmail.com", "public_metadata": null, "public_metadata_fallback": ""}, "theme": {"primary_color": "#6c47ff", "button_text_color": "#ffffff", "show_clerk_branding": true}, "otp_code": "755508", "requested_at": "03 November 2025, 20:21 UTC", "requested_by": "Chrome, Windows", "requested_from": "2a00:23c5:d02c:2b01:c0c4:6fd3:e5a7:a49c, London, GB"}, "slug": "verification_code", "object": "email", "status": "queued", "subject": "[Development] 755508 is your verification code", "user_id": null, "body_plain": "755508 is your OTP code for Natural Healing Commune.\\n\\nDo not share this with anyone.\\n\\nIt was requested at 03 November 2025, 20:21 UTC. If you did not request this, please ignore this email.\\n", "from_email_name": "notifications", "email_address_id": "idn_34z0pXRKFjZifIRgpiYg9WzkRrq", "to_email_address": "johnspaul631@gmail.com", "delivered_by_clerk": true, "reply_to_email_name": null}, "type": "email.created", "object": "event", "timestamp": 1762201275865, "instance_id": "ins_2dJJipJKAgcf34JsuLdfXQSmvil", "event_attributes": {"http_request": {"client_ip": "2a00:23c5:d02c:2b01:c0c4:6fd3:e5a7:a49c", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36"}}}, "svix_headers": {"svix-id": "msg_34z0pXpCJCxTF5DDnq3ox78Pzd1", "svix-signature": "v1,gwWsNHCSX64LU/8ws7WTeGgTHJ3T0pkL87AjyALNdik=", "svix-timestamp": "1762201276"}}
2a6f8db5-3628-40fc-9f6a-6631a6e1054e	clerk	{"evt": {"data": {"id": "ema_34z15wH4WoM7ahbPHuxtFsvEfau", "body": "<!DOCTYPE html PUBLIC \\"-//W3C//DTD XHTML 1.0 Strict//EN\\" \\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\\">\\n<html xmlns=\\"http://www.w3.org/1999/xhtml\\">\\n\\n    <head>\\n        <meta http-equiv=\\"Content-Type\\" content=\\"text/html; charset=utf-8\\">\\n        <meta name=\\"viewport\\" content=\\"width=device-width, initial-scale=1.0\\">\\n        <title>148484 is your Natural Healing Commune verification code</title>\\n        <style type=\\"text/css\\">\\n            #outlook a {\\n                padding: 0\\n            }\\n\\n            .ExternalClass {\\n                width: 100%\\n            }\\n\\n            .ExternalClass,\\n            .ExternalClass p,\\n            .ExternalClass span,\\n            .ExternalClass font,\\n            .ExternalClass td,\\n            .ExternalClass div {\\n                line-height: 100%\\n            }\\n\\n            body,\\n            table,\\n            td,\\n            a {\\n                -webkit-text-size-adjust: 100%;\\n                -ms-text-size-adjust: 100%\\n            }\\n\\n            table,\\n            td {\\n                mso-table-lspace: 0;\\n                mso-table-rspace: 0\\n            }\\n\\n            img {\\n                -ms-interpolation-mode: bicubic\\n            }\\n\\n            img {\\n                border: 0;\\n                outline: none;\\n                text-decoration: none\\n            }\\n\\n            a img {\\n                border: none\\n            }\\n\\n            td img {\\n                vertical-align: top\\n            }\\n\\n            table,\\n            table td {\\n                border-collapse: collapse\\n            }\\n\\n            body {\\n                margin: 0;\\n                padding: 0;\\n                width: 100% !important\\n            }\\n\\n            .mobile-spacer {\\n                width: 0;\\n                display: none\\n            }\\n\\n            @media all and (max-width:639px) {\\n                .container {\\n                    width: 100% !important;\\n                    max-width: 600px !important\\n                }\\n\\n                .mobile {\\n                    width: auto !important;\\n                    max-width: 100% !important;\\n                    display: block !important\\n                }\\n\\n                .mobile-center {\\n                    text-align: center !important\\n                }\\n\\n                .mobile-right {\\n                    text-align: right !important\\n                }\\n\\n                .mobile-left {\\n                    text-align: left !important;\\n                }\\n\\n                .mobile-hidden {\\n                    max-height: 0;\\n                    display: none !important;\\n                    mso-hide: all;\\n                    overflow: hidden\\n                }\\n\\n                .mobile-spacer {\\n                    width: auto !important;\\n                    display: table !important\\n                }\\n\\n                .mobile-image,\\n                .mobile-image img {\\n                    height: auto !important;\\n                    max-width: 600px !important;\\n                    width: 100% !important\\n                }\\n            }\\n        </style>\\n        <!--[if mso]><style type=\\"text/css\\">body, table, td, a { font-family: Arial, Helvetica, sans-serif !important; }</style><![endif]-->\\n    </head>\\n\\n    <body style=\\"font-family: Helvetica, Arial, sans-serif; margin: 0px; padding: 0px; background-color: #ffffff;\\">\\n        <span style=\\"color: transparent; display: none; height: 0px; max-height: 0px; max-width: 0px; opacity: 0; overflow: hidden; visibility: hidden; width: 0px;\\">Your Natural Healing Commune verification code</span>\\n        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"body\\" style=\\"width: 100%;\\">\\n            <tbody>\\n                <tr>\\n                    <td align=\\"center\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 48px 32px;\\">\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"header container\\" style=\\"width: 600px;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 16px 32px;\\">\\n                                        <p style=\\"padding: 0px; margin: 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 24px; line-height: 36px;\\">\\n                                            Natural Healing Commune\\n                                        </p>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"main container\\" style=\\"width: 600px; border-collapse: separate;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#fff\\" style=\\"vertical-align: top; line-height: 1; background-color: #ffffff; border-radius: 0px;\\">\\n                                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"block\\" style=\\"width: 100%; border-collapse: separate;\\">\\n                                            <tbody>\\n                                                <tr>\\n                                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#ffffff\\" style=\\"vertical-align: top; line-height: 1; padding: 32px 32px 48px; background-color: #ffffff; border-radius: 0px;\\">\\n                                                        <h1 class=\\"h1\\" align=\\"left\\" style=\\"padding: 0px; margin: 0px; font-style: normal; font-family: Helvetica, Arial, sans-serif; font-size: 32px; line-height: 39px; color: #000000; font-weight: bold;\\"> Verification code </h1>\\n                                                        <p align=\\"left\\" style=\\"padding: 0px; margin: 32px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> Enter the following verification code when prompted: </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 40px; line-height: 60px;\\">\\n                                                            <b>148484</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> To protect your account, do not share this code. </p>\\n                                                        <p style=\\"padding: 0px; margin: 64px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\">\\n                                                            <b>Didn't request this?</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 4px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> This code was requested from <b>2a00:23c5:d02c:2b01:c0c4:6fd3:e5a7:a49c, London, GB</b> at <b>03 November 2025, 20:23 UTC</b>. If you didn't make this request, you can safely ignore this email. </p>\\n                                                    </td>\\n                                                </tr>\\n                                            </tbody>\\n                                        </table>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                    </td>\\n                </tr>\\n            </tbody>\\n        </table>\\n    </body>\\n\\n</html>", "data": {"app": {"url": "https://settling-monarch-25.accounts.dev", "name": "Natural Healing Commune", "logo_url": null, "domain_name": "settling.monarch-25.lcl.dev", "logo_image_url": ""}, "user": {"email_address": "john@webandprosper.co.uk", "public_metadata": null, "public_metadata_fallback": ""}, "theme": {"primary_color": "#6c47ff", "button_text_color": "#ffffff", "show_clerk_branding": true}, "otp_code": "148484", "requested_at": "03 November 2025, 20:23 UTC", "requested_by": "Chrome, Windows", "requested_from": "2a00:23c5:d02c:2b01:c0c4:6fd3:e5a7:a49c, London, GB"}, "slug": "verification_code", "object": "email", "status": "queued", "subject": "[Development] 148484 is your verification code", "user_id": null, "body_plain": "148484 is your OTP code for Natural Healing Commune.\\n\\nDo not share this with anyone.\\n\\nIt was requested at 03 November 2025, 20:23 UTC. If you did not request this, please ignore this email.\\n", "from_email_name": "notifications", "email_address_id": "idn_34z15uC9yEpPLucuGWTAyAfQRPw", "to_email_address": "john@webandprosper.co.uk", "delivered_by_clerk": true, "reply_to_email_name": null}, "type": "email.created", "object": "event", "timestamp": 1762201406803, "instance_id": "ins_2dJJipJKAgcf34JsuLdfXQSmvil", "event_attributes": {"http_request": {"client_ip": "2a00:23c5:d02c:2b01:c0c4:6fd3:e5a7:a49c", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36"}}}, "svix_headers": {"svix-id": "msg_34z161xyAy84UzQiaHSqfWx9sZ5", "svix-signature": "v1,vDDm4lGH50isxAsJ/+ch58JBolzrQ/t2bHbk6tTo0Gc=", "svix-timestamp": "1762201407"}}
45e9190d-1a86-4dc7-b1e4-1e9f0f842a27	clerk	{"evt": {"data": {"id": "user_34z18Ae8htIPAjMpdGKU7VLRfzj", "banned": false, "locale": null, "locked": false, "object": "user", "passkeys": [], "username": null, "has_image": false, "image_url": "https://img.clerk.com/eyJ0eXBlIjoiZGVmYXVsdCIsImlpZCI6Imluc18yZEpKaXBKS0FnY2YzNEpzdUxkZlhRU212aWwiLCJyaWQiOiJ1c2VyXzM0ejE4QWU4aHRJUEFqTXBkR0tVN1ZMUmZ6aiIsImluaXRpYWxzIjoiSiJ9", "last_name": null, "created_at": 1762201424075, "first_name": "John", "updated_at": 1762201424096, "external_id": null, "totp_enabled": false, "web3_wallets": [], "phone_numbers": [], "saml_accounts": [], "last_active_at": 1762201424074, "mfa_enabled_at": null, "email_addresses": [{"id": "idn_34z15uC9yEpPLucuGWTAyAfQRPw", "object": "email_address", "reserved": false, "linked_to": [], "created_at": 1762201406319, "updated_at": 1762201424079, "verification": {"object": "verification_otp", "status": "verified", "attempts": 1, "strategy": "email_code", "expire_at": 1762202006788}, "email_address": "john@webandprosper.co.uk", "matches_sso_connection": false}], "last_sign_in_at": null, "mfa_disabled_at": null, "public_metadata": {}, "unsafe_metadata": {"language": "en", "membershipType": "business"}, "password_enabled": true, "private_metadata": {}, "external_accounts": [], "legal_accepted_at": null, "profile_image_url": "https://www.gravatar.com/avatar?d=mp", "two_factor_enabled": false, "backup_code_enabled": false, "delete_self_enabled": true, "enterprise_accounts": [], "primary_web3_wallet_id": null, "primary_phone_number_id": null, "primary_email_address_id": "idn_34z15uC9yEpPLucuGWTAyAfQRPw", "lockout_expires_in_seconds": null, "create_organization_enabled": true, "verification_attempts_remaining": 100}, "type": "user.created", "object": "event", "timestamp": 1762201424120, "instance_id": "ins_2dJJipJKAgcf34JsuLdfXQSmvil", "event_attributes": {"http_request": {"client_ip": "2a00:23c5:d02c:2b01:c0c4:6fd3:e5a7:a49c", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36"}}}, "svix_headers": {"svix-id": "msg_34z18B8l5TUGp4SircWuwvx6kYh", "svix-signature": "v1,JRywvR/a4TF6/7Re0wD71UCQ4smCi/jCZ8wPROgLIHI=", "svix-timestamp": "1762201424"}}
399a9f36-2b08-443c-b9d6-abff5068b752	clerk	{"evt": {"data": {"id": "ema_34z4ugDd7IdaML0chEuzYgmQy88", "body": "<!DOCTYPE html PUBLIC \\"-//W3C//DTD XHTML 1.0 Strict//EN\\" \\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\\">\\n<html xmlns=\\"http://www.w3.org/1999/xhtml\\">\\n\\n    <head>\\n        <meta http-equiv=\\"Content-Type\\" content=\\"text/html; charset=utf-8\\">\\n        <meta name=\\"viewport\\" content=\\"width=device-width, initial-scale=1.0\\">\\n        <title>272571 is your Natural Healing Commune verification code</title>\\n        <style type=\\"text/css\\">\\n            #outlook a {\\n                padding: 0\\n            }\\n\\n            .ExternalClass {\\n                width: 100%\\n            }\\n\\n            .ExternalClass,\\n            .ExternalClass p,\\n            .ExternalClass span,\\n            .ExternalClass font,\\n            .ExternalClass td,\\n            .ExternalClass div {\\n                line-height: 100%\\n            }\\n\\n            body,\\n            table,\\n            td,\\n            a {\\n                -webkit-text-size-adjust: 100%;\\n                -ms-text-size-adjust: 100%\\n            }\\n\\n            table,\\n            td {\\n                mso-table-lspace: 0;\\n                mso-table-rspace: 0\\n            }\\n\\n            img {\\n                -ms-interpolation-mode: bicubic\\n            }\\n\\n            img {\\n                border: 0;\\n                outline: none;\\n                text-decoration: none\\n            }\\n\\n            a img {\\n                border: none\\n            }\\n\\n            td img {\\n                vertical-align: top\\n            }\\n\\n            table,\\n            table td {\\n                border-collapse: collapse\\n            }\\n\\n            body {\\n                margin: 0;\\n                padding: 0;\\n                width: 100% !important\\n            }\\n\\n            .mobile-spacer {\\n                width: 0;\\n                display: none\\n            }\\n\\n            @media all and (max-width:639px) {\\n                .container {\\n                    width: 100% !important;\\n                    max-width: 600px !important\\n                }\\n\\n                .mobile {\\n                    width: auto !important;\\n                    max-width: 100% !important;\\n                    display: block !important\\n                }\\n\\n                .mobile-center {\\n                    text-align: center !important\\n                }\\n\\n                .mobile-right {\\n                    text-align: right !important\\n                }\\n\\n                .mobile-left {\\n                    text-align: left !important;\\n                }\\n\\n                .mobile-hidden {\\n                    max-height: 0;\\n                    display: none !important;\\n                    mso-hide: all;\\n                    overflow: hidden\\n                }\\n\\n                .mobile-spacer {\\n                    width: auto !important;\\n                    display: table !important\\n                }\\n\\n                .mobile-image,\\n                .mobile-image img {\\n                    height: auto !important;\\n                    max-width: 600px !important;\\n                    width: 100% !important\\n                }\\n            }\\n        </style>\\n        <!--[if mso]><style type=\\"text/css\\">body, table, td, a { font-family: Arial, Helvetica, sans-serif !important; }</style><![endif]-->\\n    </head>\\n\\n    <body style=\\"font-family: Helvetica, Arial, sans-serif; margin: 0px; padding: 0px; background-color: #ffffff;\\">\\n        <span style=\\"color: transparent; display: none; height: 0px; max-height: 0px; max-width: 0px; opacity: 0; overflow: hidden; visibility: hidden; width: 0px;\\">Your Natural Healing Commune verification code</span>\\n        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"body\\" style=\\"width: 100%;\\">\\n            <tbody>\\n                <tr>\\n                    <td align=\\"center\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 48px 32px;\\">\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"header container\\" style=\\"width: 600px;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" style=\\"vertical-align: top; line-height: 1; padding: 16px 32px;\\">\\n                                        <p style=\\"padding: 0px; margin: 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 24px; line-height: 36px;\\">\\n                                            Natural Healing Commune\\n                                        </p>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"600\\" class=\\"main container\\" style=\\"width: 600px; border-collapse: separate;\\">\\n                            <tbody>\\n                                <tr>\\n                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#fff\\" style=\\"vertical-align: top; line-height: 1; background-color: #ffffff; border-radius: 0px;\\">\\n                                        <table cellpadding=\\"0\\" cellspacing=\\"0\\" border=\\"0\\" width=\\"100%\\" class=\\"block\\" style=\\"width: 100%; border-collapse: separate;\\">\\n                                            <tbody>\\n                                                <tr>\\n                                                    <td align=\\"left\\" valign=\\"top\\" bgcolor=\\"#ffffff\\" style=\\"vertical-align: top; line-height: 1; padding: 32px 32px 48px; background-color: #ffffff; border-radius: 0px;\\">\\n                                                        <h1 class=\\"h1\\" align=\\"left\\" style=\\"padding: 0px; margin: 0px; font-style: normal; font-family: Helvetica, Arial, sans-serif; font-size: 32px; line-height: 39px; color: #000000; font-weight: bold;\\"> Verification code </h1>\\n                                                        <p align=\\"left\\" style=\\"padding: 0px; margin: 32px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> Enter the following verification code when prompted: </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 40px; line-height: 60px;\\">\\n                                                            <b>272571</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 16px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> To protect your account, do not share this code. </p>\\n                                                        <p style=\\"padding: 0px; margin: 64px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\">\\n                                                            <b>Didn't request this?</b>\\n                                                        </p>\\n                                                        <p style=\\"padding: 0px; margin: 4px 0px 0px; font-family: Helvetica, Arial, sans-serif; color: #000000; font-size: 14px; line-height: 21px;\\"> This code was requested from <b>2a00:23c5:d02c:2b01:c0c4:6fd3:e5a7:a49c, London, GB</b> at <b>03 November 2025, 20:54 UTC</b>. If you didn't make this request, you can safely ignore this email. </p>\\n                                                    </td>\\n                                                </tr>\\n                                            </tbody>\\n                                        </table>\\n                                    </td>\\n                                </tr>\\n                            </tbody>\\n                        </table>\\n                    </td>\\n                </tr>\\n            </tbody>\\n        </table>\\n    </body>\\n\\n</html>", "data": {"app": {"url": "https://settling-monarch-25.accounts.dev", "name": "Natural Healing Commune", "logo_url": null, "domain_name": "settling.monarch-25.lcl.dev", "logo_image_url": ""}, "user": {"email_address": "jwebandprospertest@gmail.com", "public_metadata": null, "public_metadata_fallback": ""}, "theme": {"primary_color": "#6c47ff", "button_text_color": "#ffffff", "show_clerk_branding": true}, "otp_code": "272571", "requested_at": "03 November 2025, 20:54 UTC", "requested_by": "Chrome, Windows", "requested_from": "2a00:23c5:d02c:2b01:c0c4:6fd3:e5a7:a49c, London, GB"}, "slug": "verification_code", "object": "email", "status": "queued", "subject": "[Development] 272571 is your verification code", "user_id": null, "body_plain": "272571 is your OTP code for Natural Healing Commune.\\n\\nDo not share this with anyone.\\n\\nIt was requested at 03 November 2025, 20:54 UTC. If you did not request this, please ignore this email.\\n", "from_email_name": "notifications", "email_address_id": "idn_34z4uejuYM8eOuPQgbhRMxuBHUs", "to_email_address": "jwebandprospertest@gmail.com", "delivered_by_clerk": true, "reply_to_email_name": null}, "type": "email.created", "object": "event", "timestamp": 1762203290624, "instance_id": "ins_2dJJipJKAgcf34JsuLdfXQSmvil", "event_attributes": {"http_request": {"client_ip": "2a00:23c5:d02c:2b01:c0c4:6fd3:e5a7:a49c", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36"}}}, "svix_headers": {"svix-id": "msg_34z4ujVGa0f636XxsDkHnFaHgBL", "svix-signature": "v1,M5T3iz9C9/ekr0lr8viJKfc0N3yu2/7nxjS0h7xXRLA=", "svix-timestamp": "1762203290"}}
1b6c0695-2953-4178-84b1-2a639dc09adc	clerk	{"evt": {"data": {"id": "user_34z4x8DfWl0CGRpY3NfJnLmEvdg", "banned": false, "locale": null, "locked": false, "object": "user", "passkeys": [], "username": null, "has_image": false, "image_url": "https://img.clerk.com/eyJ0eXBlIjoiZGVmYXVsdCIsImlpZCI6Imluc18yZEpKaXBKS0FnY2YzNEpzdUxkZlhRU212aWwiLCJyaWQiOiJ1c2VyXzM0ejR4OERmV2wwQ0dScFkzTmZKbkxtRXZkZyIsImluaXRpYWxzIjoiV0gifQ", "last_name": "Help You", "created_at": 1762203309988, "first_name": "We", "updated_at": 1762203310010, "external_id": null, "totp_enabled": false, "web3_wallets": [], "phone_numbers": [], "saml_accounts": [], "last_active_at": 1762203309987, "mfa_enabled_at": null, "email_addresses": [{"id": "idn_34z4uejuYM8eOuPQgbhRMxuBHUs", "object": "email_address", "reserved": false, "linked_to": [], "created_at": 1762203290211, "updated_at": 1762203309993, "verification": {"object": "verification_otp", "status": "verified", "attempts": 1, "strategy": "email_code", "expire_at": 1762203890610}, "email_address": "jwebandprospertest@gmail.com", "matches_sso_connection": false}], "last_sign_in_at": null, "mfa_disabled_at": null, "public_metadata": {}, "unsafe_metadata": {"language": "en", "membershipType": "business"}, "password_enabled": true, "private_metadata": {}, "external_accounts": [], "legal_accepted_at": null, "profile_image_url": "https://www.gravatar.com/avatar?d=mp", "two_factor_enabled": false, "backup_code_enabled": false, "delete_self_enabled": true, "enterprise_accounts": [], "primary_web3_wallet_id": null, "primary_phone_number_id": null, "primary_email_address_id": "idn_34z4uejuYM8eOuPQgbhRMxuBHUs", "lockout_expires_in_seconds": null, "create_organization_enabled": true, "verification_attempts_remaining": 100}, "type": "user.created", "object": "event", "timestamp": 1762203310034, "instance_id": "ins_2dJJipJKAgcf34JsuLdfXQSmvil", "event_attributes": {"http_request": {"client_ip": "2a00:23c5:d02c:2b01:c0c4:6fd3:e5a7:a49c", "user_agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36"}}}, "svix_headers": {"svix-id": "msg_34z4xBuBlfrvqY21xYCPJ1ZNohr", "svix-signature": "v1,K+DbdTfZR+M2/wBc9E6S5mfRUCgJRXs9xpkG4n4sw+o=", "svix-timestamp": "1762203310"}}
\.


--
-- TOC entry 3580 (class 0 OID 0)
-- Dependencies: 217
-- Name: __drizzle_migrations_id_seq; Type: SEQUENCE SET; Schema: drizzle; Owner: default
--

SELECT pg_catalog.setval('drizzle.__drizzle_migrations_id_seq', 74, true);


--
-- TOC entry 3380 (class 2606 OID 24585)
-- Name: __drizzle_migrations __drizzle_migrations_pkey; Type: CONSTRAINT; Schema: drizzle; Owner: default
--

ALTER TABLE ONLY drizzle.__drizzle_migrations
    ADD CONSTRAINT __drizzle_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3382 (class 2606 OID 24622)
-- Name: nhc_condition nhc_condition_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.nhc_condition
    ADD CONSTRAINT nhc_condition_pkey PRIMARY KEY (id);


--
-- TOC entry 3396 (class 2606 OID 139283)
-- Name: nhc_library_item nhc_library_item_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.nhc_library_item
    ADD CONSTRAINT nhc_library_item_pkey PRIMARY KEY (id);


--
-- TOC entry 3400 (class 2606 OID 286721)
-- Name: nhc_policy nhc_policy_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.nhc_policy
    ADD CONSTRAINT nhc_policy_pkey PRIMARY KEY (handle);


--
-- TOC entry 3392 (class 2606 OID 24676)
-- Name: nhc_post_comment nhc_post_comment_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.nhc_post_comment
    ADD CONSTRAINT nhc_post_comment_pkey PRIMARY KEY (id);


--
-- TOC entry 3384 (class 2606 OID 24630)
-- Name: nhc_post nhc_post_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.nhc_post
    ADD CONSTRAINT nhc_post_pkey PRIMARY KEY (id);


--
-- TOC entry 3390 (class 2606 OID 114690)
-- Name: nhc_post_to_treatment nhc_post_to_treatment_post_id_treatment_id_pk; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.nhc_post_to_treatment
    ADD CONSTRAINT nhc_post_to_treatment_post_id_treatment_id_pk PRIMARY KEY (post_id, treatment_id);


--
-- TOC entry 3386 (class 2606 OID 24638)
-- Name: nhc_treatment nhc_treatment_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.nhc_treatment
    ADD CONSTRAINT nhc_treatment_pkey PRIMARY KEY (id);


--
-- TOC entry 3394 (class 2606 OID 131079)
-- Name: nhc_user_accreditation nhc_user_accreditations_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.nhc_user_accreditation
    ADD CONSTRAINT nhc_user_accreditations_pkey PRIMARY KEY (id);


--
-- TOC entry 3398 (class 2606 OID 270343)
-- Name: nhc_user_dependant nhc_user_dependant_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.nhc_user_dependant
    ADD CONSTRAINT nhc_user_dependant_pkey PRIMARY KEY (id);


--
-- TOC entry 3388 (class 2606 OID 24645)
-- Name: nhc_user nhc_user_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.nhc_user
    ADD CONSTRAINT nhc_user_pkey PRIMARY KEY (clerk_id);


--
-- TOC entry 3402 (class 2606 OID 335879)
-- Name: nhc_webhook_event nhc_webhook_events_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.nhc_webhook_event
    ADD CONSTRAINT nhc_webhook_events_pkey PRIMARY KEY (id);


--
-- TOC entry 3414 (class 2606 OID 139284)
-- Name: nhc_library_item nhc_library_item_created_by_nhc_user_clerk_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.nhc_library_item
    ADD CONSTRAINT nhc_library_item_created_by_nhc_user_clerk_id_fk FOREIGN KEY (created_by) REFERENCES public.nhc_user(clerk_id);


--
-- TOC entry 3408 (class 2606 OID 196613)
-- Name: nhc_post_comment nhc_post_comment_post_nhc_post_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.nhc_post_comment
    ADD CONSTRAINT nhc_post_comment_post_nhc_post_id_fk FOREIGN KEY (post) REFERENCES public.nhc_post(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3409 (class 2606 OID 24703)
-- Name: nhc_post_comment nhc_post_comment_user_nhc_user_clerk_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.nhc_post_comment
    ADD CONSTRAINT nhc_post_comment_user_nhc_user_clerk_id_fk FOREIGN KEY ("user") REFERENCES public.nhc_user(clerk_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3403 (class 2606 OID 24651)
-- Name: nhc_post nhc_post_condition_nhc_condition_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.nhc_post
    ADD CONSTRAINT nhc_post_condition_nhc_condition_id_fk FOREIGN KEY (condition) REFERENCES public.nhc_condition(id);


--
-- TOC entry 3404 (class 2606 OID 270349)
-- Name: nhc_post nhc_post_dependant_nhc_user_dependant_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.nhc_post
    ADD CONSTRAINT nhc_post_dependant_nhc_user_dependant_id_fk FOREIGN KEY (dependant) REFERENCES public.nhc_user_dependant(id);


--
-- TOC entry 3406 (class 2606 OID 24708)
-- Name: nhc_post_to_treatment nhc_post_to_treatment_post_id_nhc_post_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.nhc_post_to_treatment
    ADD CONSTRAINT nhc_post_to_treatment_post_id_nhc_post_id_fk FOREIGN KEY (post_id) REFERENCES public.nhc_post(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3407 (class 2606 OID 24664)
-- Name: nhc_post_to_treatment nhc_post_to_treatment_treatment_id_nhc_treatment_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.nhc_post_to_treatment
    ADD CONSTRAINT nhc_post_to_treatment_treatment_id_nhc_treatment_id_fk FOREIGN KEY (treatment_id) REFERENCES public.nhc_treatment(id);


--
-- TOC entry 3405 (class 2606 OID 24698)
-- Name: nhc_post nhc_post_user_nhc_user_clerk_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.nhc_post
    ADD CONSTRAINT nhc_post_user_nhc_user_clerk_id_fk FOREIGN KEY ("user") REFERENCES public.nhc_user(clerk_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3413 (class 2606 OID 188416)
-- Name: nhc_user_accreditation nhc_user_accreditation_user_nhc_user_clerk_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.nhc_user_accreditation
    ADD CONSTRAINT nhc_user_accreditation_user_nhc_user_clerk_id_fk FOREIGN KEY ("user") REFERENCES public.nhc_user(clerk_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3415 (class 2606 OID 270344)
-- Name: nhc_user_dependant nhc_user_dependant_user_id_nhc_user_clerk_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.nhc_user_dependant
    ADD CONSTRAINT nhc_user_dependant_user_id_nhc_user_clerk_id_fk FOREIGN KEY (user_id) REFERENCES public.nhc_user(clerk_id);


--
-- TOC entry 3411 (class 2606 OID 122890)
-- Name: nhc_user_to_treatment nhc_user_to_treatment_treatment_id_nhc_treatment_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.nhc_user_to_treatment
    ADD CONSTRAINT nhc_user_to_treatment_treatment_id_nhc_treatment_id_fk FOREIGN KEY (treatment_id) REFERENCES public.nhc_treatment(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3412 (class 2606 OID 122885)
-- Name: nhc_user_to_treatment nhc_user_to_treatment_user_id_nhc_user_clerk_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.nhc_user_to_treatment
    ADD CONSTRAINT nhc_user_to_treatment_user_id_nhc_user_clerk_id_fk FOREIGN KEY (user_id) REFERENCES public.nhc_user(clerk_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3410 (class 2606 OID 24687)
-- Name: nhc_post_comment post_comment_parent_fk; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.nhc_post_comment
    ADD CONSTRAINT post_comment_parent_fk FOREIGN KEY (parent_id) REFERENCES public.nhc_post_comment(id);


--
-- TOC entry 2198 (class 826 OID 73729)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO neon_superuser WITH GRANT OPTION;


--
-- TOC entry 2197 (class 826 OID 73728)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO neon_superuser WITH GRANT OPTION;


-- Completed on 2025-11-05 09:57:30

--
-- PostgreSQL database dump complete
--

