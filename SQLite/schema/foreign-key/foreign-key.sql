--database: ./db.sqlite

/* FOREIGN KEY */

/* 

A foreign key ou FK estabelece uma relação entre as tabelas, garantindo a integridade referencial.

no SQLite (apenas nele), o recurso de FK pode estar desabilitado, para habilitar devemos usar:

PRAGMA foreign_keys = ON;
PRAGMA foreign_keys = OFF;
PRAGMA foreign_keys;  para conferior se está ativo ou não (1 ou 0)


 */

 CREATE TABLE "cursos" (
    "id" INTEGER PRIMARY KEY,
    "nome" TEXT
 ) STRICT;

 CREATE TABLE "aulas" (
    "id" INTEGER PRIMARY KEY,
    "curso_id" INTEGER,
    "nome" TEXT,
    FOREIGN KEY("curso_id") REFERENCES "cursos" ("id")
 ) STRICT;

INSERT INTO "aulas"
    ("curso_id", nome)
VALUES
    (1, 'Fundamentos de Javascript');
    -- erro pois ainda não nenhum "id" na tabela "cursos".

-- vamos criar:

INSERT INTO "cursos"
    ("nome")
VALUES
    ('Javascript');

-- agora, tentando denovo:

INSERT INTO "aulas"
    ("curso_id", nome)
VALUES
    (1, 'Fundamentos de Javascript');
    -- sucesso!!

/* isso cria uma restrição. Caso o usuário queira agora deletar a tabela cursos com DROP TABLE dará erro, porque existe uma tabela que depende do mesmo (nesse caso, a tabela aula).*/

DROP TABLE "cursos";


/* CASCADE */

/* é uma forma de definir certos comportamentos para a tabela.

Use o CASCADE para remover (ON DELETE) ou atualizar (ON UPDATE) automaticamente as linhas dependentes ao remover/atualizar uma linha referenciada.

 */

 CREATE TABLE aulas (
    "id" INTEGER PRIMARY KEY,
    "curso_id" INTEGER,
    "nome" TEXT,
    FOREIGN KEY ("curso_id") REFERENCES "cursos" ("id") ON DELETE CASCADE
 ) STRICT;


  CREATE TABLE aulas (
    "id" INTEGER PRIMARY KEY,
    "curso_id" INTEGER,
    "nome" TEXT,
    FOREIGN KEY ("curso_id") REFERENCES "cursos" ("id") ON DELETE CASCADE ON UPDATE CASCADE
 ) STRICT;

DROP TABLE "aulas";

 /*

 esse CASCADE basicamente funciona assim:

 caso eu queira deletar dados de uma tabela que é referência de outra tabela, por exemplo nesse caso, se eu quiser deletar o registro "id" = 1 da tabela cursos e tiver uma tabela que usa esse valor, como a tabela aulas, eu devo usar o ON DELETE CASCADE na criação da tabela aulas, porque quando eu for excluir o registro da tabela cursos, os registros da tabela aulas que usam esse id também serão excluídos por "cascata", por isso o nome.

 no ON UPDATE CASCADE segue a mesma lógica, mas para atualizar um valor, caso eu queria atualizar um valor, que normalmente será o id de uma tabela que é referência de outra, eu preciso colocar o ON UPDATE CASCADE na criação da tabela que usará o id da outra tabela. Dessa forma, tanto na tabela que faz referencia quanto na que usa a referência, serão atualizados os dados.
*/

UPDATE "cursos"
set "nome" = 'Python'
where "id" = 1;


SELECT * FROM "aulas";
