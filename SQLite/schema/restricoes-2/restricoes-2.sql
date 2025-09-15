--database: ./db.sqlite

-- DEFAULT

/* DEFAULT é outra restrição/configuração que eu posso definir para um campo da tabela. Com ele
é possível definir um valor padrão que será utilizado caso não seja passado nenhum valor para esse campo no INSERT. */

CREATE TABLE "usuario" (
  "id" INTEGER PRIMARY KEY,
  "email" TEXT NOT NULL UNIQUE COLLATE NOCASE,
  "nome" TEXT NOT NULL,
  "tipo" TEXT NOT NULL DEFAULT 'usuario',
  "criado" TEXT DEFAULT CURRENT_TIMESTAMP
) STRICT;


-- eu posso passar uma função como padrão para o DEFAULT também, o CURRENT_TIMESTAMP é uma função que retorna a data do momento atual em que ele é chamado. Será visto sobre funções mais a frente.

INSERT INTO "usuario" ("email", "nome") VALUES ('guli@hotmail.com', 'Guli Nagai');

INSERT INTO "usuario" ("email", "nome", "tipo", "criado") VALUES ('guli1@hotmail.com', 'Guli Nagai', 'admin', 'abcde');

DROP TABLE "usuario";

-- CHECK

/* A restrição CHECK serve para validar aquele dado e verificar se ele atende a determinada condição, que você passar */

-- A estrutura é CHECK ("campo" condicao)

CREATE TABLE "usuario" (
  "id" INTEGER PRIMARY KEY,
  "email" TEXT NOT NULL UNIQUE COLLATE NOCASE,
  "nome" TEXT NOT NULL,
  "tipo" TEXT NOT NULL DEFAULT 'usuario' CHECK ("tipo" IN ('usuario', 'admin')),
  "vitalicio" INTEGER NOT NULL DEFAULT 0 CHECK ("vitalicio" IN (0, 1)),
  "criado" TEXT DEFAULT CURRENT_TIMESTAMP
) STRICT;

INSERT INTO "usuario"
    ("email", "nome", "tipo", "vitalicio", "criado")
VALUES
    ('guli@email.com', 'Guli Nagai', 'aluno', 3, 'qualquercoisa'); -- não vai fazer o insert pq o tipo e o vitalicio não atendem ao check

INSERT INTO "usuario"
    ("email", "nome", "tipo", "vitalicio", "criado")
VALUES
    ('guli@email.com', 'Guli Nagai', 'usuario', 1, 'qualquercoisa');

INSERT INTO "usuario"
    ("email", "nome")
VALUES
    ('gulinagai@email.com', 'Guli Nagai');