CREATE TABLE CRACHA (
  num_cracha NUMBER(4),
  data_emissao DATE,
  CONSTRAINT PK_CRACHA PRIMARY KEY(num_cracha)
);

CREATE TABLE USUARIO (
  matricula NUMBER(10),
  nome VARCHAR2(80) NOT NULL,
  email VARCHAR2(100) NOT NULL,
  senha VARCHAR2(100) NOT NULL,
  num_cracha NUMBER(4) NOT NULL UNIQUE,
  CONSTRAINT PK_USUARIO PRIMARY KEY (matricula),
  CONSTRAINT FK_USU_CRA FOREIGN KEY (num_cracha) REFERENCES CRACHA (num_cracha)
);

CREATE TABLE TELEFONES (
  matricula NUMBER(10),
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

CREATE TABLE PECA (
  cod_peca NUMBER(4),
  qtd NUMBER(4) NOT NULL,
  CONSTRAINT PK_PECA PRIMARY KEY (cod_peca)
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
  matricula NUMBER(10),
  id_visitante VARCHAR2(10),
  motivo_visita VARCHAR2(100),
  CONSTRAINT PK_VISITANTE PRIMARY KEY(matricula, id_visitante),
  CONSTRAINT FK_VIS_USU FOREIGN KEY (matricula) REFERENCES USUARIO(matricula)
);

CREATE TABLE PROFESSOR (
  matricula NUMBER(10),
  cadeiras VARCHAR2(100),
  prof_coordenador NUMBER(10) NOT NULL,
  CONSTRAINT PK_PROFESSOR PRIMARY KEY (matricula),
  CONSTRAINT FK_PRO_USU FOREIGN KEY (matricula) REFERENCES USUARIO (matricula),
  CONSTRAINT FK_PRO_PROF FOREIGN KEY (prof_coordenador) REFERENCES PROFESSOR (matricula)
);

CREATE TABLE ALUNO (
  matricula NUMBER(10), 
  periodo VARCHAR2(50),
  cadeira VARCHAR2(100),
  CONSTRAINT PK_ALUNO PRIMARY KEY (matricula),
  CONSTRAINT FK_ALU_USU FOREIGN KEY (matricula) REFERENCES USUARIO (matricula)
);

CREATE TABLE FUNCIONARIO_MANUTENCAO (
  matricula NUMBER(10),  
  salario NUMBER(4),
  num_carteira VARCHAR2(50),
  CONSTRAINT PK_FUNC_MANUT PRIMARY KEY (matricula),
  CONSTRAINT FK_FUNC_MANUT_USU FOREIGN KEY (matricula) REFERENCES USUARIO (matricula)
);

CREATE TABLE MANUTENCAO (
  matricula NUMBER(10),
  id_equipamento NUMBER(4),
  data_inicio_manutencao DATE,
  data_fim_manutencao DATE,
  descricao VARCHAR2(200),
  CONSTRAINT PK_MANUTENCAO PRIMARY KEY (matricula, id_equipamento),
  CONSTRAINT FK_MANU_EQUIP FOREIGN KEY (id_equipamento) REFERENCES EQUIPAMENTO (id_equipamento),
  CONSTRAINT FK_MANU_FUNC_MANUT FOREIGN KEY (matricula) REFERENCES FUNCIONARIO_MANUTENCAO (matricula)
);

CREATE TABLE TROCA (
  matricula NUMBER(10),
  id_equipamento NUMBER(4),
  cod_peca NUMBER(4),
  CONSTRAINT PK_TROCA PRIMARY KEY (matricula, id_equipamento, cod_peca),
  CONSTRAINT FK_TROCA_MANU_MAT FOREIGN KEY (matricula, id_equipamento) REFERENCES MANUTENCAO (matricula, id_equipamento),
  CONSTRAINT FK_TROCA_PECA FOREIGN KEY (cod_peca) REFERENCES PECA (cod_peca)
);

CREATE TABLE ACESSA(
    matricula NUMBER(10) NOT NULL,
    cod_agend NUMBER(4),
    cod_lab NUMBER(4),
    CONSTRAINT PK_ACESSA PRIMARY KEY (cod_agend, cod_lab),
    CONSTRAINT FK_ACESSA_COD_AGEND FOREIGN KEY (cod_agend) REFERENCES AGENDAMENTO (cod_agend),
    CONSTRAINT FK_ACESSA_COD_LAB FOREIGN KEY (cod_lab) REFERENCES LABORATORIO (cod_lab),
    CONSTRAINT FK_ACESSA_MATRICULA FOREIGN KEY (matricula) REFERENCES USUARIO (matricula)
);

-- POVOAMENTO

-- CRACHA
INSERT INTO CRACHA VALUES (1, TO_DATE('01/01/2022','DD/MM/YYYY'));

INSERT INTO CRACHA VALUES (2, TO_DATE('02/02/2022','DD/MM/YYYY'));

INSERT INTO CRACHA VALUES (3, TO_DATE('03/03/2022','DD/MM/YYYY'));

INSERT INTO CRACHA VALUES (4, TO_DATE('04/04/2022','DD/MM/YYYY'));

INSERT INTO CRACHA VALUES (5, TO_DATE('05/05/2022','DD/MM/YYYY'));

INSERT INTO CRACHA VALUES (6, TO_DATE('06/06/2022','DD/MM/YYYY'));

INSERT INTO CRACHA VALUES (7, TO_DATE('07/07/2022','DD/MM/YYYY'));

INSERT INTO CRACHA VALUES (8, TO_DATE('08/08/2022','DD/MM/YYYY'));

INSERT INTO CRACHA VALUES (9, TO_DATE('09/09/2022','DD/MM/YYYY'));

INSERT INTO CRACHA VALUES (10, TO_DATE('10/10/2022','DD/MM/YYYY'));

INSERT INTO CRACHA VALUES (11, TO_DATE('10/10/2022','DD/MM/YYYY'));

INSERT INTO CRACHA VALUES (12, TO_DATE('10/10/2022','DD/MM/YYYY'));

INSERT INTO CRACHA VALUES (13, TO_DATE('10/10/2022','DD/MM/YYYY'));

INSERT INTO CRACHA VALUES (14, TO_DATE('10/10/2022','DD/MM/YYYY'));

INSERT INTO CRACHA VALUES (15, TO_DATE('10/10/2022','DD/MM/YYYY'));



-- USUARIO
INSERT INTO USUARIO VALUES (12350, 'Maria Geyzianny', 'maria@gmail.com', 'password123', 1);

INSERT INTO USUARIO VALUES (12346, 'Fernanda Pascoal', 'fernanda@gmail.com', 'pass456', 2);

INSERT INTO USUARIO VALUES (12347, 'Gabriel Laroche', 'gabriel@outlook.com', 'secure789', 3);

INSERT INTO USUARIO VALUES (12348, 'Valter Junior', 'valter@gmail.com', 'pwd123', 4);

INSERT INTO USUARIO VALUES (12349, ' Vinicius Monitor', 'vinicius@outlook.com', 'secret567', 5);

INSERT INTO USUARIO VALUES (12345, ' Paulo Vitor', 'paulo@gmail.com', 'pass444', 6);

INSERT INTO USUARIO VALUES (12351, 'Olivia Parker', 'oliviaparker@outlook.com', 'pass157word', 7);

INSERT INTO USUARIO VALUES (12352, 'Ethan Brooks', 'ethanbrooks@gmail.com', 'secure479', 8);

INSERT INTO USUARIO VALUES (12353, 'Madison Carter', 'madisoncarter@gmail.com', 'password998', 9);

INSERT INTO USUARIO VALUES (12354, 'William Turner', 'williamturner@gmail.com', 'secret562', 10);

INSERT INTO USUARIO VALUES (12355, 'Robson Fidalgo', 'robson@yahoo.com', 'secret463', 11);

INSERT INTO USUARIO VALUES (12356, 'Daniel Lee', 'daniellee@hotmail.com', 'secret289', 12);

INSERT INTO USUARIO VALUES (12357, 'Sophie Brown', 'sophiebrown@gmail.com', 'secret123', 13);

INSERT INTO USUARIO VALUES (12358, 'Adam Scott', 'adamscott@yahoo.com', 'secret456', 14);

INSERT INTO USUARIO VALUES (12359, 'Olivia Taylor', 'oliviataylor@hotmail.com', 'secret789', 15);

-- TELEFONES
INSERT INTO TELEFONES VALUES (12345, '123-456-7890');

INSERT INTO TELEFONES VALUES (12346, '987-654-3210');

INSERT INTO TELEFONES VALUES (12347, '555-123-4567');

INSERT INTO TELEFONES VALUES (12348, '111-222-3333');

INSERT INTO TELEFONES VALUES (12349, '444-555-6666');

INSERT INTO TELEFONES VALUES (12350, '111-272-3473');

INSERT INTO TELEFONES VALUES (12351, '999-888-7777');

INSERT INTO TELEFONES VALUES (12352, '333-444-5555');

INSERT INTO TELEFONES VALUES (12353, '555-666-7777');

INSERT INTO TELEFONES VALUES (12354, '888-777-6666');



-- AGENDAMENTO
INSERT INTO AGENDAMENTO VALUES (1, TO_DATE('02/01/2022', 'DD/MM/YYYY'), TO_DATE('03/01/2022', 'DD/MM/YYYY'));

INSERT INTO AGENDAMENTO VALUES (2, TO_DATE('03/02/2022', 'DD/MM/YYYY'), TO_DATE('04/02/2022', 'DD/MM/YYYY'));

INSERT INTO AGENDAMENTO VALUES (3, TO_DATE('04/03/2022', 'DD/MM/YYYY'), TO_DATE('05/03/2022', 'DD/MM/YYYY'));

INSERT INTO AGENDAMENTO VALUES (4, TO_DATE('05/04/2022', 'DD/MM/YYYY'), TO_DATE('06/04/2022', 'DD/MM/YYYY'));

INSERT INTO AGENDAMENTO VALUES (5, TO_DATE('06/05/2022', 'DD/MM/YYYY'), TO_DATE('07/05/2022', 'DD/MM/YYYY'));

INSERT INTO AGENDAMENTO VALUES (6, TO_DATE('12/08/2022', 'DD/MM/YYYY'), TO_DATE('14/08/2022', 'DD/MM/YYYY'));

INSERT INTO AGENDAMENTO VALUES (7, TO_DATE('15/09/2022', 'DD/MM/YYYY'), TO_DATE('16/09/2022', 'DD/MM/YYYY'));

INSERT INTO AGENDAMENTO VALUES (8, TO_DATE('21/11/2022', 'DD/MM/YYYY'), TO_DATE('22/11/2022', 'DD/MM/YYYY'));

INSERT INTO AGENDAMENTO VALUES (9, TO_DATE('06/01/2023', 'DD/MM/YYYY'), TO_DATE('07/01/2023', 'DD/MM/YYYY'));

INSERT INTO AGENDAMENTO VALUES (10, TO_DATE('20/03/2023', 'DD/MM/YYYY'), TO_DATE('23/03/2023', 'DD/MM/YYYY'));


-- EQUIPAMENTO
INSERT INTO EQUIPAMENTO VALUES (1);

INSERT INTO EQUIPAMENTO VALUES (2);

INSERT INTO EQUIPAMENTO VALUES (3);

INSERT INTO EQUIPAMENTO VALUES (4);

INSERT INTO EQUIPAMENTO VALUES (5);

INSERT INTO EQUIPAMENTO VALUES (6);

INSERT INTO EQUIPAMENTO VALUES (7);

INSERT INTO EQUIPAMENTO VALUES (8);

INSERT INTO EQUIPAMENTO VALUES (9);

INSERT INTO EQUIPAMENTO VALUES (10);

-- PECA
INSERT INTO PECA VALUES (1, 10);

INSERT INTO PECA VALUES (2, 20);

INSERT INTO PECA VALUES (3, 30);

-- LABORATORIO
INSERT INTO LABORATORIO VALUES (1, 'GRAD4', 'Laboratório 4', null);

INSERT INTO LABORATORIO VALUES (2, 'GRAD1', 'Laboratório 1', 9);

INSERT INTO LABORATORIO VALUES (3, 'GRAD2', 'Laboratório 2', 7);

INSERT INTO LABORATORIO VALUES (4, 'GRAD3', 'Laboratório 3', 3);

INSERT INTO LABORATORIO VALUES (5, 'Lab PET', 'Laboratório do PET', 4);

-- VISITANTE
INSERT INTO VISITANTE VALUES (12357, 10, 'Reunião com o professor');

INSERT INTO VISITANTE VALUES (12358, 11, 'Participação em palestra');

INSERT INTO VISITANTE VALUES (12359, 12, 'Participação em palestra');

INSERT INTO VISITANTE VALUES (12359, 13, 'Assitir TCC');

INSERT INTO VISITANTE VALUES (12359, 15, 'Assitir TCC');

INSERT INTO VISITANTE VALUES (12357, 14, 'Visita no campus de um calouro');

INSERT INTO VISITANTE VALUES (12351, 11, 'Participação em palestra');


-- PROFESSOR
INSERT INTO PROFESSOR VALUES (12345, 'ESTRUTURA DE DADOS', 12345);

INSERT INTO PROFESSOR VALUES (12351, 'PGP', 12345);

INSERT INTO PROFESSOR VALUES (12352, 'REDES', 12345);

INSERT INTO PROFESSOR VALUES (12353, 'CALCULO I', 12345);

INSERT INTO PROFESSOR VALUES (12355, 'BD', 12345);

-- ALUNO
INSERT INTO ALUNO VALUES (12350, '2021/1', 'BD');

INSERT INTO ALUNO VALUES (12346, '2021/1', 'BD');

INSERT INTO ALUNO VALUES (12347, '2021/2', 'PGP');

INSERT INTO ALUNO VALUES (12348, '2021/2', 'ESTRUTURA DE DADOS');

INSERT INTO ALUNO VALUES (12349, '2021/2', 'ESTRUTURA DE DADOS');

-- FUNCIONARIO
INSERT INTO FUNCIONARIO_MANUTENCAO VALUES (12354, 1300, 'CARTEIRA1');

INSERT INTO FUNCIONARIO_MANUTENCAO VALUES (12356, 2500, 'CARTEIRA2');


-- MANUTENCAO
INSERT INTO MANUTENCAO VALUES (12354, 10, TO_DATE('06/06/2022', 'DD/MM/YYYY'), TO_DATE('07/06/2022', 'DD/MM/YYYY'), 'Limpeza');

INSERT INTO MANUTENCAO VALUES (12356, 10, TO_DATE('07/07/2022', 'DD/MM/YYYY'), TO_DATE('09/07/2022', 'DD/MM/YYYY'), 'Troca de cadeiras');

INSERT INTO MANUTENCAO VALUES (12356, 4, TO_DATE('09/09/2022', 'DD/MM/YYYY'), TO_DATE('10/09/2022', 'DD/MM/YYYY'), 'Troca de lâmpadas');

INSERT INTO MANUTENCAO VALUES (12354, 4, TO_DATE('18/12/2022', 'DD/MM/YYYY'), TO_DATE('20/12/2022', 'DD/MM/YYYY'), 'Conserto de fiação elétrica');

-- TROCA 
INSERT INTO TROCA VALUES (12356, 10, 1);

INSERT INTO TROCA VALUES (12356, 10, 2);

INSERT INTO TROCA VALUES (12356, 4, 3);

INSERT INTO TROCA VALUES (12354, 4, 1);

INSERT INTO TROCA VALUES (12354, 4, 3);

-- ACESSA
INSERT INTO ACESSA VALUES (12349, 1, 1);

INSERT INTO ACESSA VALUES (12351, 2, 2);

INSERT INTO ACESSA VALUES (12357, 3, 3);

INSERT INTO ACESSA VALUES (12358, 4, 4);

INSERT INTO ACESSA VALUES (12359, 5, 4);



