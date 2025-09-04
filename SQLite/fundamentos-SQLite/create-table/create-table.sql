-- database: ./db.sqlite

/*Sintaxe para criar tabela:*/

CREATE TABLE cursos (id, nome, aulas);

/*Sintaxe para criar/excluir uma tabela:*/

DROP TABLE cursos;


/* Definindo tipos de dados das colunas e as restrições(conhecido como constraints) */

CREATE TABLE cursos (
    id INTEGER NOT NULL,
    nome TEXT NOT NULL,
    aulas INTEGER
);

/* sempre separado por vírgulas, no ultimo não precisa. */

/* 
    INTERGER = tipo numérico 
    TEXT = tipo texto
    NOT NULL = significa que não pode ser nulo.
*/



/* Checar Tabela */

PRAGMA TABLE_INFO('cursos');


/* Serve para checar as características da tabela, como os campos e suas caracteristicas */