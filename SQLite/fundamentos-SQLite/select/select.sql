--database: ./db.sqlite

/* SELECT */

/* 
    Faz uma consulta na tabela que for colocada, mostrando os valores dos registros de acordo com a coluna especificada e com palavras chave:


    * = mostra todas as colunas 
    "nomedacoluna" = só mostro essa coluna
    "coluna1", "coluna2" = mostra as duas colunas

 */

 /* SINTAXE: */

 SELECT "id", "nome" from "cursos";

 SELECT * FROM "cursos";



 CREATE TABLE cursos (
    id INTEGER NOT NULL,
    nome TEXT NOT NULL,
    aulas INTEGER
);



INSERT INTO "cursos" 
    ("id", "nome", "aulas") 
VALUES 
    (1, 'HTML', 10);

INSERT INTO "cursos" 
    ("id", "nome", "aulas") 
VALUES 
    (2, 'Javascript', 52);

INSERT INTO "cursos" 
    ("id", "nome", "aulas") 
VALUES 
    (3, 'React', 32);


SELECT "nome", "aulas" FROM "cursos";


/* LIMIT */

/* Palavra chave que permite limitar a quantidade de registros/linhas que será feito a ação, nesse caso, uma consulta (select) */

/* por padrão, a ordem que é mostrada os registros é de cima para baixo dos registros da tabela */

SELECT * FROM "cursos" LIMIT 5;

/* WHERE */

/* Também posso usar o where (condicional) que filtrar[a as linhas da tabela com base em uma condição

Principais sinais: > < >= <= !=
*/

SELECT * FROM "cursos" WHERE "id" = 3;

SELECT * FROM "cursos" WHERE "aulas" > 23;

SELECT * FROM "cursos" WHERE "nome" != 'React' LIMIT 3;


/* Posso usar vários where também, basta utilizar AND ou OR */

/* vamos adicionar uma informação para mostrar isso melhor: */

INSERT INTO "cursos" 
    ("id", "nome", "aulas") 
VALUES 
    (2, 'Javascript', 74);

SELECT * FROM "cursos" where "nome" = 'Javascript' AND "aulas" > 60;


SELECT "nome", "aulas" FROM "cursos" WHERE "aulas" > 0 AND "aulas" < 20 OR "aulas" > 60 AND "aulas" < 75; 

