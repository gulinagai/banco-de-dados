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


/* DELETE */

/* 
    Serve para deletar um registro/linha da tabela. 

    Normalmente, será acompanhado de uma condicional (where), dificilmente será sem, porque excluirá todos os registros daquela tabela

    lembrando que, DELETE é diferente de DROP. DELETE deleta os registros mas mantém a estrutura com as colunas, DROP deleta a tabela em si.
*/

/* Sintaxe: */

DELETE FROM "cursos";


/* DELETE com condicional (where) */

DELETE FROM "cursos" where id = 2; /* apaga todos os registros onde o id é 2 */