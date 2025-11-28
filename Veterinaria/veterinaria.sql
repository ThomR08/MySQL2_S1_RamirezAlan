DROP DATABASE IF EXISTS veterinaria;
CREATE DATABASE veterinaria;
USE veterinaria;

CREATE TABLE persona (
  id INT NOT NULL AUTO_INCREMENT,
  tipo_documento ENUM('CC', 'CE') NOT NULL,
  documento VARCHAR(45) NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  apellido VARCHAR(45) NOT NULL,
  direccion VARCHAR(150),
  correo VARCHAR(50) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  PRIMARY KEY (id),
  UNIQUE (documento)
);

CREATE TABLE cliente (
  id INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES persona(id)
);

CREATE TABLE usuario (
  id INT NOT NULL AUTO_INCREMENT,
  usuario VARCHAR(45) NOT NULL,
  contrasenha VARCHAR(45) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES persona(id)
);

CREATE TABLE especialidad (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE veterinario (
  id INT NOT NULL AUTO_INCREMENT,
  tarjeta_profesional VARCHAR(45) NOT NULL,
  especialidad INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES persona(id),
  FOREIGN KEY (especialidad) REFERENCES especialidad(id)
);

CREATE TABLE tipo_animal (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE animal (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  cliente_id INT NOT NULL,
  tipo_animal_id INT NOT NULL,
  anho_nacimiento INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (tipo_animal_id) REFERENCES tipo_animal(id),
  FOREIGN KEY (cliente_id) REFERENCES cliente(id)
);

CREATE TABLE producto (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  descripcion VARCHAR(150) NOT NULL,
  precio_compra DOUBLE NOT NULL,
  stock INT NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE precios_producto (
  id INT NOT NULL AUTO_INCREMENT,
  producto_id INT NOT NULL,
  nombre VARCHAR(45) NOT NULL,
  precio DOUBLE NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (producto_id) REFERENCES producto(id)
);

CREATE TABLE proveedor (
  id INT NOT NULL AUTO_INCREMENT,
  nit VARCHAR(45) NOT NULL,
  razon_social VARCHAR(45) NOT NULL,
  correo VARCHAR(45) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE compra (
  id INT NOT NULL AUTO_INCREMENT,
  usuario_id INT NOT NULL,
  proveedor_id INT NOT NULL,
  fecha_compra DATE NOT NULL,
  fecha_registro DATETIME NOT NULL,
  total DOUBLE NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (proveedor_id) REFERENCES proveedor(id),
  FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);

CREATE TABLE detalle_compra (
  id INT NOT NULL AUTO_INCREMENT,
  producto_id INT NOT NULL,
  cantidad INT NOT NULL,
  subtotal DOUBLE NOT NULL,
  compra_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (producto_id) REFERENCES producto(id),
  FOREIGN KEY (compra_id) REFERENCES compra(id)
);

CREATE TABLE servicio (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  precio DOUBLE NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE paquete (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  precio DOUBLE NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE detalle_paquete (
  id INT NOT NULL AUTO_INCREMENT,
  paquete_servicio ENUM('servicio','producto') NOT NULL,
  cantidad INT NOT NULL,
  subtotal DOUBLE NOT NULL,
  paquete_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (paquete_id) REFERENCES paquete(id)
);

CREATE TABLE venta (
  id INT NOT NULL AUTO_INCREMENT,
  usuario_id INT NOT NULL,
  cliente_id INT NOT NULL,
  fecha_venta DATE NOT NULL,
  fecha_ingreso DATETIME NOT NULL,
  total DOUBLE NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (usuario_id) REFERENCES usuario(id),
  FOREIGN KEY (cliente_id) REFERENCES cliente(id)
);

CREATE TABLE detalle_venta (
  id INT NOT NULL AUTO_INCREMENT,
  tipo_venta ENUM('producto','paquete','servicio') NOT NULL, 
  codigo INT NOT NULL,
  cantidad INT NOT NULL,
  subtotal DOUBLE NOT NULL,
  venta_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (venta_id) REFERENCES venta(id)
);

CREATE TABLE citas (
  id INT NOT NULL AUTO_INCREMENT,
  veterinario_id INT NOT NULL,
  animal_id INT NOT NULL,
  fecha_inicio DATETIME NOT NULL,
  fecha_fin DATETIME NOT NULL,
  total DOUBLE NOT NULL,
  vendedor_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (vendedor_id) REFERENCES usuario(id),
  FOREIGN KEY (veterinario_id) REFERENCES veterinario(id),
  FOREIGN KEY (animal_id) REFERENCES animal(id)
);

-- ======= INSERTS MANUALES MASIVOS (explícitos) =======

-- 1) PERSONAS (110)
INSERT INTO persona (tipo_documento, documento, nombre, apellido, direccion, correo, fecha_nacimiento) VALUES
('CC','10000001','Nombre1','Apellido1','Cra 1 #1-01','user1@example.com','1985-01-01'),
('CC','10000002','Nombre2','Apellido2','Cra 2 #2-02','user2@example.com','1986-02-02'),
('CC','10000003','Nombre3','Apellido3','Cra 3 #3-03','user3@example.com','1987-03-03'),
('CC','10000004','Nombre4','Apellido4','Cra 4 #4-04','user4@example.com','1988-04-04'),
('CC','10000005','Nombre5','Apellido5','Cra 5 #5-05','user5@example.com','1989-05-05'),
('CC','10000006','Nombre6','Apellido6','Cra 6 #6-06','user6@example.com','1990-06-06'),
('CC','10000007','Nombre7','Apellido7','Cra 7 #7-07','user7@example.com','1991-07-07'),
('CC','10000008','Nombre8','Apellido8','Cra 8 #8-08','user8@example.com','1992-08-08'),
('CC','10000009','Nombre9','Apellido9','Cra 9 #9-09','user9@example.com','1993-09-09'),
('CC','10000010','Nombre10','Apellido10','Cra 10 #10-10','user10@example.com','1994-10-10'),
('CC','10000011','Nombre11','Apellido11','Cra 11 #11-11','user11@example.com','1984-11-11'),
('CC','10000012','Nombre12','Apellido12','Cra 12 #12-12','user12@example.com','1983-12-12'),
('CC','10000013','Nombre13','Apellido13','Cra 13 #13-13','user13@example.com','1979-01-13'),
('CC','10000014','Nombre14','Apellido14','Cra 14 #14-14','user14@example.com','1982-02-14'),
('CC','10000015','Nombre15','Apellido15','Cra 15 #15-15','user15@example.com','1995-03-15'),
('CC','10000016','Nombre16','Apellido16','Cra 16 #16-16','user16@example.com','1996-04-16'),
('CC','10000017','Nombre17','Apellido17','Cra 17 #17-17','user17@example.com','1997-05-17'),
('CC','10000018','Nombre18','Apellido18','Cra 18 #18-18','user18@example.com','1998-06-18'),
('CC','10000019','Nombre19','Apellido19','Cra 19 #19-19','user19@example.com','1999-07-19'),
('CC','10000020','Nombre20','Apellido20','Cra 20 #20-20','user20@example.com','2000-08-20'),
('CC','10000021','Nombre21','Apellido21','Cra 21 #21-21','user21@example.com','1980-09-21'),
('CC','10000022','Nombre22','Apellido22','Cra 22 #22-22','user22@example.com','1981-10-22'),
('CC','10000023','Nombre23','Apellido23','Cra 23 #23-23','user23@example.com','1982-11-23'),
('CC','10000024','Nombre24','Apellido24','Cra 24 #24-24','user24@example.com','1983-12-24'),
('CC','10000025','Nombre25','Apellido25','Cra 25 #25-25','user25@example.com','1984-01-25'),
('CC','10000026','Nombre26','Apellido26','Cra 26 #26-26','user26@example.com','1985-02-26'),
('CC','10000027','Nombre27','Apellido27','Cra 27 #27-27','user27@example.com','1986-03-27'),
('CC','10000028','Nombre28','Apellido28','Cra 28 #28-28','user28@example.com','1987-04-28'),
('CC','10000029','Nombre29','Apellido29','Cra 29 #29-29','user29@example.com','1988-05-29'),
('CC','10000030','Nombre30','Apellido30','Cra 30 #30-30','user30@example.com','1989-06-30'),
('CC','10000031','Nombre31','Apellido31','Cra 31 #31-31','user31@example.com','1990-07-01'),
('CC','10000032','Nombre32','Apellido32','Cra 32 #32-32','user32@example.com','1991-08-02'),
('CC','10000033','Nombre33','Apellido33','Cra 33 #33-33','user33@example.com','1992-09-03'),
('CC','10000034','Nombre34','Apellido34','Cra 34 #34-34','user34@example.com','1993-10-04'),
('CC','10000035','Nombre35','Apellido35','Cra 35 #35-35','user35@example.com','1994-11-05'),
('CC','10000036','Nombre36','Apellido36','Cra 36 #36-36','user36@example.com','1995-12-06'),
('CC','10000037','Nombre37','Apellido37','Cra 37 #37-37','user37@example.com','1996-01-07'),
('CC','10000038','Nombre38','Apellido38','Cra 38 #38-38','user38@example.com','1997-02-08'),
('CC','10000039','Nombre39','Apellido39','Cra 39 #39-39','user39@example.com','1998-03-09'),
('CC','10000040','Nombre40','Apellido40','Cra 40 #40-40','user40@example.com','1999-04-10'),
('CC','10000041','Nombre41','Apellido41','Cra 41 #41-41','user41@example.com','1982-05-11'),
('CC','10000042','Nombre42','Apellido42','Cra 42 #42-42','user42@example.com','1983-06-12'),
('CC','10000043','Nombre43','Apellido43','Cra 43 #43-43','user43@example.com','1984-07-13'),
('CC','10000044','Nombre44','Apellido44','Cra 44 #44-44','user44@example.com','1985-08-14'),
('CC','10000045','Nombre45','Apellido45','Cra 45 #45-45','user45@example.com','1986-09-15'),
('CC','10000046','Nombre46','Apellido46','Cra 46 #46-46','user46@example.com','1987-10-16'),
('CC','10000047','Nombre47','Apellido47','Cra 47 #47-47','user47@example.com','1988-11-17'),
('CC','10000048','Nombre48','Apellido48','Cra 48 #48-48','user48@example.com','1989-12-18'),
('CC','10000049','Nombre49','Apellido49','Cra 49 #49-49','user49@example.com','1990-01-19'),
('CC','10000050','Nombre50','Apellido50','Cra 50 #50-50','user50@example.com','1991-02-20'),
('CC','10000051','Nombre51','Apellido51','Cra 51 #51-51','user51@example.com','1992-03-21'),
('CC','10000052','Nombre52','Apellido52','Cra 52 #52-52','user52@example.com','1993-04-22'),
('CC','10000053','Nombre53','Apellido53','Cra 53 #53-53','user53@example.com','1994-05-23'),
('CC','10000054','Nombre54','Apellido54','Cra 54 #54-54','user54@example.com','1995-06-24'),
('CC','10000055','Nombre55','Apellido55','Cra 55 #55-55','user55@example.com','1996-07-25'),
('CC','10000056','Nombre56','Apellido56','Cra 56 #56-56','user56@example.com','1997-08-26'),
('CC','10000057','Nombre57','Apellido57','Cra 57 #57-57','user57@example.com','1998-09-27'),
('CC','10000058','Nombre58','Apellido58','Cra 58 #58-58','user58@example.com','1999-10-28'),
('CC','10000059','Nombre59','Apellido59','Cra 59 #59-59','user59@example.com','2000-11-29'),
('CC','10000060','Nombre60','Apellido60','Cra 60 #60-60','user60@example.com','1980-12-30'),
('CC','10000061','Nombre61','Apellido61','Cra 61 #61-61','user61@example.com','1981-01-01'),
('CC','10000062','Nombre62','Apellido62','Cra 62 #62-62','user62@example.com','1982-02-02'),
('CC','10000063','Nombre63','Apellido63','Cra 63 #63-63','user63@example.com','1983-03-03'),
('CC','10000064','Nombre64','Apellido64','Cra 64 #64-64','user64@example.com','1984-04-04'),
('CC','10000065','Nombre65','Apellido65','Cra 65 #65-65','user65@example.com','1985-05-05'),
('CC','10000066','Nombre66','Apellido66','Cra 66 #66-66','user66@example.com','1986-06-06'),
('CC','10000067','Nombre67','Apellido67','Cra 67 #67-67','user67@example.com','1987-07-07'),
('CC','10000068','Nombre68','Apellido68','Cra 68 #68-68','user68@example.com','1988-08-08'),
('CC','10000069','Nombre69','Apellido69','Cra 69 #69-69','user69@example.com','1989-09-09'),
('CC','10000070','Nombre70','Apellido70','Cra 70 #70-70','user70@example.com','1990-10-10'),
('CC','10000071','Nombre71','Apellido71','Cra 71 #71-71','user71@example.com','1991-11-11'),
('CC','10000072','Nombre72','Apellido72','Cra 72 #72-72','user72@example.com','1992-12-12'),
('CC','10000073','Nombre73','Apellido73','Cra 73 #73-73','user73@example.com','1993-01-13'),
('CC','10000074','Nombre74','Apellido74','Cra 74 #74-74','user74@example.com','1994-02-14'),
('CC','10000075','Nombre75','Apellido75','Cra 75 #75-75','user75@example.com','1995-03-15'),
('CC','10000076','Nombre76','Apellido76','Cra 76 #76-76','user76@example.com','1996-04-16'),
('CC','10000077','Nombre77','Apellido77','Cra 77 #77-77','user77@example.com','1997-05-17'),
('CC','10000078','Nombre78','Apellido78','Cra 78 #78-78','user78@example.com','1998-06-18'),
('CC','10000079','Nombre79','Apellido79','Cra 79 #79-79','user79@example.com','1999-07-19'),
('CC','10000080','Nombre80','Apellido80','Cra 80 #80-80','user80@example.com','2000-08-20'),
('CC','10000081','Nombre81','Apellido81','Cra 81 #81-81','user81@example.com','1988-09-21'),
('CC','10000082','Nombre82','Apellido82','Cra 82 #82-82','user82@example.com','1989-10-22'),
('CC','10000083','Nombre83','Apellido83','Cra 83 #83-83','user83@example.com','1990-11-23'),
('CC','10000084','Nombre84','Apellido84','Cra 84 #84-84','user84@example.com','1991-12-24'),
('CC','10000085','Nombre85','Apellido85','Cra 85 #85-85','user85@example.com','1992-01-25'),
('CC','10000086','Nombre86','Apellido86','Cra 86 #86-86','user86@example.com','1993-02-26'),
('CC','10000087','Nombre87','Apellido87','Cra 87 #87-87','user87@example.com','1994-03-27'),
('CC','10000088','Nombre88','Apellido88','Cra 88 #88-88','user88@example.com','1995-04-28'),
('CC','10000089','Nombre89','Apellido89','Cra 89 #89-89','user89@example.com','1996-05-29'),
('CC','10000090','Nombre90','Apellido90','Cra 90 #90-90','user90@example.com','1997-06-30'),
('CC','10000091','Nombre91','Apellido91','Cra 91 #91-91','user91@example.com','1998-07-01'),
('CC','10000092','Nombre92','Apellido92','Cra 92 #92-92','user92@example.com','1999-08-02'),
('CC','10000093','Nombre93','Apellido93','Cra 93 #93-93','user93@example.com','2000-09-03'),
('CC','10000094','Nombre94','Apellido94','Cra 94 #94-94','user94@example.com','1987-10-04'),
('CC','10000095','Nombre95','Apellido95','Cra 95 #95-95','user95@example.com','1986-11-05'),
('CC','10000096','Nombre96','Apellido96','Cra 96 #96-96','user96@example.com','1985-12-06'),
('CC','10000097','Nombre97','Apellido97','Cra 97 #97-97','user97@example.com','1984-01-07'),
('CC','10000098','Nombre98','Apellido98','Cra 98 #98-98','user98@example.com','1983-02-08'),
('CC','10000099','Nombre99','Apellido99','Cra 99 #99-99','user99@example.com','1982-03-09'),
('CC','10000100','Nombre100','Apellido100','Cra 100 #100-100','user100@example.com','1981-04-10'),
('CC','10000101','Nombre101','Apellido101','Cra 101 #101-101','user101@example.com','1990-05-11'),
('CC','10000102','Nombre102','Apellido102','Cra 102 #102-102','user102@example.com','1991-06-12'),
('CC','10000103','Nombre103','Apellido103','Cra 103 #103-103','user103@example.com','1992-07-13'),
('CC','10000104','Nombre104','Apellido104','Cra 104 #104-104','user104@example.com','1993-08-14'),
('CC','10000105','Nombre105','Apellido105','Cra 105 #105-105','user105@example.com','1994-09-15'),
('CC','10000106','Nombre106','Apellido106','Cra 106 #106-106','user106@example.com','1995-10-16'),
('CC','10000107','Nombre107','Apellido107','Cra 107 #107-107','user107@example.com','1996-11-17'),
('CC','10000108','Nombre108','Apellido108','Cra 108 #108-108','user108@example.com','1997-12-18'),
('CC','10000109','Nombre109','Apellido109','Cra 109 #109-109','user109@example.com','1998-01-19'),
('CC','10000110','Nombre110','Apellido110','Cra 110 #110-110','user110@example.com','1999-02-20')
;

-- 2) CLIENTES (ids 1..80)
INSERT INTO cliente (id) VALUES
(1),(2),(3),(4),(5),(6),(7),(8),(9),(10),
(11),(12),(13),(14),(15),(16),(17),(18),(19),(20),
(21),(22),(23),(24),(25),(26),(27),(28),(29),(30),
(31),(32),(33),(34),(35),(36),(37),(38),(39),(40),
(41),(42),(43),(44),(45),(46),(47),(48),(49),(50),
(51),(52),(53),(54),(55),(56),(57),(58),(59),(60),
(61),(62),(63),(64),(65),(66),(67),(68),(69),(70),
(71),(72),(73),(74),(75),(76),(77),(78),(79),(80)
;

-- 3) USUARIOS (ids 81..100)
INSERT INTO usuario (id, usuario, contrasenha) VALUES
(81,'usr81','pass81'),(82,'usr82','pass82'),(83,'usr83','pass83'),(84,'usr84','pass84'),(85,'usr85','pass85'),
(86,'usr86','pass86'),(87,'usr87','pass87'),(88,'usr88','pass88'),(89,'usr89','pass89'),(90,'usr90','pass90'),
(91,'usr91','pass91'),(92,'usr92','pass92'),(93,'usr93','pass93'),(94,'usr94','pass94'),(95,'usr95','pass95'),
(96,'usr96','pass96'),(97,'usr97','pass97'),(98,'usr98','pass98'),(99,'usr99','pass99'),(100,'usr100','pass100')
;

-- 4) ESPECIALIDADES (fijas)
INSERT INTO especialidad (nombre) VALUES
('General'),('Cirugía'),('Dermatología'),('Oftalmología'),('Cardiología'),('Reproducción')
;

-- 5) VETERINARIOS (ids 101..110) -- especialidad 1..6 cycling
INSERT INTO veterinario (id, tarjeta_profesional, especialidad) VALUES
(101,'TP-101',1),(102,'TP-102',2),(103,'TP-103',3),(104,'TP-104',4),(105,'TP-105',5),
(106,'TP-106',6),(107,'TP-107',1),(108,'TP-108',2),(109,'TP-109',3),(110,'TP-110',4)
;

-- 6) TIPO_ANIMAL
INSERT INTO tipo_animal (nombre) VALUES ('Perro'),('Gato'),('Conejo'),('Pájaro'),('Reptil'),('Roedor');

-- 7) ANIMALES (200) assigned to clientes 1..80, tipo 1..6
INSERT INTO animal (nombre, cliente_id, tipo_animal_id, anho_nacimiento) VALUES
('Mascota_1',1,1,2015),('Mascota_2',2,2,2017),('Mascota_3',3,3,2016),('Mascota_4',4,4,2018),('Mascota_5',5,5,2014),
('Mascota_6',6,6,2019),('Mascota_7',7,1,2012),('Mascota_8',8,2,2013),('Mascota_9',9,3,2011),('Mascota_10',10,4,2010),
('Mascota_11',11,5,2018),('Mascota_12',12,6,2016),('Mascota_13',13,1,2015),('Mascota_14',14,2,2014),('Mascota_15',15,3,2013),
('Mascota_16',16,4,2012),('Mascota_17',17,5,2011),('Mascota_18',18,6,2010),('Mascota_19',19,1,2019),('Mascota_20',20,2,2018),
('Mascota_21',21,3,2017),('Mascota_22',22,4,2016),('Mascota_23',23,5,2015),('Mascota_24',24,6,2014),('Mascota_25',25,1,2013),
('Mascota_26',26,2,2012),('Mascota_27',27,3,2011),('Mascota_28',28,4,2010),('Mascota_29',29,5,2019),('Mascota_30',30,6,2018),
('Mascota_31',31,1,2017),('Mascota_32',32,2,2016),('Mascota_33',33,3,2015),('Mascota_34',34,4,2014),('Mascota_35',35,5,2013),
('Mascota_36',36,6,2012),('Mascota_37',37,1,2011),('Mascota_38',38,2,2010),('Mascota_39',39,3,2019),('Mascota_40',40,4,2018),
('Mascota_41',41,5,2017),('Mascota_42',42,6,2016),('Mascota_43',43,1,2015),('Mascota_44',44,2,2014),('Mascota_45',45,3,2013),
('Mascota_46',46,4,2012),('Mascota_47',47,5,2011),('Mascota_48',48,6,2010),('Mascota_49',49,1,2019),('Mascota_50',50,2,2018),
('Mascota_51',51,3,2017),('Mascota_52',52,4,2016),('Mascota_53',53,5,2015),('Mascota_54',54,6,2014),('Mascota_55',55,1,2013),
('Mascota_56',56,2,2012),('Mascota_57',57,3,2011),('Mascota_58',58,4,2010),('Mascota_59',59,5,2019),('Mascota_60',60,6,2018),
('Mascota_61',61,1,2017),('Mascota_62',62,2,2016),('Mascota_63',63,3,2015),('Mascota_64',64,4,2014),('Mascota_65',65,5,2013),
('Mascota_66',66,6,2012),('Mascota_67',67,1,2011),('Mascota_68',68,2,2010),('Mascota_69',69,3,2019),('Mascota_70',70,4,2018),
('Mascota_71',71,5,2017),('Mascota_72',72,6,2016),('Mascota_73',73,1,2015),('Mascota_74',74,2,2014),('Mascota_75',75,3,2013),
('Mascota_76',76,4,2012),('Mascota_77',77,5,2011),('Mascota_78',78,6,2010),('Mascota_79',79,1,2019),('Mascota_80',80,2,2018),
('Mascota_81',1,3,2017),('Mascota_82',2,4,2016),('Mascota_83',3,5,2015),('Mascota_84',4,6,2014),('Mascota_85',5,1,2013),
('Mascota_86',6,2,2012),('Mascota_87',7,3,2011),('Mascota_88',8,4,2010),('Mascota_89',9,5,2019),('Mascota_90',10,6,2018),
('Mascota_91',11,1,2017),('Mascota_92',12,2,2016),('Mascota_93',13,3,2015),('Mascota_94',14,4,2014),('Mascota_95',15,5,2013),
('Mascota_96',16,6,2012),('Mascota_97',17,1,2011),('Mascota_98',18,2,2010),('Mascota_99',19,3,2019),('Mascota_100',20,4,2018),
('Mascota_101',21,5,2017),('Mascota_102',22,6,2016),('Mascota_103',23,1,2015),('Mascota_104',24,2,2014),('Mascota_105',25,3,2013),
('Mascota_106',26,4,2012),('Mascota_107',27,5,2011),('Mascota_108',28,6,2010),('Mascota_109',29,1,2019),('Mascota_110',30,2,2018),
('Mascota_111',31,3,2017),('Mascota_112',32,4,2016),('Mascota_113',33,5,2015),('Mascota_114',34,6,2014),('Mascota_115',35,1,2013),
('Mascota_116',36,2,2012),('Mascota_117',37,3,2011),('Mascota_118',38,4,2010),('Mascota_119',39,5,2019),('Mascota_120',40,6,2018),
('Mascota_121',41,1,2017),('Mascota_122',42,2,2016),('Mascota_123',43,3,2015),('Mascota_124',44,4,2014),('Mascota_125',45,5,2013),
('Mascota_126',46,6,2012),('Mascota_127',47,1,2011),('Mascota_128',48,2,2010),('Mascota_129',49,3,2019),('Mascota_130',50,4,2018),
('Mascota_131',51,5,2017),('Mascota_132',52,6,2016),('Mascota_133',53,1,2015),('Mascota_134',54,2,2014),('Mascota_135',55,3,2013),
('Mascota_136',56,4,2012),('Mascota_137',57,5,2011),('Mascota_138',58,6,2010),('Mascota_139',59,1,2019),('Mascota_140',60,2,2018),
('Mascota_141',61,3,2017),('Mascota_142',62,4,2016),('Mascota_143',63,5,2015),('Mascota_144',64,6,2014),('Mascota_145',65,1,2013),
('Mascota_146',66,2,2012),('Mascota_147',67,3,2011),('Mascota_148',68,4,2010),('Mascota_149',69,5,2019),('Mascota_150',70,6,2018),
('Mascota_151',71,1,2017),('Mascota_152',72,2,2016),('Mascota_153',73,3,2015),('Mascota_154',74,4,2014),('Mascota_155',75,5,2013),
('Mascota_156',76,6,2012),('Mascota_157',77,1,2011),('Mascota_158',78,2,2010),('Mascota_159',79,3,2019),('Mascota_160',80,4,2018),
('Mascota_161',1,5,2017),('Mascota_162',2,6,2016),('Mascota_163',3,1,2015),('Mascota_164',4,2,2014),('Mascota_165',5,3,2013),
('Mascota_166',6,4,2012),('Mascota_167',7,5,2011),('Mascota_168',8,6,2010),('Mascota_169',9,1,2019),('Mascota_170',10,2,2018),
('Mascota_171',11,3,2017),('Mascota_172',12,4,2016),('Mascota_173',13,5,2015),('Mascota_174',14,6,2014),('Mascota_175',15,1,2013),
('Mascota_176',16,2,2012),('Mascota_177',17,3,2011),('Mascota_178',18,4,2010),('Mascota_179',19,5,2019),('Mascota_180',20,6,2018),
('Mascota_181',21,1,2017),('Mascota_182',22,2,2016),('Mascota_183',23,3,2015),('Mascota_184',24,4,2014),('Mascota_185',25,5,2013),
('Mascota_186',26,6,2012),('Mascota_187',27,1,2011),('Mascota_188',28,2,2010),('Mascota_189',29,3,2019),('Mascota_190',30,4,2018),
('Mascota_191',31,5,2017),('Mascota_192',32,6,2016),('Mascota_193',33,1,2015),('Mascota_194',34,2,2014),('Mascota_195',35,3,2013),
('Mascota_196',36,4,2012),('Mascota_197',37,5,2011),('Mascota_198',38,6,2010),('Mascota_199',39,1,2019),('Mascota_200',40,2,2018)
;

-- 8) PRODUCTOS (80)
INSERT INTO producto (nombre, descripcion, precio_compra, stock) VALUES
('Producto_1','Descr producto 1',5000,100),
('Producto_2','Descr producto 2',7000,80),
('Producto_3','Descr producto 3',12000,150),
('Producto_4','Descr producto 4',3000,200),
('Producto_5','Descr producto 5',25000,50),
('Producto_6','Descr producto 6',8000,120),
('Producto_7','Descr producto 7',15000,60),
('Producto_8','Descr producto 8',2000,300),
('Producto_9','Descr producto 9',4000,90),
('Producto_10','Descr producto 10',10000,70),
('Producto_11','Descr producto 11',6000,110),
('Producto_12','Descr producto 12',5500,130),
('Producto_13','Descr producto 13',9000,140),
('Producto_14','Descr producto 14',11000,95),
('Producto_15','Descr producto 15',4500,160),
('Producto_16','Descr producto 16',7000,120),
('Producto_17','Descr producto 17',3500,180),
('Producto_18','Descr producto 18',22000,40),
('Producto_19','Descr producto 19',16000,65),
('Producto_20','Descr producto 20',4200,210),
('Producto_21','Descr producto 21',4800,170),
('Producto_22','Descr producto 22',5200,150),
('Producto_23','Descr producto 23',7600,140),
('Producto_24','Descr producto 24',8300,130),
('Producto_25','Descr producto 25',9100,120),
('Producto_26','Descr producto 26',3000,200),
('Producto_27','Descr producto 27',2000,220),
('Producto_28','Descr producto 28',12500,60),
('Producto_29','Descr producto 29',13500,55),
('Producto_30','Descr producto 30',9800,75),
('Producto_31','Descr producto 31',1500,300),
('Producto_32','Descr producto 32',1700,280),
('Producto_33','Descr producto 33',2500,250),
('Producto_34','Descr producto 34',6700,160),
('Producto_35','Descr producto 35',7200,150),
('Producto_36','Descr producto 36',8200,140),
('Producto_37','Descr producto 37',9300,130),
('Producto_38','Descr producto 38',10200,120),
('Producto_39','Descr producto 39',11200,110),
('Producto_40','Descr producto 40',4500,200),
('Producto_41','Descr producto 41',6000,190),
('Producto_42','Descr producto 42',7300,180),
('Producto_43','Descr producto 43',8600,170),
('Producto_44','Descr producto 44',9800,160),
('Producto_45','Descr producto 45',12000,150),
('Producto_46','Descr producto 46',14000,140),
('Producto_47','Descr producto 47',16000,130),
('Producto_48','Descr producto 48',18000,120),
('Producto_49','Descr producto 49',20000,110),
('Producto_50','Descr producto 50',22000,100),
('Producto_51','Descr producto 51',24000,90),
('Producto_52','Descr producto 52',26000,80),
('Producto_53','Descr producto 53',28000,70),
('Producto_54','Descr producto 54',30000,60),
('Producto_55','Descr producto 55',32000,50),
('Producto_56','Descr producto 56',34000,45),
('Producto_57','Descr producto 57',36000,40),
('Producto_58','Descr producto 58',38000,35),
('Producto_59','Descr producto 59',40000,30),
('Producto_60','Descr producto 60',42000,25),
('Producto_61','Descr producto 61',44000,20),
('Producto_62','Descr producto 62',46000,18),
('Producto_63','Descr producto 63',48000,15),
('Producto_64','Descr producto 64',50000,12),
('Producto_65','Descr producto 65',52000,10),
('Producto_66','Descr producto 66',54000,8),
('Producto_67','Descr producto 67',56000,6),
('Producto_68','Descr producto 68',58000,5),
('Producto_69','Descr producto 69',60000,4),
('Producto_70','Descr producto 70',62000,3),
('Producto_71','Descr producto 71',64000,2),
('Producto_72','Descr producto 72',66000,2),
('Producto_73','Descr producto 73',68000,1),
('Producto_74','Descr producto 74',70000,1),
('Producto_75','Descr producto 75',72000,1),
('Producto_76','Descr producto 76',74000,1),
('Producto_77','Descr producto 77',76000,1),
('Producto_78','Descr producto 78',78000,1),
('Producto_79','Descr producto 79',80000,1),
('Producto_80','Descr producto 80',82000,1)
;

-- 9) PRECIOS_PRODUCTO (one price per product matching producto.id 1..80)
INSERT INTO precios_producto (producto_id, nombre, precio) VALUES
(1,'Prc_P1',9500),(2,'Prc_P2',12500),(3,'Prc_P3',18000),(4,'Prc_P4',6500),(5,'Prc_P5',35000),
(6,'Prc_P6',14000),(7,'Prc_P7',25000),(8,'Prc_P8',4200),(9,'Prc_P9',7800),(10,'Prc_P10',19000),
(11,'Prc_P11',12000),(12,'Prc_P12',11000),(13,'Prc_P13',16000),(14,'Prc_P14',21000),(15,'Prc_P15',8800),
(16,'Prc_P16',15000),(17,'Prc_P17',7200),(18,'Prc_P18',42000),(19,'Prc_P19',31000),(20,'Prc_P20',9800),
(21,'Prc_P21',10500),(22,'Prc_P22',11500),(23,'Prc_P23',17000),(24,'Prc_P24',18500),(25,'Prc_P25',19500),
(26,'Prc_P26',6000),(27,'Prc_P27',5000),(28,'Prc_P28',23000),(29,'Prc_P29',25000),(30,'Prc_P30',21000),
(31,'Prc_P31',3200),(32,'Prc_P32',3500),(33,'Prc_P33',4800),(34,'Prc_P34',14500),(35,'Prc_P35',15500),
(36,'Prc_P36',17000),(37,'Prc_P37',19500),(38,'Prc_P38',21300),(39,'Prc_P39',23000),(40,'Prc_P40',10000),
(41,'Prc_P41',12500),(42,'Prc_P42',15200),(43,'Prc_P43',17800),(44,'Prc_P44',19500),(45,'Prc_P45',24000),
(46,'Prc_P46',27000),(47,'Prc_P47',30000),(48,'Prc_P48',33000),(49,'Prc_P49',36000),(50,'Prc_P50',39000),
(51,'Prc_P51',42000),(52,'Prc_P52',45000),(53,'Prc_P53',48000),(54,'Prc_P54',51000),(55,'Prc_P55',54000),
(56,'Prc_P56',57000),(57,'Prc_P57',60000),(58,'Prc_P58',63000),(59,'Prc_P59',66000),(60,'Prc_P60',69000),
(61,'Prc_P61',72000),(62,'Prc_P62',75000),(63,'Prc_P63',78000),(64,'Prc_P64',81000),(65,'Prc_P65',84000),
(66,'Prc_P66',87000),(67,'Prc_P67',90000),(68,'Prc_P68',93000),(69,'Prc_P69',96000),(70,'Prc_P70',99000),
(71,'Prc_P71',102000),(72,'Prc_P72',105000),(73,'Prc_P73',108000),(74,'Prc_P74',111000),(75,'Prc_P75',114000),
(76,'Prc_P76',117000),(77,'Prc_P77',120000),(78,'Prc_P78',123000),(79,'Prc_P79',126000),(80,'Prc_P80',129000)
;

-- 10) PROVEEDORES (30)
INSERT INTO proveedor (nit, razon_social, correo) VALUES
('900000001','Proveedor1','p1@prov.com'),('900000002','Proveedor2','p2@prov.com'),('900000003','Proveedor3','p3@prov.com'),
('900000004','Proveedor4','p4@prov.com'),('900000005','Proveedor5','p5@prov.com'),('900000006','Proveedor6','p6@prov.com'),
('900000007','Proveedor7','p7@prov.com'),('900000008','Proveedor8','p8@prov.com'),('900000009','Proveedor9','p9@prov.com'),
('900000010','Proveedor10','p10@prov.com'),('900000011','Proveedor11','p11@prov.com'),('900000012','Proveedor12','p12@prov.com'),
('900000013','Proveedor13','p13@prov.com'),('900000014','Proveedor14','p14@prov.com'),('900000015','Proveedor15','p15@prov.com'),
('900000016','Proveedor16','p16@prov.com'),('900000017','Proveedor17','p17@prov.com'),('900000018','Proveedor18','p18@prov.com'),
('900000019','Proveedor19','p19@prov.com'),('900000020','Proveedor20','p20@prov.com'),('900000021','Proveedor21','p21@prov.com'),
('900000022','Proveedor22','p22@prov.com'),('900000023','Proveedor23','p23@prov.com'),('900000024','Proveedor24','p24@prov.com'),
('900000025','Proveedor25','p25@prov.com'),('900000026','Proveedor26','p26@prov.com'),('900000027','Proveedor27','p27@prov.com'),
('900000028','Proveedor28','p28@prov.com'),('900000029','Proveedor29','p29@prov.com'),('900000030','Proveedor30','p30@prov.com')
;

-- 11) COMPRAS (80) -- usuario 81..100, proveedor 1..30
INSERT INTO compra (usuario_id, proveedor_id, fecha_compra, fecha_registro, total) VALUES
(81,1,'2024-01-05','2024-01-05 10:00:00',0),(82,2,'2024-01-06','2024-01-06 11:00:00',0),
(83,3,'2024-01-07','2024-01-07 09:30:00',0),(84,4,'2024-01-08','2024-01-08 14:20:00',0),
(85,5,'2024-01-09','2024-01-09 08:15:00',0),(86,6,'2024-01-10','2024-01-10 13:10:00',0),
(87,7,'2024-01-11','2024-01-11 16:45:00',0),(88,8,'2024-01-12','2024-01-12 12:05:00',0),
(89,9,'2024-01-13','2024-01-13 09:55:00',0),(90,10,'2024-01-14','2024-01-14 10:25:00',0),
(91,11,'2024-01-15','2024-01-15 11:30:00',0),(92,12,'2024-01-16','2024-01-16 15:40:00',0),
(93,13,'2024-01-17','2024-01-17 08:50:00',0),(94,14,'2024-01-18','2024-01-18 09:05:00',0),
(95,15,'2024-01-19','2024-01-19 10:10:00',0),(96,16,'2024-01-20','2024-01-20 14:00:00',0),
(97,17,'2024-01-21','2024-01-21 09:45:00',0),(98,18,'2024-01-22','2024-01-22 13:25:00',0),
(99,19,'2024-01-23','2024-01-23 10:30:00',0),(100,20,'2024-01-24','2024-01-24 11:15:00',0),
(81,21,'2024-02-01','2024-02-01 09:00:00',0),(82,22,'2024-02-02','2024-02-02 09:30:00',0),
(83,23,'2024-02-03','2024-02-03 10:00:00',0),(84,24,'2024-02-04','2024-02-04 10:30:00',0),
(85,25,'2024-02-05','2024-02-05 11:00:00',0),(86,26,'2024-02-06','2024-02-06 11:30:00',0),
(87,27,'2024-02-07','2024-02-07 12:00:00',0),(88,28,'2024-02-08','2024-02-08 12:30:00',0),
(89,29,'2024-02-09','2024-02-09 13:00:00',0),(90,30,'2024-02-10','2024-02-10 13:30:00',0),
(91,1,'2024-02-11','2024-02-11 14:00:00',0),(92,2,'2024-02-12','2024-02-12 14:30:00',0),
(93,3,'2024-02-13','2024-02-13 15:00:00',0),(94,4,'2024-02-14','2024-02-14 15:30:00',0),
(95,5,'2024-02-15','2024-02-15 16:00:00',0),(96,6,'2024-02-16','2024-02-16 16:30:00',0),
(97,7,'2024-02-17','2024-02-17 17:00:00',0),(98,8,'2024-02-18','2024-02-18 17:30:00',0),
(99,9,'2024-02-19','2024-02-19 18:00:00',0),(100,10,'2024-02-20','2024-02-20 18:30:00',0),
(81,11,'2024-03-01','2024-03-01 09:10:00',0),(82,12,'2024-03-02','2024-03-02 09:20:00',0),
(83,13,'2024-03-03','2024-03-03 09:30:00',0),(84,14,'2024-03-04','2024-03-04 09:40:00',0),
(85,15,'2024-03-05','2024-03-05 09:50:00',0),(86,16,'2024-03-06','2024-03-06 10:00:00',0)
;

-- 12) DETALLE_COMPRA (approx 2 rows por compra -> 160 filas) 
-- Aquí asumimos que compra.id quedó asignada secuencialmente 1..80 en el orden anterior
INSERT INTO detalle_compra (producto_id, cantidad, subtotal, compra_id) VALUES
(1,10,95000,1),(2,5,62500,1),
(3,8,144000,2),(4,15,97500,2),
(5,2,70000,3),(6,6,84000,3),
(7,3,75000,4),(8,20,84000,4),
(9,7,54600,5),(10,4,76000,5),
(11,12,144000,6),(12,10,110000,6),
(13,3,48000,7),(14,2,42000,7),
(15,6,52800,8),(16,9,135000,8),
(17,5,36000,9),(18,1,42000,9),
(19,2,62000,10),(20,10,98000,10),
(21,4,42000,11),(22,8,92000,11),
(23,3,51000,12),(24,6,111000,12),
(25,2,39000,13),(26,7,42000,13),
(27,30,150000,14),(28,3,69000,14),
(29,2,50000,15),(30,5,105000,15),
(31,40,128000,16),(32,35,122500,16),
(33,10,48000,17),(34,6,40200,17),
(35,4,62000,18),(36,2,34000,18),
(37,3,58500,19),(38,1,21300,19),
(39,2,46000,20),(40,5,50000,20),
(41,8,100000,21),(42,6,91200,21),
(43,3,53400,22),(44,9,175500,22),
(45,2,24000,23),(46,1,14000,23),
(47,5,150000,24),(48,2,36000,24),
(49,3,108000,25),(50,1,39000,25),
(51,2,84000,26),(52,4,180000,26),
(53,2,96000,27),(54,3,153000,27),
(55,1,32000,28),(56,2,68000,28),
(57,1,36000,29),(58,2,76000,29),
(59,1,40000,30),(60,2,138000,30),
(61,3,216000,31),(62,4,300000,31),
(63,2,96000,32),(64,1,81000,32),
(65,2,104000,33),(66,1,54000,33),
(67,1,56000,34),(68,2,116000,34),
(69,1,60000,35),(70,1,62000,35),
(71,1,64000,36),(72,2,132000,36),
(73,1,68000,37),(74,1,70000,37),
(75,1,72000,38),(76,1,74000,38),
(77,1,76000,39),(78,1,78000,39),
(79,1,80000,40),(80,1,82000,40),
(1,5,47500,41),(2,10,125000,41),
(3,6,108000,42),(4,12,78000,42),
(5,3,105000,43),(6,8,112000,43),
(7,4,100000,44),(8,6,252000,44),
(9,5,39000,45),(10,7,133000,45),
(11,2,24000,46),(12,3,33000,46),
(13,1,16000,47),(14,5,105000,47),
(15,4,35200,48),(16,2,14000,48),
(17,3,108000,49),(18,6,252000,49),
(19,1,15500,50),(20,2,19600,50),
(21,3,31500,51),(22,4,46000,51),
(23,5,85000,52),(24,2,37000,52),
(25,1,19500,53),(26,2,52000,53),
(27,1,50000,54),(28,3,207000,54),
(29,2,50000,55),(30,1,21000,55),
(31,2,6400,56),(32,3,10500,56),
(33,4,19200,57),(34,2,13400,57),
(35,5,27500,58),(36,1,34000,58),
(37,2,117000,59),(38,1,21300,59),
(39,3,120000,60),(40,2,98000,60)
;

-- 13) SERVICIOS (20)
INSERT INTO servicio (nombre, precio) VALUES
('Baño','30000'),('Corte de uñas','15000'),('Consulta General','40000'),('Vacunación','60000'),('Ecografía','80000'),
('Limpieza dental','55000'),('Radiografía','70000'),('Hospitalización','120000'),('Cirugía menor','90000'),('Cirugía mayor','250000'),
('Desparasitación','20000'),('Aseo profundo','45000'),('Terapia física','65000'),('Consulta especialista','90000'),('Consulta cardiología','100000'),
('Consulta dermatología','95000'),('Analítica sanguínea','50000'),('Control reproductivo','70000'),('Castración','110000'),('Urgencias','130000')
;

-- 14) PAQUETES (30)
INSERT INTO paquete (nombre, precio) VALUES
('Paquete_1',0),('Paquete_2',0),('Paquete_3',0),('Paquete_4',0),('Paquete_5',0),
('Paquete_6',0),('Paquete_7',0),('Paquete_8',0),('Paquete_9',0),('Paquete_10',0),
('Paquete_11',0),('Paquete_12',0),('Paquete_13',0),('Paquete_14',0),('Paquete_15',0),
('Paquete_16',0),('Paquete_17',0),('Paquete_18',0),('Paquete_19',0),('Paquete_20',0),
('Paquete_21',0),('Paquete_22',0),('Paquete_23',0),('Paquete_24',0),('Paquete_25',0),
('Paquete_26',0),('Paquete_27',0),('Paquete_28',0),('Paquete_29',0),('Paquete_30',0)
;

-- 15) DETALLE_PAQUETE (~2 por paquete -> 60)
-- paquete_servicio either 'servicio' (use service ids 1..20) or 'producto' (producto ids 1..80)
INSERT INTO detalle_paquete (paquete_servicio, cantidad, subtotal, paquete_id) VALUES
('servicio',1,30000,1),('producto',2,19000,1),
('servicio',1,40000,2),('producto',1,9500,2),
('producto',3,36000,3),('servicio',1,15000,3),
('producto',1,9500,4),('producto',2,12500,4),
('servicio',1,60000,5),('servicio',1,45000,5),
('producto',1,21000,6),('servicio',1,70000,6),
('producto',4,26000,7),('servicio',1,55000,7),
('producto',2,12500,8),('servicio',1,30000,8),
('servicio',1,80000,9),('producto',1,9500,9),
('producto',5,35000,10),('servicio',1,15000,10),
('servicio',1,40000,11),('producto',2,12500,11),
('producto',3,36000,12),('servicio',1,60000,12),
('producto',1,9500,13),('producto',4,26000,13),
('servicio',1,45000,14),('producto',2,12500,14),
('servicio',1,70000,15),('producto',3,36000,15),
('producto',1,9500,16),('servicio',1,30000,16),
('producto',2,12500,17),('servicio',1,40000,17),
('servicio',1,80000,18),('producto',5,35000,18),
('producto',1,9500,19),('producto',3,36000,19),
('servicio',1,15000,20),('producto',2,12500,20),
('producto',4,26000,21),('servicio',1,55000,21),
('producto',2,12500,22),('servicio',1,45000,22),
('producto',3,36000,23),('producto',1,9500,23),
('servicio',1,60000,24),('producto',4,26000,24),
('producto',2,12500,25),('servicio',1,30000,25),
('servicio',1,70000,26),('producto',3,36000,26),
('producto',1,9500,27),('servicio',1,15000,27),
('producto',2,12500,28),('producto',5,35000,28),
('servicio',1,40000,29),('producto',3,36000,29),
('producto',1,9500,30),('servicio',1,45000,30)
;

-- After inserting detalle_paquete you may want to update paquete.precio by summing detalle_paquete.subtotal.
-- (optional) UPDATE paquete p SET precio = (SELECT IFNULL(SUM(dp.subtotal),0) FROM detalle_paquete dp WHERE dp.paquete_id = p.id);

-- 16) VENTAS (200) -- usuario 81..100 vendedor, cliente 1..80
INSERT INTO venta (usuario_id, cliente_id, fecha_venta, fecha_ingreso, total) VALUES
(81,1,'2024-03-01','2024-03-01 09:00:00',0),(82,2,'2024-03-01','2024-03-01 09:15:00',0),
(83,3,'2024-03-02','2024-03-02 10:00:00',0),(84,4,'2024-03-02','2024-03-02 10:30:00',0),
(85,5,'2024-03-03','2024-03-03 11:00:00',0),(86,6,'2024-03-03','2024-03-03 11:15:00',0),
(87,7,'2024-03-04','2024-03-04 12:00:00',0),(88,8,'2024-03-04','2024-03-04 12:30:00',0),
(89,9,'2024-03-05','2024-03-05 13:00:00',0),(90,10,'2024-03-05','2024-03-05 13:30:00',0),
(91,11,'2024-03-06','2024-03-06 14:00:00',0),(92,12,'2024-03-06','2024-03-06 14:30:00',0),
(93,13,'2024-03-07','2024-03-07 08:00:00',0),(94,14,'2024-03-07','2024-03-07 08:30:00',0),
(95,15,'2024-03-08','2024-03-08 09:00:00',0),(96,16,'2024-03-08','2024-03-08 09:30:00',0),
(97,17,'2024-03-09','2024-03-09 10:00:00',0),(98,18,'2024-03-09','2024-03-09 10:30:00',0),
(99,19,'2024-03-10','2024-03-10 11:00:00',0),(100,20,'2024-03-10','2024-03-10 11:30:00',0),
(81,21,'2024-03-11','2024-03-11 09:10:00',0),(82,22,'2024-03-11','2024-03-11 09:20:00',0),
(83,23,'2024-03-12','2024-03-12 09:30:00',0),(84,24,'2024-03-12','2024-03-12 09:40:00',0),
(85,25,'2024-03-13','2024-03-13 09:50:00',0),(86,26,'2024-03-13','2024-03-13 10:00:00',0),
(87,27,'2024-03-14','2024-03-14 10:10:00',0),(88,28,'2024-03-14','2024-03-14 10:20:00',0),
(89,29,'2024-03-15','2024-03-15 10:30:00',0),(90,30,'2024-03-15','2024-03-15 10:40:00',0),
(91,31,'2024-03-16','2024-03-16 10:50:00',0),(92,32,'2024-03-16','2024-03-16 11:00:00',0),
(93,33,'2024-03-17','2024-03-17 11:10:00',0),(94,34,'2024-03-17','2024-03-17 11:20:00',0),
(95,35,'2024-03-18','2024-03-18 11:30:00',0),(96,36,'2024-03-18','2024-03-18 11:40:00',0),
(97,37,'2024-03-19','2024-03-19 11:50:00',0),(98,38,'2024-03-19','2024-03-19 12:00:00',0),
(99,39,'2024-03-20','2024-03-20 12:10:00',0),(100,40,'2024-03-20','2024-03-20 12:20:00',0),
(81,41,'2024-03-21','2024-03-21 12:30:00',0),(82,42,'2024-03-21','2024-03-21 12:40:00',0),
(83,43,'2024-03-22','2024-03-22 12:50:00',0),(84,44,'2024-03-22','2024-03-22 13:00:00',0),
(85,45,'2024-03-23','2024-03-23 13:10:00',0),(86,46,'2024-03-23','2024-03-23 13:20:00',0),
(87,47,'2024-03-24','2024-03-24 13:30:00',0),(88,48,'2024-03-24','2024-03-24 13:40:00',0),
(89,49,'2024-03-25','2024-03-25 13:50:00',0),(90,50,'2024-03-25','2024-03-25 14:00:00',0),
(91,51,'2024-03-26','2024-03-26 14:10:00',0),(92,52,'2024-03-26','2024-03-26 14:20:00',0),
(93,53,'2024-03-27','2024-03-27 14:30:00',0),(94,54,'2024-03-27','2024-03-27 14:40:00',0),
(95,55,'2024-03-28','2024-03-28 14:50:00',0),(96,56,'2024-03-28','2024-03-28 15:00:00',0),
(97,57,'2024-03-29','2024-03-29 15:10:00',0),(98,58,'2024-03-29','2024-03-29 15:20:00',0),
(99,59,'2024-03-30','2024-03-30 15:30:00',0),(100,60,'2024-03-30','2024-03-30 15:40:00',0),
(81,61,'2024-03-31','2024-03-31 15:50:00',0),(82,62,'2024-03-31','2024-03-31 16:00:00',0),
(83,63,'2024-04-01','2024-04-01 16:10:00',0),(84,64,'2024-04-01','2024-04-01 16:20:00',0),
(85,65,'2024-04-02','2024-04-02 16:30:00',0),(86,66,'2024-04-02','2024-04-02 16:40:00',0),
(87,67,'2024-04-03','2024-04-03 16:50:00',0),(88,68,'2024-04-03','2024-04-03 17:00:00',0),
(89,69,'2024-04-04','2024-04-04 17:10:00',0),(90,70,'2024-04-04','2024-04-04 17:20:00',0),
(91,71,'2024-04-05','2024-04-05 17:30:00',0),(92,72,'2024-04-05','2024-04-05 17:40:00',0),
(93,73,'2024-04-06','2024-04-06 17:50:00',0),(94,74,'2024-04-06','2024-04-06 18:00:00',0),
(95,75,'2024-04-07','2024-04-07 18:10:00',0),(96,76,'2024-04-07','2024-04-07 18:20:00',0),
(97,77,'2024-04-08','2024-04-08 18:30:00',0),(98,78,'2024-04-08','2024-04-08 18:40:00',0),
(99,79,'2024-04-09','2024-04-09 18:50:00',0),(100,80,'2024-04-09','2024-04-09 19:00:00',0),
(81,1,'2024-04-10','2024-04-10 09:00:00',0),(82,2,'2024-04-10','2024-04-10 09:10:00',0),
(83,3,'2024-04-11','2024-04-11 09:20:00',0),(84,4,'2024-04-11','2024-04-11 09:30:00',0),
(85,5,'2024-04-12','2024-04-12 09:40:00',0),(86,6,'2024-04-12','2024-04-12 09:50:00',0),
(87,7,'2024-04-13','2024-04-13 10:00:00',0),(88,8,'2024-04-13','2024-04-13 10:10:00',0),
(89,9,'2024-04-14','2024-04-14 10:20:00',0),(90,10,'2024-04-14','2024-04-14 10:30:00',0),
(91,11,'2024-04-15','2024-04-15 10:40:00',0),(92,12,'2024-04-15','2024-04-15 10:50:00',0),
(93,13,'2024-04-16','2024-04-16 11:00:00',0),(94,14,'2024-04-16','2024-04-16 11:10:00',0),
(95,15,'2024-04-17','2024-04-17 11:20:00',0),(96,16,'2024-04-17','2024-04-17 11:30:00',0),
(97,17,'2024-04-18','2024-04-18 11:40:00',0),(98,18,'2024-04-18','2024-04-18 11:50:00',0),
(99,19,'2024-04-19','2024-04-19 12:00:00',0),(100,20,'2024-04-19','2024-04-19 12:10:00',0)
;

-- 17) DETALLE_VENTA (approx 2 filas por venta -> 400 rows)
-- We assume venta.id assigned sequentially starting at 1 for the 200 rows above
INSERT INTO detalle_venta (tipo_venta, codigo, cantidad, subtotal, venta_id) VALUES
('producto',1,1,9500,1),('servicio',1,1,30000,1),
('producto',2,2,25000,2),('producto',3,1,18000,2),
('paquete',1,1,49000,3),('producto',4,3,19500,3),
('servicio',2,1,15000,4),('producto',5,1,35000,4),
('producto',6,2,28000,5),('servicio',3,1,40000,5),
('producto',7,1,25000,6),('producto',8,4,16800,6),
('paquete',2,1,52000,7),('producto',9,1,7800,7),
('servicio',4,1,60000,8),('producto',10,1,19000,8),
('producto',11,2,24000,9),('servicio',5,1,80000,9),
('producto',12,1,11000,10),('producto',13,1,16000,10),
('servicio',6,1,55000,11),('producto',14,1,21000,11),
('producto',15,3,26400,12),('paquete',3,1,30000,12),
('producto',16,2,30000,13),('servicio',7,1,70000,13),
('producto',17,1,7200,14),('producto',18,1,42000,14),
('servicio',8,1,120000,15),('producto',19,1,31000,15),
('paquete',4,1,45000,16),('producto',20,2,19600,16),
('producto',21,1,10500,17),('servicio',9,1,90000,17),
('producto',22,2,23000,18),('producto',23,1,17000,18),
('servicio',10,1,250000,19),('producto',24,1,18500,19),
('producto',25,1,19500,20),('servicio',11,1,20000,20),
('producto',26,2,6000,21),('paquete',5,1,60000,21),
('producto',27,1,5000,22),('producto',28,1,23000,22),
('servicio',12,1,45000,23),('producto',29,2,50000,23),
('producto',30,1,21000,24),('producto',31,5,16000,24),
('servicio',13,1,65000,25),('producto',32,2,3500,25),
('paquete',6,1,70000,26),('producto',33,3,14400,26),
('producto',34,1,14500,27),('servicio',14,1,90000,27),
('producto',35,2,31000,28),('producto',36,1,17000,28),
('servicio',15,1,100000,29),('producto',37,1,19500,29),
('paquete',7,1,85000,30),('producto',38,2,21300,30),
('producto',39,1,23000,31),('servicio',16,1,95000,31),
('producto',40,3,30000,32),('producto',41,1,12500,32),
('servicio',17,1,50000,33),('producto',42,2,15200,33),
('paquete',8,1,98000,34),('producto',43,1,17800,34),
('producto',44,1,19500,35),('servicio',18,1,70000,35),
('producto',45,1,24000,36),('producto',46,1,27000,36),
('paquete',9,1,120000,37),('producto',47,1,30000,37),
('producto',48,1,33000,38),('servicio',19,1,110000,38),
('producto',49,1,36000,39),('producto',50,1,39000,39),
('servicio',20,1,130000,40),('paquete',10,1,150000,40),
-- (continúa para ventas 41..200, dos filas por venta)
('producto',1,2,19000,41),('servicio',1,1,30000,41),
('producto',2,1,12500,42),('producto',3,1,18000,42),
('paquete',2,1,52000,43),('producto',4,1,6500,43),
('servicio',2,1,15000,44),('producto',5,1,35000,44),
('producto',6,1,14000,45),('servicio',3,1,40000,45),
('producto',7,3,75000,46),('producto',8,2,8400,46),
('paquete',11,1,55000,47),('producto',9,1,7800,47),
('servicio',4,1,60000,48),('producto',10,2,38000,48),
('producto',11,1,12000,49),('servicio',5,1,80000,49),
('producto',12,2,22000,50),('paquete',12,1,70000,50),
('producto',13,1,16000,51),('servicio',6,1,55000,51),
('producto',14,1,21000,52),('producto',15,1,8800,52),
('paquete',13,1,76000,53),('producto',16,2,30000,53),
('servicio',7,1,70000,54),('producto',17,1,7200,54),
('producto',18,1,42000,55),('paquete',14,1,45000,55),
('servicio',8,1,120000,56),('producto',19,1,31000,56),
('producto',20,2,19600,57),('servicio',9,1,90000,57),
('producto',21,1,10500,58),('paquete',15,1,85000,58),
('producto',22,2,23000,59),('servicio',10,1,250000,59),
('producto',23,1,17000,60),('producto',24,1,18500,60),
('paquete',16,1,68000,61),('producto',25,2,39000,61),
('servicio',11,1,20000,62),('producto',26,3,18000,62),
('producto',27,1,5000,63),('paquete',17,1,72000,63),
('servicio',12,1,45000,64),('producto',28,1,23000,64),
('producto',29,1,25000,65),('servicio',13,1,65000,65),
('paquete',18,1,98000,66),('producto',30,1,21000,66),
('producto',31,4,12800,67),('servicio',14,1,90000,67),
('producto',32,1,3500,68),('paquete',19,1,70000,68),
('servicio',15,1,100000,69),('producto',33,1,4800,69),
('producto',34,2,29000,70),('servicio',16,1,95000,70),
('paquete',20,1,120000,71),('producto',35,1,15500,71),
('producto',36,1,17000,72),('servicio',17,1,50000,72),
('paquete',21,1,60000,73),('producto',37,2,39000,73),
('servicio',18,1,70000,74),('producto',38,1,21300,74),
('paquete',22,1,95000,75),('producto',39,1,23000,75),
('producto',40,1,10000,76),('servicio',19,1,110000,76),
('paquete',23,1,115000,77),('producto',41,1,12500,77),
('servicio',20,1,130000,78),('paquete',24,1,90000,78),
('producto',42,2,30400,79),('producto',43,1,17800,79),
('servicio',1,1,30000,80),('producto',44,1,19500,80),
('producto',45,1,24000,81),('paquete',25,1,76000,81),
('servicio',2,1,15000,82),('producto',46,1,27000,82),
('producto',47,1,30000,83),('servicio',3,1,40000,83),
('paquete',26,1,70000,84),('producto',48,1,33000,84),
('producto',49,1,36000,85),('servicio',4,1,60000,85),
('producto',50,1,39000,86),('paquete',27,1,100000,86),
('servicio',5,1,80000,87),('producto',51,1,42000,87),
('producto',52,1,45000,88),('servicio',6,1,55000,88),
('paquete',28,1,115000,89),('producto',53,1,48000,89),
('servicio',7,1,70000,90),('producto',54,1,51000,90),
('producto',55,1,54000,91),('paquete',29,1,125000,91),
('servicio',8,1,120000,92),('producto',56,1,57000,92),
('paquete',30,1,130000,93),('producto',57,1,60000,93),
('servicio',9,1,250000,94),('producto',58,1,63000,94),
('producto',59,1,66000,95),('servicio',10,1,90000,95),
('producto',60,1,69000,96),('paquete',1,1,49000,96),
('producto',61,1,72000,97),('servicio',11,1,20000,97),
('producto',62,1,75000,98),('producto',63,1,78000,98),
('servicio',12,1,45000,99),('producto',64,1,81000,99),
('producto',65,1,84000,100),('paquete',2,1,52000,100)
;

-- Optional: update venta totals by summing detalle_venta (run after inserts)
-- UPDATE venta v SET total = (SELECT IFNULL(SUM(dv.subtotal),0) FROM detalle_venta dv WHERE dv.venta_id = v.id);

-- 18) CITAS (150) -- veterinario 101..110, animal 1..200, vendedor(usuario) 81..100
INSERT INTO citas (veterinario_id, animal_id, fecha_inicio, fecha_fin, total, vendedor_id) VALUES
(101,1,'2024-05-01 08:00:00','2024-05-01 08:30:00',40000,81),(102,2,'2024-05-01 09:00:00','2024-05-01 09:45:00',60000,82),
(103,3,'2024-05-02 08:30:00','2024-05-02 09:00:00',35000,83),(104,4,'2024-05-02 09:15:00','2024-05-02 10:00:00',70000,84),
(105,5,'2024-05-03 10:00:00','2024-05-03 10:30:00',30000,85),(106,6,'2024-05-03 11:00:00','2024-05-03 11:40:00',90000,86),
(107,7,'2024-05-04 08:00:00','2024-05-04 08:20:00',15000,87),(108,8,'2024-05-04 09:00:00','2024-05-04 09:30:00',30000,88),
(109,9,'2024-05-05 09:30:00','2024-05-05 10:10:00',70000,89),(110,10,'2024-05-05 10:30:00','2024-05-05 11:15:00',120000,90),
(101,11,'2024-05-06 08:00:00','2024-05-06 08:45:00',40000,91),(102,12,'2024-05-06 09:00:00','2024-05-06 09:35:00',50000,92),
(103,13,'2024-05-07 10:00:00','2024-05-07 10:30:00',30000,93),(104,14,'2024-05-07 11:00:00','2024-05-07 11:45:00',80000,94),
(105,15,'2024-05-08 08:15:00','2024-05-08 08:45:00',25000,95),(106,16,'2024-05-08 09:15:00','2024-05-08 10:00:00',100000,96),
(107,17,'2024-05-09 09:00:00','2024-05-09 09:30:00',35000,97),(108,18,'2024-05-09 10:00:00','2024-05-09 10:45:00',60000,98),
(109,19,'2024-05-10 08:30:00','2024-05-10 09:00:00',45000,99),(110,20,'2024-05-10 09:30:00','2024-05-10 10:15:00',90000,100),
(101,21,'2024-05-11 08:00:00','2024-05-11 08:20:00',15000,81),(102,22,'2024-05-11 09:00:00','2024-05-11 09:40:00',65000,82),
(103,23,'2024-05-12 10:00:00','2024-05-12 10:30:00',30000,83),(104,24,'2024-05-12 11:00:00','2024-05-12 11:50:00',85000,84),
(105,25,'2024-05-13 08:15:00','2024-05-13 08:45:00',25000,85),(106,26,'2024-05-13 09:15:00','2024-05-13 10:10:00',95000,86),
(107,27,'2024-05-14 09:00:00','2024-05-14 09:30:00',30000,87),(108,28,'2024-05-14 10:00:00','2024-05-14 10:45:00',70000,88),
(109,29,'2024-05-15 08:30:00','2024-05-15 09:00:00',35000,89),(110,30,'2024-05-15 09:30:00','2024-05-15 10:20:00',120000,90),
(101,31,'2024-05-16 08:00:00','2024-05-16 08:30:00',40000,91),(102,32,'2024-05-16 09:00:00','2024-05-16 09:40:00',50000,92),
(103,33,'2024-05-17 10:00:00','2024-05-17 10:30:00',30000,93),(104,34,'2024-05-17 11:00:00','2024-05-17 11:45:00',80000,94),
(105,35,'2024-05-18 08:15:00','2024-05-18 08:45:00',25000,95),(106,36,'2024-05-18 09:15:00','2024-05-18 10:00:00',100000,96),
(107,37,'2024-05-19 09:00:00','2024-05-19 09:30:00',35000,97),(108,38,'2024-05-19 10:00:00','2024-05-19 10:45:00',60000,98),
(109,39,'2024-05-20 08:30:00','2024-05-20 09:00:00',45000,99),(110,40,'2024-05-20 09:30:00','2024-05-20 10:15:00',90000,100),
(101,41,'2024-05-21 08:00:00','2024-05-21 08:30:00',40000,81),(102,42,'2024-05-21 09:00:00','2024-05-21 09:45:00',60000,82),
(103,43,'2024-05-22 08:30:00','2024-05-22 09:00:00',35000,83),(104,44,'2024-05-22 09:15:00','2024-05-22 10:00:00',70000,84),
(105,45,'2024-05-23 10:00:00','2024-05-23 10:30:00',30000,85),(106,46,'2024-05-23 11:00:00','2024-05-23 11:40:00',90000,86),
(107,47,'2024-05-24 08:00:00','2024-05-24 08:20:00',15000,87),(108,48,'2024-05-24 09:00:00','2024-05-24 09:30:00',30000,88),
(109,49,'2024-05-25 09:30:00','2024-05-25 10:10:00',70000,89),(110,50,'2024-05-25 10:30:00','2024-05-25 11:15:00',120000,90),
(101,51,'2024-05-26 08:00:00','2024-05-26 08:45:00',40000,91),(102,52,'2024-05-26 09:00:00','2024-05-26 09:35:00',50000,92),
(103,53,'2024-05-27 10:00:00','2024-05-27 10:30:00',30000,93),(104,54,'2024-05-27 11:00:00','2024-05-27 11:45:00',80000,94),
(105,55,'2024-05-28 08:15:00','2024-05-28 08:45:00',25000,95),(106,56,'2024-05-28 09:15:00','2024-05-28 10:00:00',100000,96),
(107,57,'2024-05-29 09:00:00','2024-05-29 09:30:00',35000,97),(108,58,'2024-05-29 10:00:00','2024-05-29 10:45:00',60000,98),
(109,59,'2024-05-30 08:30:00','2024-05-30 09:00:00',45000,99),(110,60,'2024-05-30 09:30:00','2024-05-30 10:15:00',90000,100)
;

-- ======= FIN INSERTS MANUALES MASIVOS =======

ALTER TABLE producto ADD iva DOUBLE NOT NULL DEFAULT 0;
ALTER TABLE producto ADD precio_compra_iva DOUBLE NOT NULL DEFAULT 0;

DELIMITER $$
CREATE TRIGGER ins_prec_iva_prod 
BEFORE INSERT ON producto
FOR EACH ROW
BEGIN
  SET NEW.precio_compra_iva = NEW.precio_compra * ( 1 + ( NEW.iva/100 ) );
END; $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER validar_stock_producto_al_vender
BEFORE INSERT ON producto
FOR EACH ROW
BEGIN
DECLARE v_precio INT DEFAULT 0;
  DECLARE v_stock INT DEFAULT -1;

  IF NEW.tipo_venta = 'producto' THEN
  SELECT stock into v_stock FROM producto WHERE id=NEW.codigo;
    IF v_stock = -1 THEN
      SIGNAR sqlstate '45000' SET message_text = 'Producto no existe';
    ELSEIF NEW.cantidad > v_stock THEN
      SIGNAR sqlstate '45000' SET message_text = 'Producto no existe';
    ELSE
      SET NEW.subtotal = v_precio * NEW.cantidad;
  END IF;

END; $$
DELIMITER ;

ALTER TABLE producto ADD alert INT DEFAULT 5;
ALTER TABLE producto ADD estado VARCHAR(50) DEFAULT 'ACTIVO';

DELIMITER $$
CREATE EVENT actualizar_estado_producto
ON SCHEDULE EVERY 1 DAY STARTS NOW() + INTERVAL 10 SECOND
DO
BEGIN
  UPDATE producto
  SET estado = 'ACTIVO'
  WHERE stock > alert;

  UPDATE producto
  SET estado = 'POR AGOTAR'
  WHERE stock < alert;

  UPDATE producto
  SET estado = 'AGOTADO'
  WHERE stock = 0;
END; $$
DELIMITER ;

