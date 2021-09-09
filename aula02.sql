use sala_de_aula

create table tb_alunoo(
	cod_aluno			int identity primary key,
	nome				varchar (30),
	data_nasc			datetime,
	idade				tinyint,
	e_mail				varchar(50),
	fone_res			char(9),
	fone_com			char(9),
	fax					char(9),
	celular				char(9),
	profissao			varchar(40),
	empresa				varchar(50),
)

insert into tb_alunoo (nome, data_nasc,idade, e_mail, fone_res, fone_com, fax, celular, profissao, empresa)
	values ('Carlos Magno', '1959.11.12', 53, 'magno@magno.com', '23456789', '23459876', '', '998765432',
			'Analista De Sistemas', 'IMPACTA TECNOLOGIA')
insert into tb_alunoo (nome, data_nasc,idade, e_mail, fone_res, fone_com, fax, celular, profissao, empresa)
	values ('Caio Ramos', '1999.07.09', 19, 'caio@magno.com', '23456789', '23459876', '', '998765432',
			'Programador', 'IMPACTA TECNOLOGIA')
insert into tb_alunoo (nome, data_nasc,idade, e_mail, fone_res, fone_com, fax, celular, profissao, empresa)
	values ('Andre da Silva', '1980.1.2', 33, 'Andre@silva.com', '23456789', '23459876', '', '988765432',
			'Analista De Sistemas', 'SOMA INFORMÁTICA'),
			 ('Marcelo Soares', '1983.4.21', 30, 'marcelo@soares.com', '23456789', '23459876', '', '988523354',
			 'Instrutor', 'IMPACTA TECNOLOGIA')


select cod_aluno, nome, idade, profissao, empresa from tb_alunoo where idade <= 30


create table alunos2 (
	num_aluno			int,
	nome				varchar(30),	
	data_nasc			datetime,
	idade				tinyint,
	e_mail				varchar(50),
	fone_res			char(8),
	fone_com			char(8),
	fax					char(8),
	celular				char(9),
	profissao			varchar(40),
	empresa				varchar(50)
)

insert into alunos2 
select * from tb_alunoo /*Inserindo dados de tb_alunoo em alunos2*/

select * from alunos2

insert into tb_alunoo values ('Maria Luiza', '1997.10.29', 15 , 'Luiza@luiza.com', '23456789', '23457896', '', '998745236',
								'Estudante', 'Colégio Monte Videl') 

 