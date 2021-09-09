use PEDIDOS	

create table clientes_mg (	
	codigo			int primary key,
	nome			varchar(50),
	endereco		varchar(60),
	bairro			varchar(30),
	cidade			varchar(30),
	fone			varchar(18)
)

 /* Copiar 20 registros da tabela TB_cliente
	para a tabela cliente_MG*/
insert top(20) into clientes_mg
select codcli, nome, endereco, bairro, cidade, fone1
from TB_CLIENTE
where ESTADO = 'MG'

select * from clientes_mg

create table emp_temp (
	codfun		int primary key,
	nome		varchar (30),
	cod_depto	int,
	cod_cargo	int,
	salario		numeric(10,2)
)


insert into emp_temp output inserted.*  -- visualização das informações na tabela, ele ja mostra os dados assim que inseridos
select codfun, nome, cod_depto, cod_cargo, salario
from TB_EMPREGADO

--delete apagando todos os registros da tabela
delete from emp_temp

/*Inserindo empregados que pertencem ao departamento
de códigos 2 (5 colunas), e usando output para
verigicar os dados inseridos de 3 colunas*/

insert into emp_temp
output inserted.codfun, inserted.nome, inserted.cod_depto
select codfun, nome, cod_depto, cod_cargo, salario
from tb_empregado where COD_DEPTO = 2 


-- delete from emp_temp
-- Declarar variável tabular
declare @reg_insert	table ( -- o @ identifica uma variável
	codfun		int,
	nome		varchar(30),
	cod_depto	int,
	cod_cargo	int,
	salario		numeric(10,2)
)

-- Inserir Dados e armazenar em variável tabular
insert into emp_temp 
output inserted.* into @reg_insert
select codfun, nome, cod_depto, cod_cargo, salario
from TB_EMPREGADO where COD_DEPTO = 3

select * from @reg_insert

select * from emp_temp



--CAP 4 



use PEDIDOS

select * from TB_EMPREGADO 

select codfun, nome, salario from TB_EMPREGADO 


--coluna virtual, nao existe no banco
select codfun, nome, salario, salario * 1.10 as Salario_Mais_10_Por_Cento --adicionando nome para a coluna a mais
 from TB_EMPREGADO 


 -- apelido para os campos no select 
 select codfun as Código,
		nome as Nome,
		salario as Salário,
		data_admissao as [Data De Admissão] -- Inserir dados com espaço com colchetes, apóstrofo ou aspas duplas
from TB_EMPREGADO


select * from TB_EMPREGADO order by NOME
select * from TB_EMPREGADO order by NOME asc -- ascendente (Padrão)
select * from TB_EMPREGADO order by SALARIO
select * from TB_EMPREGADO order by SALARIO asc	

select * from TB_EMPREGADO order by DATA_ADMISSAO

select * from TB_EMPREGADO order by nome desc -- descendete
select * from TB_EMPREGADO order by SALARIO desc	
select * from TB_EMPREGADO order by DATA_ADMISSAO desc

-- order by pela coluna por apelido	
select CODFUN as Código,
	nome as Nome, 
	salario as Salário,
	salario * 1.10 [Salário com 10% de aumento]
from tb_empregado order by Salário

-- Order by pela posição da coluna
select CODFUN as Código,
	nome as Nome, 
	salario as Salário, -- posição 3
	salario * 1.10 [Salário com 10% de aumento]
from tb_empregado order by 3 -- posição dele no select ↑

-- Order by por capo de data
select codfun, nome, data_admissao, salario	
from TB_EMPREGADO
order by DATA_ADMISSAO

-- Order by "composto" mais de um campo
select cod_depto, nome, data_admissao, salario 
from TB_EMPREGADO
order by COD_DEPTO, NOME

-- Order by com dois campos
select cod_depto, nome, data_admissao, salario
from TB_EMPREGADO
order by COD_DEPTO, SALARIO -- ou order by 1, 4

-- Order by com dois campos utilizando desc
select cod_depto, nome, data_admissao, salario
from TB_EMPREGADO
order by COD_DEPTO, salario desc


-- Lista os 5 primeiros empregados de acordo com a chave primária
select top 5 * from TB_EMPREGADO

-- Lista os 5 empregados mais antigos
select top 5 * from TB_EMPREGADO order by DATA_ADMISSAO

-- Lista os 5 empregados mais novos
select top 5 * from TB_EMPREGADO order by DATA_ADMISSAO desc

-- Lista os 5 empregados mais bem pagos
select top 5 * from TB_EMPREGADO order by SALARIO desc

-- Lista os 7 funcionarios que ganham mais
select top 7 codfun, nome, salario from TB_EMPREGADO order by SALARIO desc

-- Lista os 7 Funcionarios que ganham mais, inclusive aqueles empatados por ultimo na lista
select top 7 with ties codfun, nome, salario from TB_EMPREGADO order by salario desc

-- Mostrar 10% das linhas da tabela tb_empregado
select top 10 percent codfun, nome, salario from TB_EMPREGADO order by salario desc -- 7 linhas
																					-- Total = 61 linhas


-- Mostrando os funcionários com salário abaixo de 1000
select codfun, nome, cod_cargo, salario from TB_EMPREGADO where salario < 1000 order by salario	

-- Mostrando os funcionários com salário acima de 5000							
select codfun, nome, cod_cargo, salario from TB_EMPREGADO where salario > 5000 order by salario		

-- Mostrando os funcionários com departamento menor ou igual a 3
select * from TB_EMPREGADO where COD_DEPTO <= 3 order by COD_DEPTO

-- Mostrando os funcionários com departamento igual a 2 											
select * from TB_EMPREGADO where COD_DEPTO = 2 order by COD_DEPTO

-- Mostrando os funcionários com departamento diferente de 2
select * from TB_EMPREGADO where COD_DEPTO != 2 order by COD_DEPTO 

-- Mostrando os funcionários que tenham nome alfabeticamentte maior que RAQUEL	
select codfun, nome, salario from TB_EMPREGADO where nome > 'Raquel' order by nome 

select codfun, nome, salario from TB_EMPREGADO where nome < 'Eliana' order by nome 


select * from TB_EMPREGADO where COD_DEPTO = 2 or salario > 5000

select * from TB_EMPREGADO where COD_DEPTO = 2 and COD_DEPTO = 5

select * from TB_EMPREGADO where salario >= 3000 and SALARIO <= 5000 order by SALARIO

select * from TB_EMPREGADO where SALARIO < 3000 or SALARIO > 5000 order by SALARIO


-- Também pode ser feito usando o operador not, aqueles que não estão entre 3000 e 5000, estão fora dessa faixa
select * from TB_EMPREGADO where not (SALARIO >= 3000 and salario <= 5000) order by SALARIO




select * from TB_EMPREGADO where SALARIO between 3000 and 5000 order by SALARIO

select * from TB_EMPREGADO where DATA_ADMISSAO between '2000.1.1' and '2000.12.31' order by DATA_ADMISSAO

select * from TB_EMPREGADO where SALARIO not between 3000 and 5000 order by SALARIO



-- Busca na coluna por parte do nome
select * from TB_EMPREGADO where nome like 'MARIA%'

select * from TB_EMPREGADO where nome like 'MA%'

select * from TB_EMPREGADO where nome like '%MARIA'

select * from TB_EMPREGADO where nome like '%SOUZA%'

select * from TB_EMPREGADO where nome like '%z_' -- 1 casa depois do z

select * from TB_EMPREGADO where nome like '%SOU[SZ]A%' --ou S ou Z

select * from TB_EMPREGADO where nome not like '%MA%' -- Não tenham MA no nome




select * from TB_EMPREGADO where COD_DEPTO in (1,2,4,7) order by COD_DEPTO -- Codigos que tenham 1, 2, 4 ou 7

select nome, estado from TB_CLIENTE where estado in ('AM', 'PR', 'RJ', 'SP')	

select nome, estado from TB_CLIENTE where estado not in ('AM', 'PR', 'RJ', 'SP') -- Não teram esses estados

insert into TB_EMPREGADO (nome) values ('Jose Manuel')

select * from TB_EMPREGADO



-- buscando informação null
select codfun, nome, salario, premio_mensal, salario + premio_mensal as renda_total from TB_EMPREGADO where salario is null

select * from TB_EMPREGADO where DATA_NASCIMENTO is not null -- data_nascimento != null

select codfun, nome, salario, premio_mensal, isnull(salario, 0) + isnull(premio_mensal, 0) as renda_total -- Substituindo os valor nulos	
			from TB_EMPREGADO where salario is null

select codfun, nome, isnull(data_nascimento, '1900.1.1') as data_nasc from tb_empregado


-- adicionando 45 dias a partir da data atual
select getdate() + 45



-- Converteu em inteiro a conta que esta sendo feita (data atual - data admissao)
select codfun, nome, cast(getdate() - data_admissao as int) as dias_na_empresa from tb_empregado






--------------------/* LABORATÓRIO 2 */-----------------------

-- 1
use PEDIDOS

-- 2
select cod_produto, descricao, qtd_real, qtd_minima, qtd_real - qtd_minima as diferenca 
	from TB_PRODUTO where qtd_real < QTD_MINIMA

-- 3 
select * from tb_produto where qtd_real > 5000

-- 4
select * from TB_PRODUTO where preco_venda < 0.50

-- 5
select * from tb_pedido where vlr_total > 15000

-- 6
select * from TB_PRODUTO where QTD_REAL between 500 and 1000

-- 7
select * from TB_PEDIDO where VLR_TOTAL between 15000 and 25000

-- 8 
select * from TB_PRODUTO where QTD_REAL > 5000 and COD_TIPO = 6

-- 9
select * from TB_PRODUTO where QTD_REAL > 5000 or COD_TIPO = 6

-- 10	
select * from TB_PEDIDO where VLR_TOTAL < 100 or VLR_TOTAL > 100000 

-- 11
select * from TB_PRODUTO where QTD_REAL < 500 or QTD_REAL > 1000 


	

						------------------------ AULA 03 --------------------------


use PEDIDOS

-- Número do dia correspondente a data de hoje
select day (getdate()) [dia de hoje]

--Todos os funcionário admitidos no dia primeiro
-- de qualquer mês de qualquer ano
select * from TB_EMPREGADO
where day(data_admissao) = 1

-- Empregados admitidos no mês de dezembro
select * from TB_EMPREGADO
where month (data_admissao) = 12

select * from TB_EMPREGADO
where year(data_admissao) =  2006

select * from TB_EMPREGADO
where year(data_admissao) = 2006 and
		month(data_admissao) = 6

select * from TB_EMPREGADO
where datepart(year, data_admissao) = 1987 and
		datepart(month, data_admissao) = 05	


-- retornando o dia da semana
select 
	codfun, nome, data_admissao,
	datename(weekday, data_admissao) as dia_semana, 
	datename(month, data_admissao) as mes
from TB_EMPREGADO
where datepart(weekday, data_admissao) = 6		

-- Adicionando dia/mês/ano a partir da data atual
select dateadd(day, 45, getdate()) 

select dateadd(month, 6, getdate())

select dateadd(year, 2, getdate())


-- Diferença em meses
select datediff(month, '1959.11.12', getdate())


select DATEFROMPARTS(2013,12,25)

select TB_EMPREGADO.CODFUN, TB_EMPREGADO.nome, TB_DEPARTAMENTO.DEPTO
	from TB_EMPREGADO join TB_DEPARTAMENTO
		on TB_EMPREGADO.COD_DEPTO = TB_DEPARTAMENTO.COD_DEPTO

select e.codfun, e.nome, d.depto from TB_EMPREGADO e
		join TB_DEPARTAMENTO d
			on e.COD_DEPTO = d.COD_DEPTO


-- tb_empregado e tb_cargo
select e.codfun, e.nome, c.cargo from TB_EMPREGADO e
		join TB_CARGO c
			on e.COD_CARGO = c.COD_CARGO

select e.codfun, e.nome, c.cargo from TB_CARGO c
		join TB_EMPREGADO e
			on e.COD_CARGO = c.COD_CARGO

select e.codfun, e.nome, e.cod_depto, e.cod_cargo, d.depto, c.cargo 
		from TB_EMPREGADO e join TB_DEPARTAMENTO d on e.COD_DEPTO = d.COD_DEPTO
								join tb_cargo c on e.COD_CARGO = c.COD_CARGO


select i.num_pedido, i.num_item, i.cod_produto,		
		pr.descricao, i.quantidade, i.pr_unitario,
		t.tipo, u.unidade, cr.cor, pe.data_emissao
from TB_ITENSPEDIDO i
	join TB_PRODUTO pr	on i.ID_PRODUTO = pr.id_produto						
	join tb_cor cr		on i.ID_PRODUTO = cr.CODCOR
	join TB_TIPOPRODUTO t on pr.cod_tipo  = t.cod_tipo
	join TB_UNIDADE	u	on pr.COD_UNIDADE = u.cod_unidade
	join tb_pedido pe	on i.NUM_PEDIDO = pe.NUM_PEDIDO
where pe.DATA_EMISSAO between '2014.1.1' and '2014.1.31'	


select * from TB_EMPREGADO -- retorna 61 linhas

select e.codfun, e.nome, e.cod_depto, c.cargo  -- retorna 58 linhas (eliminação de valores null)
	from TB_EMPREGADO e inner join TB_CARGO c 
		on e.COD_CARGO = c.COD_CARGO




-- USANDO O LEFT JOIN (TODOS OS DADOS DA TABELA DO LADO ESQUERDO DO JOIN)
select e.codfun, e.nome, e.cod_depto, e.COD_CARGO, c.cargo 
	from TB_EMPREGADO e left join TB_CARGO c 
		on e.COD_CARGO = c.COD_CARGO
	where c.cod_cargo is null --mostrando somente os valores null

-- USANDO O RIGHT JOIN (TODOS OS DADOS DA TABELA DO LADO DIREITO DO JOIN)
select e.codfun, e.nome, e.cod_depto, c.cargo 
	from TB_EMPREGADO e right join TB_CARGO c 
		on e.COD_CARGO = c.COD_CARGO
	where e.cod_cargo is null --mostrando somente os valores null

-- USANDO O FULL JOIN UNE O LEFT E O RIGHT
select e.codfun, e.nome, e.cod_depto, e.cod_cargo, c.cargo
	from tb_empregado e full join tb_cargo c
	on e.COD_CARGO = c.COD_CARGO 
where e.COD_CARGO is null or c.COD_CARGO is null

-- USANDO O CROSS JOIN - Produto Cartesiano
select e.codfun, e.nome, e.cod_depto, e.cod_cargo, d.depto
	from TB_EMPREGADO e cross join TB_DEPARTAMENTO d
	

----------------------- CAP. 6 ----------------------------
--sub query--

select * from TB_CLIENTE
where exists (select * from TB_PEDIDO
				where CODCLI = TB_CLIENTE.CODCLI and
						DATA_EMISSAO between '2014.1.1'
						and '2014.1.31')
-- ou 
select * from TB_CLIENTE
where CODCLI in (select CODCLI from TB_PEDIDO
					where DATA_EMISSAO between '2014.1.1'
					and '2014.1.31')

-- Lista de empregados cujo cargo tenha salário incial inferior a 5000
select * from TB_EMPREGADO
where COD_CARGO in (select cod_cargo from TB_CARGO
						where SALARIO_INIC < 5000)

-- Lista de departamentos em que não existe nenhum funcinário cadastrado
select * from TB_DEPARTAMENTO
where COD_DEPTO not in (select distinct COD_DEPTO from TB_EMPREGADO  -- distinct retira repetição
							where COD_DEPTO is not null)
-- ou
select e.codfun, e.nome, e.cod_depto, e.cod_cargo, d.cod_depto, d.depto
		from TB_EMPREGADO e right join TB_DEPARTAMENTO d 
				on e.COD_DEPTO = d.COD_DEPTO
					where e.COD_DEPTO is null


-- Funcionários(s) que ganha(m) menos 
select * from TB_EMPREGADO
	where SALARIO = (select min(salario) from TB_EMPREGADO)
	
-- ou
select top 1 with ties * from TB_EMPREGADO  -- With ties busca todos os registros que bate no valor do critério
where salario is not null
order by SALARIO	


select * from TB_EMPREGADO
where DATA_ADMISSAO = (select max(data_admissao) from TB_EMPREGADO)	

-- ou
select top 1 with ties * from TB_EMPREGADO
order by DATA_ADMISSAO desc				


select p.codven, v.nome, sum(p.vlr_total) as tot_vendido, 100 * sum(p.vlr_total) / (select sum(vlr_total) 
		from TB_PEDIDO where DATA_EMISSAO between '2014.1.1' and '2014.1.31') as porcentagem
		from TB_PEDIDO p join TB_VENDEDOR v
		on p.CODVEN = v.CODVEN
		where p.DATA_EMISSAO between '2014.1.1' and '2014.1.31'
		group by p.CODVEN, v.NOME

select cod_depto, (select sum(e.salario) from TB_EMPREGADO e
	where e.sindicalizado = 's' and
		  e.cod_depto = TB_EMPREGADO.COD_DEPTO) as Tot_Salario__Sind,
		  (Select sum(e.salario) from TB_EMPREGADO e 
		  where e.SINDICALIZADO = 'n' and
		  e.COD_DEPTO = TB_EMPREGADO.COD_DEPTO) as Tot_Salario_Nao_Sind
	from TB_EMPREGADO
		group by COD_DEPTO


select * from TB_PEDIDO
	where CODVEN in (select CODVEN from TB_VENDEDOR where nome = 'LEIA')
	and CODCLI in (select CODCLI from TB_CLIENTE where CODCLI not in (select codcli from TB_PEDIDO
																			where DATA_EMISSAO between '2014.1.1' and
																			'2014.1.31') 
	and CODCLI in (select CODCLI from TB_PEDIDO where DATA_EMISSAO between '2013.12.1' and '2013.12.31')
	and ESTADO = 'SP')



-- TABELA TEMPORÁRIA 1 - CÓDIGO VENDEDORA LEIA
select codven into #vend_leia from tb_vendedor
	where nome = 'leia'

-- verificando o conteúdo da tabela temporária	
select * from #vend_leia

-- TABELA TEMPORÁRIA 2 - CLIENTES QUE COMPRARAM EM JAN/2014
select codcli into #cli_com_ped_jan_2014 from TB_PEDIDO
	where DATA_EMISSAO between '2014.1.1' and '2014.1.31'

-- TABELA TEMPORÁRIA 3 - CLIENTES QUE COMPRARAM DEZ/2013
select codcli into #cli_com_ped_2013 from TB_PEDIDO
	where DATA_EMISSAO between '2013.12.1' and '2013.12.31'


-- TABELA TEMPORÁRIA 4 - CLIENTES DE SP QUE COMPRARAM EM DEZ/2013, MAS NAO COMPRARAM EM JAN/2014
select codcli into #cli_final from TB_CLIENTE
	where CODCLI not in (select CODCLI from #cli_com_ped_jan_2014)
	and
		CODCLI in (select CODCLI from #cli_com_ped_2013)
	and
		estado = 'sp'


select * from TB_PEDIDO
	where codven in (select codven from #vend_leia)
	and
	codcli in (select codcli from #cli_final)


						---------------LAB PAG 176 CAP 05-----------------

-- 1 
use PEDIDOS

-- 2 
select p.num_pedido, p.data_emissao, p.vlr_total, v.nome as vendedor
		from tb_pedido p join TB_VENDEDOR v on p.CODVEN = v.CODVEN

-- 3
select p.num_pedido, p.data_emissao, p.vlr_total, c.nome as cliente
		from TB_PEDIDO p join TB_CLIENTE c on p.CODCLI = c.CODCLI

-- 4
select p.num_pedido, p.codven, p.data_emissao, p.vlr_total, v.nome as vendedor, c.nome as cliente
		from TB_PEDIDO p join TB_VENDEDOR v on p.CODVEN = v.CODVEN
						 join TB_CLIENTE c on p.CODCLI = c.CODCLI

-- 5 
select p.descricao, i.num_pedido, i.num_item, i.id_produto, i.cod_produto, i.quantidade, i.pr_unitario, i.data_entrega, i.situacao
	 from TB_ITENSPEDIDO i join TB_PRODUTO p 
				on i.ID_PRODUTO = p.ID_PRODUTO

-- 6
select p.cod_produto, p.descricao, t.tipo  from TB_PRODUTO p join TB_TIPOPRODUTO t
				on  p.COD_TIPO = t.COD_TIPO		
				
-- 7 
select p.cod_produto, p.descricao, t.tipo, u.unidade from TB_PRODUTO p
					 join TB_TIPOPRODUTO t on p.COD_TIPO = t.COD_TIPO
					 join TB_UNIDADE u on p.COD_UNIDADE = u.COD_UNIDADE
																
-- 8
select i.num_pedido, i.num_item, i.cod_produto, i.quantidade, i.pr_unitario, p.cod_produto, p.descricao, t.tipo, u.unidade 
		from TB_ITENSPEDIDO i join TB_PRODUTO p on i.ID_PRODUTO = p.ID_PRODUTO
							  join TB_TIPOPRODUTO t on p.COD_TIPO = t.COD_TIPO
							  join TB_UNIDADE u	 on p.COD_UNIDADE = u.COD_UNIDADE

-- 9
select i.num_pedido, i.num_item, i.cod_produto, i.quantidade, i.pr_unitario, p.cod_produto, p.descricao, t.tipo, u.unidade, c.cor
		from TB_ITENSPEDIDO i join TB_PRODUTO p on i.ID_PRODUTO = p.ID_PRODUTO
							  join TB_TIPOPRODUTO t on p.COD_TIPO = t.COD_TIPO
							  join TB_UNIDADE u	 on p.COD_UNIDADE = u.COD_UNIDADE
							  join TB_COR c		on i.CODCOR = c.CODCOR

-- 10
select p.num_pedido, p.codven, p.data_emissao, p.vlr_total, v.nome from TB_PEDIDO p join TB_VENDEDOR v
					on p.CODVEN = v.CODVEN where p.DATA_EMISSAO between '2014.1.1' and '2014.1.31' and v.nome = 'marcelo'

-- 11
select c.nome, p.data_emissao from tb_cliente c join TB_PEDIDO p on c.CODCLI = p.CODCLI 
					where p.DATA_EMISSAO between '2014.1.1' and '2014.1.31' order by p.DATA_EMISSAO

-- 12
select p.descricao, i.cod_produto, d.data_emissao from TB_ITENSPEDIDO i
					join TB_PRODUTO p on p.COD_PRODUTO = i.COD_PRODUTO
					join TB_PEDIDO d on i.NUM_PEDIDO = d.NUM_PEDIDO
					where d.DATA_EMISSAO between '2014.1.1' and '2014.1.31' order by p.DESCRICAO

-- 13
select p.num_pedido, p.vlr_total, c.nome from TB_PEDIDO p join TB_CLIENTE c on p.CODCLI = c.CODCLI	
						where p.DATA_EMISSAO between '2014.1.1' and '2014.1.31' and c.nome like 'MARCIO%'

-- 14
select i.num_pedido, i.quantidade, i.pr_unitario, p.descricao, v.nome

select * from TB_ITENSPEDIDO
select * from TB_PRODUTO
select * from TB_VENDEDOR
