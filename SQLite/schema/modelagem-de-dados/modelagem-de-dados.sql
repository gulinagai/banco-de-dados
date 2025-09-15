/* 
    Modelagem de Dados

A modelagem de dados acontece em 4 etapas:

Levantamento de Requisitos
Modelagem Conceitual
Modelagem Lógica
Modelagem Física




LEVANTAMENTO DE REQUISITOS
Etapa inicial onde se define quais dados são necessários para o sistema. Quais as necessidades do negócio e quais informações devem ser armazenadas.

Pesquisas

Questionários

Entrevistas

Reuniões

MODELAGEM CONCEITUAL
A modelagem conceitual é a representação das entidades, atributos e relacionamentos de forma abstrata, geralmente em diagramas, sem se preocupar com detalhes técnicos.

Entidades (tabelas):

Representam objetos ou conceitos do negócio (ex: Usuário, Produto, Pedido).

Atributos (colunas):

Características das entidades (ex: Nome, Preço, Data de Criação).

Relacionamentos (fk):

Como as entidades se relacionam entre si (ex: Usuário faz Pedido, Produto pertence a Categoria).

Cardinalidade: (1:n, n:1, 1:1, n:n)

Define quantas instâncias de uma entidade podem se relacionar com outra (ex: Um Usuário pode fazer vários Pedidos, mas um Pedido pertence a apenas um Usuário).

-- imagem modelo-conceitual




MODELAGEM LÓGICA
A modelagem lógica é a definição dos tipos de dados, chaves primárias, chaves estrangeiras e restrições de integridade. É uma representação mais técnica do modelo conceitual.

Tipos de Dados:

Define o tipo de dado genérico das colunas (ex: INTEGER, TEXT, REAL).

Chaves Primárias (PK):

Identificam de forma única cada registro na tabela (ex: ID do Usuário).

Chaves Estrangeiras (FK):

Referenciam chaves primárias de outras tabelas para estabelecer relacionamentos

Restrições:

Define as regras que os dados devem seguir, se deve ser único, não nulo, etc.

Normalização:

Processo de organização dos dados para reduzir redundâncias e dependências, dividindo tabelas em entidades menores.


ex:

Usuarios
- id (INTEGER, PK)
- nome (TEXT)
- email (TEXT, UNIQUE)

Compras
- id (INTEGER, PK)
- usuario_id (INTEGER, FK -> Usuarios.id)
- produto (TEXT)



MODELAGEM FÍSICA (tudo que eu faço aqui no vscode, é a implementação do banco de dados no SGBD)
A modelagem física é a implementação do modelo lógico no SGBD (SQLite) escolhido, definindo como os dados serão armazenados fisicamente.

Criação de tabelas

Com tipos de dados específicos, chaves primárias, estrangeiras, restrições e relacionamentos.

Definição de índices

O que deve ser indexado para melhorar a performance das consultas.

Configuração de armazenamento

Quais as configurações do banco de dados, como tamanho máximo, collation, etc.

ex:

CREATE TABLE "usuarios" (
  "id" INTEGER PRIMARY KEY,
  "nome" TEXT NOT NULL,
  "email" TEXT NOT NULL UNIQUE COLLATE NOCASE
) STRICT;

CREATE TABLE "compras" (
  "id" INTEGER PRIMARY KEY,
  "usuario_id" INTEGER NOT NULL,
  "produto" TEXT NOT NULL,
  FOREIGN KEY ("usuario_id") REFERENCES "usuarios" ("id")
) STRICT;


 */