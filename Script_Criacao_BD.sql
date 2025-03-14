
CREATE TABLE IF NOT EXISTS `ECommerce_Dias`.`Contatos` (
  `idContatos` INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `num_celular` VARCHAR(11) NOT NULL,
  `num_celular_reserva` VARCHAR(11) NULL DEFAULT NULL,
  `email_cliente` VARCHAR(45) NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


CREATE TABLE IF NOT EXISTS `ECommerce_Dias`.`Cliente` (
  `idCliente` INTEGER PRIMARY KEY AUTO_iNCREMENT NOT NULL,
  `nome-cliente` VARCHAR(250) NOT NULL,
  `endereco_cliente` VARCHAR(250) NOT NULL,
  `CPF` VARCHAR(11) NOT NULL,
  `CNPJ` VARCHAR(14) NULL DEFAULT NULL,
  `contatos_IdContatos` INT NOT NULL,
  CONSTRAINT `fk_Cliente_Contatos`
    FOREIGN KEY (`Contatos_IdContatos`)
    REFERENCES `ECommerce_Dias`.`Contatos` (`idContatos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

ALTER TABLE`Ecommerce_Dias`.`Cliente`
CHANGE COLUMN `nome-cliente` `nome_cliente` varchar(90) not null;

CREATE TABLE IF NOT EXISTS `Ecommerce_Dias`.`Pedido`(
  `idPedidos` INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `nome_produto` VARCHAR(90) NOT NULL,
  `quantidade_pedido` VARCHAR(45) NOT NULL,
  `descricao_pedido` VARCHAR(90) NOT NULL,
  `data_pedido` DATE NOT NULL,
  `fornecedor` VARCHAR(90) NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Cliente_Contatos_idContatos` INT NOT NULL,
  CONSTRAINT `fk_Pedidos_Cliente1`
	FOREIGN KEY (`Cliente_idCliente`)
	REFERENCES `ECommerce_Dias`.`Cliente`(`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `Fk_pedidos_Contatos`
		FOREIGN KEY (`Cliente_Contatos_idContatos`)
        REFERENCES `Ecommerce_Dias`.`Contatos` (`idContatos`)
		ON DELETE NO ACTION
        ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


CREATE TABLE IF NOT EXISTS `ECommerce_Dias`.`Produtos` (
  `idProdutos` INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `nome_produto` VARCHAR(90) NOT NULL,
  `descricao_produto` VARCHAR(90) NOT NULL,
  `lote_produto` VARCHAR(90) NOT NULL,
  `data_fabricacao` DATE NOT NULL,
  `data_validade` DATE NOT NULL,
  `Pedidos_idPedidos` INT NOT NULL,
  `Pedidos_Cliente_idCliente` INT NOT NULL,
  `Pedidos_Cliente_Contatos_idContatos` INT NOT NULL,
  `fornecedor_idfornecedor` INT NOT NULL,
  `categoria` VARCHAR(45) NOT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

ALTER TABLE `Ecommerce_Dias`.`Produtos`
ADD CONSTRAINT `fk_Produtos_Pedidos`
	FOREIGN KEY(`Pedidos_idPedidos`)
    REFERENCES `Ecommerce_Dias`.`Pedido`(`idPedidos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE `Ecommerce_Dias`.`Produtos`
ADD CONSTRAINT `fk_Produtos_Pedidos_Clientes`
	FOREIGN KEY(`Pedidos_Cliente_idCliente`)
    REFERENCES `Ecommerce_Dias`.`Cliente`(`idCliente`)
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION;
  
ALTER TABLE `Ecommerce_dias`.`Produtos`
ADD CONSTRAINT `fk_Produtos_Pedidos_Clientes_Contatos`
	FOREIGN KEY(`Pedidos_Cliente_Contatos_idContatos`)
    REFERENCES `Ecommerce_Dias`.`Contatos`(`idContatos`)
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION;
    
ALTER TABLE `ECommerce_Dias`.`Produtos`
ADD CONSTRAINT `Fk_Produtos_fornecedor`
    FOREIGN KEY (`fornecedor_idfornecedor`)
    REFERENCES `ECommerce_Dias`.`fornecedor` (`idFornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;    


CREATE TABLE IF NOT EXISTS `Ecommerce_Dias`.`fornecedor`(
	idFornecedor INTEGER PRIMARY KEY AUTO_INCREMENT,
    razao_social VARCHAR(90) NOT NULL,
    CNPJ VARCHAR(15) NOT NULL,
    endereco VARCHAR(90) NOT NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

ALTER TABLE `Ecommerce_Dias`.`fornecedor`
MODIFY idFornecedor INTEGER AUTO_INCREMENT NOT NULL;

DESC fornecedor;


CREATE TABLE IF NOT EXISTS `Ecommerce_Dias`.`Produtos_em_Estoque`(
    idProdutos_estoque INTEGER PRIMARY KEY AUTO_INCREMENT,
    Produtos_idProdutos INT NOT NULL,
    Produtos_Pedidos_idPedidos INT NOT NULL,
    Produtos_Pedidos_Cliente_idCliente INT NOT NULL,
    Produtos_Pedidos_Cliente_Contatos_idContatos INT NOT NULL,
    Produtos_fornecedor_idfornecedor INT NOT NULL,
    quantidade_produto INT NOT NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

ALTER TABLE `Ecommerce_Dias`.`Produtos_em_Estoque`
MODIFY idProdutos_estoque INTEGER AUTO_INCREMENT NOT NULL;

DESC Produtos_em_Estoque;

ALTER TABLE`Ecommerce_Dias`.`Produtos_em_Estoque`
ADD COLUMN `quantida_estoque` INT NOT NULL;

ALTER TABLE `Ecommerce_Dias`.`Produtos_em_Estoque`
ADD CONSTRAINT`fK_Produtos_idProdutos`
	FOREIGN KEY(`Produtos_idProdutos`)
    REFERENCES `Ecommerce_Dias`.`Produtos`(`idProdutos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
    
ALTER TABLE `Ecommerce_Dias`.`Produtos_em_Estoque`
ADD CONSTRAINT `fk_Produtos_Pedidos_Cliente_idCliente`
    FOREIGN KEY (`Produtos_Pedidos_Cliente_idCliente`)
    REFERENCES `Ecommerce_Dias`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE `Ecommerce_Dias`.`Produtos_em_Estoque`
ADD CONSTRAINT `fk_Produtos_Pedidos_Cliente_Contatos_idContatos`
    FOREIGN KEY (`Produtos_Pedidos_Cliente_Contatos_idContatos`)
    REFERENCES `Ecommerce_Dias`.`Contatos` (`idContatos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE `Ecommerce_Dias`.`Produtos_em_Estoque`
ADD CONSTRAINT `FK_Produtos_Pedidos_idPedidos`
    FOREIGN KEY (`Produtos_Pedidos_idPedidos`)
    REFERENCES `Ecommerce_Dias`.`Pedido` (`idPedidos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

-- Segunda parte do Banco 


CREATE TABLE IF NOT EXISTS `ECommerce_Dias`.`tipo_pagamento` (
  idtipo_pagamento INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
  boleto VARCHAR(90) NULL DEFAULT NULL,
  pix VARCHAR(90) NULL DEFAULT NULL,
  num_cartao VARCHAR(20) NULL DEFAULT NULL,
  data_vencimento_cartao DATE NULL DEFAULT NULL,
  nome_cartao VARCHAR(150) NULL DEFAULT NULL,
  tipo_pagamentocol VARCHAR(45) NULL DEFAULT NULL)
  
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `ECommerce_Dias`.`transportadora` (
  idtransportadora INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  nome_razao_social VARCHAR(90) NOT NULL,
  endereco VARCHAR(90) NOT NULL,
  CNJP_transportadora VARCHAR(14) NOT NULL,
  telefone_transportadora VARCHAR(11) NOT NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `ECommerce_Dias`.`Entrega` (
  idEntrega INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  cod_rastreio VARCHAR(90) NOT NULL,
  status VARCHAR(45) NOT NULL,
  transportadora_idtransportadora INT NOT NULL,
  CONSTRAINT fk_transportadora_idtransportadora
    FOREIGN KEY (transportadora_idtransportadora)
    REFERENCES `ECommerce_Dias`.`transportadora` (idtransportadora)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Ecommerce_Dias`.`Nota_Fiscal`(
	idNota_Fiscal INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    data_emissao DATE NOT NULL,
    nome_destinatario VARCHAR(90),
    CNPJ_CPF_destinatario VARCHAR(15) NOT NULL,
    nome_remetente VARCHAR(90) NOT NULL, 
    CNPJ_CPF_remetente VARCHAR(15) NOT NULL,
    valor_venda DECIMAL NOT NULL,
    transportadora_idtransportadora2 INT NOT NULL,
    tipo_pagamento_idtipo_pagamento INT NOT NULL,
    CONSTRAINT fk_transportadora_idtransportadora2
		FOREIGN KEY(transportadora_idtransportadora2)
        REFERENCES `Ecommerce_Dias`.`transportadora`(`idtransportadora`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
	CONSTRAINT fk_tipo_pagamento_idtipo_pagamento
		FOREIGN KEY(tipo_pagamento_idtipo_pagamento)
        REFERENCES `Ecommerce_Dias`.`tipo_pagamento`(`idtipo_pagamento`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
)

ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


CREATE TABLE IF NOT EXISTS `Ecommerce_Dias`.`ordem_servico`(
	idordem_servico INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    descricao_ordem VARCHAR(90) NOT NULL,
    fornecedor VARCHAR(90) NOT NULL,
    data_ordem DATETIME NOT NULL,
    Nota_Fiscal_idNota_Fiscal INT NOT NULL,
    CONSTRAINT fk_Nota_Fiscal_idNota_Fiscal
		FOREIGN KEY(Nota_Fiscal_idNota_Fiscal)
        REFERENCES `Ecommerce_Dias`.`Nota_Fiscal`(`idNota_Fiscal`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Ecommerce_Dias`.`Produtos_tem_ordem`(
	idProdutos_tem_ordem INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    Produtos_idProdutos2 INT NOT NULL,
    Produtos_Pedidos_idPedidos2 INT NOT NULL,
    Produtos_Pedidos_Cliente_idCliente2 INT NOT NULL,
    Produtos_Pedidos_Cliente_Contatos_idContatos2 INT NOT NULL,
    ordem_servico_idordem_servico INT NOT NULL
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


ALTER TABLE `Ecommerce_Dias`.`Produtos_tem_ordem`
ADD CONSTRAINT fk_Produtos_idProdutos2
  FOREIGN KEY (Produtos_idProdutos2)
  REFERENCES `Ecommerce_Dias`.`Produtos` (idProdutos)
  ON DELETE NO ACTION 
  ON UPDATE NO ACTION;

ALTER TABLE `Ecommerce_Dias`.`Produtos_tem_ordem`
ADD CONSTRAINT fk_Produtos_Pedidos_idPedidos2
  FOREIGN KEY (Produtos_Pedidos_idPedidos2)
  REFERENCES `Ecommerce_Dias`.`Pedido` (idPedidos)
  ON DELETE NO ACTION 
  ON UPDATE NO ACTION;

ALTER TABLE `Ecommerce_Dias`.`Produtos_tem_ordem`
ADD CONSTRAINT fk_Produtos_Pedidos_Cliente_idCliente2
  FOREIGN KEY (Produtos_Pedidos_Cliente_idCliente2)
  REFERENCES `Ecommerce_Dias`.`Cliente` (idCliente)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `Ecommerce_Dias`.`Produtos_tem_ordem`
ADD CONSTRAINT fk_Produtos_Pedidos_Cliente_Contatos_idContatos2
  FOREIGN KEY (Produtos_Pedidos_Cliente_Contatos_idContatos2)
  REFERENCES `Ecommerce_Dias`.`Contatos` (idContatos)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `Ecommerce_Dias`.`Produtos_tem_ordem`
ADD CONSTRAINT fk_ordem_servico_idordem_servico
  FOREIGN KEY (ordem_servico_idordem_servico)
  REFERENCES `Ecommerce_Dias`.`ordem_servico` (idordem_servico)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  
INSERT INTO `ECommerce_Dias`.`Contatos` (num_celular, num_celular_reserva, email_cliente) VALUES
('11987654321', '11987654322', 'joao.silva@example.com'),
('11987654323', '11987654324', 'maria.oliveira@example.com'),
('11987654325', '11987654326', 'carlos.souza@example.com'),
('11987654327', '11987654328', 'ana.pereira@example.com'),
('11987654329', '11987654330', 'paulo.lima@example.com'),
('11987654331', '11987654332', 'fernanda.costa@example.com'),
('11987654333', '11987654334', 'ricardo.alves@example.com'),
('11987654335', '11987654336', 'juliana.martins@example.com'),
('11987654337', '11987654338', 'roberto.dias@example.com'),
('11987654339', '11987654340', 'patricia.mendes@example.com');

INSERT INTO `ECommerce_Dias`.`Cliente` (nome_cliente, endereco_cliente, CPF, CNPJ, contatos_IdContatos) VALUES
('João Silva', 'Rua A, 123', '12345678901', NULL, 1),
('Maria Oliveira', 'Rua B, 456', '12345678902', NULL, 2),
('Carlos Souza', 'Rua C, 789', '12345678903', NULL, 3),
('Ana Pereira', 'Rua D, 101', '12345678904', NULL, 4),
('Paulo Lima', 'Rua E, 202', '12345678905', NULL, 5),
('Fernanda Costa', 'Rua F, 303', '12345678906', NULL, 6),
('Ricardo Alves', 'Rua G, 404', '12345678907', NULL, 7),
('Juliana Martins', 'Rua H, 505', '12345678908', NULL, 8),
('Roberto Dias', 'Rua I, 606', '12345678909', NULL, 9),
('Patrícia Mendes', 'Rua J, 707', '12345678910', NULL, 10);

INSERT INTO `ECommerce_Dias`.`fornecedor` (razao_social, CNPJ, endereco) VALUES
('Apple Inc.', '12345678000195', 'Av. Apple, 1000, São Paulo, SP'),
('Samsung Electronics', '98765432000198', 'Av. Samsung, 5000, São Paulo, SP'),
('Sony Corporation', '13579246800010', 'Av. Sony, 3000, São Paulo, SP'),
('Microsoft Corporation', '24681357900023', 'Av. Microsoft, 2000, São Paulo, SP'),
('Lenovo', '78965412000134', 'Av. Lenovo, 1500, São Paulo, SP'),
('HP Inc.', '32165498700159', 'Av. HP, 2500, São Paulo, SP'),
('LG Electronics', '45678912300156', 'Av. LG, 1800, São Paulo, SP'),
('Huawei Technologies', '98765432100055', 'Av. Huawei, 2200, São Paulo, SP'),
('Dell Technologies', '75315948900130', 'Av. Dell, 2700, São Paulo, SP'),
('Asus', '65498732100043', 'Av. Asus, 1300, São Paulo, SP');

INSERT INTO `Ecommerce_Dias`.`Pedido` (nome_produto, quantidade_pedido, descricao_pedido, data_pedido, fornecedor, Cliente_idCliente, Cliente_Contatos_idContatos) VALUES
('iPhone 13', '10', 'Smartphone Apple', '2025-01-01', 'Apple Inc.', 11, 1),
('Galaxy S21', '20', 'Smartphone Samsung', '2025-01-02', 'Samsung Electronics', 12, 2),
('PlayStation 5', '30', 'Console Sony', '2025-01-03', 'Sony Corporation', 13, 3),
('Xbox Series X', '40', 'Console Microsoft', '2025-01-04', 'Microsoft Corporation', 14, 4),
('MacBook Pro', '50', 'Laptop Apple', '2025-01-05', 'Apple Inc.', 15, 5),
('Galaxy Tab S7', '60', 'Tablet Samsung', '2025-01-06', 'Samsung Electronics', 16, 6),
('Sony WH-1000XM4', '70', 'Headphone Sony', '2025-01-07', 'Sony Corporation', 17, 7),
('Surface Pro 7', '80', 'Tablet Microsoft', '2025-01-08', 'Microsoft Corporation', 18, 8),
('Apple Watch Series 7', '90', 'Smartwatch Apple', '2025-01-09', 'Apple Inc.', 19, 9),
('Galaxy Buds Pro', '100', 'Earbuds Samsung', '2025-01-10', 'Samsung Electronics', 20, 10);


INSERT INTO `Ecommerce_Dias`.`Produtos` (nome_produto, descricao_produto, lote_produto, data_fabricacao, data_validade, Pedidos_idPedidos, Pedidos_Cliente_idCliente, Pedidos_Cliente_Contatos_idContatos, fornecedor_idfornecedor, categoria) VALUES
('iPhone 13', 'Smartphone Apple', 'Lote 001', '2025-01-01', '2025-12-31', 31, 11, 1, 1, 'Smartphones'),
('Galaxy S21', 'Smartphone Samsung', 'Lote 002', '2025-01-02', '2025-12-31', 32, 12, 2, 2, 'Smartphones'),
('PlayStation 5', 'Console Sony', 'Lote 003', '2025-01-03', '2025-12-31', 33, 13, 3, 3, 'Consoles'),
('Xbox Series X', 'Console Microsoft', 'Lote 004', '2025-01-04', '2025-12-31', 34, 14, 4, 4, 'Consoles'),
('MacBook Pro', 'Laptop Apple', 'Lote 005', '2025-01-05', '2025-12-31', 35, 15, 5, 1, 'Laptops'),
('Galaxy Tab S7', 'Tablet Samsung', 'Lote 006', '2025-01-06', '2025-12-31', 36, 16, 6, 2, 'Tablets'),
('Sony WH-1000XM4', 'Headphone Sony', 'Lote 007', '2025-01-07', '2025-12-31', 37, 17, 7, 3, 'Fones de ouvido'),
('Surface Pro 7', 'Tablet Microsoft', 'Lote 008', '2025-01-08', '2025-12-31', 38, 18, 8, 4, 'Tablets'),
('Apple Watch Series 7', 'Smartwatch Apple', 'Lote 009', '2025-01-09', '2025-12-31', 39, 19, 9, 1, 'Smartwatches'),
('Galaxy Buds Pro', 'Earbuds Samsung', 'Lote 010', '2025-01-10', '2025-12-31', 40, 20, 10, 2, 'Acessórios');

INSERT INTO `Ecommerce_Dias`.`Produtos_em_Estoque` 
(Produtos_idProdutos, Produtos_Pedidos_idPedidos, Produtos_Pedidos_Cliente_idCliente, Produtos_Pedidos_Cliente_Contatos_idContatos, Produtos_fornecedor_idfornecedor, quantidade_produto) 
VALUES
(11, 31, 11, 1, 1, 10),  
(12, 32, 12, 2, 2, 20),  
(13, 33, 13, 3, 3, 30),  
(14, 34, 14, 4, 4, 40),  
(15, 35, 15, 5, 1, 50),  
(16, 36, 16, 6, 2, 60),  
(17, 37, 17, 7, 3, 70),  
(18, 38, 18, 8, 4, 80),  
(19, 39, 19, 9, 1, 90),  
(20, 40, 20, 10, 2, 100);

INSERT INTO `ECommerce_Dias`.`transportadora` (nome_razao_social, endereco, CNJP_transportadora, telefone_transportadora) VALUES
('Transportadora Alpha', 'Av. das Indústrias, 1500, São Paulo, SP', '12345678000123', '11987654321'),
('Transportadora Beta', 'Rua das Flores, 300, São Paulo, SP', '98765432000145', '11987654322'),
('Transportadora Gamma', 'Av. dos Pássaros, 400, São Paulo, SP', '12345987600156', '11987654323'),
('Logística Rápida', 'Rua das Palmeiras, 1000, São Paulo, SP', '98765432100078', '11987654324'),
('Transporte Seguro', 'Rua da Paz, 1200, São Paulo, SP', '13579246800012', '11987654325');

INSERT INTO `ECommerce_Dias`.`tipo_pagamento` 
(boleto, pix, num_cartao, data_vencimento_cartao, nome_cartao, tipo_pagamentocol) VALUES
('Boleto Banco do Brasil', NULL, NULL, NULL, NULL, 'Boleto'),
(NULL, '9876543210', NULL, NULL, NULL, 'PIX'),
(NULL, NULL, '1234 5678 9012 3456', '2025-12-01', 'João Silva', 'Cartão de Crédito'),
(NULL, NULL, '9876 5432 1098 7654', '2025-06-15', 'Maria Oliveira', 'Cartão de Crédito'),
('Boleto Itaú', NULL, NULL, NULL, NULL, 'Boleto'),
('Boleto Santander', NULL, NULL, NULL, NULL, 'Boleto'),
(NULL, '1234567890', NULL, NULL, NULL, 'PIX'),
(NULL, NULL, '2345 6789 0123 4567', '2025-11-01', 'Carlos Souza', 'Cartão de Crédito'),
(NULL, NULL, '3456 7890 1234 5678', '2025-09-20', 'Ana Pereira', 'Cartão de Crédito'),
('Boleto Bradesco', NULL, NULL, NULL, NULL, 'Boleto');

INSERT INTO `ECommerce_Dias`.`Entrega` (cod_rastreio, status, transportadora_idtransportadora) VALUES
('BR1234567890', 'Em Trânsito', 1),
('BR2345678901', 'Entregue', 2),
('BR3456789012', 'Em Trânsito', 3),
('BR4567890123', 'Aguardando Retirada', 4),
('BR5678901234', 'Entregue', 5),
('BR6789012345', 'Em Trânsito', 6),
('BR7890123456', 'Entregue', 7),
('BR8901234567', 'Em Trânsito', 8),
('BR9012345678', 'Aguardando Retirada', 9),
('BR0123456789', 'Em Trânsito', 10);

INSERT INTO `Ecommerce_Dias`.`Nota_Fiscal` (data_emissao, nome_destinatario, CNPJ_CPF_destinatario, nome_remetente, CNPJ_CPF_remetente, valor_venda, transportadora_idtransportadora2, tipo_pagamento_idtipo_pagamento) VALUES
('2025-01-10', 'João Silva', '12345678901', 'Apple Inc.', '12345678000195', 5000.00, 1, 1),
('2025-01-11', 'Maria Oliveira', '12345678902', 'Samsung Electronics', '98765432000198', 6000.00, 2, 2),
('2025-01-12', 'Carlos Souza', '12345678903', 'Sony Corporation', '13579246800010', 7000.00, 3, 3),
('2025-01-13', 'Ana Pereira', '12345678904', 'Microsoft Corporation', '24681357900023', 8000.00, 4, 4),
('2025-01-14', 'Paulo Lima', '12345678905', 'Apple Inc.', '12345678000195', 9000.00, 5, 5),
('2025-01-15', 'Fernanda Costa', '12345678906', 'Samsung Electronics', '98765432000198', 10000.00, 6, 6),
('2025-01-16', 'Ricardo Alves', '12345678907', 'Sony Corporation', '13579246800010', 11000.00, 7, 7),
('2025-01-17', 'Juliana Martins', '12345678908', 'Microsoft Corporation', '24681357900023', 12000.00, 8, 8),
('2025-01-18', 'Roberto Dias', '12345678909', 'Apple Inc.', '12345678000195', 13000.00, 9, 9),
('2025-01-19', 'Patrícia Mendes', '12345678910', 'Samsung Electronics', '98765432000198', 14000.00, 10, 10);

INSERT INTO `Ecommerce_Dias`.`ordem_servico` (descricao_ordem, fornecedor, data_ordem, Nota_Fiscal_idNota_Fiscal) VALUES
('Serviço de revisão do produto', 'Apple Inc.', '2025-01-20 10:00:00', 11),
('Instalação do sistema operacional', 'Samsung Electronics', '2025-01-21 11:00:00', 12),
('Ajuste no hardware do console', 'Sony Corporation', '2025-01-22 12:00:00', 13),
('Atualização de software', 'Microsoft Corporation', '2025-01-23 13:00:00', 14),
('Troca de bateria do laptop', 'Apple Inc.', '2025-01-24 14:00:00', 15),
('Substituição de tela do tablet', 'Samsung Electronics', '2025-01-25 15:00:00', 16),
('Reparo no headset', 'Sony Corporation', '2025-01-26 16:00:00', 17),
('Configuração de rede no tablet', 'Microsoft Corporation', '2025-01-27 17:00:00', 18),
('Atualização de firmware no smartwatch', 'Apple Inc.', '2025-01-28 18:00:00', 19),
('Reparo de conexão dos fones de ouvido', 'Samsung Electronics', '2025-01-29 19:00:00', 20);

INSERT INTO `Ecommerce_Dias`.`Produtos_tem_ordem` (Produtos_idProdutos2, Produtos_Pedidos_idPedidos2, Produtos_Pedidos_Cliente_idCliente2, Produtos_Pedidos_Cliente_Contatos_idContatos2, ordem_servico_idordem_servico) VALUES
(11, 31, 11, 1, 11),
(12, 32, 12, 2, 12),
(13, 33, 13, 3, 13),
(14, 34, 14, 4, 14),
(15, 35, 15, 5, 15),
(16, 36, 16, 6, 16),
(17, 37, 17, 7, 17),
(18, 38, 18, 8, 18),
(19, 39, 19, 9, 19),
(20, 40, 20, 10, 20);

SELECT Cliente.nome_cliente,
Produtos.nome_produto as Produto,
Produtos.descricao_produto, 
fornecedor.razao_social as Fornecedor, 
Pedido.quantidade_pedido as qtd_pedida,
Pedido.data_pedido
FROM Produtos
INNER JOIN Pedido ON Produtos.Pedidos_idPedidos = Pedido.idPedidos
INNER JOIN Cliente ON Pedido.Cliente_idCliente = Cliente.idCliente
INNER JOIN fornecedor ON Produtos.fornecedor_idfornecedor = fornecedor.idfornecedor;

INSERT INTO contatos (email_Cliente, num_celular)
VALUES ('osvaldo@email.com', '1234567890');

select email_Cliente, num_celular, idContatos
from contatos
where email_Cliente = 'osvaldo@email.com' and num_celular = '1234567890';
  
Select nome_cliente as nome,
contatos_idContatos, 
num_celular as celular, 
email_Cliente 
from Cliente
inner join Contatos on Cliente.contatos_idContatos = Contatos.idContatos;    







  