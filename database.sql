CREATE TABLE IF NOT EXISTS `dz_nyse_acoes` (
    `id` varchar(50) NOT NULL,
    `image` varchar(50) NOT NULL,
	`nome` varchar(50) NOT NULL,
	`valor` varchar(50) NOT NULL,
	`rendimento` varchar(50) NOT NULL,
    PRIMARY KEY(`id`)
)

CREATE TABLE IF NOT EXISTS `dz_nyse_venda` (
    `id` varchar(50) NOT NULL,
    `id_acao` varchar(50) NOT NULL,
	`vendedor` varchar(50) NOT NULL,
	`quantidade` varchar(50) NOT NULL,
	`valor` varchar(50) NOT NULL,
	`player_id` varchar(50) NOT NULL,
	`player_name` varchar(50) NOT NULL,
    PRIMARY KEY(`id`)
)

CREATE TABLE IF NOT EXISTS `dz_nyse_extrato` (
    `id` int(50) NOT NULL AUTO_INCREMENT,
    `id_acao` varchar(50) NOT NULL,
	`tipo` varchar(50) NOT NULL,
	`quantidade` varchar(50) NOT NULL,
	`valor` varchar(50) NOT NULL,
	`valor` varchar(50) NOT NULL,
	`player_id` varchar(50) NOT NULL,
	`player_name` varchar(50) NOT NULL,
    PRIMARY KEY(`id`)
)

CREATE TABLE IF NOT EXISTS `dz_nyse_user_acoes` (
    `id` int(50) NOT NULL AUTO_INCREMENT,
    `id_acao` varchar(50) NOT NULL,
	`quantidade` varchar(50) NOT NULL,
	`player_id` varchar(50) NOT NULL,
	`player_name` varchar(50) NOT NULL,
    PRIMARY KEY(`id`)
)

INSERT INTO `dz_nyse_acoes` (`id`, `image`, `nome`, `valor`, `rendimento`) VALUES (``, `Maze Bank`, ``, ``, ``)
