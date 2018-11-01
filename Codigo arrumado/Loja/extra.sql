
DROP TABLE IF EXISTS "ItemCompra";
DROP TABLE IF EXISTS "Compra";
DROP TABLE IF EXISTS "Fornecedor";

CREATE TABLE "Fornecedor" (
	"cod" serial,
	"CNPJ" varchar(17) NOT NULL,
	"nomeFantasia" varchar(100) NOT NULL, 
	CONSTRAINT "fornecedorPK" PRIMARY KEY (cod),
	CONSTRAINT "cnpjUnique" UNIQUE ("CNPJ"));

CREATE TABLE "Compra"(
	"cod" serial,
	"dataHora" timestamp NOT NULL,
	"codFornecedor" int,
	CONSTRAINT "compraPK" PRIMARY KEY (cod),
	CONSTRAINT "fornecedorFK" FOREIGN KEY ("codFornecedor") REFERENCES "Fornecedor" ("cod")
		ON DELETE SET NULL ON UPDATE CASCADE);

CREATE TABLE "ItemCompra"(
	"codProduto" int,
	"codCompra"  int,
	"precoUnit"  numeric(7,2) NOT NULL,
	"quantidade" float NOT NULL,
	CONSTRAINT "itemCompraPK" PRIMARY KEY ("codProduto", "codCompra"),
	CONSTRAINT "compraFK" FOREIGN KEY ("codCompra") REFERENCES "Compra" ("cod")
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT "produtoFK" FOREIGN KEY ("codProduto") REFERENCES "produto" ("codproduto")
		ON DELETE SET NULL ON UPDATE CASCADE);

INSERT INTO "Fornecedor" ("CNPJ", "nomeFantasia") VALUES
	('12354698754','Atacadeiro'), 				--1
	('23542228754','Rei do atacado'),			--2
	('62542982754','Diz tri "buidor" de bebidas'),		--3
	('09876653233','nervosinho pouco calmo de produtos');	--4

INSERT INTO "Compra" ("dataHora","codFornecedor") VALUES
	(now() - interval '6 months',1),			--1
	(now() - interval '5 months',1),			--2
	(now() - interval '4 months 20 days',1),		--3
	(now() - interval '4 months 10 days',3),		--4
	(now() - interval '2 months',4),			--5
	(now() - interval '1 months',4);			--6

INSERT INTO "ItemCompra" ("codProduto", "codCompra","precoUnit","quantidade") VALUES
	(1,1, 4.00, 150),
	(2,1, 2.50, 350),
	(3,1, 4.50, 50),
	(4,1, 6.00, 50),
	(5,1, 8.00, 10), 
	(11,2, 3.00, 30),
	(12,2, 1.00, 300),
	(13,2, 4.99, 50),
	(14,3, 2.00, 50),
	(15,3, 1.50, 100),
	(17,3, 4.00, 50),
	(6,4,2,600),
	(7,4,4,500),
	(8,4,1.5,650),
	(9,4,2.99,600),
	(10,4,0.75,1500),
	(19,4,10,20),
	(20,4,1,60),
	(16,5, 1200, 10),
	(18,5, 15, 20),
	(21,6, 3, 60),
	(5,6, 7.00, 100), 
	(11,6, 2.50, 300);

	