-- criação de banco de dados para e-commerce
create database ecommerce;
use ecommerce;

-- criar tabela cliente
create table Cliente (
			IdCliente int primary key auto_increment,
            Nome varchar(45) not null,
            Endereço varchar(100) not null,
            Identificação enum ("Pessoa Física", "Pessoa Jurídica") 
				default "Pessoa Física",
			Email varchar(80) not null
            );
            
-- criar tabela Pessoa Física
create table PessoaFisica (
			CPF char(11) primary key not null,
            PrimeiroNome varchar(20) not null,
            Sobrenome varchar(45) not null
            );
            
-- criar tabela Pessoa Jurídica
create table PessoaJuridica (
			CNPJ char(14) primary key not null,
            NomeFantasia varchar(50) not null,
            RazaoSocial varchar(50) not null
            );
            
-- criar tabela Pedido            
create table Pedido (
			IdPedido int primary key auto_increment,
            StatusdoPedido enum ('Em andamento', 'Enviado') default "Em andamento",
            Descricao varchar(45),
            IdCliente int not null,
            constraint fk_IdCliente foreign key (IdCliente)
            references Cliente(IdCliente),
            Frete float,
            Entrega boolean default false,
            CodigoRastreio varchar(15),
            Pagamento enum ('Pix', 'Boleto', 'Cartão')
            );
            
-- criar tabela Pix
create table Pix (
			IdPix int primary key auto_increment,
            Pix boolean default true
            );
            
-- criar tabela Boleto
create table Boleto (
			IdBoleto int primary key auto_increment,
            Boleto boolean default false
            );
            
-- criar tabela Cartão
create table Cartao (
			IdCartao int primary key auto_increment,
            Cartao boolean default true,
            NumeroCartao varchar(30),
            ValidadeCartao varchar(6),
            NomeCartao varchar(20),
            CodigoCartao char(3)
            );
            
-- criar tabela Produto
create table Produto (
			IdProduto int primary key auto_increment,
            Categoria enum ("Armação de grau", "Lente", "Armação solar"),
            Descricao varchar(100),
            Preco float
            );
            
-- criar tabela Relação Pedido Produto
create table PedidoProduto (
			IdPedido int,
            foreign key (IdPedido)
            references Pedido(IdPedido),
            IdProduto int,
            foreign key (IdProduto)
            references Produto(IdProduto),
            Quantidade int
			);
            
-- criar tabela estoque
create table Estoque (
			IdEstoque int primary key auto_increment,
            Localizacao varchar(50)
            );
            
-- criar tabela Relação Produto Estoque
create table ProdutoEstoque (
			IdProduto int,
            foreign key (IdProduto)
            references Produto(IdProduto),
            IdEstoque int,
            foreign key (IdEstoque)
            references Estoque(IdEstoque),
            Quantidade int
			);
            
-- criar tabela Fornecedor
create table Fornecedor (
			IdFornecedor int primary key auto_increment,
            CNPJFornecedor char(14),
            RazaoSocialFornecedor varchar(30)
            );
            
-- criar tabela Relação Produto Fornecedor
create table ProdutoFornecedor (
			IdProduto int,
			foreign key (IdProduto)
            references Produto(IdProduto),
            IdFornecedor int,
            foreign key (IdFornecedor)
            references Fornecedor(IdFornecedor),
            UltimaCompra date
			);
            
-- Populando a tabela cliente
insert into Cliente (Nome, Endereço, Identificação, email)
		values ('Raquel Sousa', 'Rua dos bobos, nº 0, Rio de Janeiro, RJ', 
				'Pessoa Física', 'raquellinda@meudominio.com'),
                ('Raissa Fofinha', 'Alameda da Preguiça, nº 20, Rio de Janeiro, RJ',
                'Pessoa física', 'issinhafofy@msn.br'),
                ('Elaine Curtinha', 'Rua dos Aposentados, nº 55, Duque de Caxias, RJ',
                'Pessoa jurídica', 'aprendimeuemail@gmail.com');
                
-- Populando a tabela Pessoa Física
insert into PessoaFisica (CPF, PrimeiroNome, Sobrenome)
			values (12345678900, 'Raquel', 'Sousa'),
					(12345678901, 'Raissa', 'Fofinha');
                    
-- Populando a tabela Pessoa Jurídica
insert into PessoaJuridica (CNPJ, NomeFantasia, RazaoSocial)
			values (12345678900000, 'Elaine', 'Curtinha');
                      
-- Populando a tabela Pedido
insert into Pedido (Descricao, IdCliente, Frete, 
					Entrega, CodigoRastreio, Pagamento)
			values ('Um óculos de sol', 1, 15.5, 
					true, 'ABC130BR', 'Pix'),
					('Lente e óculos de grau', 2, 12.3, 
                    false, 'BES095WBR', 'Boleto'),
                    ('2 óculos de sol e 1 de grau', 3, 20.9, 
                    true, 'FLS193FBR', 'Cartão');
                    
-- Populando a tabela Cartão
insert into Cartao (NumeroCartao, ValidadeCartao, NomeCartao, CodigoCartao)
			values ('00000000000000000', '08/29', 'Elaine Curtinha', '001');

-- Populando a tabela Produto
insert into Produto (Categoria, Descricao, Preco)
			values ('Armação solar', null, 139.9),
				   ('Armação solar', 'óculos de proteção solar, com lentes polarizadas', 115.5),
                   ('Lente', 'Lente visão simples, com tratamento antirreflexo', 355.5),
                   ('Armação de grau', 'Armação para óculos de grau, composta por material de acetato', 239.9);

-- Populando a tabela Pedido Produto
insert into PedidoProduto (Quantidade)
			values (1),
					(2),
                    (3);
                    
-- Populando a tabela Estoque
insert into Estoque (Localizacao)
			Values ("Rua Estrela Guia, nº 10, Curiri, RJ")
            
-- Populando a tabela Produto Estoque
insert into ProdutoEstoque (Quantidade)
			Values (30),
					(25),
                    (39);
                    
-- Populando a tabela Fornecedor
insert into Fornecedor (CNPJFornecedor, RazaoSocialFornecedor)
				values (9876543210001, 'Ótica Nonato');
                
-- Populando a tabela Relação Produto Fornecedor
insert into ProdutoFornecedor (UltimaCompra)
			value (09/20/2021);
            
-- Queries
show tables;
desc produto;
select * from cliente as c, pedido as pd, produto as pt order by c.nome;
select * from cliente as c, pedido as pd, produto as pt where c.identificação = "Pessoa Física";
select nome, pagamento, preco from cliente as c, pedido as pd, produto as pt having pt.preco > 300;