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

*/