-- Sub consulta e Consulta externa

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

-- Mostre o nome e email dos usuários que nunca levaram algum visitante, não pode fazer a consulta com JOIN
SELECT U.NOME, U.EMAIL
FROM USUARIO U 
WHERE NOT EXISTS (
	SELECT * 
    FROM VISITANTE V 
    WHERE V.MATRICULA = U.MATRICULA);
