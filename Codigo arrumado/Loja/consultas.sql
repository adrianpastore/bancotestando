-- a. Os funcionários (nome, sexo e salário) com salário maior que R$2.000.

SELECT (nome, sexo, salario) FROM "funcionario" WHERE salario > 2000;

-- b. Os funcionários (nome, cpf) com "cadu" ou "carla" no nome ou no login (desconsiderar maiúsculas e minúsculas.

SELECT (nome, cpf) FROM "funcionario" 
WHERE Lower(nome) like '%cadu%' or Lower(nome) like '%carla%' or Lower(login) like '%cadu%' or Lower(login) like '%carla%';

-- % = qualquer pálavra que venha antes ou depóis (depende da posição)

-- c. Fazer o item b para os clientes comparando apenas o nome

SELECT (nome, cpf) FROM "cliente"
WHERE Lower(nome) like '%cadu%' or Lower(nome) like '%carla%';

-- d. Unir as consultas do item b e c em uma única consulta.

SELECT (nome, cpf) FROM "cliente"
WHERE Lower(nome) like '%cadu%' or Lower(nome) like '%carla%'
UNION
SELECT (nome, cpf) FROM "funcionario" 
WHERE Lower(nome) like '%cadu%' or Lower(nome) like '%carla%' or Lower(login) like '%cadu%' or Lower(login) like '%carla%';

-- e. Mostrar os diferentes codDepartamento existentes na tabela Funcionario.

SELECT DISTINCT (codDepartamento) FROM "funcionario"
ORDER BY codDepartamento;

-- distinct mostra apenas os diferentes

-- order by ordena de acordo com a coluna selecionada

-- f. Mostrar todas as informações para cliente que possuem email no Hotmail ou gmail.

SELECT * FROM "cliente"
WHERE email ilike '%gmail%' or email ilike '%hotmail%';

-- ilike desconsidera maiúsculas e minúsculas

-- g. Mostrar todas as informações para funcionários com salário entre 2000 e 6000 e idade entre 20 anos e 40 anos.

SELECT * FROM "funcionario" WHERE salario BETWEEN 2000 and 6000 and extract(year FROM age(dataNascimento)) BETWEEN 20 and 40;

-- between é um intervalo

-- h. Ordene os funcionários pelo sexo (crescente) caso de empate pelo salário (decrescente)

SELECT nome, sexo, salario FROM funcionario
ORDER BY sexo ASC, salario DESC;

-- ASC = crescente , DESC = decrescente

-- i. Os clientes ordenados pelo nome.

SELECT nome FROM cliente
ORDER BY nome;

-- j. A média salarial e o maior e menor salário dos funcionários.

SELECT AVG(salario) as media, MAX(salario), MIN(salario) FROM funcionario;

-- avg calcula a média

-- k. O item j por sexo.

SELECT AVG(salario) as media, MAX(salario), MIN(salario), sexo FROM funcionario
GROUP BY sexo;

-- l. Os funcionários que também são clientes e que possuem salário menor que 4500. Ordene a resposta pela data de nascimento, do mais velho para o mais novo.

SELECT c.nome FROM funcionario f INNER JOIN cliente c ON f.nome = c.nome
WHERE salario < 4500
ORDER BY f.datanascimento DESC;

-- m. Os funcionários que não são clientes.

SELECT nome FROM funcionario
EXCEPT
SELECT nome FROM cliente;

SELECT * FROM funcionario WHERE cpf NOT IN ( SELECT cpf FROM cliente);

-- n. As vendas ordenadas por data

SELECT * FROM notafiscal
ORDER BY datavenda;

-- o. Quantas vendas por ano.

SELECT COUNT (extract(year from datavenda)) from notafiscal group by (extract(year from datavenda))

-- p. CodProduto e total de itens vendidos ordenados pelo total vendido decrescente

SELECT sum(quantidade), codproduto from itemvenda group by codproduto order by sum(quantidade) desc

-- Exercício 2

-- a. O nome dos funcionários e de seus respectivos departamentos.

SELECT f.nome as funcionario, d.nome as departamento FROM funcionario f FULL OUTER JOIN departamento d 
    ON f.coddepartamento = d.coddepartamento
ORDER BY f.nome, d.nome;

-- b. Quantas diferentes pessoas (todos seus dados) existem no banco de dados (clientes e funcionários).

SELECT * FROM funcionario f FULL OUTER JOIN cliente c
USING(nome)
ORDER BY nome;

-- c. A média salarial por sexo dos funcionários que não são clientes e têm mais de 30 anos.

SELECT AVG(salario) AS media, sexo FROM funcionario 
WHERE cpf NOT IN ( SELECT cpf FROM cliente) and extract(year FROM age(dataNascimento)) > 30
GROUP BY sexo;

-- d. O item 1.j agrupado por nome do departamento e ordenado pelo nome do departamento para funcionários do sexo masculino com salário maior que 2000

SELECT min(salario), max(salario), avg(salario), departamento.nome 
FROM funcionario INNER JOIN departamento ON funcionario.codDepartamento = departamento.codDepartamento 
WHERE sexo = 'M' and salario > 2000
GROUP BY departamento.nome
ORDER BY departamento.nome;

--e. A descrição dos produtos bem como o número de itens que foram vendidos, ordenado pelo número de itens que foram vendidos.Todos os produtos e total em R$ vendido 

SELECT p.codproduto, p.descricao, sum(iv.quantidade) as quant 
FROM Produto p INNER JOIN ItemVenda iv ON p.codproduto = iv.codproduto
GROUP BY p.codproduto
ORDER BY quant;

 --f. A descrição e número de vezes que cada produto foi vendido, ordenado pelo número de vezes que foi vendido.
SELECT iv.codproduto, p.descricao, COUNT(iv.codproduto) 
FROM itemvenda iv INNER JOIN produto p ON iv.codproduto = p.codproduto 
GROUP BY p.descricao, iv.codProduto
ORDER BY iv.codProduto;

--g. A listas dos clientes que mais vezes compram na loja. Nome e total de compras ordenado pelo total de compras.
SELECT nf.codcliente, COUNT(nf.codCliente) AS "Total de compras"
FROM notafiscal nf INNER JOIN cliente c ON nf.codcliente = c.codcliente
GROUP BY nf.codcliente
ORDER BY COUNT(nf.codcliente) desc

--h. A lista dos funcionários que mais vendas realizaram. Nome e total de vendas realizadas ordenado pelo total de vendas.
SELECT nf.codfuncionario AS "Codigo do Funcionario", COUNT(nf.codfuncionario) AS "Total de Vendas"
FROM notafiscal nf INNER JOIN funcionario f ON nf.codfuncionario = f.codfuncionario
GROUP BY nf.codfuncionario
ORDER BY COUNT(nf.codfuncionario) desc

--i. A lista de dos departamentos e o total em vendas (R$) realizadas por cada departamento.

with new2 as (
with new  as (select sum(iv.quantidade) as soma, iv.codnotafiscal, nf.codfuncionario
from itemvenda iv inner join notafiscal nf on iv.codnotafiscal = nf.codnotafiscal
group by iv.codnotafiscal, nf.codfuncionario
order by soma)
select nw.soma, nw.codnotafiscal, nw.codfuncionario, f.coddepartamento 
from new nw full outer join funcionario f on nw.codfuncionario = f.codfuncionario)

select coalesce(sum(n2.soma),0), d.nome, n2.coddepartamento from new2 n2 inner join departamento d on n2.coddepartamento = d.coddepartamento
group by n2.coddepartamento, d.nome
order by n2.coddepartamento
