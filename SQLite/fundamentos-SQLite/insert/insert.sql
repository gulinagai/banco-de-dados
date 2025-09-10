--database: ./db.sqlite  

CREATE TABLE cursos (
    id INTEGER NOT NULL,
    nome TEXT NOT NULL,
    aulas INTEGER
);

/* insert (sintaxe) */

INSERT INTO cursos (id, nome, aulas) VALUES (1, 'HTML', '10');

/* CONSTRAINTS E INSERT */

/* Erros de inserção devido a restrições previamente definidas(constraints) */

INSERT INTO cursos (nome, aulas) VALUES ('CSS', 12);

/* erro NOT NULL porque o id é NOT NULL. */



/* ASPAS no insert: */

/* Existem 2 tipos de aspas possíveis de serem utilizadas: aspas simples ('') e aspas duplas ("") */

/* 
as aspas simples são usadas exclusivamente para strings.END TRANSACTION

as aspas duplas são usadas exclusivamente para identificadores como nomes de colunas ou tabelas 
(no MySQL é usado as aspas invertidas `...`)

os números são definidos sem aspas.
*/

INSERT INTO "cursos" ("id", "nome", "aulas") VALUES (1, 'HTML', 10);

/* O uso de asoas duplas para tabelas e colunas não é obrigatório, porém, é uma boa prática pois não permite possíveis conflitos com palavras chave do SQLite, permitindo criar tabelas com qualquer nome, mesmo que aquela palavra seja igual a uma das palavras chave do SQLite. */

/* Indentação */

/* A indentação é opcional, mas ajuda na legibilidade, principalmente em queries mais complexas. */

INSERT INTO "cursos" 
    ("id", "nome", "aulas") 
VALUES 
    (1, 'HTML', 10);

INSERT INTO 
    "cursos" ("id", "nome", "aulas") 
VALUES 
    (1, 'HTML', 10);


/* A forma de indentar não muda em nada o código, é só um questão visual*/

/* Múltiplos Registros */

/* Podemos inserir múltiplos registros em uma tabela em um único insert, basta separar por vírgula e continuar */

INSERT INTO "cursos" 
    ("id", "nome", "aulas") 
VALUES 
    (2, 'CSS', 17),
    (3, 'Javascript', 53);
