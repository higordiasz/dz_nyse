DROP TABLE IF EXISTS `dz_nyse_acoes`;
CREATE TABLE IF NOT EXISTS `dz_nyse_acoes` (
    `id` varchar(50) NOT NULL,
    `image` varchar(50) NOT NULL,
	`nome` varchar(50) NOT NULL,
	`valor` int(50) NOT NULL,
	`rendimento` varchar(50) NOT NULL,
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
	`player_id` varchar(50) NOT NULL,
	`player_name` varchar(50) NOT NULL,
    PRIMARY KEY(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO dz_nyse_acoes (`id`, `image`, `nome`, `valor`, `rendimento`) VALUES('maze01', 'https://i.imgur.com/yr7Vmbf.jpeg', 'Maze Bank', '950', '55'),
('karin01', 'https://imgur.com/39Zo6sg.jpeg', 'Karin', '2355', '98'),
('securo01', 'https://imgur.com/SUGnAIS.jpeg', 'SecuroServ', '1425', '75');

INSERT INTO dz_nyse_venda (`id_acao`, `vendedor`, `quantidade`, `valor`, `player_id`, `player_name`) VALUES ('maze01','Maze Bank','1000','950','-1','Governo'),
('karin01','Karin','1000','2355','-1','Governo'),
('securo01','SecuroServ','1000','1425','-1','Governo')
