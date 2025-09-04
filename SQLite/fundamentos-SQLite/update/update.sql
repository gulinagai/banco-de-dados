--database: ./db.sqlite

CREATE TABLE cursos (
    id INTEGER NOT NULL,
    nome TEXT NOT NULL,
    aulas INTEGER
);



INSERT INTO "cursos" 
    ("id", "nome", "aulas") 
VALUES 
    (1, 'HTML', 10);

    INSERT INTO "cursos" 
    ("id", "nome", "aulas") 
VALUES 
    (2, 'Javascript', 52);

        INSERT INTO "cursos" 
    ("id", "nome", "aulas") 
VALUES 
    (3, 'React', 32);

/* UPDATE */


/* O update atualiza o valor de um registro de uma coluna de uma tabela de acordo com a coluna que é passada

Não se usa FROM. O nome da tabela é colocado logo após o UPDATE.

Palavra chave SET: após essa palavra chave, é colocado a coluna que eu quero alterar o valor.
caso eu queria alterar mais de uma coluna, basta eu colocar ',' e colocar a próxima, mas a estrutura é:

UPDATE "tabela" SET "coluna1" = 'Valor novo', "coluna2" = 'Valor Novo'

lembrando que normalmente se aplica condicional (where) no update também, senão irá alterar todos os registros.
 */

UPDATE "cursos"
SET "nome" = 'Node.js',
    "aulas" = 22
WHERE "id" = 3;