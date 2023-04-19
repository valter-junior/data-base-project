-- CONSULTAS SELECT 

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
SELECT L.ENDERECO_NUM_SALA 
FROM LABORATORIO L LEFT JOIN ACESSA A ON L.COD_LAB = A.COD_LAB
WHERE A.COD_LAB IS NULL; 

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
    
-- Mostre a Nome dos alunos que cursam a mesma cadeira e estão no mesmo período do aluno com matricula
SELECT U.NOME
FROM ALUNO A, USUARIO U
WHERE A.MATRICULA = U.MATRICULA AND
    (A.CADEIRA, A.PERIODO) = (
    SELECT A1.CADEIRA, A1.PERIODO
    FROM ALUNO A1
    WHERE A1.MATRICULA = 12350
    AND A.MATRICULA <> 12350 
);
    
-- Mostre a matricula dos funcionários que começaram e terminaram uma manutenção no mesmo dia do funcionário com matricula 12356 
SELECT M1.MATRICULA
FROM MANUTENCAO M1
WHERE (M1.DATA_INICIO_MANUTENCAO, M1.DATA_FIM_MANUTENCAO) IN (
	SELECT M2.DATA_INICIO_MANUTENCAO, M2.DATA_FIM_MANUTENCAO
    FROM MANUTENCAO M2
    WHERE M2.MATRICULA = 12356
    AND M1.MATRICULA <> 12356);


-- FUNÇÕES/PROCEDIMENTOS

-- Retorna a qauntidade total de Laboratórios
CREATE OR REPLACE
PROCEDURE
	exibir_qtd_lab
IS 
	qtdLab number; 
BEGIN 
	SELECT COUNT(COD_LAB) INTO qtdLab
	FROM LABORATORIO;
	DBMS_OUTPUT.PUT_LINE('Quantidade : '||qtdLab);
END;

BEGIN
	exibir_qtd_lab;
END;

-- Remove da tabela Aluno o Miguel Diaz que tem como número de matricula 12360
CREATE OR REPLACE FUNCTION
	remove_aluno(mat_aluno IN NUMBER);
	RETURN VARCHAR(2)
IS
	codU ALUNO.MATRICULA%TYPE := 12360;
BEGIN
	DELETE FROM ALUNO
	WHERE MATRICULA = codU
	RETURN 'Aluno removido';
	
EXCEPTION
	WHEN NO_DATA_FOUND THEN
	RETURN 'Aluno não foi encontrado';
END;


-- Altera o email do Usuario Gabriel Laroche co matricula 12347
DECLARE
novo_email USUARIO.EMAIL%TYPE := 'glarocheborba@gmail.com';
BEGIN 
	UPDATE USUARIO
	SET EMAIL = novo_email
	WHERE MATRICULA = 12347;
	COMMIT;
END;

