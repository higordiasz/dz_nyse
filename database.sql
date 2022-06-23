DROP TABLE IF EXISTS `dz_nyse_acoes`;
CREATE TABLE IF NOT EXISTS `dz_nyse_acoes` (
    `id` varchar(50) NOT NULL,
    `image` varchar(50) NOT NULL,
	`nome` varchar(50) NOT NULL,
	`valor` int(50) NOT NULL,
	`rendimento` int(50) NOT NULL,
	`rendimento_max` int(50) NOT NULL,
	`rendimento_min` int(50) NOT NULL,
	`r_negativo_max` int(50) NOT NULL,
	`r_negativo_min` int(50) NOT NULL,
    PRIMARY KEY(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `dz_nyse_venda`;
CREATE TABLE IF NOT EXISTS `dz_nyse_venda` (
    `id` int(50) NOT NULL AUTO_INCREMENT,
    `id_acao` varchar(50) NOT NULL,
	`vendedor` varchar(50) NOT NULL,
	`quantidade` int(50) NOT NULL,
	`valor` int(50) NOT NULL,
	`player_id` varchar(50) NOT NULL,
	`player_name` varchar(50) NOT NULL,
    PRIMARY KEY(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `dz_nyse_extrato`;
CREATE TABLE IF NOT EXISTS `dz_nyse_extrato` (
    `id` int(50) NOT NULL AUTO_INCREMENT,
    `id_acao` varchar(50) NOT NULL,
	`tipo` varchar(50) NOT NULL,
	`quantidade` int(50) NOT NULL,
	`valor` int(50) NOT NULL,
	`descricao` varchar(50) NOT NULL,
	`player_id` varchar(50) NOT NULL,
	`player_name` varchar(50) NOT NULL,
    PRIMARY KEY(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `dz_nyse_user_acoes`;
CREATE TABLE IF NOT EXISTS `dz_nyse_user_acoes` (
    `id` int(50) NOT NULL AUTO_INCREMENT,
    `id_acao` varchar(50) NOT NULL,
	`quantidade` int(50) NOT NULL,
	`ultimo_rendimento` varchar(50) NOT NULL,
	`player_id` varchar(50) NOT NULL,
	`player_name` varchar(50) NOT NULL,
    PRIMARY KEY(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `dz_nyse_user`;
CREATE TABLE IF NOT EXISTS `dz_nyse_user` (
	`id` int(50) NOT NULL AUTO_INCREMENT,
    `saldo_disponivel` int(50) NOT NULL,
	`despesas` int(50) NOT NULL,
	`rendimentos` int(50) NOT NULL,
	`ouro` int(50) NOT NULL,
	`player_id` varchar(50) NOT NULL,
	`player_name` varchar(50) NOT NULL,
    PRIMARY KEY(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `dz_nyse_gold`;
CREATE TABLE IF NOT EXISTS `dz_nyse_gold` (
	`id` int(50) NOT NULL AUTO_INCREMENT,
    `nome` varchar(50) NOT NULL,
	`imagen` varchar(50) NOT NULL,
	`atual` int(50) NOT NULL,
	`last` varchar(50) NOT NULL,
	`cotacao01` int(50) NOT NULL,
	`cotacao02` int(50) NOT NULL,
	`cotacao03` int(50) NOT NULL,
	`cotacao04` int(50) NOT NULL,
	`cotacao05` int(50) NOT NULL,
	`cotacao06` int(50) NOT NULL,
	`cotacao07` int(50) NOT NULL,
	`cotacao08` int(50) NOT NULL,
	`cotacao09` int(50) NOT NULL,
	`cotacao10` int(50) NOT NULL,
	`min` int(50) NOT NULL,
	`max` int(50) NOT NULL,
    PRIMARY KEY(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO dz_nyse_acoes (`id`, `image`, `nome`, `valor`, `rendimento`, `rendimento_max`, `rendimento_min`, `r_negativo_max`, `r_negativo_min`) VALUES('maze01', 'https://i.imgur.com/yr7Vmbf.jpeg', 'Maze Bank', '950', '55', '70', '30', '40', '10'),
('karin01', 'https://imgur.com/39Zo6sg.jpeg', 'Karin', '2355', '98', '105', '55', '55', '10'),
('securo01', 'https://imgur.com/SUGnAIS.jpeg', 'SecuroServ', '1425', '75', '90', '45', '65', '15'),
('fruit01', 'https://imgur.com/OvtCZDq.jpeg', 'Fruit Computers', '4155', '230', '290', '150', '110', '35'),
('emperor01', 'https://imgur.com/C30HbnF.jpeg', 'Emperor', '2085', '125', '150', '65', '80', '20'),
('dynasty01', 'https://imgur.com/kUhbplA.jpeg', 'Dynasty 8', '3975', '265', '315', '210', '250', '150'),
('24701', 'https://imgur.com/S0IChaO.jpeg', '24/7', '5845', '375', '435', '325', '350', '285'),
('annis01', 'https://imgur.com/DEUxXah.jpeg', 'Annis', '1895', '120', '165', '85', '115', '45');

INSERT INTO dz_nyse_venda (`id_acao`, `vendedor`, `quantidade`, `valor`, `player_id`, `player_name`) VALUES ('maze01','Maze Bank','150','950','-1','Governo'),
('karin01','Karin','100','2355','-1','Governo'),
('securo01','SecuroServ','70','1425','-1','Governo'),
('fruit01','SecuroServ','50','4155','-1','Governo'),
('emperor01','SecuroServ','120','2085','-1','Governo'),
('dynasty01','SecuroServ','80','3975','-1','Governo'),
('24701','SecuroServ','30','5845','-1','Governo'),
('annis01','SecuroServ','150','1895','-1','Governo');

INSERT INTO dz_nyse_gold (`nome`, `imagen`, `atual`, `last`, `cotacao01`, `cotacao02`, `cotacao03`, `cotacao04`, `cotacao05`, `cotacao06`, `cotacao07`, `cotacao08`, `cotacao09`, `cotacao10`, `min`, `max`) VALUES ('ouro24k', 'https://imgur.com/kw0ZxTf.jpeg', '325', '1656021033', '325', '400', '333', '326', '365', '310', '394', '390', '345', '365', '310', '410');
