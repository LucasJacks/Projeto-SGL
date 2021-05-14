create database selecta;


/*=============== TABELA CARGOS ============================================================================================*/


create table CARGOS (
	id serial,
	código integer unique not null,
	descricao varchar(50) unique not null,
	primary key (id)
	);
	
insert into cargos values 
	(DEFAULT,'01','Administrador'),
	(DEFAULT,'02','Gerente'),
	(DEFAULT,'03','Supervisor'),
	(DEFAULT,'04','Caixa');


/*=============== TABELA RELACIONAL USUÁRIOS ============================================================================================*/


create table usuarios (
	id serial,
	email varchar(150) unique not null,
	senha varchar(20) unique not null,
	nome varchar(100) not null,
	cpf integer unique not null,
	telefone integer unique not null,
	id_cargo_fk INTEGER UNIQUE NOT NULL 
	primary key (id),
	foreign key (id_cargo_fk) references cargos (id)
	);
	
insert into usuarios values 
	(DEFAULT,'lucas.selectaloterica@gmail.com','123456','Lucas Rocha Jacks','03490717058','51995773541'),
	(DEFAULT,'carlarjacks@gmail.com','96583352','Carla Bernadete Rocha Jacks','98765432112', '51997370179');


/*=============== TABELA UNIDADE LOTERICA ============================================================================================*/


create table unidadeloterica (
	id serial,
	filial int unique not null,
	codigoloterico int unique not null,
	cnpj char(14) unique not null,
	nomefantasia varchar(50),
	razaosocial varchar(50) not null,
	endereco varchar(100) not null,
	primary key (id)
	);
	
insert into unidadeloterica values 
	(DEFAULT,'01','180041797','89473474000164','SELECTA AGÊNCIAS LOTÉRICAS','SELECTA AGÊNCIAS LOTÉRICAS LTDA.','AVENIDA PARAGUASSU, 2146, LOJAS 01 E 02, CENTRO, CAPÃO DA CANOA, RS, 95555000'),
	(DEFAULT,'02','180078844','89473474000245','SELECTA AGÊNCIAS LOTÉRICAS FILIAL', 'SELECTA AGÊNCIAS LOTÉRICAS LTDA. - FILIAL','RUA FAUSTINO JOÃO PEREIRA, 252, LOJA 03, SANTA LUZIA, CAPÃO DA CANOA, RS, 95555000'),
	(DEFAULT,'03','180151894','05312561000140','SELECTA AGÊNCIAS LOTÉRICAS','BPR LOTERIAS E CONVENIÊNCIAS LTDA.','AVENIDA RUDÁ, 907, LOJA 01, ZONA NOVA, CAPÃO DA CANOA, RS, 95555000');
	

/*=============== TABELA RELACIONAL TFL'S ============================================================================================*/


create table TFL (
	id serial,
	numeroserie integer not null,
	codigo integer not null,
	modelo integer not null,
	id_codigoloterico_fk integer not null,
	primary key (id),
	foreign key (id_codigoloterico_fk) references unidadeloterica (id)
);

insert into tfl values 
	(DEFAULT,'3069588','15910','4020','180041797'),
	(DEFAULT,'3069586','15909','4020','180041797'),
	(DEFAULT,'3069597','15908','4020','180041797'),
	(DEFAULT,'3069606','15906','4020','180041797');


/*=============== TABELA TIPO OPERAÇÕES ============================================================================================*/


create table TipoOperacoes (
	id serial,
	descricao varchar (50) not null,
	categoria varchar (50) not null,
	observacao varchar (150)	
);

INSERT INTO TipoOperacoes VALUES
	(DEFAULT,'SANGRIA','CRÉDITO'),
	(DEFAULT,'SUPRIMENTO','DÉBITO'),
	(DEFAULT,'TROCO','DÉBITO'),
	(DEFAULT,'DESPESA','CRÉDITO');


/*=============== TABELA RELACIONAL OPERAÇÕES ============================================================================================*/


create table operacoes (
	id serial,
	valor decimal (10,2) not null,
	id_tfl_fk INTEGER NOT NULL,
	id_tipo_fk INTEGER NOT NULL,
	id_usuario_fk INTEGER NOT NULL,
	observacao varchar (150),
	primary key (id),
	foreign key (id_tfl_fk) references TFL (id),
	foreign key (id_tipo_fk) references TipoOperacoes (id),
	foreign key (id_usuario_fk) references usuarios (id)
);


/*=============== TABELA RELACIONAL LOG ============================================================================================*/


create table LOG (
	id serial,
	dataHora DATE not null,
	id_operação_fk INTEGER NOT NULL,
	descricao VARCHAR(500),
	id_usuario_fk INTEGER NOT NULL,
	nomeTabela varchar (150) NOT NULL,
	primary key (id),
	foreign key (id_operacao_fk) references operacoes (id),
	foreign key (id_usuario_fk) references usuarios (id)
);


/*=============== TABELA PERMISSOES ============================================================================================*/


create table PERMISSOES (
	id serial,
	permissao VARCHAR(100) NOT NULL UNIQUE,
	observacao VARCHAR(150),
	primary key (id)
);


/*=============== TABELA RELACIONAL PERMISSOES ============================================================================================*/


create table REL_CARGOS_PERMISSOES (
	id serial,
	id_permissao_fk INTEGER NOT NULL,
	id_cargo_fk INTEGER NOT NULL,
	primary key (id),
	foreign key (id_permissao_fk) references PERMISSOES (id),
	foreign key (id_cargo_fk) references CARGOS (id)
);