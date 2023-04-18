CREATE TABLE CRACHA (
  num_cracha NUMBER(4),
  data_emissao DATE,
  CONSTRAINT PK_CRACHA PRIMARY KEY(num_cracha)
);

CREATE TABLE USUARIO (
  matricula VARCHAR2(10),
  nome VARCHAR2(80) NOT NULL,
  email VARCHAR2(100) NOT NULL,
  senha VARCHAR2(100) NOT NULL,
  num_cracha NUMBER(4) NOT NULL UNIQUE,
  CONSTRAINT PK_USUARIO PRIMARY KEY (matricula),
  CONSTRAINT FK_USU_CRA FOREIGN KEY (num_cracha) REFERENCES CRACHA (num_cracha)
);

CREATE TABLE TELEFONES (
  matricula VARCHAR2(10),
  telefone VARCHAR2(20),
  CONSTRAINT PK_TELEFONES PRIMARY KEY (matricula, telefone),
  CONSTRAINT FK_TEL_USU FOREIGN KEY (matricula) REFERENCES USUARIO (matricula)
);

CREATE TABLE AGENDAMENTO (
  cod_agend NUMBER(4),
  data_inicio DATE NOT NULL,
  data_fim DATE NOT NULL,
  CONSTRAINT PK_AGENDAMENTO PRIMARY KEY (cod_agend)
);

CREATE TABLE EQUIPAMENTO (
  id_equipamento NUMBER(4),
  CONSTRAINT PK_EQUIPAMENTO PRIMARY KEY (id_equipamento)
);

CREATE TABLE PEÇA (
  cod_peca NUMBER(4),
  qtd NUMBER(4) NOT NULL,
  CONSTRAINT PK_PEÇA PRIMARY KEY (cod_peca)
);

CREATE TABLE LABORATORIO (
  cod_lab NUMBER(4),
  endereco_num_sala VARCHAR2(50),
  endereco_predio VARCHAR2(50),
  id_equipamento NUMBER(4),
  CONSTRAINT PK_LABORATORIO PRIMARY KEY (cod_lab),
  CONSTRAINT FK_LABORATORIO FOREIGN KEY (id_equipamento) REFERENCES EQUIPAMENTO (id_equipamento)
);

CREATE TABLE VISITANTE (
  matricula VARCHAR2(10),
  id_visitante VARCHAR2(10),
  motivo_visita VARCHAR2(100),
  CONSTRAINT PK_VISITANTE PRIMARY KEY(matricula, id_visitante),
  CONSTRAINT FK_VIS_USU FOREIGN KEY (matricula) REFERENCES USUARIO(matricula)
);

CREATE TABLE PROFESSOR (
  matricula VARCHAR2(10),
  cadeiras VARCHAR2(100),
  prof_coordenador VARCHAR2(10) NOT NULL,
  CONSTRAINT PK_PROFESSOR PRIMARY KEY (matricula),
  CONSTRAINT FK_PRO_USU FOREIGN KEY (matricula) REFERENCES USUARIO (matricula),
  CONSTRAINT FK_PRO_PROF FOREIGN KEY (prof_coordenador) REFERENCES PROFESSOR (matricula)
);

CREATE TABLE ALUNO (
  matricula VARCHAR2(10), 
  periodo VARCHAR2(50),
  cadeira VARCHAR2(100),
  CONSTRAINT PK_ALUNO PRIMARY KEY (matricula),
  CONSTRAINT FK_ALU_USU FOREIGN KEY (matricula) REFERENCES USUARIO (matricula)
);

CREATE TABLE FUNCIONARIO_MANUTENCAO (
  matricula VARCHAR2(10),  
  salario NUMBER(4),
  num_carteira VARCHAR2(50),
  CONSTRAINT PK_FUNC_MANUT PRIMARY KEY (matricula),
  CONSTRAINT FK_FUNC_MANUT_USU FOREIGN KEY (matricula) REFERENCES USUARIO (matricula)
);

CREATE TABLE MANUTENCAO (
  matricula VARCHAR2(10),
  id_equipamento NUMBER(4),
  data_inicio_manutencao DATE,
  data_fim_manutencao DATE,
  descricao VARCHAR2(200),
  CONSTRAINT PK_MANUTENCAO PRIMARY KEY (matricula, id_equipamento),
  CONSTRAINT FK_MANU_EQUIP FOREIGN KEY (id_equipamento) REFERENCES EQUIPAMENTO (id_equipamento),
  CONSTRAINT FK_MANU_FUNC_MANUT FOREIGN KEY (matricula) REFERENCES FUNCIONARIO_MANUTENCAO (matricula)
);

-- Verificar como fazer referencia de (matricula, id_equipamento) de forma correta 
CREATE TABLE TROCA (
  matricula VARCHAR2(10),
  id_equipamento NUMBER(4),
  cod_peca NUMBER(4),
  CONSTRAINT PK_TROCA PRIMARY KEY (matricula, id_equipamento, cod_peca),
  CONSTRAINT FK_TROCA_MANU_MAT FOREIGN KEY (matricula, id_equipamento) REFERENCES MANUTENCAO (matricula, id_equipamento),
  CONSTRAINT FK_TROCA_PECA FOREIGN KEY (cod_peca) REFERENCES PEÇA (cod_peca)
);

CREATE TABLE ACESSA(
    matricula VARCHAR2(10) NOT NULL,
    cod_agend NUMBER(4),
    cod_lab NUMBER(4),
    CONSTRAINT PK_ACESSA PRIMARY KEY (cod_agend, cod_lab),
    CONSTRAINT FK_ACESSA_COD_AGEND FOREIGN KEY (cod_agend) REFERENCES AGENDAMENTO (cod_agend),
    CONSTRAINT FK_ACESSA_COD_LAB FOREIGN KEY (cod_lab) REFERENCES LABORATORIO (cod_lab),
    CONSTRAINT FK_ACESSA_MATRICULA FOREIGN KEY (matricula) REFERENCES USUARIO (matricula)
);
