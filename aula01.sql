create database sala_de_aula
go
use sala_de_aula

create table tb_aluno(
	cod_aluno		int,
	nome			varchar(30),
	data_nascimento	datetime,
	idade			tinyint,
	e_mail			varchar(50), -- varchar = elimina os espaços vazio
	fone_res		char(9),  -- char = tamanho todo utilizado
	fone_com		char(9),
	fax				char(9),
	celular			char(9),
	profissao		varchar(40),
	empresa			varchar(50) )

-- apaga a tabela
drop table tb_aluno



create table tb_aluno(
	num_aluno			int identity,
	nome				varchar(30),
	data_nascimento		datetime,
	idade				tinyint,
	e_mail				varchar(50),
	fone_res			char(8),
	fone_com			char(8),
	fax					char(8),
	celular				char(8),
	profissao			varchar(40),
	empresa				varchar(50) 
)


insert tb_aluno (nome) values ('Edson')

select * from tb_aluno 



drop table tb_aluno



create table tb_aluno(
	codigo				int not null,
	nome				varchar(30) not null,
	e_mail				varchar(100) null
)

insert tb_aluno (codigo) values (1)
insert tb_aluno (codigo, nome) values (2,'Caio')

select * from tb_aluno


/* 
Constraints -> Validações, restrições, consistências de dados.
As constraints permitem validar os dados que são gravados nas tabelas do
banco de dados.
*/

create database teste_constraint
go
use teste_constraint

create table tb_tipo_produto (
	cod_tipo			int identity not null,  -- identity para adicionar número automaticamente (+1)
	tipo				varchar(30) not null,
	constraint pk_tb_tipo_produto -- nome da constraint
				primary key (cod_tipo),
	constraint uq_tb_tipo_produto_tipo
				unique (tipo)
)

insert tb_tipo_produto values ('Mouse')
insert tb_tipo_produto values ('Pen-Drive')
insert tb_tipo_produto values ('Hard Disk')

-- Select * from tb_tipo_produto
	select cod_tipo from tb_tipo_produto

insert tb_tipo_produto values ('Hard Disk') -- ERRO de Constraint Unique



create table tb_produto (
	id_produto			int identity not null, 
	descricao			varchar(50),
	cod_tipo			int,
	preco_custo			numeric(10,2),
	preco_venda			numeric(10,2),
	qntd_real			numeric(10,2),
	qntd_minima			numeric(10,2),
	data_cadastro		datetime default getdate(), --se estiver vazio o dafault coloca automatico o valor...
	sn_ativo			char(1) default 'S',  --se nao tiver nada o valor fica como 'S'
	constraint  pk_tb_produto 
				 primary key (id_produto),
constraint uq_tb_produto_descricao
				 unique (descricao),
	constraint ck_tb_produto_precos
				check (preco_venda >= preco_custo),
	constraint ck_tb_produto_data_cad
				check (data_cadastro <= getdate()),
	constraint ck_tb_produto_sn_ativo
				check (sn_ativo in ('N', 'S')),
	constraint fk_tb_produto_tipo_produto
				 foreign key (cod_tipo)
				 references tb_tipo_produto (cod_tipo)
)


select * from tb_tipo_produto
select * from tb_produto


-- teste a constraint default, vai gerar informação
-- data_cadastro e sn_ativo sem que tenham sido mencionadas no insert 

insert tb_produto (descricao, cod_tipo, preco_custo, preco_venda, qntd_real, qntd_minima)	
		values ('Testando Inclusão', 1, 10, 12, 10, 5)

insert tb_produto (descricao, cod_tipo, preco_custo, preco_venda, qntd_real, qntd_minima)
		values ('Testando Inclusão 2', 10, 10, 12, 10, 5) -- ERRO, pois não existe o cod_tipo = 10 em tb_tipo_produto

insert tb_produto (descricao, cod_tipo, preco_custo, preco_venda, qntd_real, qntd_minima)
		values ('Testando Inclusão 2', 1, 14, 12, 10, 5) -- ERRO, pois preco_custo > preco_venda



  /*  TESTE PESSOAL

select tb_tipo_produto.tipo, tb_produto.preco_custo, tb_produto.preco_venda, tb_produto.sn_ativo 
				from tb_tipo_produto  inner join tb_produto 
							on tb_produto.cod_tipo = tb_produto.cod_tipo
*/





-- UTILIZANDO O ALTER TABLE --- 

drop table tb_produto

drop table tb_tipo_produto



create table tb_tipo_produto (
	cod_tipo			int identity not null, 
	tipo				varchar(30) not null,
)

alter table tb_tipo_produto add
	constraint pk_tipo_produto 
		primary key (cod_tipo)

alter table tb_tipo_produto add
	constraint uq_tipo_produto_tipo
		unique (tipo)



create table tb_produto (
	id_produto			int identity not null, 
	descricao			varchar(50),
	cod_tipo			int,
	preco_custo			numeric(10,2),
	preco_venda			numeric(10,2),
	qntd_real			numeric(10,2),
	qntd_minima			numeric(10,2),
	data_cadastro		datetime, 
	sn_ativo			char(1) 
)

alter table tb_produto add
	constraint pk_tb_produto
		primary key (id_produto)

alter table tb_produto add
	constraint uq_tb_produto_descricao
		unique (descricao)

-- criando várias constraints em um unico alter table

alter table tb_produto add
	constraint ck_tb_produto_precos
		check(preco_venda >= preco_custo),
	constraint ck_tb_produto_data
		check(data_cadastro <= getdate()),
	constraint ck_tb_produto_sn_ativo
		check(sn_ativo in ('S', 'N')),
	constraint fk_tb_produto_tipo_produto
		foreign key (cod_tipo)
		references tb_tipo_produto (cod_tipo),
	constraint df_tb_produto_sn_ativo
		default ('S') for sn_ativo,
	constraint df_tb_produto_data_cadastro
		default(getdate()) for data_cadastro 
		