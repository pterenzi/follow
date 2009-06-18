-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.0.27-community-log


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema follow
--

CREATE DATABASE IF NOT EXISTS follow;
USE follow;

--
-- Definition of table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(32) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `categories`
--

/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` (`id`,`name`) VALUES 
 (1,'Gestor'),
 (2,'Administrador'),
 (3,'Usuário');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;


--
-- Definition of table `categories_permissaos`
--

DROP TABLE IF EXISTS `categories_permissaos`;
CREATE TABLE `categories_permissaos` (
  `categories_id` int(10) unsigned NOT NULL,
  `permissaos_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`categories_id`,`permissaos_id`),
  KEY `categories_has_permissaos_fkindex1` (`categories_id`),
  KEY `categories_has_permissaos_fkindex2` (`permissaos_id`),
  CONSTRAINT `categories_permissaos_ibfk_1` FOREIGN KEY (`categories_id`) REFERENCES `categories` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `categories_permissaos_ibfk_2` FOREIGN KEY (`permissaos_id`) REFERENCES `permissaos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `categories_permissaos`
--

/*!40000 ALTER TABLE `categories_permissaos` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories_permissaos` ENABLE KEYS */;


--
-- Definition of table `empresas`
--

DROP TABLE IF EXISTS `empresas`;
CREATE TABLE `empresas` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(64) default NULL,
  `razao` varchar(128) default NULL,
  `tipo` int(10) unsigned default NULL,
  `contato` varchar(64) default NULL,
  `contato_fone` varchar(32) default NULL,
  `contato_cell` varchar(32) default NULL,
  `contato_email` varchar(128) default NULL,
  `fone` varchar(32) default NULL,
  `endereco` varchar(128) default NULL,
  `bairro` varchar(32) default NULL,
  `municipio` varchar(32) default NULL,
  `uf` varchar(2) default NULL,
  `cnpj` varchar(32) default NULL,
  `insc_est` varchar(64) default NULL,
  `insc_mun` varchar(64) default NULL,
  `site` varchar(128) default NULL,
  `banco` varchar(32) default NULL,
  `agencia` varchar(32) default NULL,
  `conta` varchar(32) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `empresas`
--

/*!40000 ALTER TABLE `empresas` DISABLE KEYS */;
/*!40000 ALTER TABLE `empresas` ENABLE KEYS */;


--
-- Definition of table `empresas_projetos`
--

DROP TABLE IF EXISTS `empresas_projetos`;
CREATE TABLE `empresas_projetos` (
  `empresas_id` int(10) unsigned NOT NULL,
  `projetos_id` int(10) unsigned NOT NULL,
  `name` varchar(64) default NULL,
  PRIMARY KEY  (`empresas_id`,`projetos_id`),
  KEY `empresas_has_projetos_fkindex1` (`empresas_id`),
  KEY `empresas_has_projetos_fkindex2` (`projetos_id`),
  CONSTRAINT `empresas_projetos_ibfk_1` FOREIGN KEY (`empresas_id`) REFERENCES `empresas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `empresas_projetos_ibfk_2` FOREIGN KEY (`projetos_id`) REFERENCES `projetos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `empresas_projetos`
--

/*!40000 ALTER TABLE `empresas_projetos` DISABLE KEYS */;
/*!40000 ALTER TABLE `empresas_projetos` ENABLE KEYS */;


--
-- Definition of table `estados`
--

DROP TABLE IF EXISTS `estados`;
CREATE TABLE `estados` (
  `id` int(11) NOT NULL auto_increment,
  `sigla` varchar(2) default NULL,
  `estado` varchar(64) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `estados`
--

/*!40000 ALTER TABLE `estados` DISABLE KEYS */;
INSERT INTO `estados` (`id`,`sigla`,`estado`) VALUES 
 (11,'RO','RONDONIA'),
 (12,'AC','ACRE'),
 (13,'AM','AMAZONAS'),
 (14,'RR','RORAIMA'),
 (15,'PA','PARA'),
 (16,'AP','AMAPA'),
 (17,'TO','TOCANTINS'),
 (21,'MA','MARANHAO'),
 (22,'PI','PIAUI'),
 (23,'CE','CEARA'),
 (24,'RN','RIO GRANDE DO NORTE'),
 (25,'PB','PARAIBA'),
 (26,'PE','PERNAMBUCO'),
 (27,'AL','ALAGOAS'),
 (28,'SE','SERGIPE'),
 (29,'BA','BAHIA'),
 (31,'MG','MINAS GERAIS'),
 (32,'ES','ESPIRITO SANTO'),
 (33,'RJ','RIO DE JANEIRO'),
 (35,'SP','SAO PAULO'),
 (41,'PR','PARANA'),
 (42,'SC','SANTA CATARINA'),
 (43,'RS','RIO GRANDE DO SUL'),
 (50,'MS','MATO GROSSO DO SUL'),
 (51,'MT','MATO GROSSO'),
 (52,'GO','GOIAS'),
 (53,'DF','DISTRITO FEDERAL');
/*!40000 ALTER TABLE `estados` ENABLE KEYS */;


--
-- Definition of table `permissaos`
--

DROP TABLE IF EXISTS `permissaos`;
CREATE TABLE `permissaos` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `description` varchar(64) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `permissaos`
--

/*!40000 ALTER TABLE `permissaos` DISABLE KEYS */;
/*!40000 ALTER TABLE `permissaos` ENABLE KEYS */;


--
-- Definition of table `projetos`
--

DROP TABLE IF EXISTS `projetos`;
CREATE TABLE `projetos` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(32) default NULL,
  `description` varchar(256) default NULL,
  `data_inicio` date default NULL,
  `data_fim` date default NULL,
  `prazo` int(10) unsigned default NULL,
  `ativo` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `projetos`
--

/*!40000 ALTER TABLE `projetos` DISABLE KEYS */;
/*!40000 ALTER TABLE `projetos` ENABLE KEYS */;


--
-- Definition of table `projetos_usuarios`
--

DROP TABLE IF EXISTS `projetos_usuarios`;
CREATE TABLE `projetos_usuarios` (
  `usuarios_id` int(10) unsigned NOT NULL,
  `projetos_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`usuarios_id`,`projetos_id`),
  KEY `usuarios_has_projetos_fkindex1` (`usuarios_id`),
  KEY `usuarios_has_projetos_fkindex2` (`projetos_id`),
  CONSTRAINT `projetos_usuarios_ibfk_1` FOREIGN KEY (`usuarios_id`) REFERENCES `usuarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `projetos_usuarios_ibfk_2` FOREIGN KEY (`projetos_id`) REFERENCES `projetos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `projetos_usuarios`
--

/*!40000 ALTER TABLE `projetos_usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `projetos_usuarios` ENABLE KEYS */;


--
-- Definition of table `messages`
--

DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `usuarios_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id`,`usuarios_id`),
  KEY `messages_fkindex1` (`usuarios_id`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`usuarios_id`) REFERENCES `usuarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `messages`
--

/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;


--
-- Definition of table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `schema_migrations`
--

/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;


--
-- Definition of table `situacaos`
--

DROP TABLE IF EXISTS `situacaos`;
CREATE TABLE `situacaos` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `description` varchar(32) default NULL,
  `sigla` varchar(8) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `situacaos`
--

/*!40000 ALTER TABLE `situacaos` DISABLE KEYS */;
/*!40000 ALTER TABLE `situacaos` ENABLE KEYS */;


--
-- Definition of table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
CREATE TABLE `tasks` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `projeto_id` int(10) unsigned NOT NULL,
  `usuario_id` int(10) unsigned NOT NULL,
  `estimated_time` int(11) NOT NULL,
  `evaluation` int(10) unsigned NOT NULL,
  `situacao_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FK_tasks_1` (`projeto_id`),
  KEY `FK_tasks_2` (`usuario_id`),
  KEY `FK_tasks_3` (`situacao_id`),
  CONSTRAINT `FK_tasks_1` FOREIGN KEY (`projeto_id`) REFERENCES `projetos` (`id`),
  CONSTRAINT `FK_tasks_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `FK_tasks_3` FOREIGN KEY (`situacao_id`) REFERENCES `situacaos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tasks`
--

/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;


--
-- Definition of table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `categories_id` int(10) unsigned NOT NULL,
  `name` varchar(32) default NULL,
  `cargo` varchar(32) default NULL,
  `pass` varchar(64) default NULL,
  `endereco` varchar(128) default NULL,
  `bairro` varchar(32) default NULL,
  `municipio` varchar(32) default NULL,
  `uf` varchar(2) default NULL,
  `cpf` varchar(32) NOT NULL,
  `email` varchar(128) default NULL,
  `gerente` varchar(32) default NULL,
  `login` varchar(16) NOT NULL,
  `hashed_password` varchar(255) NOT NULL,
  `salt` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `ativado` char(1) default NULL,
  PRIMARY KEY  (`id`),
  KEY `usuarios_fkindex1` USING BTREE (`categories_id`),
  CONSTRAINT `FK_usuarios_1` FOREIGN KEY (`categories_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `usuarios`
--

/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` (`id`,`categories_id`,`name`,`cargo`,`pass`,`endereco`,`bairro`,`municipio`,`uf`,`cpf`,`email`,`gerente`,`login`,`hashed_password`,`salt`,`created_at`,`updated_at`,`ativado`) VALUES 
 (2,3,'WILSON AQUINO DE MAGALHÃES','Tecnico',NULL,'Rua tra la la','mexericas','Embu','SP','15755319847','willinos@gmail.com','mano  brown','willinos','3671f38ce6d9f377d9fb7ba5981b45dbf5abcc42','412261000.500537961562879','2009-04-05 12:23:38','2009-04-05 15:34:30',NULL),
 (5,2,'Administrador','Administrador do Sistema',NULL,'Rio de janeiro','Barra da Tijuca','Rio de janeiro','RJ','','willinos@gmail.com','Wilson aquino','admin','e864b363cd6f0f10abf8e5bb0c711b85ee675ee3','394424800.427083304011527','2009-04-05 15:11:35','2009-04-05 15:11:35',NULL);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
