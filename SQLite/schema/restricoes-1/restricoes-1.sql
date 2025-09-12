--database: ./db.sqlite

/*

RESTRIÇÕES ou CONSTRAINTS

Existem vários tipos de restrições para campos, nessa aula serão vistos:

- NOT NULL

O valor da coluna não pode ser nulo.

sintaxe:

CREATE TABLE "usuario" (
  "id" INTEGER PRIMARY KEY,
  "nome" TEXT NOT NULL
) STRICT;

- UNIQUE

Como o próprio nome diz, define como único na tabela.

Existem 2 formas de se utilizar UNIQUE:

1. Em uma coluna específica, escrevendo UNIQUE diretamente na definição da coluna. O valor da coluna deve ser único em relação às outras linhas da tabela.

sintaxe:

CREATE TABLE "usuario" (
  "id" INTEGER PRIMARY KEY,
  "email" TEXT NOT NULL UNIQUE,
  "nome" TEXT NOT NULL
) STRICT;

2. Aplicando para mais de uma coluna, esse "conjunto de valores específicos para determinadas colunas específicas simultaneamente" deve ser único, criando uma chave única composta

sintaxe:

CREATE TABLE "certificados" (
  "id" INTEGER PRIMARY KEY,
  "pessoa_id" INTEGER NOT NULL,
  "curso_id" INTEGER NOT NULL,
  UNIQUE ("pessoa_id", "curso_id")
) STRICT;

- COLLATE

Define como a comparação de textos deve ser feita, por exemplo, se deve ser sensível a maiúsculas e minúscuolas NOCASE.

Com o COLLATE NOCASE Guli@email.com é o mesmo que guli@email.com

sintaxe:

CREATE TABLE "usuario" (
  "id" INTEGER PRIMARY KEY,
  "email" TEXT NOT NULL UNIQUE COLLATE NOCASE,
  "nome" TEXT NOT NULL
) STRICT;

*/

CREATE TABLE "cursos" (
    "id" INTEGER PRIMARY KEY,
    "nome" TEXT NOT NULL
) STRICT;

INSERT INTO "cursos"
    ("nome")
VALUES
    (null);  -- erro NOT NULL CONSTRAINT


DROP TABLE "cursos";

CREATE TABLE "usuario" (
    "id" INTEGER PRIMARY KEY,
    "nome" TEXT NOT NULL,
    "email" TEXT NOT NULL UNIQUE
) STRICT;

INSERT INTO "usuario" 
    ("nome", "email")
VALUES
    ('Gustavo Nagai', 'guli@email.com'); -- se eu tentar cadastrar duas vezes com o mesmo email vai dar errado, por conta da constraint UNIQUE


CREATE TABLE "certificados" (
  "id" INTEGER PRIMARY KEY,
  "pessoa_id" INTEGER NOT NULL,
  "curso_id" INTEGER NOT NULL,
  UNIQUE ("pessoa_id", "curso_id")
) STRICT;

INSERT INTO "certificados" 
    ("pessoa_id", "curso_id")
VALUES
    (1, 1);  -- erro se tentar inserir duas vezes com esse mesmos valores (1,1)


INSERT INTO "certificados" 
    ("pessoa_id", "curso_id")
VALUES
    (1, 2);



DROP TABLE "usuario";


CREATE TABLE "usuario" (
    "id" INTEGER PRIMARY KEY,
    "nome" TEXT NOT NULL,
    "email" TEXT NOT NULL UNIQUE COLLATE NOCASE
) STRICT;


INSERT INTO "usuario" 
    ("nome", "email")
VALUES
    ('Guli', 'gulinAGAI@email.com');

DELETE FROM "usuario";