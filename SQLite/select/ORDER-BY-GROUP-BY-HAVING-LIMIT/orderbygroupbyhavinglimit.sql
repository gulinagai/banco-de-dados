--database: ./db.sqlite

CREATE TABLE "produtos" (
  "id" INTEGER PRIMARY KEY,
  "nome" TEXT NOT NULL,
  "categoria" TEXT,
  "preco" INTEGER NOT NULL,
  "taxa_importacao" INTEGER NOT NULL DEFAULT 0,
  "estoque" INTEGER NOT NULL DEFAULT 0,
  "lancamento" INTEGER DEFAULT 1 CHECK ("lancamento" IN (0, 1)),
  "criado" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
) STRICT;

INSERT INTO "produtos" ("nome","categoria","preco","taxa_importacao","estoque","lancamento","criado") VALUES
('Fone Bluetooth','audio',19900,0,150,0,'2048-01-16 10:12:34'),
('Teclado Mecânico','periferico',34900,6500,20,0,'2048-02-02 09:45:10'),
('Mouse Gamer Pro','periferico',24900,0,120,0,'2048-02-21 14:05:28'),
('Monitor 27 4K','monitor',219900,9000,40,0,'2048-03-06 11:23:57'),
('Hub USB-C','acessorio',9900,0,200,0,'2048-03-11 08:47:13'),
('Webcam 1080p','video',17900,3500,110,0,'2048-04-01 16:32:40'),
('SSD NVMe 1TB','armazenamento',57900,0,70,0,'2048-04-19 13:21:05'),
('Cadeira Ergonômica',null,139900,12000,0,0,'2048-05-03 09:14:22'),
('Notebook 14 1TB','notebook',429900,0,30,0,'2048-05-16 10:55:31'),
('Ring Light LED',null,8900,0,5,0,'2049-06-02 12:06:09'),
('Smartwatch',null,79900,8000,90,0,'2049-06-21 15:44:18'),
('Carregador GaN','energia',15900,0,140,0,'2049-07-06 11:12:47'),
('Notebook 16 2TB','notebook',529900,0,37,0,'2049-05-16 10:55:31'),
('Power Bank 20000 mAh','energia',22900,0,130,1,'2049-07-23 17:03:59'),
('Óculos 3D Pro','acessorio',21900,0,110,1,'2049-07-26 17:03:59'),
('Headset ANC Pro','audio',99900,11000,60,1,'2049-08-11 10:28:36'),
('Placa-mãe Z790','hardware',189900,0,35,1,'2049-09-02 09:49:52'),
('Processador X9-5600','hardware',159900,9500,50,0,'2049-09-19 14:17:08'),
('Processador X11-5600','hardware',199900,9500,50,0,'2049-10-01 14:17:08'),
('Impressora 3D Mini','impressora',249900,0,20,0,'2049-10-06 08:38:41'),
('Alto-falante WiFi Pro','audio',34900,0,100,0,'2049-11-02 16:25:55'),
('Câmera de Ação 4K','video',89900,7000,45,0,'2049-11-21 13:56:12'),
('Roteador WiFi 6E','rede',64900,0,75,0,'2049-12-06 11:11:11');

/*
    ORDER BY
Ordena os resultados de uma consulta.

*/

-- ASC (ascendente) é o padrão no ORDER BY
SELECT * FROM "produtos" ORDER BY "preco" ASC;
SELECT * FROM "produtos" ORDER BY "preco" DESC;

-- primeiro ordena por categoria, e em situações que forem a mesma categoria, ordena por preço
SELECT * FROM "produtos" ORDER BY "categoria" ASC, "preco" ASC;

-- ordena por data
SELECT * FROM "produtos" ORDER BY "criado";


/*
    GROUP BY
Agrupa os resultados de uma consulta, normalmente para mostrar a soma, a média, a contagem dos valores dos registros de um determinado grupo, esse grupo seria um outro valor de um campo da tabela, que se repete, como: categoria por exemplo.
*/

SELECT "categoria", COUNT(*) AS "total" FROM "produtos" GROUP BY "categoria";
SELECT "categoria", AVG("preco") AS "preco_medio" FROM "produtos" GROUP BY "categoria";

SELECT "categoria", COUNT(*) AS "total_por_categoria" FROM "produtos" GROUP BY "categoria" LIMIT 3;

-- GROUP BY e ORDER BY juntos
SELECT "categoria", COUNT(*) AS "total_por_categoria"
FROM "produtos" GROUP BY "categoria" ORDER BY "total_por_categoria" DESC;

--- Agrupar por ANO
SELECT STRFTIME('%Y', "criado") AS "ano", COUNT(*) AS "total"
FROM "produtos" GROUP BY "ano";


SELECT STRFTIME('%Y', "criado") AS "ano", COUNT(*) AS "total_por_ano" FROM "produtos" GROUP BY "ano";

/*
    HAVING
Filtra os resultados de uma consulta após o agrupamento. O HAVING funciona como o WHERE após o GROUP BY.

é literalmente o WHERE, mas quando se usa um GROUP BY.
com WHERE não funcionaria.
*/

SELECT "categoria", COUNT(*) AS "total_por_categoria"
FROM "produtos" GROUP BY "categoria"
HAVING "total_por_categoria" > 1 ORDER BY "total_por_categoria";

SELECT "categoria", AVG("preco") AS "preco_medio"
FROM "produtos" GROUP BY "categoria"
HAVING "preco_medio" > 70000;

SELECT "total_por_categoria", COUNT(*) AS "total_grupos_com_mesma_qtd" FROM (
    SELECT "categoria", COUNT(*) AS "total_por_categoria" FROM "produtos" GROUP BY "categoria"
) AS "sub" GROUP BY "total_por_categoria" ORDER BY "total_por_categoria" DESC;


-- isso é SUBQUERY, será visto mais a frente
-- mas para entendimento, a select de dentro praticamente vira uma nova tabela na qual o select externo irá fazer a consulta!

