-- Sub consulta e Consulta externa

-- Mostre o nome e data emissão do cracha de todos os usuarios que são alunos e estão no segundo período
SELECT U.NOME, C.DATA_EMISSAO
FROM USUARIO U INNER JOIN CRACHA C ON U.NUM_CRACHA = C.NUM_CRACHA INNER JOIN ALUNO A ON U.MATRICULA = A.MATRICULA
WHERE PERIODO = '2';

-- Deve-se mostrar o nome de todos os alunos que agendaram laboratórios na data 02-JAN-22
SELECT U.NOME
FROM USUARIO U INNER JOIN ACESSA A
            ON U.MATRICULA = A.MATRICULA INNER JOIN AGENDAMENTO AG
    	ON A.COD_AGEND = AG.COD_AGEND
WHERE AG.DATA_INICIO = '02-JAN-22' AND U.MATRICULA IN (
    	SELECT A.MATRICULA
            FROM ALUNO A);

-- Mostre os usuarios que levaram mais de um 1 visitante 
SELECT U.NOME, COUNT(*)
FROM USUARIO U INNER JOIN VISITANTE V ON U.MATRICULA = V.MATRICULA
GROUP BY U.NOME
HAVING COUNT(*) > 1;

-- Mostre o Num_Sala dos laboratorios que nunca tiveram um agendamento
SELECT L.NUM_SALA 
FROM LABORATORIO L LEFT JOIN ACESSA A ON L.COD_LAB = A.COD_LAB INNER JOIN AGENDAMENTO AG ON A.COD_AGEND = AG.COD_AGEND
WHERE A.COD_LAB IS NULL AND AG.COD_AGEND IS NULL; 

-- Mostre o nome e email dos usuários que ja levaram algum visitante, não pode fazer a consulta com JOIN
SELECT U.NOME, U.EMAIL
FROM USUARIO U 
WHERE EXISTS (
	SELECT * 
    FROM VISITANTE V 
    WHERE V.MATRICULA = U.MATRICULA);

-- Mostre o nome e o número do crachá dos usuários que nunca levaram algum visitante, não pode fazer a consulta com JOIN, e faça ordenado pelo número do cracha
SELECT U.NOME, U.NUM_CRACHA
FROM USUARIO U   
WHERE NOT EXISTS (
	SELECT * 
    FROM VISITANTE V 
    WHERE V.MATRICULA = U.MATRICULA)
ORDER BY U.NUM_CRACHA;

-- Mostre o codigo das peça que tem mais ou um numero igual de peças que a media total de todos os tipos de peças 
SELECT P.COD_PECA
FROM PECA P
WHERE P.QTD >= (SELECT AVG(QTD)
    FROM PECA)
    
-- Mostre a matricula dos funcionários que começaram e terminaram uma manutenção no mesmo dia do funcionário com matricula 123456 
SELECT MATRICULA
FROM MANUTENCAO
WHERE (DATE(DATA_INICIO_MANUTENCAO), DATE(DATA_FIM_MANUTENCAO)) IN (
	SELECT DATE(DATA_INICIO_MANUTENCAO), DATE(DATA_FIM_MANUTENCAO)
    FROM MANUTENCAO
    WHERE MATRICULA = 123456);
