/*

Normalização

A normalização é o processo de organizar os dados para reduzir redundâncias e dependências, dividindo tabelas em entidades menores. São diferentes formas normais (FN) que ajudam a estruturar os dados de forma eficiente.

1FN 

Diz que cada célula da tabela deve guardar somente um único valor, sem listas ou valores separados por vírgula dentro de uma mesma célula


-- não normalizado
CREATE TABLE "produtos" (
  "id" INTEGER PRIMARY KEY,
  "nome" TEXT
) STRICT;

CREATE TABLE "pedidos" (
  "id" INTEGER PRIMARY KEY,
  "produtos" TEXT,
  "criado" TEXT DEFAULT CURRENT_TIMESTAMP
) STRICT;

INSERT INTO "pedidos" ("produtos") VALUES ('[1,2,3]');
Copiar
-- normalizado (1FN)
CREATE TABLE "produtos" (
  "id" INTEGER PRIMARY KEY,
  "nome" TEXT
) STRICT;

CREATE TABLE "pedidos" (
  "id" INTEGER PRIMARY KEY,
  "criado" TEXT DEFAULT CURRENT_TIMESTAMP
) STRICT;

CREATE TABLE "pedido_produtos" (
  "pedido_id" INTEGER,
  "produto_id" INTEGER,
  FOREIGN KEY ("pedido_id") REFERENCES "pedidos" ("id"),
  FOREIGN KEY ("produto_id") REFERENCES "produtos" ("id")
) STRICT;

INSERT INTO "pedidos" ("id") VALUES (1);

INSERT INTO "pedido_produtos" ("pedido_id", "produto_id") VALUES (1, 1), (1, 2), (1, 3);



2FN 

Para entendermos o que é isso, precisamos entender o que é chave primária composta ou Composite Primary Key

A chave primária composta é formada por duas ou mais colunas de uma tabela, e ela é usada quando apenas uma coluna não consegue garantir unicidade, garantir que cada valor daquela coluna seja único

mas a combinação entre os valores das duas colunas torna aquele valor único.

sintaxe:

PRIMARY KEY (coluna1, coluna2)


sabendo disso, na 2FN deve ser eliminado as colunas que dependem parcipalmente da primary key, e não totalmente dela. Por exemplo, depende de uma das colunas da Primary key, mas a outra não

não pode ter nenhuma coluna que dependa apenas de parte da chave primária composta, tem que depender de tudo

essas colunas que dependem parcialmente da chave primária composta são chamadas dependências parciais.

CREATE TABLE "usuarios" (
  "id" INTEGER PRIMARY KEY,
  "nome" TEXT
) STRICT;

CREATE TABLE "cursos" (
  "id" INTEGER PRIMARY KEY,
  "nome" TEXT
) STRICT;
Copiar
-- não normalizado (2FN)
CREATE TABLE "certificados" (
  "usuario_id" INTEGER,
  "curso_id" INTEGER,
  "curso_nome" TEXT,
  FOREIGN KEY ("usuario_id") REFERENCES "usuarios" ("id"),
  FOREIGN KEY ("curso_id") REFERENCES "cursos" ("id"),
  PRIMARY KEY ("usuario_id", "curso_id")
) STRICT;


-- normalizado (2FN)
CREATE TABLE "certificados" (
  "usuario_id" INTEGER,
  "curso_id" INTEGER,
  FOREIGN KEY ("usuario_id") REFERENCES "usuarios" ("id"),
  FOREIGN KEY ("curso_id") REFERENCES "cursos" ("id"),
  PRIMARY KEY ("usuario_id", "curso_id")
) STRICT;

3FN 

Quando se existe  colunas que dependem de outra(s) colunas não-chave, deve ser criado uma nova tabela que será específica para isso.
Na tabela que continha tudo deve conter agora apenas o id da nova tabela criada

Essas colunas que dependem de outra coluna que não é chave são chamadas de dependências transitivas


-- não normalizado (3FN)
CREATE TABLE "usuarios" (
  "id" INTEGER PRIMARY KEY,
  "nome" TEXT,
  "tipo" TEXT CHECK ("tipo" IN ('usuario', 'admin')),
  "tipo_leitura" INTEGER CHECK ("tipo_leitura" IN (0, 1)),
  "tipo_escrita" INTEGER CHECK ("tipo_escrita" IN (0, 1))
) STRICT;


-- normalizado (3FN)
CREATE TABLE "usuarios" (
  "id" INTEGER PRIMARY KEY,
  "nome" TEXT,
  "tipo_id" INTEGER,
  FOREIGN KEY ("tipo_id") REFERENCES "tipos" ("id")
) STRICT;

CREATE TABLE "tipos" (
  "id" INTEGER PRIMARY KEY,
  "tipo" TEXT UNIQUE,
  "leitura" INTEGER CHECK ("leitura" IN (0, 1)),
  "escrita" INTEGER CHECK ("escrita" IN (0, 1))
) STRICT;


Tabela Referência

Quando temos uma coluna não chave que possui valores geralmente fixos e repetidos, como estados, tipos de usuário, status de pedido, etc. Podemos criar uma tabela de referência para normalizar esses dados.

Foi literalmente o que foi feito no 3FN mas é importante lembrar que, o 3FN consiste em eliminar dependências transitivas, e a criação de uma tabela referência pode ser a solução nesse sentido.

CREATE TABLE "status_pedido" (
  "id" INTEGER PRIMARY KEY,
  "nome" TEXT UNIQUE NOT NULL,
  "cor" TEXT NOT NULL,
  "encerrado" INTEGER NOT NULL CHECK ("encerrado" IN (0,1))
) STRICT;

INSERT INTO
  "status_pedido" ("nome", "cor", "encerrado")
VALUES
  ('aguardando', '#FFC107', 0),
  ('pago', '#17A2B8', 0),
  ('separando', '#007BFF', 0),
  ('enviado', '#6610F2', 0),
  ('entregue', '#28A745', 1),
  ('cancelado', '#DC3545', 1);

CREATE TABLE "pedidos" (
  "id" INTEGER PRIMARY KEY,
  "valor_total" INTEGER NOT NULL,
  "status_id" INTEGER NOT NULL,
  FOREIGN KEY ("status_id") REFERENCES "status_pedido" ("id")
) STRICT;

INSERT INTO
  "pedidos" ("valor_total", "status_id")
VALUES
  (100, 1), (200, 2), (150, 3);


*/