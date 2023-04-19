-- Sub consulta e Consulta externa



-- Mostre os usuarios que levaram mais de um 1 visitante 
SELECT U.NOME, COUNT(*)
FROM USUARIO U INNER JOIN VISITANTE V ON U.MATRICULA = U.MATRICULA
GROUP BY U.NOME
HAVING COUNT(*) > 1

-- Mostre o Num_Sala dos laboratorios que nunca tiveram um agendamento
SELECT L.NUM_SALA 
FROM LABORATORIO L LEFT JOIN ACESSA A ON L.COD_LAB = A.COD_LAB INNER JOIN AGENDAMENTO AG ON A.COD_AGEND = AG.COD_AGEND
WHERE A.COD_LAB IS NULL AND AG.COD_AGEND IS NULL; 
