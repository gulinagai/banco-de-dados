--database: ./db.sqlite

/* PRIMARY KEY */

-- Define uma coluna como chave primária, que deve ser única e não nula.

-- Sintaxe:

CREATE TABLE "cursos" (
    "id" INTEGER PRIMARY KEY,
    "nome" TEXT,
    "preco" INTEGER
) STRICT;

INSERT INTO "cursos"
    ("nome", "preco")
VALUES
    ('HTML', 1000);


/* O primary key basicamente já cria um valor INTEGER ou TEXT (dependendo do que for colocado) e auto-incrementa, caso não haja um valor inicial especificado, será iniciado com 1, os valores posteriores serão sempre o incremento do ultimo valor adicionado na tabela */


/* RowId */

-- No SQLite (apenas nele, no MySQL e PostgreeSQL não.), existe uma coluna oculta chamada rowid, que é um identificador único para cada linha.

-- Se não for definido uma chave primária, o SQLite cria automaticamente uma coluna rowid, que funciona basicamente como uma.

-- Se uma coluna for definida como INTEGER PRIMARY KEY, ela sobrepõe a coluna rowid, ou seja, a coluna rowid se torna a coluna id. Se for usado INT ao invés de INTEGER, isso não acontece, por isso é recomendado que se use INTEGER.

SELECT rowid, id from "cursos";