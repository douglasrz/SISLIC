--
-- PostgreSQL database dump
--

-- Dumped from database version 10.0
-- Dumped by pg_dump version 10.0

-- Started on 2017-11-17 14:41:53

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12924)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2922 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 205 (class 1259 OID 24636)
-- Name: categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE categoria (
    id_categoria integer NOT NULL,
    nome character varying(45) NOT NULL,
    descricao character varying(65)
);


ALTER TABLE categoria OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 24662)
-- Name: categoria_fornecedor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE categoria_fornecedor (
    id_catetogia_fornecedor integer NOT NULL,
    id_categoria integer NOT NULL,
    id_fornecedor integer
);


ALTER TABLE categoria_fornecedor OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 24634)
-- Name: categoria_id_categoria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE categoria_id_categoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE categoria_id_categoria_seq OWNER TO postgres;

--
-- TOC entry 2923 (class 0 OID 0)
-- Dependencies: 204
-- Name: categoria_id_categoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE categoria_id_categoria_seq OWNED BY categoria.id_categoria;


--
-- TOC entry 208 (class 1259 OID 24660)
-- Name: catetogia_fornecedor_id_catetogia_fornecedor_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE catetogia_fornecedor_id_catetogia_fornecedor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE catetogia_fornecedor_id_catetogia_fornecedor_seq OWNER TO postgres;

--
-- TOC entry 2924 (class 0 OID 0)
-- Dependencies: 208
-- Name: catetogia_fornecedor_id_catetogia_fornecedor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE catetogia_fornecedor_id_catetogia_fornecedor_seq OWNED BY categoria_fornecedor.id_catetogia_fornecedor;


--
-- TOC entry 197 (class 1259 OID 24586)
-- Name: fornecedor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE fornecedor (
    id_fornecedor integer NOT NULL,
    razao_social character varying(50) NOT NULL,
    telefone character varying(20),
    pontuacao integer,
    login character varying(30) NOT NULL,
    senha character varying NOT NULL,
    cnpj character varying,
    email character varying
);


ALTER TABLE fornecedor OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 24584)
-- Name: fornecedor_id_fornecedor_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE fornecedor_id_fornecedor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE fornecedor_id_fornecedor_seq OWNER TO postgres;

--
-- TOC entry 2925 (class 0 OID 0)
-- Dependencies: 196
-- Name: fornecedor_id_fornecedor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE fornecedor_id_fornecedor_seq OWNED BY fornecedor.id_fornecedor;


--
-- TOC entry 199 (class 1259 OID 24594)
-- Name: funcionario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE funcionario (
    id_funcionario integer NOT NULL,
    nome character varying(45) NOT NULL,
    telefone character varying(45),
    cargo character varying(45) NOT NULL,
    login character varying,
    senha character varying,
    id_setor integer
);


ALTER TABLE funcionario OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 24592)
-- Name: funcionario_id_funcionario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE funcionario_id_funcionario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE funcionario_id_funcionario_seq OWNER TO postgres;

--
-- TOC entry 2926 (class 0 OID 0)
-- Dependencies: 198
-- Name: funcionario_id_funcionario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE funcionario_id_funcionario_seq OWNED BY funcionario.id_funcionario;


--
-- TOC entry 207 (class 1259 OID 24644)
-- Name: item_pedido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE item_pedido (
    id_item_pedido integer NOT NULL,
    quantidade integer,
    preco double precision,
    id_produto integer NOT NULL,
    id_pedido integer NOT NULL
);


ALTER TABLE item_pedido OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 24642)
-- Name: item_pedido_id_item_pedido_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE item_pedido_id_item_pedido_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE item_pedido_id_item_pedido_seq OWNER TO postgres;

--
-- TOC entry 2927 (class 0 OID 0)
-- Dependencies: 206
-- Name: item_pedido_id_item_pedido_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE item_pedido_id_item_pedido_seq OWNED BY item_pedido.id_item_pedido;


--
-- TOC entry 211 (class 1259 OID 24680)
-- Name: lance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lance (
    id_lance integer NOT NULL,
    valor_total double precision NOT NULL,
    id_pedido integer NOT NULL,
    id_fornecedor integer NOT NULL,
    data date
);


ALTER TABLE lance OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 24678)
-- Name: lance_id_lance_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE lance_id_lance_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE lance_id_lance_seq OWNER TO postgres;

--
-- TOC entry 2928 (class 0 OID 0)
-- Dependencies: 210
-- Name: lance_id_lance_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE lance_id_lance_seq OWNED BY lance.id_lance;


--
-- TOC entry 216 (class 1259 OID 40984)
-- Name: lance_item_pedido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lance_item_pedido (
    id integer NOT NULL,
    id_lance integer NOT NULL,
    id_item_pedido integer NOT NULL
);


ALTER TABLE lance_item_pedido OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 24698)
-- Name: log_penalidade; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE log_penalidade (
    id_log_pontuacao integer NOT NULL,
    id_fornecedor integer NOT NULL,
    id_funcionario integer NOT NULL,
    descricao character varying(45),
    valor integer,
    motivo character varying,
    id_pedido integer,
    data_penal date,
    nome_pedido character varying
);


ALTER TABLE log_penalidade OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 24696)
-- Name: log_penalidade_id_log_pontuacao_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE log_penalidade_id_log_pontuacao_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE log_penalidade_id_log_pontuacao_seq OWNER TO postgres;

--
-- TOC entry 2929 (class 0 OID 0)
-- Dependencies: 212
-- Name: log_penalidade_id_log_pontuacao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE log_penalidade_id_log_pontuacao_seq OWNED BY log_penalidade.id_log_pontuacao;


--
-- TOC entry 201 (class 1259 OID 24602)
-- Name: pedido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE pedido (
    id_pedido integer NOT NULL,
    data_lancamento date NOT NULL,
    data_limite date NOT NULL,
    id_funcionario integer,
    nome character varying,
    descricao character varying,
    id_setor integer,
    autorizado boolean
);


ALTER TABLE pedido OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 24600)
-- Name: pedido_id_pedido_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE pedido_id_pedido_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pedido_id_pedido_seq OWNER TO postgres;

--
-- TOC entry 2930 (class 0 OID 0)
-- Dependencies: 200
-- Name: pedido_id_pedido_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE pedido_id_pedido_seq OWNED BY pedido.id_pedido;


--
-- TOC entry 203 (class 1259 OID 24623)
-- Name: produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE produto (
    id_produto integer NOT NULL,
    nome character varying(45) NOT NULL,
    descricao character varying(45),
    id_categoria integer
);


ALTER TABLE produto OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 24621)
-- Name: produto_id_produto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE produto_id_produto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE produto_id_produto_seq OWNER TO postgres;

--
-- TOC entry 2931 (class 0 OID 0)
-- Dependencies: 202
-- Name: produto_id_produto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE produto_id_produto_seq OWNED BY produto.id_produto;


--
-- TOC entry 214 (class 1259 OID 40966)
-- Name: setor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE setor (
    nome character varying NOT NULL,
    id_setor integer NOT NULL
);


ALTER TABLE setor OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 40974)
-- Name: setor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE setor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE setor_id_seq OWNER TO postgres;

--
-- TOC entry 2932 (class 0 OID 0)
-- Dependencies: 215
-- Name: setor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE setor_id_seq OWNED BY setor.id_setor;


--
-- TOC entry 2737 (class 2604 OID 24639)
-- Name: categoria id_categoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categoria ALTER COLUMN id_categoria SET DEFAULT nextval('categoria_id_categoria_seq'::regclass);


--
-- TOC entry 2739 (class 2604 OID 24665)
-- Name: categoria_fornecedor id_catetogia_fornecedor; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categoria_fornecedor ALTER COLUMN id_catetogia_fornecedor SET DEFAULT nextval('catetogia_fornecedor_id_catetogia_fornecedor_seq'::regclass);


--
-- TOC entry 2733 (class 2604 OID 24589)
-- Name: fornecedor id_fornecedor; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY fornecedor ALTER COLUMN id_fornecedor SET DEFAULT nextval('fornecedor_id_fornecedor_seq'::regclass);


--
-- TOC entry 2734 (class 2604 OID 24597)
-- Name: funcionario id_funcionario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY funcionario ALTER COLUMN id_funcionario SET DEFAULT nextval('funcionario_id_funcionario_seq'::regclass);


--
-- TOC entry 2738 (class 2604 OID 24647)
-- Name: item_pedido id_item_pedido; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY item_pedido ALTER COLUMN id_item_pedido SET DEFAULT nextval('item_pedido_id_item_pedido_seq'::regclass);


--
-- TOC entry 2740 (class 2604 OID 24683)
-- Name: lance id_lance; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lance ALTER COLUMN id_lance SET DEFAULT nextval('lance_id_lance_seq'::regclass);


--
-- TOC entry 2741 (class 2604 OID 24701)
-- Name: log_penalidade id_log_pontuacao; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY log_penalidade ALTER COLUMN id_log_pontuacao SET DEFAULT nextval('log_penalidade_id_log_pontuacao_seq'::regclass);


--
-- TOC entry 2735 (class 2604 OID 24605)
-- Name: pedido id_pedido; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pedido ALTER COLUMN id_pedido SET DEFAULT nextval('pedido_id_pedido_seq'::regclass);


--
-- TOC entry 2736 (class 2604 OID 24626)
-- Name: produto id_produto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY produto ALTER COLUMN id_produto SET DEFAULT nextval('produto_id_produto_seq'::regclass);


--
-- TOC entry 2742 (class 2604 OID 40976)
-- Name: setor id_setor; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY setor ALTER COLUMN id_setor SET DEFAULT nextval('setor_id_seq'::regclass);


--
-- TOC entry 2904 (class 0 OID 24636)
-- Dependencies: 205
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY categoria (id_categoria, nome, descricao) FROM stdin;
1	informatica	tudo de informatica, desde de acessorios
2	eletronico	audio, video etc
3	Movéis	Cama, mesa e banho
4	Eletronico	tudo 
5	Informatica	TUdo em infor
6	moveis	12131
7	Papel 	afa
\.


--
-- TOC entry 2908 (class 0 OID 24662)
-- Dependencies: 209
-- Data for Name: categoria_fornecedor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY categoria_fornecedor (id_catetogia_fornecedor, id_categoria, id_fornecedor) FROM stdin;
17	5	1
\.


--
-- TOC entry 2896 (class 0 OID 24586)
-- Dependencies: 197
-- Data for Name: fornecedor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY fornecedor (id_fornecedor, razao_social, telefone, pontuacao, login, senha, cnpj, email) FROM stdin;
1	Random ltd	98993019	10	douglas	123	1111111	douglas@gmail.com
\.


--
-- TOC entry 2898 (class 0 OID 24594)
-- Dependencies: 199
-- Data for Name: funcionario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY funcionario (id_funcionario, nome, telefone, cargo, login, senha, id_setor) FROM stdin;
1	Jose	991921839	gerente	\N	\N	\N
2	Jose	991921839	auxiliar administrativo	\N	\N	\N
3	douglas	12343454	admin	douglas	123	1
\.


--
-- TOC entry 2906 (class 0 OID 24644)
-- Dependencies: 207
-- Data for Name: item_pedido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY item_pedido (id_item_pedido, quantidade, preco, id_produto, id_pedido) FROM stdin;
3	10	21	2	3
4	10	21	1	4
5	12	19	1	3
7	12	19	2	4
10	5	99.5	3	3
11	5	99.5	4	4
12	3	109	4	5
\.


--
-- TOC entry 2910 (class 0 OID 24680)
-- Dependencies: 211
-- Data for Name: lance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY lance (id_lance, valor_total, id_pedido, id_fornecedor, data) FROM stdin;
\.


--
-- TOC entry 2915 (class 0 OID 40984)
-- Dependencies: 216
-- Data for Name: lance_item_pedido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY lance_item_pedido (id, id_lance, id_item_pedido) FROM stdin;
\.


--
-- TOC entry 2912 (class 0 OID 24698)
-- Dependencies: 213
-- Data for Name: log_penalidade; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY log_penalidade (id_log_pontuacao, id_fornecedor, id_funcionario, descricao, valor, motivo, id_pedido, data_penal, nome_pedido) FROM stdin;
1	1	1	atraso na entrega	20	atraso na entrega	1	2017-11-20	\N
2	1	1	o mouse quebrou a rodinha	20	baixa qualidade	1	2015-11-20	mouses
\.


--
-- TOC entry 2900 (class 0 OID 24602)
-- Dependencies: 201
-- Data for Name: pedido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY pedido (id_pedido, data_lancamento, data_limite, id_funcionario, nome, descricao, id_setor, autorizado) FROM stdin;
3	2017-10-20	2018-10-29	1	Acessorios de informatica	ESTE PEDIDO DEVE SER ENTREGUE ATE O DIA 29 DE DEZEMBRO DESTE ANO	1	t
5	2017-11-02	20171-11-15	1	Caixa de Som	Caixa de som JBL GO	1	t
4	2017-10-20	2018-10-29	1	Mesas	ESTE PEDIDO DEVE SER ENTREGUE ATE O DIA 29 DE DEZEMBRO DESTE ANO	1	f
\.


--
-- TOC entry 2902 (class 0 OID 24623)
-- Dependencies: 203
-- Data for Name: produto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY produto (id_produto, nome, descricao, id_categoria) FROM stdin;
3	monitor	monitor de 22 polegadas, da marca dell	1
4	Som JBL	Caixa de som JBL charge 3	3
1	mouse	mouse dell	2
2	teclado	teclado dell	2
\.


--
-- TOC entry 2913 (class 0 OID 40966)
-- Dependencies: 214
-- Data for Name: setor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY setor (nome, id_setor) FROM stdin;
Financeiro	1
Marketing	2
Comunicação	3
\.


--
-- TOC entry 2933 (class 0 OID 0)
-- Dependencies: 204
-- Name: categoria_id_categoria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('categoria_id_categoria_seq', 7, true);


--
-- TOC entry 2934 (class 0 OID 0)
-- Dependencies: 208
-- Name: catetogia_fornecedor_id_catetogia_fornecedor_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('catetogia_fornecedor_id_catetogia_fornecedor_seq', 21, true);


--
-- TOC entry 2935 (class 0 OID 0)
-- Dependencies: 196
-- Name: fornecedor_id_fornecedor_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('fornecedor_id_fornecedor_seq', 1, true);


--
-- TOC entry 2936 (class 0 OID 0)
-- Dependencies: 198
-- Name: funcionario_id_funcionario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('funcionario_id_funcionario_seq', 3, true);


--
-- TOC entry 2937 (class 0 OID 0)
-- Dependencies: 206
-- Name: item_pedido_id_item_pedido_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('item_pedido_id_item_pedido_seq', 12, true);


--
-- TOC entry 2938 (class 0 OID 0)
-- Dependencies: 210
-- Name: lance_id_lance_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('lance_id_lance_seq', 1, false);


--
-- TOC entry 2939 (class 0 OID 0)
-- Dependencies: 212
-- Name: log_penalidade_id_log_pontuacao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('log_penalidade_id_log_pontuacao_seq', 2, true);


--
-- TOC entry 2940 (class 0 OID 0)
-- Dependencies: 200
-- Name: pedido_id_pedido_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('pedido_id_pedido_seq', 5, true);


--
-- TOC entry 2941 (class 0 OID 0)
-- Dependencies: 202
-- Name: produto_id_produto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('produto_id_produto_seq', 4, true);


--
-- TOC entry 2942 (class 0 OID 0)
-- Dependencies: 215
-- Name: setor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('setor_id_seq', 3, true);


--
-- TOC entry 2752 (class 2606 OID 24641)
-- Name: categoria categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (id_categoria);


--
-- TOC entry 2756 (class 2606 OID 24667)
-- Name: categoria_fornecedor catetogia_fornecedor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categoria_fornecedor
    ADD CONSTRAINT catetogia_fornecedor_pkey PRIMARY KEY (id_catetogia_fornecedor);


--
-- TOC entry 2744 (class 2606 OID 24591)
-- Name: fornecedor fornecedor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY fornecedor
    ADD CONSTRAINT fornecedor_pkey PRIMARY KEY (id_fornecedor);


--
-- TOC entry 2746 (class 2606 OID 24599)
-- Name: funcionario funcionario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY funcionario
    ADD CONSTRAINT funcionario_pkey PRIMARY KEY (id_funcionario);


--
-- TOC entry 2754 (class 2606 OID 24649)
-- Name: item_pedido item_pedido_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY item_pedido
    ADD CONSTRAINT item_pedido_pkey PRIMARY KEY (id_item_pedido);


--
-- TOC entry 2762 (class 2606 OID 40988)
-- Name: lance_item_pedido lance_item_pedido_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lance_item_pedido
    ADD CONSTRAINT lance_item_pedido_pkey PRIMARY KEY (id);


--
-- TOC entry 2758 (class 2606 OID 24685)
-- Name: lance lance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lance
    ADD CONSTRAINT lance_pkey PRIMARY KEY (id_lance);


--
-- TOC entry 2760 (class 2606 OID 24703)
-- Name: log_penalidade log_penalidade_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY log_penalidade
    ADD CONSTRAINT log_penalidade_pkey PRIMARY KEY (id_log_pontuacao);


--
-- TOC entry 2748 (class 2606 OID 24607)
-- Name: pedido pedido_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pedido
    ADD CONSTRAINT pedido_pkey PRIMARY KEY (id_pedido);


--
-- TOC entry 2750 (class 2606 OID 24628)
-- Name: produto produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (id_produto);


--
-- TOC entry 2765 (class 2606 OID 24655)
-- Name: item_pedido fk_itemPedido_pedido1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY item_pedido
    ADD CONSTRAINT "fk_itemPedido_pedido1" FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido);


--
-- TOC entry 2766 (class 2606 OID 24668)
-- Name: categoria_fornecedor id_categoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categoria_fornecedor
    ADD CONSTRAINT id_categoria FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria);


--
-- TOC entry 2767 (class 2606 OID 24673)
-- Name: categoria_fornecedor id_fornecedor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categoria_fornecedor
    ADD CONSTRAINT id_fornecedor FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor);


--
-- TOC entry 2769 (class 2606 OID 24691)
-- Name: lance id_fornecedor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lance
    ADD CONSTRAINT id_fornecedor FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor);


--
-- TOC entry 2770 (class 2606 OID 24704)
-- Name: log_penalidade id_fornecedor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY log_penalidade
    ADD CONSTRAINT id_fornecedor FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor);


--
-- TOC entry 2763 (class 2606 OID 24608)
-- Name: pedido id_funcionario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pedido
    ADD CONSTRAINT id_funcionario FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario);


--
-- TOC entry 2771 (class 2606 OID 24709)
-- Name: log_penalidade id_funcionario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY log_penalidade
    ADD CONSTRAINT id_funcionario FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario);


--
-- TOC entry 2768 (class 2606 OID 24686)
-- Name: lance id_pedido; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lance
    ADD CONSTRAINT id_pedido FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido);


--
-- TOC entry 2764 (class 2606 OID 24650)
-- Name: item_pedido id_produto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY item_pedido
    ADD CONSTRAINT id_produto FOREIGN KEY (id_produto) REFERENCES produto(id_produto);


--
-- TOC entry 2773 (class 2606 OID 40994)
-- Name: lance_item_pedido lance_item_pedido_id_item_pedido_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lance_item_pedido
    ADD CONSTRAINT lance_item_pedido_id_item_pedido_fkey FOREIGN KEY (id_item_pedido) REFERENCES item_pedido(id_item_pedido);


--
-- TOC entry 2772 (class 2606 OID 40989)
-- Name: lance_item_pedido lance_item_pedido_id_lance_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lance_item_pedido
    ADD CONSTRAINT lance_item_pedido_id_lance_fkey FOREIGN KEY (id_lance) REFERENCES lance(id_lance);


-- Completed on 2017-11-17 14:41:56

--
-- PostgreSQL database dump complete
--

