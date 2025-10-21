--database: ./db.sqlite

/*

Generated Columns

nada mais é do que a geração de colunas automaticamente a partir de outras colunas, não é possível inserir dados manualmente nas mesmas. Existem dois tipos:

VIRTUAL:

Calcula o valor durante a execução da query, não ocupa espaço no disco portanto não faz de fato parte da tabela, é só para visualização.

STORED:

Armazena o valor no disco, como uma coluna normal. Utilizar quando a coluna é geralmente utilizada em filtros/consultas.

*/

CREATE TABLE "users" (
  "id" INTEGER PRIMARY KEY,
  "nome" TEXT NOT NULL,
  "sobrenome" TEXT NOT NULL,
  "nome_completo_virtual" TEXT GENERATED ALWAYS AS ("nome" || ' ' || "sobrenome") VIRTUAL,
  "nome_completo_stored" TEXT GENERATED ALWAYS AS ("nome" || ' ' || "sobrenome") STORED
) STRICT;

INSERT INTO "users" ("nome", "sobrenome")
VALUES ('Guli', 'Nagai') ;

SELECT * FROM "users";
    


-- GENERATED ALWAYS é opcional e VIRTUAL é o padrão.
CREATE TABLE "users" (
  "id" INTEGER PRIMARY KEY,
  "nome" TEXT NOT NULL,
  "sobrenome" TEXT NOT NULL,
  "nome_completo_virtual" TEXT AS ("nome" || ' ' || "sobrenome"),
  "nome_completo_stored" TEXT AS ("nome" || ' ' || "sobrenome") STORED
) STRICT;    -- eu poderia ter criado dessa forma

-- Durante o SELECT podemos criar uma coluna gerada temporária:
SELECT *, ("nome" || ' ' || "sobrenome") AS "nome_completo" FROM "users";

-- nessa última forma, a coluna é gerada somente no momento do select, ou seja, se eu fizer outro select e tirar essa seleção, ele será removido da visualização. Também é comum visualizar isso quando em funções de agregação como SUM(), COUNT(), AVG(), etc, quando queremos renomear usando o AS para facilitar a identificação do que é esse campo, nesse processo é a mesma coisa, está sendo gerado um generated column no momento do SELECT.


