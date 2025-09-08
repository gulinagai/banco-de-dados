--database: ./db.sqlite


/* STRICT

No modo strict (estrito), o SQLite impõe regras mais rígidas sobre os tipos de dados

no CREATE TABLE: apenas alguns tipos de dados são permitidos

no INSERT: os dados podem corresponder ao tipo definido na tabela

 */

 CREATE TABLE "cursos" (
  "id" INTEGER,
  "nome" TEXT,
  "preco" INTEGER
) STRICT;

INSERT INTO
  "cursos" ("id", "nome", "preco")
VALUES
  ('a', 'HTML', 1000); -- ERRO, 'a' não é um INTEGER

INSERT INTO
  "cursos" ("id", "nome", "preco")
VALUES
  ('1', 'HTML', 1000); -- Funciona, transforma '1' em 1


/* Tipos de dados permitidos com uso do STRICT:

INT
*: Números inteiros

INTEGER
: Números inteiros

TEXT
: Texto

REAL
: Números flutuantes

BLOB
: Dados binários

ANY
: Qualquer tipo de dado
 */

 -- sintaxe:

 CREATE TABLE "cursos" (
  "id" INTEGER,
  "nome" TEXT,
  "preco" INTEGER
) STRICT;
