CREATE TABLE `usuario` (
  `idusuario` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nombreDeUsuario` varchar(45) DEFAULT NULL,
  `nombreYApellido` varchar(45) DEFAULT NULL,
  `usuariocol2` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `contrasenia` varchar(45) DEFAULT NULL,
  `validado` tinyint(1) DEFAULT '0',
  `nacimiento` DATE DEFAULT NULL,
  PRIMARY KEY (`idusuario`),
  UNIQUE KEY `nombreDeUsuario_UNIQUE` (`nombreDeUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
