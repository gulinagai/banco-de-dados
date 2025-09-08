--database: ./db.sqlite

/*

Tipos de dados no SQLite

PRINCIPAIS TIPOS:

INTEGER - Armazena números inteiros

    inclusive boolean (0, 1)
    timestamp (registro digital de data e hora que indidica o momento exato em que um evento ocorreu)

TEXT - Armazena textos

    strings, datas, json

Dados no SQLite

Existem 3 momentos importantes em que o SQLite lida com tipos de dados:

1. Na definição de tabelas
    Definir o tipo de dado da coluna

2. Inserção de dados
    Concerte o dado para o tipo de acordo com a afinidade da coluna

3. Consulta de dados
    Retorna o valor armazenado

Tipos de dados do SQLite:

TEXT - Texto

INTEGER - Números inteiros

REAL - Números flutuantes

BLOB - Dados binários

NULL - Valor nulo

Porém, existem diversos outros tipos de dados em outros bancos de dados como o MYSQL, o PostgreeSQL, etc.

por exemplo, nesses bancos existe:

INT
TINYINT
SMALLINT
MEDIUMINT
BIGINT
UNSIGNED BIG INT
INT2
INT8

CHARACTER(20)
VARCHAR(255)
VARYING CHARACTER(255)
NCHAR(55)
NATIVE CHARACTER(70)
NVARCHAR(100)
TEXT
CLOB

BLOB
sem tipo de dado especificado

REAL
DOUBLE
DOUBLE PRECISION
etc

no SQLite, 99% da definição do tipo de dado, será TEXT ou INTEGER, pois o SQLite converte qualquer que seja esses tipos de dados para seu tipo de dado de afinidade.

por exemplo, INT, TINYINT, SMALLINT, possuem afinidade pelo tipo INTEGER, então no final das contas, caso seja verificado o tipo de dado daquele campo depois que a tabela foi formada, será INTEGER.
mesma coisa com VARCHAR, NCHAR, CHARACTER, que se tornarão TEXT

porém, isso só ocorre no SQLite. Em bancos de dados mais complexos como o MySQL e o PostgreeSQL usam todos esses tipos que foram mencionados.

----------

No SQLite, quando se define um tipo de dado de um campo, esse tipo de dado não é definitivamente imposto, ou seja, se eu colocar um campo tipo INTEGER e escrever um texto, ele vai aceitar

a não ser se definirmos de forma estrita, que será visto na próxima aula.

caso não, o SQLite sempre vai pegar a informação e tentar transformar para o tipo de dado de afinidade, que podem ser aqueles mencionados: TEXT, INTEGER, REAL, BLOB e NUMERIC.

*/

CREATE TABLE "produtos" (
    "id" INT,
    "descontinuado" TINYINT,
    "nome" VARCHAR(100),
    "preco" DECIMAL(10, 2),
    "descricao" TEXT,
    "data_criacao" DATETIME
);

INSERT INTO "produtos" 
    ("id", "descontinuado", "nome", "preco", "descricao", "data_criacao")
VALUES
    (1, 0, 'Notebook', 200.5, null, '24-10-2049');

-- confirmando o que foi dito acima:

SELECT "id", "descontinuado" FROM "produtos";

SELECT typeof("id"), typeof("descontinuado") FROM "produtos";
-- ambos retornaram INTEGER

-- o typeof é uma função que retorna o tipo de dado do dado que está dentro da função

SELECT typeof("descricao") FROM "produtos";


-- No SQLite, quando eu defino um tipo de dado para um campo, mesmo que eu faça o INSERT com o tipo de dado totalmente diferente, o SQLite irá aceitar o INSERT e converter o tipo dependendo da afinidade e com que tipo de dado aquele dado parece, por exemplo:

INSERT INTO "produtos" 
    ("id", "descontinuado", "nome", "preco", "descricao", "data_criacao")
VALUES
    ('1', '0', 999, '200.5', 2, 2049);


SELECT * FROM "produtos";

-- foi adicionado.

-- vamos verificar o tipo:

SELECT typeof("id"), typeof("descontinuado"), typeof("nome"), typeof("preco"), typeof("descricao"), typeof("data_criacao") FROM "produtos";

-- o que aconteceu foi que, mesmo fazendo o INSERT com valores não condizentes com o tipo definido no CREATE TABLE, o SQLite consegue converter o tipo para o valor especificado no CREATE TABLE na maioria das vezes, porém temos um problema, o DATETIME acabou criando um dado do tipo INTEGER e outro do tipo TEXT, tornando o comando inconsistente. Para isso, e para que definamos que o usuário defina unicamente um tipo de valor específico, usamos o STRICT.


