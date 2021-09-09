use PEDIDOS

-- AVG = MÉDIA
select avg(salario) as salario_medio
	from TB_EMPREGADO

select avg(salario) as salario_medio
	from TB_EMPREGADO
		where COD_DEPTO = 2


-- COUNT = QUANTIDADE TOTAL 
select count(*) as qtd_empregados 
	from TB_EMPREGADO

select count(cod_depto) as qtd_empregados
	from TB_EMPREGADO
		where COD_DEPTO = 2


-- MIN = MENOR VALOR
select min(salario) as menor_salario
	from TB_EMPREGADO

select min(salario) as menor_salario
	from TB_EMPREGADO
		where COD_DEPTO = 2


-- MAX = MAIOR VALOR
select max(salario) as maior_salario
	from TB_EMPREGADO

select max(salario) as maior_salario
	from TB_EMPREGADO
		where COD_DEPTO = 2


-- SUM = SOMA
select sum(salario) as soma_salarios
	from TB_EMPREGADO


			---------------------- GROUP BY ----------------------------

select cod_depto, sum(salario) as tot_sal
	from TB_EMPREGADO
		group by COD_DEPTO
		order by tot_sal

-- UTILIZANDO COM O JOIN

select e.cod_depto, d.depto, sum(e.salario) as total_sal from TB_EMPREGADO e 
					join TB_DEPARTAMENTO d on e.COD_DEPTO = d.COD_DEPTO
		group by e.COD_DEPTO, d.DEPTO
		order by total_sal

-- consulta do tipo Ranking - OS 5 PRIMEIROS DEPARTAMENTOS QUE MAIS GASTAM COM SALARIO
select top 5 e.cod_depto, d.depto, sum(e.salario) as total_sal from TB_EMPREGADO e
					join TB_DEPARTAMENTO d on e.COD_DEPTO = d.cod_depto
		group by e.COD_DEPTO, d.DEPTO
		order by total_sal desc

-- OS 10 CLIENTES QUE MAIS GASTARAM EM JANEIRO 2014
select top 10 c.codcli, c.nome, sum(p.vlr_total) as total_comprado
		from TB_PEDIDO p join TB_CLIENTE c on p.CODCLI = c.CODCLI
			where p.DATA_EMISSAO between '2014.1.1' and '2014.1.31'
				group by c.CODCLI, c.NOME
					order by total_comprado desc


-- ALL (ATRIBUI OS VALORES NULL)
select c.codcli, c.nome, sum(p.vlr_total) as tot_comprado
		from TB_PEDIDO p join TB_CLIENTE c on p.CODCLI = c.CODCLI
			where p.DATA_EMISSAO between '2014.1.1' and '2014.1.31'
				group by all c.CODCLI, c.NOME


-- HAVING = FILTRO (EX: WHERE). RESULTADO. HAVING somente no group by
-- WHERE = FILTRA VALOR DA COLUNA
select e.cod_depto, d.depto, sum(e.salario) as tot_sal from TB_EMPREGADO e 
			join TB_DEPARTAMENTO d on e.COD_DEPTO = d.COD_DEPTO
				group by e.COD_DEPTO, d.DEPTO
					HAVING sum(e.salario) > 10000
						order by tot_sal

-- Gera subtotal para agrupamento determinado na clausa group by	
select v.nome as vendedor, c.nome as cliente, isnull (t.tipo,'total')tipo_produto, sum(i.quantidade) as qntd_total from TB_PEDIDO Pe
				join TB_CLIENTE c on pe.CODCLI = c.CODCLI
				join TB_VENDEDOR v on pe.CODCLI = v.CODVEN
				join TB_ITENSPEDIDO i on pe.NUM_PEDIDO = i.NUM_PEDIDO
				join TB_PRODUTO pr on i.ID_PRODUTO = pr.ID_PRODUTO
				join TB_TIPOPRODUTO t on pr.COD_TIPO = t.COD_TIPO
			where pe.DATA_EMISSAO between '2013.1.1' and '2013.6.30'
				group by v.NOME, c.NOME, t.TIPO
	with rollup -- soma das quantidade total 



-- Gera subtotal pelo menor nível de detalhamento conforme a clausula group by (tipo produto: tipo)
select v.nome as vendedor, isnull(c.nome,'total') as cliente, isnull (t.tipo,'total')tipo_produto, sum(i.quantidade) as qntd_total from TB_PEDIDO Pe
				join TB_CLIENTE c on pe.CODCLI = c.CODCLI
				join TB_VENDEDOR v on pe.CODCLI = v.CODVEN	
				join TB_ITENSPEDIDO i on pe.NUM_PEDIDO = i.NUM_PEDIDO
				join TB_PRODUTO pr on i.ID_PRODUTO = pr.ID_PRODUTO
				join TB_TIPOPRODUTO t on pr.COD_TIPO = t.COD_TIPO
			where pe.DATA_EMISSAO between '2013.1.1' and '2013.12.30'
								and v.nome='leia'
				group by v.NOME, c.NOME, t.TIPO
	with cube




---------- CAP 10 -------------


-- Retorna a quantidade de caracteres contidas na String
select len('Brasil')

-- Replica o Texto (TEXTO, QNTD)
select replicate('teste',4)

-- Inverte o texto
select reverse('anima ai')

-- Converte um número em texto
select str(213)

-- (TEXTO, INICIA NA POSIÇÃO, TERMINA NA POSIÇÃO(contada a partir da iniciação))
select SUBSTRING('Paralelepípedo',3,7)

-- Concatena Strings
select CONCAT('SQL', ' MÓDULO'
		+	replicate(' ', 15), 'I')

-- Procura o primeiro caractere no segundo parametrô
select CHARINDEX('A', 'CASA')
select CHARINDEX('O', 'Caio')


select GETDATE()

-- Formata uma expressão
select format(getdate(), 'dd/MM/yyyy')


select nome, salario, case sindicalizado 
						when 'S' then 'Sim'
						when 'N' then 'Não'
						else 'N/C'
					end as [Sindicato?],
		data_admissao
	from TB_EMPREGADO


select nome, salario, data_admissao, case DATEPART(weekday, data_admissao)
						when 1 then 'Domingo'
						when 2 then 'Segunda-Feira'
						when 3 then 'Terça-Feira'
						when 4 then 'Quarta-Feira'
						when 5 then 'Quinta-Feira'
						when 6 then 'Sexta-Feira'
						when 7 then 'Sábado'
					end as [Dia Da Semana]
				from TB_EMPREGADO
	
-- Une Resultados de duas fontes de informação, trazendo visão como se fosse apenas de um lugar (tabela)
select nome, fone1 from TB_CLIENTE
union 
select nome, FAX from TB_CLIENTE order by NOME

-- All - Busca valores repetidos
select nome, fone1 from TB_CLIENTE
union all
select nome, fone1 from TB_CLIENTE order by NOME




select cod_depto from TB_DEPARTAMENTO
	intersect
select cod_depto from TB_EMPREGADO
	where SALARIO > 5000

-- select * from TB_EMPREGADO where salario > 5000

-- Except mostra o que não tem na TB_EMPREGADO mas tem na tb_DEPARTAMENTO
select cod_depto from TB_DEPARTAMENTO
	except
select cod_depto from TB_EMPREGADO

-- select * from TB_EMPREGADO where COD_DEPTO in (10,13)
	

select cod_cargo from TB_CARGO
	except
select cod_Cargo from TB_EMPREGADO
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	-------- LAB 1 - CAP 09 ----------

-- 1
use PEDIDOS

-- 2
select count(PRECO_VENDA) as Média from TB_PRODUTO

-- 3
select count(data_emissao) as [Qntd_Pedido(01/14)], max(vlr_total) as [Maior_Vlr_Total], min(vlr_total) as [Menor_Vlr_Total]
					from TB_PEDIDO where DATA_EMISSAO between '2014.1.1' and '2014.1.31'

-- 4
select sum(vlr_total) as [Valor_Total_Vendido] from TB_PEDIDO where DATA_EMISSAO  between '2014.1.1' and '2014.1.31'

-- 5
select * from TB_PEDIDO
select sum(vlr_total) as [Valor_Total_Vendido] from TB_PEDIDO where CODVEN = 1 and  DATA_EMISSAO  between '2014.1.1' and '2014.1.31'

-- 6
select v.NOME, v.CODVEN, sum(p.vlr_total) from TB_PEDIDO p join TB_VENDEDOR v on p.CODVEN = v.CODVEN 
				where p.DATA_EMISSAO between '2014.1.1' and '2014.1.31' and v.NOME='Leia'

-- 7
select v.NOME, v.CODVEN, sum(p.vlr_total) from TB_PEDIDO p join TB_VENDEDOR v on p.CODVEN = v.CODVEN 
				where p.DATA_EMISSAO between '2014.1.1' and '2014.1.31' and v.NOME='Marcelo'

-- 8
select v.NOME, ((p.VLR_TOTAL * v.PORC_COMISSAO) / 100) as comissao from TB_PEDIDO p join TB_VENDEDOR v on p.CODVEN = v.CODVEN
				where p.DATA_EMISSAO between '2014.1.1' and '2014.1.31' and v.NOME='Leia'

-- 9

select v.NOME, ((p.VLR_TOTAL * v.PORC_COMISSAO) / 100) as comissao from TB_PEDIDO p join TB_VENDEDOR v on p.CODVEN = v.CODVEN
				where p.DATA_EMISSAO between '2014.1.1' and '2014.1.31' and v.NOME='Marcelo'


-- 10	
select  v.nome, sum(p.vlr_total) as total_vendido
		from TB_PEDIDO p join TB_VENDEDOR v on p.CODVEN = v.codven
			where p.DATA_EMISSAO between '2014.1.1' and '2014.1.31'
				group by  v.NOME
					order by total_vendido desc

-- 11
select c.nome, sum(p.vlr_total) as total_comprado
		from TB_PEDIDO p join TB_CLIENTE c on p.CODCLI = c.CODCLI
			where p.DATA_EMISSAO between '2014.1.1' and '2014.1.31'
				group by  c.NOME
					order by total_comprado desc

-- 12
select sum(p.vlr_total) as valor_total_vend, count(p.vlr_total) as total_vend 
				from TB_PEDIDO p 
					where DATA_EMISSAO between '2014.1.1' and '2014.1.31'

-- 13
select  v.nome, sum(p.vlr_total) as total_vendido
		from TB_PEDIDO p join TB_VENDEDOR v on p.CODVEN = v.codven
			where p.DATA_EMISSAO between '2014.1.1' and '2014.1.31'
				group by  v.NOME
					having sum(p.vlr_total) > 80000
						order by total_vendido desc

-- 14
select c.nome, sum(p.vlr_total) as total_comprado
		from TB_PEDIDO p join TB_CLIENTE c on p.CODCLI = c.CODCLI
			where p.DATA_EMISSAO between '2014.1.1' and '2014.1.31'
				group by  c.NOME
					having sum(p.vlr_total) > 6000
						order by total_comprado desc

-- 15
select sum(p.vlr_total) as valor_total_vend, count(p.vlr_total) as total_vend 
				from TB_PEDIDO p 
					where DATA_EMISSAO between '2014.1.1' and '2014.1.31'
						and VLR_TOTAL > 16000
							order by total_vend

-- 16
select top 10 v.nome, sum(p.vlr_total) as total_vendido
		from TB_PEDIDO p join TB_VENDEDOR v on p.CODVEN = v.codven
			where p.DATA_EMISSAO between '2014.1.1' and '2014.1.31'
				group by  v.NOME
					order by total_vendido desc
						
-- 17
select top 10 v.nome, sum(p.vlr_total) as total_vendido
		from TB_PEDIDO p join TB_VENDEDOR v on p.CODVEN = v.codven
			where p.DATA_EMISSAO between '2014.1.1' and '2014.1.31'
				group by  v.NOME
					order by total_vendido desc


	-------- LAB 1 - CAP 10 ----------

-- 1
use PEDIDOS

-- 2
select nome, salario, data_admissao, 
							case datepart(month, data_admissao)
								when 1 then 'Janeiro'
								when 2 then 'Fevereiro'
								when 3 then 'Março'
								when 4 then 'Abril'
								when 5 then 'Maio'
								when 6 then 'Junho'
								when 7 then 'Julho'
								when 8 then 'Agosto'
								when 9 then 'Setembro'
								when 10 then 'Outubro'
								when 11 then 'Novembro'
								when 12 then 'Dezembro'
							end as Mês
						from TB_EMPREGADO
							
-- 3
select nome, CONCAT(ENDERECO,' - ',BAIRRO,' - ',cidade,'/',estado)	
		from TB_CLIENTE

-- 4
select nome, format(data_nascimento, 'dd/MM')	from TB_EMPREGADO 

-- 5

