	use pedidos

declare @a int = 10;
	print @a

	/* Operadores lógicos (mesmo processo da programação) */

set @a += 1
	print @a

set @a /= 2
	print @a

set @a += 2 * 3
	print @a


-- aumentar o salário dos funcionários em 20%
update TB_EMPREGADO
	set SALARIO *= 1.2

-- Somar 2 na quantidade de dependentes do func cod 5
update TB_EMPREGADO 
	set NUM_DEPEND += 2
		where CODFUN = 5

	select num_depend from TB_EMPREGADO where CODFUN = 5

-- Alterar dados do cliente de cod 5
update TB_CLIENTE
	set ENDERECO = 'Av Paulista 1009 - 10 and',
		bairro = 'cerqueira cesar',
		CIDADE = 'Sao Paulo'
where CODCLI = 5


select * from TB_CLIENTE where CODCLI = 5

-- Alterar os dados do grupo de produtos
select * from TB_PRODUTO
	where cod_tipo = 5

update TB_PRODUTO
	set QTD_ESTIMADA = qtd_real,
		CLAS_FISC = '96082000',
		ipi = 8
	where COD_TIPO = 5

select * from TB_PRODUTO
	where cod_tipo = 5



select * from emp_temp
-- Multiplicar por 10 o valor do salario de registros
update top (5) emp_temp set salario *= 10

-- INTO <nome tabela> para gerar uma tabela com os dados do resultset determinado no select

select * into empregados_tmp from TB_EMPREGADO

select * from empregados_tmp -- where SALARIO > 5000

select * from empregados_tmp where SALARIO > 5000


delete from empregados_tmp where SALARIO > 5000


-- Apaga os registros com os codigos citados
select * from empregados_tmp where codfun in (3,5,7)
delete from empregados_tmp where codfun in (3,5,7)


-- criar tabela a partir do comendo select into

select * into cliente_mg from TB_CLIENTE

select * from cliente_mg


-- apaga os 10 primeiros registros da tabela
delete top(10) from cliente_mg


create table emp_temp(
	codfun		int primary key,
	nome		varchar(30),
	cod_depto	int,
	cod_cargo	int,
	salario		numeric(10,2)
	) 

	--output inserted.* -> mostrar todos os registros que foram incluidos
insert into emp_temp output inserted.* select codfun, nome, cod_depto, cod_cargo, salario from TB_EMPREGADO

	--output deleted.* -> Mostra todos os registro que foram excluidos	
delete from emp_temp output deleted.*
	where cod_depto = 2


update emp_temp set salario *= 1.5
output inserted.codfun, inserted.nome, inserted.cod_depto,
	 deleted.salario as Salario_Antigo,
	 inserted.salario as Salario_Novo
		where cod_depto = 3
		

-- abre uma transação no banco
	begin transaction 

-- verifica se existe transações 
	select @@TRANCOUNT

-- Alterar os salairos do cod_cargo = 5
	update TB_EMPREGADO set SALARIO = 950
	output inserted.CODFUN, inserted.NOME, 
			deleted.salario as Salario_Anterior,
			inserted.salario as Salario_Atualizado
	where COD_CARGO = 5

-- Se estiver tudo ok
Commit transaction

-- Caso Contrário
rollback transaction

select * from TB_EMPREGADO where COD_CARGO = 5

update TB_EMPREGADO
	set salario *= 1.10
		where COD_DEPTO = (select COD_DEPTO from TB_DEPARTAMENTO
									where depto = 'C.P.D.')

update TB_PRODUTO	
	set PRECO_VENDA = PRECO_CUSTO * 1.2
		where COD_TIPO = (select COD_TIPO from TB_TIPOPRODUTO
									where tipo = 'regua')

delete from TB_PEDIDO
	where DATA_EMISSAO between '2013.12.1' and '2013.12.15' and CODVEN = (select CODVEN from TB_VENDEDOR
																				where nome = 'Marcelo')
---------- OU ------------

update TB_EMPREGADO set SALARIO *= 1.10 from TB_EMPREGADO e
		 inner join TB_DEPARTAMENTO d on e.COD_DEPTO = d.COD_DEPTO
			where d.DEPTO = 'C.P.D'

update TB_PRODUTO set PRECO_VENDA = PRECO_CUSTO * 1.2 from TB_PRODUTO p 
		inner join TB_TIPOPRODUTO t on p.COD_TIPO = t.COD_TIPO
			where t.TIPO = 'regua'

delete from TB_PEDIDO from TB_PEDIDO p join TB_VENDEDOR v 
					on p.CODVEN = v.CODVEN
					where p.DATA_EMISSAO between '2013.12.1' and '2013.12.15'
						and v.nome = 'marcelo'

						---------- LABORATÓRIO -----------

----- CAP 7 ------

-- 1
use PEDIDOS

-- 2
select * from TB_PRODUTO
update TB_PRODUTO set PRECO_CUSTO += 0.15 where COD_TIPO = 2

-- 3
begin tran

update TB_PRODUTO set PRECO_VENDA = PRECO_CUSTO * 1.3
	output inserted.*
		where COD_TIPO = 2

-- 4 
 update TB_PRODUTO set IPI += 0.5 where COD_TIPO = 3

 -- 5 
 update TB_PRODUTO set QTD_MINIMA -= QTD_MINIMA * 0.10 output
								deleted.QTD_MINIMA as Qntd_Antigo,
								inserted.QTD_MINIMA as Qntd_Novo

-- 6 
update TB_CLIENTE
	set ENDERECO = 'AV. CELSO GARCIA, 1234',
		bairro = 'TATUAPE',
		CIDADE = 'Sao Paulo',
		ESTADO = 'SP',
		CEP	   = '03407080'
	output deleted.ENDERECO as End_Antigo,
		   deleted.BAIRRO	as Bairro_Antigo,
		   deleted.CIDADE   as Cidade_Antigo,
		   deleted.ESTADO	as Estado_Antigo,
		   deleted.CEP		as CEP_Antigo,
		   inserted.ENDERECO as End_Novo,
		   inserted.BAIRRO	 as Bairro_Novo,
		   inserted.CIDADE   as Cidade_Novo,
		   inserted.ESTADO   as Estado_Novo,
		   inserted.CEP		 as CEP_Novo
where CODCLI = 11							

select * from TB_CLIENTE where CODCLI = 11

-- 7	
update TB_CLIENTE
	set END_COB = ENDERECO,
		BAI_COB = BAIRRO,
		CID_COB = CIDADE,
		EST_COB = ESTADO,
		CEP_COB = CEP
	where CODCLI = 13

-- 8 
update TB_CLIENTE set ICMS = 12 output deleted.ICMS as ICMS_Antigo,
										inserted.ICMS as ICMS_Novo
   where ESTADO in ('rj','ro','ac','rr','mg','pr','sc','rs','ms','mt')

-- 9 
update TB_CLIENTE set ICMS = 18 output deleted.ICMS as ICMS_Antigo,	inserted.ICMS as ICMS_Novo
			where ESTADO = 'sp'

-- 10
update TB_CLIENTE set ICMS = 7 output deleted.ICMS as ICMS_Antigo,	inserted.ICMS as ICMS_Novo
	where ESTADO not in ('rj','ro','ac','rr','mg','pr','sc','rs','ms','mt','sp')

-- 11
select * from TB_ITENSPEDIDO
update TB_ITENSPEDIDO set desconto = 7 where ID_PRODUTO = 8 and DATA_ENTREGA between '2014-01-01' and '2014-01-31' 
															and QUANTIDADE > 1000

-- 12
update TB_ITENSPEDIDO set desconto = 0 where QUANTIDADE < 1000 and DATA_ENTREGA > '2014-06-01' and DESCONTO > 0

-- 13
select * into vendedores_tmp from TB_VENDEDOR
select * from vendedores_tmp

-- 14
delete from vendedores_tmp output deleted.*
	where CODVEN > 5

-- 15
select * into copia_pedidos from TB_PEDIDO

-- 16
delete from copia_pedidos output deleted.*
	where CODVEN = 2

-- 17
delete from copia_pedidos output deleted.*
	where DATA_EMISSAO between '2014-01-01' and '2014-06-30'

-- 18
delete from copia_pedidos output deleted.*

--19
drop table copia_pedidos


----- CAP 8 ------	


-- 1
use PEDIDOS

-- 2
update TB_CARGO set SALARIO_INIC = 600 output deleted.SALARIO_INIC as Salario_Antigo, inserted.SALARIO_INIC as Salario_Novo
				where CARGO = 'OFICCE BOY'

-- 3
update TB_CARGO set SALARIO_INIC += SALARIO_INIC*0.10 output deleted.SALARIO_INIC as Salario_Antigo, 
															inserted.SALARIO_INIC as Salario_NOVO
select * from tb_cargo
-- 4
update TB_EMPREGADO set SALARIO = c.SALARIO_INIC from TB_EMPREGADO e 
				join TB_CARGO c on e.COD_CARGO = c.COD_CARGO

-- 5
update TB_PRODUTO set PRECO_VENDA = PRECO_CUSTO * 1.3

-- 6
update TB_PRODUTO set PRECO_VENDA = PRECO_CUSTO * 2.0 
			where COD_TIPO = 5

-- 7
update TB_PRODUTO set PRECO_VENDA = PRECO_CUSTO * 4.0 from TB_PRODUTO p join TB_TIPOPRODUTO t	
								on p.COD_TIPO = t.COD_TIPO
			where t.TIPO = 'regua'	

-- 8
update TB_ITENSPEDIDO set CODCOR = 7 from TB_ITENSPEDIDO t join TB_COR c
						on t.CODCOR = c.CODCOR
						where c.COR = 'VERMELHO' and
						DATA_ENTREGA between '2014-10-1' and '2014-10-31'

-- 9	
update TB_CLIENTE set ICMS = 12 output deleted.ICMS as ICMS_Antigo, inserted.ICMS as ICMS_Novo
							where estado in ('RJ','RO','AC','RR','MG','PR','SC','RS','MS','MT')

-- 10	
update TB_CLIENTE set ICMS = 18 output deleted.ICMS as ICMS_Antigo, inserted.ICMS as ICMS_Novo
							where ESTADO = 'SP'

-- 11
update TB_CLIENTE set ICMS = 7 output deleted.ICMS as ICMS_Antigo, inserted.ICMS as ICMS_Novo	
							where estado not in ('RJ','RO','AC','RR','MG','PR','SC','RS','MS','MT','SP')

-- 12
create table estados (
	cod_estado		int identity primary key,
	sigla			char (2),
	icms			numeric (4,2)
	)

-- 13
insert into estados output inserted.*
SELECT DISTINCT ESTADO, ICMS FROM TB_CLIENTE
WHERE ESTADO IS NOT NULL

-- 14 
alter table tb_cliente  add cod_estado int

-- 15
update TB_CLIENTE set cod_estado = (select cod_estado from estados)
select * from TB_CLIENTE
select * from estados









			