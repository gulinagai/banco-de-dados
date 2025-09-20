--database: ./db.sqlite

-- Crie possíveis tabelas para os JSON's abaixo.

-- Defina os tipos de dados, chaves primárias e estrangeiras, relacionamentos entre as tabelas e as restrições necessárias.

-- Considerações:

-- - Use STRICT.

-- - CURRENT_TIMESTAMP retorna a data e hora atual.

-- - PRIMARY KEY (id1, id2) define uma chave primária composta.

-- - O SLUG do curso precisa ser único
-- /api/javascript-basico

-- - O SLUG da aula precisa ser único em relação ao curso.
-- /api/javascript-basico/variaveis-let-const

-- - Se o usuário for deletado, as aulas concluídas e certificados desse usuário também devem ser removidas.

-- - O campo "free" na tabela de aulas deve ser um booleano.


-- Users
-- {
--   "id": 42,
--   "name": "André",
--   "password": "senha123",
--   "email": "andre@email.com",
--   "created": "2049-06-14 12:34:56"
-- }

CREATE TABLE "users" (
    "id" INTEGER PRIMARY KEY,
    "name" TEXT NOT NULL, 
    "password" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "created" TEXT DEFAULT CURRENT_TIMESTAMP
) STRICT;

INSERT INTO "users"
    ("id", "name", "password", "email", "created")
VALUES
     (42, 'André', 'senha123', 'andre@email.com', '2049-06-14 12:34:56');

DELETE FROM "users";

DROP TABLE "courses";
-- Courses
-- {
--   "id": 1,
--   "slug": "javascript-basico",
--   "title": "JavaScript Básico",
--   "description": "Aprenda os fundamentos da linguagem JavaScript.",
--   "aulas": 20,
--   "horas": 5,
--   "created": "2049-06-14 12:34:56"
-- }

CREATE TABLE "courses" (
    "id" INTEGER PRIMARY KEY,
    "slug" TEXT UNIQUE NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "aulas" INTEGER NOT NULL,
    "horas" INTEGER NOT NULL,
    "created" TEXT DEFAULT CURRENT_TIMESTAMP
) STRICT;

INSERT INTO "courses"
    ("slug", "title", "description", "aulas", "horas", "created")
VALUES
    ('javascript-basico', 'JavaScript Básico', 'Aprenda os fundamentos da linguagem JavaScript.', 20, 5, '2049-06-14 12:34:56');

INSERT INTO "courses"
    ("slug", "title", "description", "aulas", "horas", "created")
VALUES
    ('javascript-basico', 'React Avançado', 'Aprenda os fundamentos de React.js.', 32, 12, '2049-05-14 21:25:50'); -- erro pq o slug é unico

INSERT INTO "courses"
    ("slug", "title", "description", "aulas", "horas", "created")
VALUES
    ('react-avancado', 'React Avançado', 'Aprenda os fundamentos de React.js.', 32, 12, '2049-05-14 21:25:50');

DROP TABLE lessons;

-- Lessons
-- {
--   "id": 101,
--   "course_id": 1,
--   "slug": "variaveis-let-const",
--   "title": "Variáveis: let e const",
--   "materia": "Fundamentos",
--   "materia_slug": "fundamentos",
--   "seconds": 480,
--   "video": "variaveis.mp4",
--   "description": "Entenda a diferença entre let, const e var.",
--   "lesson_order": 3,
--   "free": 1,
--   "created": "2049-06-14 12:35:10"
-- }




CREATE TABLE "lessons" (
    "id" INTEGER PRIMARY KEY,
    "course_id" INTEGER,
    "slug" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "materia" TEXT NOT NULL,
    "materia_slug" TEXT NOT NULL,
    "seconds" INTEGER NOT NULL,
    "video" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "lesson_order" INTEGER NOT NULL,
    "free" INTEGER NOT NULL DEFAULT 0 CHECK ("free" IN (0,1)),
    "created" TEXT DEFAULT CURRENT_TIMESTAMP,
    UNIQUE ("course_id", "slug")
    FOREIGN KEY ("course_id") REFERENCES "courses" ("id")
) STRICT;

DROP TABLE "users";
DROP TABLE "courses";
DROP TABLE "lessons";
DROP TABLE "lessons_completed";
DROP TABLE "certificates";

INSERT INTO "lessons"
    ("id", "course_id", "slug", "title", "materia", "materia_slug", "seconds", "video", "description", "lesson_order", "free", "created")
VALUES 
    (101, 1, 'variaveis-let-const', 'Variáveis: let e const', 'Fundamentos', 'fundamentos', 480, 'variaveis.mp4', 'Entenda a diferença entre let, const e var', 3, 1, '2049-06-14 12:35:10');

INSERT INTO "lessons"
    ("id", "course_id", "slug", "title", "materia", "materia_slug", "seconds", "video", "description", "lesson_order", "free", "created")
VALUES 
    (103, 2, 'apresentacao-curso', 'Apresentação do Curso', 'Informações Iniciais', 'informacoes-inicias', 520, 'apresentacao.mp4', 'Apresentação Inicial do Curso', 2, 1, '2049-06-14 12:35:10');

DROP TABLE "lessons";

-- Lessons Completed
-- {
--   "user_id": 42,
--   "course_id": 1,
--   "lesson_id": 101,
--   "completed": "2049-06-15 08:20:05"
-- }

CREATE TABLE "lessons_completed" (
    "user_id" INTEGER,
    "course_id" INTEGER,
    "lesson_id" INTEGER,
    "completed" TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("user_id") REFERENCES "users" ("id")
    FOREIGN KEY ("course_id") REFERENCES "courses" ("id")
    FOREIGN KEY ("lesson_id") REFERENCES "lessons" ("id")
) STRICT;

INSERT INTO "lessons_completed" 
    ("user_id", "course_id", "lesson_id", "completed")
VALUES
    (42, 1, 101, '2049-06-15 08:20:05');

-- Certificates
-- {
--   "id": "aq32scsqd",
--   "user_id": 42,
--   "course_id": 1,
--   "completed": "2049-06-15 09:10:00"
-- }

CREATE TABLE "certificates" (
    "id" TEXT PRIMARY KEY,
    "user_id" INTEGER NOT NULL,
    "course_id" INTEGER NOT NULL,
    "completed" TEXT DEFAULT CURRENT_TIMESTAMP,
    UNIQUE ("user_id", "course_id"),
    FOREIGN KEY ("user_id") REFERENCES "users" ("id"),
    FOREIGN KEY ("course_id") REFERENCES "courses" ("id")
) STRICT;

DROP TABLE "certificates";


INSERT INTO "certificates"
    ("id", "user_id", "course_id", "completed")
VALUES
    ('aq32scsqd', 42, 1, '2049-06-15 09:10:00');