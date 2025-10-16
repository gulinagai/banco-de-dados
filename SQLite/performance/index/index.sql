--database: ./db.sqlite

/*
Index

Os índices são utilizados para acelerar a busca de dados em tabelas. São automaticamente criados para colunas que são PRIMARY KEY ou UNIQUE, mas também podem ser criados manualmente para outras colunas.

TODO INDEX É AUTOMATICAMENTE CRIADO QUANDO É CRIADO UMA PRIMARY KEY OU UM CAMPO UNIQUE. 

https://drive.google.com/file/d/1rDrUeR_kYcqTdq3eqKzrNGMSkySRi9SB/view?usp=sharing

-- Usa o index para fazer a busca
SELECT * FROM "users" WHERE "id" = 50000;
EXPLAIN QUERY PLAN SELECT * FROM "users" WHERE "id" = 50000;

o EXPLAIN QUERY PLAN mostra como é feito a busca do dado na coluna 'detail'

-- Usa o index para fazer a busca
SELECT * FROM "users" WHERE "email" = 'lara.pereira6863@example.com';
EXPLAIN QUERY PLAN SELECT * FROM "users" WHERE "email" = 'lara.pereira6863@example.com';

-- SCAN users para fazer a busca
SELECT * FROM "users" WHERE "email2" = 'lara.pereira6863@example.com';
EXPLAIN QUERY PLAN SELECT * FROM "users" WHERE "email2" = 'lara.pereira6863@example.com';

nesses casos dos emails acima, o email2 não possuia CONSTRAINT nenhuma, diferente de 'email' que dizia que devia ser UNIQUE (cria automaticamente um index), sendo assim, o tempo de busca pelo segundo método demorou muito mais do que na primeira forma, reduzindo o desempenho.

-- SCAN users, não usa index
SELECT * FROM "users" WHERE "created" = '2020-05-03 17:47:09';
EXPLAIN QUERY PLAN SELECT * FROM "users" WHERE "created" = '2020-05-03 17:47:09';



Pragma
É possível verificar as características usando PRAGMA index_info.

SELECT * FROM "sqlite_schema" WHERE "type" = 'index';

esse SELECT seleciona TODAS as tabelas, triggers e indexs da tabela.

PRAGMA index_list('certificates');    retorna todos os index da tabela que for passada como argumento. 

PRAGMA index_info('sqlite_autoindex_certificates_2'); retorna as informações sobre um index específico

PRAGMA index_xinfo('sqlite_autoindex_certificates_2');






resumo:

basicamente, campos de tabelas que não possuem PRIMARY KEY ou UNIQUE como restrições, demorarão muito para serem feito a consulta do dado que está contido neles, porque o banco fará a consulta registro por registro.
esse tipo de consulta registro por registro é chamado de FULL TABLE SCAN

para verificar se o select ta sendo feito usando esse FULL TABLE SCAN, basta colocar EXPLAIN QUERY PLAN antes do SELECT.

é isso.


Caso eu queira otimizar o tempo de busca de um campo, que não é PRIMARY KEY nem UNIQUE (que são campos que o banco cria uma index automaticamente, eu também posso criar manualmente.)

mas antes, vamos entender o porque o uso de index se torna mais  otimizado e rápido.

B-Tree
Os índices são criados usando uma estrutura de dados chamada B-Tree (o sqlite usa B+ Tree). Ela faz com que a busca do usuário de id 1 ou 45323 tenha a mesma performance.

-- imagem btree.svg

usando a metodologia B-Tree, a busca se torna mais rápida, como mostrada na imagem, ele faz comparações, exemplo: numero sejado: 6

6 >= 5 ? sim então segue o caminho da direita, descartando a esquerda

6 >=7 ? não então vai pela esquerda

6 >= 6 ? sim, continua pela direita (mesmo já encontrando o valor)

6 === 6

isso torna a consulta muito mais otimizada, melhorando a performance da aplicação.

se for uma palavra, segue a ordem alfabética.

CRIANDO UM INDEX

caso haja um campo de uma tabela que não foi definido como PRIMARY KEY ou UNIQUE, que são as restrições que criam automaticamente um index para aquela coluna, e mesmo assim, é desejado que se queira um index para aquele determinado campo para otimizar a busca de dados, podemos criar um INDEX manualmente:

O comando CREATE INDEX cria um índice e o DROP INDEX remove o índice.

CREATE INDEX "nome_indice" ON "nome_tabela" ("coluna", ...)    
CREATE INDEX "idx_users_created" ON "users" ("created");       -- cria um index, com o nome idx_users_created para a tabela users, coluna created
DROP INDEX "idx_users_created"; -- exclui o index idx_users_created

SELECT * FROM "users" WHERE "created" = '2020-05-03 17:47:09';  -- muito mais rópido pq agora buscou pela b-tree
EXPLAIN QUERY PLAN SELECT * FROM "users" WHERE "created" = '2020-05-03 17:47:09'; -- mostra que buscou via index



Custo
Os índices ocupam espaço em disco e memória, e podem impactar a performance do INSERT, UPDATE e DELETE, pois o índice também precisa ser atualizado. 

Toda vez que algo for alterado, deletado, adicionado na tabela, todos os index da tabela devem ser atualizados.

-- 1_000_000 de produtos, em uma tabela com 5.750 GB
-- Ao criar um índice, o tamanho do banco de dados aumentou para 5.770 GB
-- O índice ocupou cerca de 20 MB
SELECT COUNT(*) FROM "products";

SELECT * FROM "products" WHERE "sku" = 'U4XMSABD3HN1';

CREATE INDEX "idx_products_sku" ON "products" ("sku");


sabendo que ele tem um certo custo de memória (precisa de espaço na memória para ser utilizado), não é recomendado criar um index para cada campo da tabela, apenas para os mais utilizados e mais pertinentes:

Quando Criar
SELECT, INSERT, UPDATE e DELETE

A necessidade dos índices vem das colunas frequentemente usadas em WHERE, GROUP BY, JOIN ON ou ORDER BY.

Cardinalidade (não é a do modelo conceitual, é um conceito dentro do banco de dados)

cardinalidade de uma coluna significa quantos valores únicos existem nela em relação ao total de linhas.

Alta cardinalidade: muitos valores diferentes (ex: CPF, e-mail, ID de produto).

Baixa cardinalidade: poucos valores diferentes (ex: gênero “M/F”, booleanos true/false).

Outra variável é a cardinalidade da coluna, ou seja, a quantidade de valores únicos, quanto maior a cardinalidade, mais útil será o índice.

-- 0 - 100, quanto mais próximo de 100, mais útil será o índice
SELECT (100 * COUNT(DISTINCT "sku") / COUNT(*)) AS "card" FROM "products";
SELECT (100 * COUNT(DISTINCT "free") / COUNT(*)) AS "card" FROM "lessons";

essas fórmulas servem para verificar a cardinalidade da coluna 




COVERING INDEX

É um índice que contém todas as colunas necessárias para a consulta, evitando a necessidade de acessar a tabela principal. Por isso a boa prática é selecionar apenas as colunas necessárias.

SELECT "id", "email" FROM "users" WHERE "email" = 'lara.pereira6863@example.com'; -- mais otimizado do que colocar *, porque os index dessas colunas já foram suficientes para buscar o dado

EXPLAIN QUERY PLAN SELECT "id", "email" FROM "users" WHERE "email" = 'lara.pereira6863@example.com'; -- se verificarmos o EXPLAIN QUERY PLAN, vai aparecer COVERING INDEX que diz que, a busca de id e email da tabela users já foi suficiente através da busca via index, diferente se fizesse uma busca *,

caso não fosse suficiente buscar as colunas desejadas através dos index, após a busca via index para as colunas que são acháveis pelo index, seria capturado o rowId do id, que é o registro onde está o dado que se quer buscar, e faria uma outra busca pela b-tree usando esse rowId, ou seja, seriam duas buscas.

EXPLAIN QUERY PLAN SELECT * FROM "users" WHERE "email" = 'lara.pereira6863@example.com';





Index Compostos
Índices compostos são aqueles que envolvem mais de uma coluna. Eles são úteis quando as consultas frequentemente filtram ou ordenam por múltiplas colunas.

Quando definimos uma PRIMARY KEY ou UNIQUE compostos, um índice composto é criado automaticamente.

A ordem das colunas na criação é importante. 
A coluna mais seletiva (com maior cardinalidade) deve ser a primeira.

-- Se definimos uma PRIMARY KEY composta, um índice composto é criado automaticamente

CREATE INDEX "idx_lc_user_lesson" ON "lessons_completed" ("user_id", "course_id", "lesson_id");

-- Usa o índice composto
EXPLAIN QUERY PLAN SELECT "user_id", "course_id", "lesson_id"
FROM "lessons_completed"
WHERE "course_id" = 1 AND "user_id" = 1;

-- Não usa o índice composto, pois a coluna user_id não é a primeira
EXPLAIN QUERY PLAN SELECT * FROM "lessons_completed" WHERE "course_id" = 1;
EXPLAIN QUERY PLAN SELECT * FROM "lessons_completed" WHERE "lesson_id" = 1;

IMPORTANTE:

nos casos de INDEX Compostos, seja por UNIQUE, PRIMARY KEY ou uma criada manualmente, 
no WHERE do SELECT, eu preciso obrigatoriamente respeitar a ordem em que foi definido O INDEX, PRIMARY KEY ou UNIQUE, ou seja, se for feito um SELECT com um WHERE da primeira definição da ordem lá onde definiciu a criação do index, eu preciso obrigatoriamente informar essa primeira definição no WHERE, se quiser fazer uma busca com um WHERE pelo segundo item da definição na ordem em que se definiu, precisa colocar tanto o primeiro quanto o segundo, com um AND, se colocar só o segundo, a busca será sim feita normalmente, mas não usará mais o INDEX, usará o método SCAN, que faz uma procura do dado pela tabela inteira.






Parcial
Índices parciais são aqueles que indexam apenas uma parte dos dados de uma tabela, com base em uma condição específica. Eles são úteis para melhorar a performance de consultas que filtram por essa condição.

CREATE INDEX "idx_users_vitalicio" ON "users" ("name") WHERE "vitalicio" = 1;

-- Usa o índice parcial
SELECT * FROM "users" WHERE "name" = 'Ana Júlia Carvalho' AND "vitalicio" = 1;

-- Não usa o índice parcial, pois a condição vitalicio não é atendida
SELECT * FROM "users" WHERE "name" = 'Ana Júlia Carvalho' AND "vitalicio" = 0;

EXPLAIN QUERY PLAN SELECT * FROM "users" WHERE "name" = 'Ana Júlia Carvalho' AND "vitalicio" = 1;


IMPORTANTE:

nesse caso do index parcial, só é criado um index para os registros de uma coluna especifica de uma tabela especifica ONDE tais registros atendem ao WHERE que foi passado na criação do INDEX (create index), os registros dessa coluna que não obedecerem ao WHERE, não serão indexados.


*/