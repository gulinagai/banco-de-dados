--database: ./db.sqlite

/* 

VIEW 

Funciona como uma coluna virtual, porém para tabelas. Aqui o select inteiro é armazenado como uma view. Basta escrever o select e acima do mesmo adicionar CREATE VIEW "nome_da_view" AS.


normalmente ele é utilizado quando eu quero facilitar a visualização de um select, por exemplo, que está em ids e visualizar pelos nomes, então eu monto um select inteiro para isso, e, quando estiver montado, eu posso criar uma VIEW disso, para não ter que ficar montando esse SELECT inteiro toda vez que eu quiser visualizar a tabela pelos nomes por exemplo.


*/

CREATE VIEW "lessons_completed_full" AS
SELECT "u"."email", "c"."title" AS "course", "l"."title" AS "lesson", "lc"."completed"
FROM "lessons_completed" AS "lc"
JOIN "lessons" AS "l" ON "l"."id" = "lc"."lesson_id"
JOIN "users" AS "u" ON "u"."id" = "lc"."user_id"
JOIN "courses" AS "c" ON "c"."id" = "lc"."course_id";

SELECT * FROM "lessons_completed_full" WHERE "email" = 'pedro@email.com';

--continuar amanhã, ta sem os dados