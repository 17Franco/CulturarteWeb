-- MySQL dump 10.13  Distrib 8.0.43, for Linux (x86_64)
--
-- Host: localhost    Database: Culturarte
-- ------------------------------------------------------
-- Server version	8.0.43-0ubuntu0.22.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Categoria`
--

DROP TABLE IF EXISTS `Categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Categoria` (
  `nombreCategoria` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `categoria_padre` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`nombreCategoria`),
  KEY `FK8xo9rnc65i56y4cfnwv1f8mhb` (`categoria_padre`),
  CONSTRAINT `FK8xo9rnc65i56y4cfnwv1f8mhb` FOREIGN KEY (`categoria_padre`) REFERENCES `Categoria` (`nombreCategoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Categoria`
--

LOCK TABLES `Categoria` WRITE;
/*!40000 ALTER TABLE `Categoria` DISABLE KEYS */;
INSERT INTO `Categoria` VALUES ('Carnaval',NULL),('Cine',NULL),('Danza',NULL),('Literatura',NULL),('Música',NULL),('Teatro',NULL),('Humoristas','Carnaval'),('Lubolos','Carnaval'),('Murga','Carnaval'),('Parodistas','Carnaval'),('Revista','Carnaval'),('Cine a Pedal','Cine'),('Cine al Aire Libre','Cine'),('Stand-up','Comedia'),('Ballet','Danza'),('Flamenco','Danza'),('Concierto','Música'),('Festival','Música'),('Comedia','Teatro'),('Teatro Dramático','Teatro'),('Teatro Musical','Teatro');
/*!40000 ALTER TABLE `Categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Colaboracion`
--

DROP TABLE IF EXISTS `Colaboracion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Colaboracion` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `creado` date DEFAULT NULL,
  `monto` int NOT NULL,
  `tipoRetorno` enum('EntradaGratis','PorcentajeGanancia') DEFAULT NULL,
  `colaborador` varchar(255) DEFAULT NULL,
  `propuesta` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKov8v8761nv4mcxlmagc527wqg` (`colaborador`),
  KEY `FKitw9o5tpfse6fnhx97a97fvxs` (`propuesta`),
  CONSTRAINT `FKitw9o5tpfse6fnhx97a97fvxs` FOREIGN KEY (`propuesta`) REFERENCES `Propuesta` (`Titulo`),
  CONSTRAINT `FKov8v8761nv4mcxlmagc527wqg` FOREIGN KEY (`colaborador`) REFERENCES `Colaborador` (`nickname`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Colaboracion`
--

LOCK TABLES `Colaboracion` WRITE;
/*!40000 ALTER TABLE `Colaboracion` DISABLE KEYS */;
INSERT INTO `Colaboracion` VALUES (1,'2017-05-20',50000,'PorcentajeGanancia','novick','Cine en el Botanico'),(2,'2017-05-24',50000,'PorcentajeGanancia','robinh','Cine en el Botánico'),(3,'2017-05-30',50000,'PorcentajeGanancia','nicoJ','Cine en el Botánico'),(4,'2017-06-30',200000,'PorcentajeGanancia','marcelot','Religiosamente'),(5,'2017-07-01',500,'EntradaGratis','Tiajaci','Religiosamente'),(6,'2017-07-07',600,'EntradaGratis','Mengano','Religiosamente'),(7,'2017-07-10',50000,'PorcentajeGanancia','novick','Religiosamente'),(8,'2017-07-15',50000,'PorcentajeGanancia','sergiop','Religiosamente'),(9,'2017-08-01',200000,'PorcentajeGanancia','marcelot','El Pimiento Indomable'),(10,'2017-08-03',80000,'PorcentajeGanancia','sergiop','El Pimiento Indomable'),(11,'2017-08-05',50000,'EntradaGratis','chino','Pilsen Rock'),(12,'2017-08-10',120000,'PorcentajeGanancia','novick','Pilsen Rock'),(13,'2017-08-15',120000,'EntradaGratis','tonyp','Pilsen Rock'),(14,'2017-08-13',100000,'PorcentajeGanancia','sergiop','Romeo y Julieta'),(15,'2017-08-14',200000,'PorcentajeGanancia','marcelot','Romeo y Julieta'),(16,'2017-08-15',30000,'EntradaGratis','tonyp','Un día de Julio'),(17,'2017-08-17',150000,'PorcentajeGanancia','marcelot','Un día de Julio');
/*!40000 ALTER TABLE `Colaboracion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Colaborador`
--

DROP TABLE IF EXISTS `Colaborador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Colaborador` (
  `nickname` varchar(255) NOT NULL,
  PRIMARY KEY (`nickname`),
  CONSTRAINT `FKjabyv7ba97wiikavtf703ocgq` FOREIGN KEY (`nickname`) REFERENCES `Usuario` (`nickname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Colaborador`
--

LOCK TABLES `Colaborador` WRITE;
/*!40000 ALTER TABLE `Colaborador` DISABLE KEYS */;
INSERT INTO `Colaborador` VALUES ('chino'),('juanP'),('marcelot'),('Mengano'),('nicoJ'),('novick'),('Peregano'),('robinh'),('sergiop'),('Tiajaci'),('tonyp');
/*!40000 ALTER TABLE `Colaborador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Proponente`
--

DROP TABLE IF EXISTS `Proponente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Proponente` (
  `biografia` text,
  `direccion` varchar(255) DEFAULT NULL,
  `webSite` varchar(255) DEFAULT NULL,
  `nickname` varchar(255) NOT NULL,
  PRIMARY KEY (`nickname`),
  CONSTRAINT `FKos51n9fuqdt411ixkynltfsl9` FOREIGN KEY (`nickname`) REFERENCES `Usuario` (`nickname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Proponente`
--

LOCK TABLES `Proponente` WRITE;
/*!40000 ALTER TABLE `Proponente` DISABLE KEYS */;
INSERT INTO `Proponente` VALUES ('Nace en el año 1947 en el conventillo \"Medio Mundo\" ubicado en pleno Barrio Sur. Es heredero parcialmente\njunto al resto de sus hermanos- de la Comparsa \"Morenada\" (inactiva desde el fallecimiento de Juan Ángel Silva),\nen 1999 forma su propia Comparsa de negros y libolos \"Cuareim 1080\". Director responsable, compositor y\ncantante de la misma.','Br. Artigas 4567','https://www.facebook.com/C1080?ref=br_rs','cachilas'),('','Emilio Frugoni 1138 Ap. 02','http://www.efectocine.com','diegop'),('En 1972 ingresó a la Escuela de Arte Dramático del teatro El Galpón. Participó en más de treinta obras teatrales y\nvarios largometrajes. Integró el elenco estable de Radioteatro del Sodre, y en 2006 fue asesor de su Consejo\nDirectivo. Como actor recibió múltiples reconocimientos: cuatro premios Florencio, premio al mejor actor\nextranjero del Festival de Miami y premio Mejor Actor de Cine 2008. Durante varios períodos fue directivo del\nteatro El Galpón y dirigente de la Sociedad Uruguaya de Actores (SUA); integró también la Federación Uruguaya\nde Teatros Independientes (FUTI). Formó parte del equipo de gestión de la refacción de los teatros La Máscara,\nAstral y El Galpón, y del equipo de gestión en la construcción del teatro De la Candela y de la sala Atahualpa de El\nGalpón.','Gral. Flores 5645','','hectorg'),('Horacio Rubino Torres nace el 25 de febrero de 1962, es conductor, actor y libretista. Debuta en 1982 en carnaval\nen Los \"Klaper´s\", donde estuvo cuatro años, actuando y libretando. Luego para \"Gaby´s\" (6 años), escribió en\ncategoría revistas y humoristas y desde el comienzo y hasta el presente en su propio conjunto Momosapiens.','18 de Julio 1234','https://twitter.com/horaciorubino','hrubino'),('','Benito Blanco 4321','','juliob'),('','Paraguay 1423','','kairoh'),('Queremos ser vistos y reconocidos como una organización: referente en divulgación científica con un fuerte\nespíritu didáctico y divertido, a través de acciones coordinadas con otros divulgadores científicos, que permitan\nestablecer puentes de comunicación. Impulsora en la generación de espacios de democratización y apropiación\nsocial del conocimiento científico.','8 de Octubre 1429','https://bardocientifico.com/','losBardo'),('Martín Buscaglia (Montevideo, 1972) es un artista, músico, compositor y productor uruguayo. Tanto con su banda\n(\"Los Bochamakerns\") como en su formato \"Hombre orquesta\", o solo con su guitarra, ha recorrido el mundo\ntocando entre otros países en España, Estados Unidos, Inglaterra, Francia, Australia, Brasil, Colombia, Argentina,\nChile, Paraguay, México y Uruguay. (Actualmente los Bochamakers son Matías Rada, Martín Ibarburu, Mateo\nMoreno, Herman Klang) Paralelamente, tiene proyectos a dúo con el español Kiko Veneno, la cubana Yusa,\nel argentino Lisandro Aristimuño, su compatriota Antolín, y trío junto a los brasileros Os Mulheres Negras.','Colonia 4321','https://www.martinbuscaglia.com/','mbusca'),('Tabaré Cardozo (Montevideo, 24 de julio de 1971) es un cantante, compositor y murguista uruguayo; conocido por\nsu participación en la murga Agarrate Catalina, conjunto que fundó junto a su hermano Yamandú y Carlos\nTanco en el año 2001.','Santiago Rivas 1212','https://www.facebook.com/Tabar%C3%A9-Cardozo-55179094281/?ref=br_rs','tabarec');
/*!40000 ALTER TABLE `Proponente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Propuesta`
--

DROP TABLE IF EXISTS `Propuesta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Propuesta` (
  `Titulo` varchar(255) NOT NULL,
  `Descripcion` varchar(2000) DEFAULT NULL,
  `Fecha` date DEFAULT NULL,
  `FechaPublicacion` date DEFAULT NULL,
  `Imagen` varchar(255) DEFAULT NULL,
  `Lugar` varchar(255) DEFAULT NULL,
  `MontoTotal` int NOT NULL,
  `Precio` int NOT NULL,
  `fechaExpiracion` date DEFAULT NULL,
  `categoria` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `proponente` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Titulo`),
  KEY `FKg6f534dgmcx7u9nqg8mictlf2` (`categoria`),
  KEY `FKay70jsl117hssucrwuh5d7m5p` (`proponente`),
  CONSTRAINT `FKay70jsl117hssucrwuh5d7m5p` FOREIGN KEY (`proponente`) REFERENCES `Proponente` (`nickname`),
  CONSTRAINT `FKg6f534dgmcx7u9nqg8mictlf2` FOREIGN KEY (`categoria`) REFERENCES `Categoria` (`nombreCategoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Propuesta`
--

LOCK TABLES `Propuesta` WRITE;
/*!40000 ALTER TABLE `Propuesta` DISABLE KEYS */;
INSERT INTO `Propuesta` VALUES ('Bardo en la FING','El 10 de Diciembre se presentará Bardo Científico en la FING. El humor puede ser usado como una herramienta importante\npara el aprendizaje y la democratización de la ciencia, los monólogos científicos son una forma didáctica de apropiación del\nconocimiento científico y contribuyen a que el público aprenda ciencia de forma amena. Los invitamos a pasar un rato\ndivertido, en un espacio en el cual aprenderán cosas de la ciencia que los sorprenderán. ¡Los esperamos!','2025-12-10','2025-10-22','','Anfiteatro Edificio \"José Luis Massera\"',100000,200,'2025-11-21','Stand-up','losBardo'),('Cine en el Botanico','El 16 de Diciembre a la hora 20 se proyectará la película \"Clever\", en el Jardín Botánico (Av. 19 de Abril 1181) en el marco\nde las actividades realizadas por el ciclo Cultura al Aire Libre. El largometraje uruguayo de ficción Clever es dirigido por\nFederico Borgia y Guillermo Madeiro. Es apto para mayores de 15 años.','2025-09-16','2025-10-22','','Jardin Botanico',150000,200,'2025-11-21','Cine al Aire Libre','diegop'),('El Lazarillo de Tormes','Vuelve unas de las producciones de El Galpón más aclamadas de los últimos tiempos. Esta obra se ha presentado en\nMiami, Nueva York, Washington, México, Guadalajara, Río de Janeiro y La Habana. En nuestro país, El Lazarillo de\nTormes fue nominado en los rubros mejor espectáculo y mejor dirección a los Premios Florencio 1995, obteniendo su\nprotagonista Héctor Guido el Florencio a Mejor actor de ese año.','2025-12-03','2025-10-22','','Teatro el Galpón',175000,350,'2025-11-21','Teatro Dramático','hectorg'),('El Pimiento Indomable','El Pimiento Indomable, formación compuesta por Kiko Veneno y el uruguayo Martín Buscaglia, presentará este 19 de\nOctubre, su primer trabajo. Bajo un título homónimo al del grupo, es un disco que según los propios protagonistas\n“no se parece al de ninguno de los dos por separado. Entre los títulos que se podrán escuchar se encuentran “Nadador\nsalvador”, “América es más grande”, “Pescaito Enroscado” o “La reina del placer”.','2025-10-19','2025-10-22','IMG/PIM/pim.jpg','Teatro Solís',400000,400,'2025-11-21','Concierto','mbusca'),('Pilsen Rock','La edición 2017 del Pilsen Rock se celebrará el 21 de Octubre en la Rural del Prado y contará con la participación de más\nde 15 bandas nacionales. Quienes no puedan trasladarse al lugar, tendrán la posibilidad de disfrutar los shows a través de\nInternet, así como entrevistas en vivo a los músicos una vez finalizados los conciertos.','2025-10-21','2025-10-22','IMG/PIL/pil.jpg','Rural del Prado',900000,1000,'2025-11-21','Festival','kairoh'),('Religiosamente','MOMOSAPIENS presenta \"Religiosamente\". Mediante dos parodias y un hilo conductor que aborda la temática de la\nreligión Momosapiens, mediante el humor y la reflexión, hilvana una historia que muestra al hombre inmerso en el tema\nreligioso. El libreto está escrito utilizando diferentes lenguajes de humor, dando una visión satírica y reflexiva desde\ndistintos puntos de vista, logrando mediante situaciones paródicas armar una propuesta plena de arte carnavalero.','2025-10-07','2025-10-22','IMG/MOM/MOMO.jpg','Teatro de Verano',300000,300,'2025-11-21','Parodistas','hrubino'),('Romeo y Julieta','Romeo y Julieta de Kenneth MacMillan, uno de los ballets favoritos del director artístico Julio Bocca, se presentará\nnuevamente el 5 de Noviembre en el Auditorio Nacional del Sodre. Basada en la obra homónima de William Shakespeare,\nRomeo y Julieta es considerada la coreografía maestra del MacMillan. La producción de vestuario y escenografía se realizó\nen los Talleres del Auditorio Adela Reta, sobre los diseños originales.','2025-11-05','2025-10-22','IMG/RYJ/RYJ.jpg','Auditorio Nacional del Sodre',750000,800,'2025-11-21','Ballet','juliob'),('Un día de Julio','La Catalina presenta el espectáculo \"Un Día de Julio\" en Landia. Un hombre misterioso y solitario vive encerrado entre las\ncuatro paredes de su casa. Intenta, con sus teorías extravagantes, cambiar el mundo exterior que le resulta inhabitable.\nUn día de Julio sucederá algo que cambiará su vida y la de su entorno para siempre.','2025-11-16','2025-10-22','IMG/UDJ/UDIJ.jpg','Landia',300000,650,'2025-11-21','Murga','tabarec');
/*!40000 ALTER TABLE `Propuesta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Registro_Estado`
--

DROP TABLE IF EXISTS `Registro_Estado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Registro_Estado` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `estado` enum('INGRESADA','PUBLICADA','EN_FINANCIACION','FINANCIADA','NO_FINANCIADA','CANCELADA') DEFAULT NULL,
  `fechaReg` date DEFAULT NULL,
  `propuesta` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK42pax8m8wc7lqsdonxd9ycivp` (`propuesta`),
  CONSTRAINT `FK42pax8m8wc7lqsdonxd9ycivp` FOREIGN KEY (`propuesta`) REFERENCES `Propuesta` (`Titulo`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Registro_Estado`
--

LOCK TABLES `Registro_Estado` WRITE;
/*!40000 ALTER TABLE `Registro_Estado` DISABLE KEYS */;
INSERT INTO `Registro_Estado` VALUES (1,'INGRESADA','2025-10-22','Cine en el Botanico'),(2,'PUBLICADA','2025-10-22','Cine en el Botanico'),(3,'EN_FINANCIACION','2025-10-22','Cine en el Botanico'),(4,'FINANCIADA','2025-10-22','Cine en el Botanico'),(5,'CANCELADA','2025-10-22','Cine en el Botanico'),(6,'INGRESADA','2025-10-22','Religiosamente'),(7,'PUBLICADA','2025-10-22','Religiosamente'),(8,'EN_FINANCIACION','2025-10-22','Religiosamente'),(9,'FINANCIADA','2025-10-22','Religiosamente'),(10,'INGRESADA','2025-10-22','El Pimiento Indomable'),(11,'PUBLICADA','2025-10-22','El Pimiento Indomable'),(12,'EN_FINANCIACION','2025-10-22','El Pimiento Indomable'),(13,'INGRESADA','2025-10-22','Pilsen Rock'),(14,'PUBLICADA','2025-10-22','Pilsen Rock'),(15,'EN_FINANCIACION','2025-10-22','Pilsen Rock'),(16,'INGRESADA','2025-10-22','Romeo y Julieta'),(17,'PUBLICADA','2025-10-22','Romeo y Julieta'),(18,'EN_FINANCIACION','2025-10-22','Romeo y Julieta'),(19,'INGRESADA','2025-10-22','Un día de Julio'),(20,'PUBLICADA','2025-10-22','Un día de Julio'),(21,'EN_FINANCIACION','2025-10-22','Un día de Julio'),(22,'INGRESADA','2025-10-22','El Lazarillo de Tormes'),(23,'PUBLICADA','2025-10-22','El Lazarillo de Tormes'),(24,'INGRESADA','2025-10-22','Bardo en la FING');
/*!40000 ALTER TABLE `Registro_Estado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Usuario`
--

DROP TABLE IF EXISTS `Usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Usuario` (
  `nickname` varchar(255) NOT NULL,
  `apellido` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `pass` varchar(255) DEFAULT NULL,
  `rutaImg` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`nickname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Usuario`
--

LOCK TABLES `Usuario` WRITE;
/*!40000 ALTER TABLE `Usuario` DISABLE KEYS */;
INSERT INTO `Usuario` VALUES ('cachilas','Silva','Cachila.sil@c1080.org.uy','1947-01-01','Waldemar \"Cachila\"','123','IMG/cachilas/8273.jpg'),('chino','Recoba','chino@trico.org.uy','1976-03-17','Alvaro','123',''),('diegop','Parodi','diego@efectocine.com','1975-01-01','Diego','123',''),('hectorg','Guido','hector.gui@1galpon.org.uy','1954-01-07','Héctor','123','IMG/hectorg/7232.jpg'),('hrubino','Rubino','horacio.rubino@guambia.com.uy','1962-02-25','Horacio','123','IMG/hrubino/547129.JPG'),('juanP','Perez','juanp@elpueblo.com','1970-01-01','Juan','123',''),('juliob','Bocca','juliobocca@sodre.com.uy','1967-03-16','Julio','123',''),('kairoh','Herrera','kairoher@pilsenrock.com.uy','1840-04-25','Kairo','123','IMG/kairoh/images.jpeg'),('losBardo','Bardo','losbardo@bardocientifico.com','1980-10-31','Los','123','IMG/losBardo/BC-head-home-heroe-color-final.jpg'),('marcelot','Tinelli','marcelot@ideasdelsur.com.ar','1960-04-01','Marcelo','123','IMG/marcelot/2132.jpg'),('mbusca','Buscaglia','Martin.bus@agadu.org.uy','1972-06-14','Martín','123','IMG/mbusca/583283.jpg'),('Mengano','Gómez','menganog@elpueblo.com','1982-02-02','Mengano','123',''),('nicoJ','Jodal','jodal@artech.com.uy','1960-09-08','Nicolás','123','IMG/nicoJ/Jodal-Nicolas.jpg'),('novick','Novick','edgardo@novick.com.uy','1952-07-17','Edgardo','123','IMG/novick/images.jpeg'),('Peregano','López','peregano@elpueblo.com','1985-03-03','Perengano','123',''),('robinh','Henderson','Robin.h@tinglesa.com.uy','1940-08-03','Robin','123',''),('sergiop','Puglia','puglia@alpanpan.com.uy','1950-01-28','Sergio','123','IMG/sergiop/puglia01.jpg'),('tabarec','Cardozo','tabare.car@agadu.org.uy','1971-07-24','Tabaré','123','IMG/tabarec/images.jpeg'),('Tiajaci','Jacinta','jacinta@elpueblo.com','1990-04-04','Tía','123',''),('tonyp','Pacheco','eltony@manya.org.uy','1955-02-14','Antonio','123','IMG/tonyp/antonio.jpg');
/*!40000 ALTER TABLE `Usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comentarios`
--

DROP TABLE IF EXISTS `comentarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comentarios` (
  `propuesta` varchar(255) NOT NULL,
  `comentario` varchar(255) DEFAULT NULL,
  `usuario` varchar(255) NOT NULL,
  PRIMARY KEY (`propuesta`,`usuario`),
  CONSTRAINT `FKq1xivx0jbh78hpy5n250pnaar` FOREIGN KEY (`propuesta`) REFERENCES `Propuesta` (`Titulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comentarios`
--

LOCK TABLES `comentarios` WRITE;
/*!40000 ALTER TABLE `comentarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `comentarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `propuesta_favorita`
--

DROP TABLE IF EXISTS `propuesta_favorita`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `propuesta_favorita` (
  `usuario` varchar(255) NOT NULL,
  `propuesta` varchar(255) NOT NULL,
  PRIMARY KEY (`usuario`,`propuesta`),
  KEY `FKsfr0rvc3vu0ufertwqeneyjye` (`propuesta`),
  CONSTRAINT `FKr6v18uyfvr601jr6kbhlxidjs` FOREIGN KEY (`usuario`) REFERENCES `Usuario` (`nickname`),
  CONSTRAINT `FKsfr0rvc3vu0ufertwqeneyjye` FOREIGN KEY (`propuesta`) REFERENCES `Propuesta` (`Titulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `propuesta_favorita`
--

LOCK TABLES `propuesta_favorita` WRITE;
/*!40000 ALTER TABLE `propuesta_favorita` DISABLE KEYS */;
/*!40000 ALTER TABLE `propuesta_favorita` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `retorno`
--

DROP TABLE IF EXISTS `retorno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `retorno` (
  `propuesta` varchar(255) NOT NULL,
  `retorno` enum('EntradaGratis','PorcentajeGanancia') DEFAULT NULL,
  KEY `FKd0t31ruve27c7vv93qe92eu9m` (`propuesta`),
  CONSTRAINT `FKd0t31ruve27c7vv93qe92eu9m` FOREIGN KEY (`propuesta`) REFERENCES `Propuesta` (`Titulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `retorno`
--

LOCK TABLES `retorno` WRITE;
/*!40000 ALTER TABLE `retorno` DISABLE KEYS */;
INSERT INTO `retorno` VALUES ('Cine en el Botanico','PorcentajeGanancia'),('Religiosamente','EntradaGratis'),('Religiosamente','PorcentajeGanancia'),('El Pimiento Indomable','PorcentajeGanancia'),('Pilsen Rock','EntradaGratis'),('Pilsen Rock','PorcentajeGanancia'),('Romeo y Julieta','PorcentajeGanancia'),('Un día de Julio','EntradaGratis'),('Un día de Julio','PorcentajeGanancia'),('El Lazarillo de Tormes','EntradaGratis'),('Bardo en la FING','EntradaGratis');
/*!40000 ALTER TABLE `retorno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario_seguidos`
--

DROP TABLE IF EXISTS `usuario_seguidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario_seguidos` (
  `seguidor` varchar(255) NOT NULL,
  `seguido` varchar(255) NOT NULL,
  PRIMARY KEY (`seguidor`,`seguido`),
  KEY `FK6ogkgb2fpok50e5aelhvdx3ve` (`seguido`),
  CONSTRAINT `FK6ogkgb2fpok50e5aelhvdx3ve` FOREIGN KEY (`seguido`) REFERENCES `Usuario` (`nickname`),
  CONSTRAINT `FKtb7deeuuq7adsei575teefwwi` FOREIGN KEY (`seguidor`) REFERENCES `Usuario` (`nickname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario_seguidos`
--

LOCK TABLES `usuario_seguidos` WRITE;
/*!40000 ALTER TABLE `usuario_seguidos` DISABLE KEYS */;
INSERT INTO `usuario_seguidos` VALUES ('juanP','cachilas'),('marcelot','cachilas'),('mbusca','cachilas'),('novick','cachilas'),('tabarec','cachilas'),('tonyp','chino'),('hrubino','diegop'),('juliob','diegop'),('nicoJ','diegop'),('robinh','diegop'),('sergiop','diegop'),('diegop','hectorg'),('hrubino','hectorg'),('Mengano','hectorg'),('robinh','hectorg'),('cachilas','hrubino'),('losBardo','hrubino'),('novick','hrubino'),('tabarec','hrubino'),('hectorg','juliob'),('marcelot','juliob'),('Mengano','juliob'),('robinh','juliob'),('sergiop','juliob'),('Tiajaci','juliob'),('juanP','kairoh'),('marcelot','kairoh'),('mbusca','kairoh'),('Tiajaci','kairoh'),('diegop','losBardo'),('hrubino','losBardo'),('nicoJ','losBardo'),('hectorg','mbusca'),('juliob','mbusca'),('sergiop','mbusca'),('losBardo','nicoJ'),('Tiajaci','novick'),('kairoh','sergiop'),('Mengano','sergiop'),('juanP','tabarec'),('mbusca','tabarec'),('novick','tabarec'),('chino','tonyp');
/*!40000 ALTER TABLE `usuario_seguidos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-22 16:37:30
