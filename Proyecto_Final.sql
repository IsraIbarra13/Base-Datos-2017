-- tables
-- Table: Empleado
CREATE TABLE Empleado (
    No_empleado int NOT NULL,
    Nombre varchar(70) NOT NULL,
    Apellido_Paterno varchar(40)  NOT NULL,
    Apellido_Materno varchar(40)  NULL,
    Direccion varchar(150) NULL,
	Fecha_nacimiento Date  NOT NULL,
    CONSTRAINT Empleado_pk 
        PRIMARY KEY (No_empleado)
);

-- Table: Area
CREATE TABLE Area (
    ID int NOT NULL unique,
    Nombre varchar(50) UNIQUE NOT NULL,
    CONSTRAINT Area_pk PRIMARY KEY (ID)
);

-- Table: Estatus
CREATE TABLE Estatus (
	ID int NOT NULL unique,
    Nombre varchar(50) unique NOT NULL,
    Descripcion varchar(500) NOT NULL,
    CONSTRAINT Estatus_pk PRIMARY KEY (ID)
);

--Table: Cuenta
CREATE TABLE Cuenta (
	ID int unique NOT NULL,
	Usuario varchar(100) unique NOT NULL,
	PasswordCuenta varchar(700) NOT NULL,
	NivelAutorizacion int NOT NULL,
	CONSTRAINT Cuenta_pk PRIMARY KEY (ID)
);

-- Table: Profesor
CREATE TABLE Profesor (
    Empleado_No_empleado int unique NOT NULL,	
	Cuenta_ID int NULL,
    Estatus_ID int NOT NULL,
    Area_ID int NOT NULL,
    GradoEstudio varchar(100)  NOT NULL,
    CONSTRAINT Profesor_pk 
		PRIMARY KEY (Empleado_No_empleado),
	CONSTRAINT Profesor_Cuenta
		FOREIGN KEY (Cuenta_ID)
		REFERENCES Cuenta (ID),
	CONSTRAINT Profesor_Estatus
		FOREIGN KEY (Estatus_ID)
		REFERENCES Estatus (ID),
	CONSTRAINT Profesor_Empleado
		FOREIGN KEY (Empleado_No_empleado)
		REFERENCES Empleado (No_empleado),
	CONSTRAINT Profesor_Area
		FOREIGN KEY (Area_ID)
		REFERENCES Area (ID) 
);

-- Table: Cliente
CREATE TABLE Cliente (
    ID int unique NOT NULL,
    Nombre varchar(70)  NOT NULL,
    Apellido_Paterno varchar(40)  NOT NULL,
    Apellido_Materno varchar(40)  NULL,
    Correo varchar(100) NOT NULL,
	Direccion varchar(150) NULL,
    Fecha_nacimiento Date  NOT NULL,
    Estatus_ID INT NOT NULL,
    CONSTRAINT Cliente_pk 
		PRIMARY KEY (ID),
	CONSTRAINT Cliente_Estatus
		FOREIGN KEY (Estatus_ID)
		REFERENCES Estatus (ID)
);

-- Table: Materia
CREATE TABLE Materia (
    Clave int unique NOT NULL,
    Nombre varchar(50) NOT NULL,
    Hora_semanal smallint  NOT NULL,
    Grado smallint  NOT NULL,
    Area_ID int  NOT NULL,
    CONSTRAINT Materia_pk 
		PRIMARY KEY (Clave),
	CONSTRAINT Materia_Area
		FOREIGN KEY (Area_ID)
		REFERENCES Area (ID) 
);

CREATE TABLE Tipo_Aula(
	ID int unique NOT NULL,
	TIPO VARCHAR(50) UNIQUE NOT NULL,
	CONSTRAINT Tipo_pk
		PRIMARY KEY (ID)
);

-- Table: Aula
CREATE TABLE Aula (
    Numero int unique NOT NULL,
    Capacidad smallint  NOT NULL,
	Tipo_aula int NOT NULL,
    CONSTRAINT Aula_pk 
		PRIMARY KEY (Numero),
	CONSTRAINT Tipo_fk
		FOREIGN KEY (Tipo_aula)
		REFERENCES Tipo_aula (ID)
);

-- Table: Curso
CREATE TABLE Curso (
    Clave int unique NOT NULL,
    Aula_Numero int  NOT NULL,-----Para tabla paquetes
    Profesor_Empleado_No_empleado int  NOT NULL,
    CONSTRAINT Curso_pk 
		PRIMARY KEY (Clave),
	CONSTRAINT Curso_Aula
		FOREIGN KEY (Aula_Numero)
		REFERENCES Aula (Numero),
	CONSTRAINT Curso_Profesor
		FOREIGN KEY (Profesor_Empleado_No_empleado)
		REFERENCES Profesor (Empleado_No_empleado)
);

-- Table: Horario
CREATE TABLE Horario (
    Clave int identity(1,1) NOT NULL,
    Hora_inicio Time NOT NULL,
    Hora_fin Time NOT NULL,
    Dia varchar(15) NOT NULL,
    CONSTRAINT Horario_pk 
		PRIMARY KEY (Clave)
);

-- Table: Curso_Horario
CREATE TABLE Curso_Horario (
    Curso_Clave int NOT NULL,
    Horario_Clave int NOT NULL,
    CONSTRAINT Curso_Horario_pk 
		PRIMARY KEY (Curso_Clave,Horario_Clave),
	CONSTRAINT Curso_Horario_Curso
		FOREIGN KEY (Curso_Clave)
		REFERENCES Curso (Clave),
	CONSTRAINT Curso_Horario_Horario
		FOREIGN KEY (Horario_Clave)
		REFERENCES Horario (Clave) 
);

-- Table: Grupo
CREATE TABLE Grupo (
	ID int unique NOT NULL,
    Curso_Clave int NOT NULL,
    Calificacion numeric(4,2) NULL,
    Cliente_ID int  NOT NULL,
    CONSTRAINT Grupo_pk 
		PRIMARY KEY (ID),
	CONSTRAINT Grupo_Estudiante
		FOREIGN KEY (Cliente_ID)
		REFERENCES Cliente (ID),
	CONSTRAINT Inscripcion_Curso
		FOREIGN KEY (Curso_Clave)
		REFERENCES Curso (Clave)   
);

-- Table: Clases
CREATE TABLE Clases (
	Materia_Clave int NOT NULL,
	Curso_Clave int NOT NULL,
	CONSTRAINT Clases_pk
		PRIMARY KEY (Materia_Clave,Curso_Clave),
	CONSTRAINT Clases_Materia
		FOREIGN KEY (Materia_Clave)
		REFERENCES Materia (Clave),
	CONSTRAINT Clases_Curso
		FOREIGN KEY (Curso_Clave)
		REFERENCES Curso (Clave)
);

/*Inserta las areas que abarca los cursos*/
INSERT [dbo].[Area] ([ID], [Nombre]) VALUES (6, N'Arte y Cultura')
INSERT [dbo].[Area] ([ID], [Nombre]) VALUES (3, N'Ciencias Naturales')
INSERT [dbo].[Area] ([ID], [Nombre]) VALUES (4, N'Ciencias Sociales')
INSERT [dbo].[Area] ([ID], [Nombre]) VALUES (5, N'Deportes')
INSERT [dbo].[Area] ([ID], [Nombre]) VALUES (2, N'Español')
INSERT [dbo].[Area] ([ID], [Nombre]) VALUES (1, N'Matematicas')

INSERT INTO Materia VALUES(1,'Español I',4,1,2);
INSERT INTO Materia VALUES(2,'Español II',4,2,2);
INSERT INTO Materia VALUES(3,'Español III',4,3,2);
INSERT INTO Materia VALUES(4,'Biologia',3,1,3);
INSERT INTO Materia VALUES(5,'Fisica',3,2,3);
INSERT INTO Materia VALUES(6,'Quimica',3,3,3);
INSERT INTO Materia VALUES(7,'Matematicas I',5,1,1);
INSERT INTO Materia VALUES(8,'Matematicas II',5,2,1);
INSERT INTO Materia VALUES(9,'Matematicas III',5,3,1);
INSERT INTO Materia VALUES(10,'Cultura Física y Salud I',2,1,5);
INSERT INTO Materia VALUES(11,'Cultura Física y Salud II',2,2,5);
INSERT INTO Materia VALUES(12,'Cultura Física y Salud III',2,3,5);
INSERT INTO Materia VALUES(13,'Historia del mundo',4,2,4);
INSERT INTO Materia VALUES(14,'Historia de mexico',4,3,4);
INSERT INTO Materia VALUES(15,'Musica',1,3,6);

/*Abarca el el estatus de profesores, aspirantes y egresados*/
INSERT [dbo].[Estatus] ([ID], [Nombre], [Descripcion]) VALUES (1, N'baja', N'profesor,alumno')
INSERT [dbo].[Estatus] ([ID], [Nombre], [Descripcion]) VALUES (2, N'jubilado', N'profesor')
INSERT [dbo].[Estatus] ([ID], [Nombre], [Descripcion]) VALUES (3, N'activo', N'profesor')
INSERT [dbo].[Estatus] ([ID], [Nombre], [Descripcion]) VALUES (4, N'inscrito', N'alumno')
INSERT [dbo].[Estatus] ([ID], [Nombre], [Descripcion]) VALUES (5, N'suspendido', N'alumno')
INSERT [dbo].[Estatus] ([ID], [Nombre], [Descripcion]) VALUES (6, N'revalidante', N'alumno: es alumno, pero reprobo todos sus cursos')
INSERT [dbo].[Estatus] ([ID], [Nombre], [Descripcion]) VALUES (7, N'solicitante', N'cliente : Al momento de ingresar sus datos')
INSERT [dbo].[Estatus] ([ID], [Nombre], [Descripcion]) VALUES (8, N'en proceso', N'cliente: Cuando aun no ha pagado.')
INSERT [dbo].[Estatus] ([ID], [Nombre], [Descripcion]) VALUES (9, N'aceptado', N'cliente: Despues de haber pagado. Un dia despues se vuelve inscrito')

/*Del 9 al 108 son los usuarios para los profesores
Y del 1 al 8 los usuarios estandars para pruebas y acceso rapido*/
INSERT INTO Cuenta([ID],[Usuario],[PasswordCuenta],[NivelAutorizacion]) VALUES(9,'Nam.ligula.elit@convallisest.ca','GHQ09LRX3WM',2),(10,'suscipit.nonummy.Fusce@tortornibhsit.org','PKE25LJA4WM',2),(11,'orci.Donec@Integervitaenibh.co.uk','KWT98ZJQ7AW',2),(12,'vestibulum.nec@Phasellusdapibus.com','LAG88IKI1FF',2),(13,'arcu.Nunc.mauris@Crasdictumultricies.net','OTF09OMB0JR',2),(14,'faucibus@Aeneanegestas.com','UQC57ZAS2FV',2),(15,'gravida.nunc.sed@feugiat.net','BMG70MCD7UH',2),(16,'malesuada.fames.ac@malesuada.edu','FXI40PEI6NJ',2),(17,'lorem.vitae@semutcursus.com','KDL16NHX2LR',2),(18,'sed.turpis.nec@interdumlibero.co.uk','YKM97GZU9FC',2);
INSERT INTO Cuenta([ID],[Usuario],[PasswordCuenta],[NivelAutorizacion]) VALUES(19,'mi@cursusnonegestas.org','UXY00XQT9WA',2),(20,'Cras@aliquetPhasellusfermentum.edu','FVI53ULC4FJ',2),(21,'habitant.morbi@vulputate.co.uk','HXE91ALI5AV',2),(22,'egestas.Duis.ac@seddictum.ca','OLL84PGI1CB',2),(23,'pellentesque.massa@Praesent.org','DUZ04PJK5WD',2),(24,'tempus.non@velmaurisInteger.org','ATI16DWV8LB',2),(25,'vitae@Pellentesquehabitant.com','SIL55VOJ9ZC',2),(26,'nascetur.ridiculus.mus@necdiam.net','VDY27CJW5YV',2),(27,'sagittis@dapibus.com','RUP69LZA4RH',2),(28,'Cum.sociis@semNullainterdum.com','RHI95XJY8IO',2);
INSERT INTO Cuenta([ID],[Usuario],[PasswordCuenta],[NivelAutorizacion]) VALUES(29,'Donec.egestas.Duis@nuncestmollis.org','SKC36LGD9KR',2),(30,'Sed.nunc@euturpisNulla.ca','VWH71NNT5BP',2),(31,'mi.Duis.risus@Nullamvitaediam.com','EMT94QPX5YC',2),(32,'egestas.ligula@dictumsapien.net','UNO85CTN7XV',2),(33,'blandit.at@turpis.edu','SKH62YRD7FM',2),(34,'magna@semut.org','BMM16LUY6NC',2),(35,'mi.fringilla.mi@tincidunt.edu','SGD09LWM2FF',2),(36,'semper.tellus@risus.edu','XUO96GOE8EO',2),(37,'lobortis@Donecfelisorci.org','CPN69FWC0FN',2),(38,'vitae.dolor@Nullamvitaediam.co.uk','YYA44MTC0LL',2);
INSERT INTO Cuenta([ID],[Usuario],[PasswordCuenta],[NivelAutorizacion]) VALUES(39,'sodales@nisinibh.edu','VGF78YGB4ZR',2),(40,'felis.ullamcorper@ut.com','LBO75ZWP5SJ',2),(41,'lacus@Aeneaneget.edu','KAW64DRO5YM',2),(42,'dictum.eleifend@eu.edu','APN23CDY9UU',2),(43,'turpis.vitae@a.co.uk','WCB63FOF8KA',2),(44,'dui.Fusce.aliquam@tristiqueneque.co.uk','LGW09YRM2AJ',2),(45,'et.rutrum@Duis.edu','QKH45MHR7IO',2),(46,'lectus.pede@Integeraliquam.com','BXI86VAH3KO',2),(47,'Aliquam@a.com','ICD07XCC5RG',2),(48,'nisl@Vivamusnibhdolor.ca','OGT46YUU8AY',2);
INSERT INTO Cuenta([ID],[Usuario],[PasswordCuenta],[NivelAutorizacion]) VALUES(49,'dui@Vivamusmolestie.edu','JHR88HBM1LK',2),(50,'Ut.tincidunt.orci@consectetueradipiscing.org','NEW07PBP4SA',2),(51,'penatibus.et@lacus.org','TQV83NQF7VN',2),(52,'dictum@orciluctus.edu','OQV05OJK2GF',2),(53,'et@ametluctusvulputate.edu','XGS78OIQ5XM',2),(54,'fermentum@loremipsum.com','OBX63SWF9QW',2),(55,'nunc@porttitorvulputate.co.uk','IDM53XQR7JI',2),(56,'hendrerit.Donec.porttitor@laoreetlectusquis.ca','UQO96NHX0TY',2),(57,'sociis@accumsan.co.uk','YNT41IOA5HK',2),(58,'lacus@conguea.co.uk','YFX60JIN1KJ',2);
INSERT INTO Cuenta([ID],[Usuario],[PasswordCuenta],[NivelAutorizacion]) VALUES(59,'at@leoVivamusnibh.ca','TFB81ALJ9AZ',2),(60,'Integer.eu.lacus@Mauris.ca','LOA94VAY7XG',2),(61,'Mauris@Suspendissecommodotincidunt.ca','DEO41OJO2DP',2),(62,'turpis.In@Aliquamtinciduntnunc.edu','LER21HND2ZT',2),(63,'dui.Fusce.aliquam@quis.com','EYQ94BZV9TX',2),(64,'orci.Ut@CuraePhasellusornare.edu','KAQ63ZMA3YP',2),(65,'Duis.volutpat@tempor.co.uk','KWR47FKS0DN',2),(66,'tristique.pellentesque@maurisa.ca','JAY46SVP3ZF',2),(67,'ipsum.non@consequat.com','UHG20PJD0VE',2),(68,'nisi@elit.com','ZRR91LCK7DX',2);
INSERT INTO Cuenta([ID],[Usuario],[PasswordCuenta],[NivelAutorizacion]) VALUES(69,'est.ac.mattis@famesacturpis.edu','QDM90QUS7IB',2),(70,'tristique.senectus@doloregestasrhoncus.edu','RDP32RLP8WO',2),(71,'a@diamnunc.ca','WJL15BQU3UF',2),(72,'auctor@est.co.uk','WJR87GYC1WA',2),(73,'arcu.et@mieleifend.ca','ZUF23UNX9JM',2),(74,'Sed@ullamcorpereu.ca','VWC73AAN2GV',2),(75,'lacus.varius.et@imperdietdictum.net','IEX92HPH9IJ',2),(76,'sed.sem.egestas@etrutrum.com','CEC15IFF3DL',2),(77,'Donec.sollicitudin.adipiscing@eu.co.uk','KGV24VPY9FH',2),(78,'arcu.iaculis.enim@Nunc.edu','DPC11NCU0VW',2);
INSERT INTO Cuenta([ID],[Usuario],[PasswordCuenta],[NivelAutorizacion]) VALUES(79,'justo.Praesent.luctus@pellentesque.net','WCI00GQX4YU',2),(80,'elit.Nulla@sitametrisus.net','RLG84TGN5QP',2),(81,'blandit.viverra@quam.co.uk','ERO24IVQ4WU',2),(82,'Pellentesque.habitant.morbi@nuncullamcorper.com','DAY04QBT8AY',2),(83,'sed.dolor@eueros.com','KRB01LJD8BI',2),(84,'vel.venenatis.vel@ligulaNullamfeugiat.com','ESU35NES3HY',2),(85,'dolor@morbi.com','UMJ57FJP5YD',2),(86,'a.aliquet.vel@erosProinultrices.org','NQM43WNU1GF',2),(87,'tincidunt@egestasDuis.co.uk','RAH99FUC7AF',2),(88,'quis.diam.Pellentesque@duiCumsociis.edu','HKB31SUX7ZH',2);
INSERT INTO Cuenta([ID],[Usuario],[PasswordCuenta],[NivelAutorizacion]) VALUES(89,'sem.ut@vulputate.co.uk','RZB69EHQ6BP',2),(90,'a.nunc@eueratsemper.com','CDG13PDM5SY',2),(91,'Aliquam@quis.net','MBS84FMB0HS',2),(92,'vel@erosnectellus.com','VGF81CAW7GC',2),(93,'magna.Praesent@viverraMaecenasiaculis.co.uk','ZKZ39HDX3XS',2),(94,'fermentum.fermentum@consequat.net','XCJ78NPH8II',2),(95,'massa@facilisismagnatellus.net','HJR51JTV4FY',2),(96,'rutrum.magna@elit.org','OSW92KTP1VL',2),(97,'augue.eu.tempor@diam.co.uk','ZBB97QES5NK',2),(98,'dui@leoVivamusnibh.com','MYA48BUQ7XE',2);
INSERT INTO Cuenta([ID],[Usuario],[PasswordCuenta],[NivelAutorizacion]) VALUES(99,'fermentum@quisarcuvel.net','ACO14SFT2LU',2),(100,'interdum@magnaDuisdignissim.org','BUG62HST3MP',2),(101,'Duis@metussit.net','GTY50KAQ9DD',2),(102,'Sed@ultriciesligula.com','LWN30UZI6SK',2),(103,'aliquet.odio@sedfacilisisvitae.edu','NKP91EWJ3BD',2),(104,'augue@arcuMorbi.edu','TPN18EFB8KI',2),(105,'tempus@vehicula.com','FLC14JLI2WZ',2),(106,'eros.turpis@Nullasemper.edu','AOC40HNS8TQ',2),(107,'Suspendisse.aliquet@lectus.co.uk','SAM56RPD4AO',2),(108,'montes@egestas.org','XJO87IPT6PT',2);

/*
Del 1000 al 1199 son empleados(profesores)
Del 1200 al 1229 son personal en general(secretarias, intendentes etc)
*/

INSERT INTO Empleado([No_empleado],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Direccion],[Fecha_nacimiento]) VALUES(1000,'Penelope','England','Gibbs','Apdo.:718-9158 Ligula. C.','1991/02/02'),(1001,'Sarah','Vinson','Rasmussen','Apartado núm.: 324, 7681 Metus C/','1987/11/09'),(1002,'Laurel','Alexander','Franco','Apdo.:863-2467 Mattis Av.','1986/02/20'),(1003,'Shelly','Gay','Hendricks','7915 Eros C/','1988/02/26'),(1004,'Kiayada','Roth','Cabrera','Apdo.:269-5265 Mauris Av.','1995/02/24'),(1005,'Jane','Pate','Sweeney','496-4400 Nunc Carretera','1995/04/23'),(1006,'Kelsey','Blankenship','Maldonado','7273 In Av.','1993/04/30'),(1007,'Hiroko','Palmer','Kline','Apdo.:513-5757 Orci. C.','1995/04/15'),(1008,'Wyatt','Rollins','Dodson','Apartado núm.: 323, 6411 Adipiscing Avenida','1982/09/06'),(1009,'Ingrid','Snider','Delgado','Apdo.:511-2076 Eu C/','1990/11/02');
INSERT INTO Empleado([No_empleado],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Direccion],[Fecha_nacimiento]) VALUES(1010,'Amena','Rodriquez','Haynes','Apdo.:973-934 Iaculis C.','1993/12/14'),(1011,'Lara','Lyons','Price','5977 Sodales Ctra.','1992/03/10'),(1012,'Xenos','Powell','Lane','178-4428 Non Avda.','1990/10/09'),(1013,'Roanna','Mosley','Lawrence','931-7016 Eros ','1980/09/06'),(1014,'Zeph','Lawrence','Dunlap','1693 Nec Carretera','1982/05/16'),(1015,'Ferris','Barlow','Farley','Apartado núm.: 417, 3741 Lacinia Ctra.','1991/02/13'),(1016,'Hyacinth','Carrillo','Harrell','1360 Tempus Ctra.','1988/11/25'),(1017,'Ashton','Hess','Marsh','4459 Nullam Ctra.','1984/05/07'),(1018,'Cain','Castillo','Knapp','Apartado núm.: 398, 5562 Pellentesque C.','1993/07/26'),(1019,'Richard','Mcmillan','Kirk','714-6391 Magnis Carretera','1980/09/27');
INSERT INTO Empleado([No_empleado],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Direccion],[Fecha_nacimiento]) VALUES(1020,'Wing','Conner','Koch','178 Eleifend, C/','1994/03/13'),(1021,'Micah','Merritt','Cunningham','Apdo.:699-4072 Nisi ','1990/06/03'),(1022,'Scarlett','Montgomery','Hinton','698 In Avda.','1991/08/09'),(1023,'Audra','Kline','Rich','579-8483 Massa. Avenida','1990/02/21'),(1024,'Owen','Higgins','Mccullough','817-3266 Penatibus C.','1982/03/28'),(1025,'Benedict','Vazquez','Carpenter','Apartado núm.: 466, 4859 Ut C/','1991/09/21'),(1026,'Warren','Ellis','Oliver','108-6559 Pharetra C/','1994/09/27'),(1027,'Jenna','Ferrell','Wilkerson','Apdo.:661-2773 Odio Carretera','1981/03/24'),(1028,'Jack','Palmer','Grimes','5303 Nisi. Avda.','1984/02/25'),(1029,'Abra','Brewer','Mcintosh','Apartado núm.: 664, 3845 Sodales. Av.','1993/12/12');
INSERT INTO Empleado([No_empleado],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Direccion],[Fecha_nacimiento]) VALUES(1030,'Theodore','Lynn','Pittman','Apartado núm.: 952, 9465 Ac Calle','1993/01/08'),(1031,'Ferris','Whitfield','Terry','Apdo.:602-9325 Fringilla C.','1983/01/07'),(1032,'Beatrice','Knight','Weiss','Apdo.:411-4673 Tristique Calle','1990/11/13'),(1033,'Xenos','Fuller','Burnett','9786 Sed Av.','1993/04/27'),(1034,'Dahlia','Bradshaw','Kline','Apdo.:177-3052 Aliquam Ctra.','1985/10/26'),(1035,'Fiona','Finley','Reynolds','9313 Enim Carretera','1992/04/19'),(1036,'David','Mckenzie','Kelley','Apartado núm.: 509, 5228 Sed Ctra.','1990/06/09'),(1037,'Gage','Bright','Malone','Apartado núm.: 705, 1541 Dui Avenida','1993/02/22'),(1038,'Keiko','Hampton','Mckenzie','Apdo.:365-2192 Ac C/','1987/05/12'),(1039,'Malik','Obrien','Parrish','Apartado núm.: 367, 2147 Ornare. Calle','1985/12/22');
INSERT INTO Empleado([No_empleado],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Direccion],[Fecha_nacimiento]) VALUES(1040,'Cody','Finley','Sargent','429-5850 Ipsum Carretera','1981/09/28'),(1041,'Acton','Bush','Cash','Apdo.:808-3535 Nec Av.','1987/02/21'),(1042,'Natalie','Kirk','Moss','Apdo.:620-1088 Quisque ','1988/09/22'),(1043,'Colorado','Drake','Pratt','Apdo.:524-2623 Eleifend Calle','1981/11/12'),(1044,'Hasad','Fuller','Mcmahon','Apdo.:583-4710 Elit. Carretera','1990/08/03'),(1045,'Angelica','Wolf','Hanson','Apdo.:281-3222 Lobortis Carretera','1986/02/18'),(1046,'Kirestin','Love','Hatfield','Apartado núm.: 325, 1992 Pellentesque Ctra.','1990/02/10'),(1047,'Matthew','Webb','Ayala','Apdo.:311-2436 Augue Carretera','1983/09/27'),(1048,'Melvin','Cardenas','Church','138-3897 Eleifend Avenida','1987/01/06'),(1049,'Daryl','Burnett','Fuller','224-1173 Fusce Avenida','1989/09/26');
INSERT INTO Empleado([No_empleado],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Direccion],[Fecha_nacimiento]) VALUES(1050,'Rogan','Jacobson','Clayton','967-2614 Sed Carretera','1983/09/11'),(1051,'Serina','Day','Ray','Apartado núm.: 151, 6284 Rutrum Calle','1980/05/10'),(1052,'Heather','Carr','Potts','Apdo.:343-5820 Cursus Av.','1986/11/21'),(1053,'Azalia','Conway','Stevenson','8404 Diam Calle','1994/04/19'),(1054,'Melissa','Serrano','Blankenship','828-4664 Elit, Avenida','1991/11/07'),(1055,'Jelani','Tran','Morris','Apartado núm.: 388, 5382 Velit. Ctra.','1989/06/12'),(1056,'Otto','Hayden','Richard','Apartado núm.: 514, 4956 Ridiculus Avenida','1985/11/06'),(1057,'Hedley','Cameron','Shepherd','Apartado núm.: 625, 2654 Bibendum ','1982/06/06'),(1058,'Jasper','Becker','Casey','726-5962 Sit Av.','1994/01/19'),(1059,'Leah','Harper','Knapp','Apdo.:763-237 Est. ','1988/05/12');
INSERT INTO Empleado([No_empleado],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Direccion],[Fecha_nacimiento]) VALUES(1060,'Lucian','Ochoa','Maxwell','Apdo.:411-9829 Pharetra Avenida','1993/10/26'),(1061,'Shay','Long','Christensen','9957 Blandit Avenida','1993/03/23'),(1062,'Kyle','Johns','Grant','5986 Aliquam ','1986/07/13'),(1063,'Chloe','Grimes','Cunningham','546 Nunc C.','1989/07/09'),(1064,'Patience','Boyle','Stein','806-8610 Euismod Avenida','1984/02/17'),(1065,'Ulric','Fisher','Joyce','Apdo.:483-846 Vulputate Avda.','1987/11/20'),(1066,'Jelani','Kirby','Hull','Apartado núm.: 728, 1362 Volutpat ','1995/04/07'),(1067,'Idola','Buckley','Ratliff','Apdo.:996-8932 Mauris Carretera','1988/08/28'),(1068,'Isaac','Barlow','Perkins','383-7230 Odio, Carretera','1995/03/20'),(1069,'Colorado','Bright','Knight','720-1495 Inceptos Avenida','1981/07/12');
INSERT INTO Empleado([No_empleado],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Direccion],[Fecha_nacimiento]) VALUES(1070,'Xavier','Massey','Dyer','Apartado núm.: 117, 9222 Justo. Av.','1990/02/08'),(1071,'Octavius','Atkinson','Johnson','Apdo.:594-7432 Mi Av.','1995/01/04'),(1072,'Martin','Shepard','Coffey','Apartado núm.: 906, 4403 Tincidunt Ctra.','1982/09/02'),(1073,'Willa','Savage','Sosa','Apdo.:288-489 Lacinia Calle','1985/11/03'),(1074,'Laith','Richmond','Mccoy','Apartado núm.: 469, 6192 Fringilla Calle','1980/07/15'),(1075,'Cameron','Martin','Hobbs','Apartado núm.: 442, 3507 Dictum C.','1990/11/23'),(1076,'Darryl','Buckley','Russo','296-7205 Nec Avda.','1992/06/14'),(1077,'Cleo','Bird','Holland','4331 Leo. C/','1995/06/04'),(1078,'Quynn','Cardenas','Walsh','362-4779 Ornare Ctra.','1987/03/26'),(1079,'Grant','Petersen','Bray','128-5790 Urna, C.','1988/08/27');
INSERT INTO Empleado([No_empleado],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Direccion],[Fecha_nacimiento]) VALUES(1080,'Elijah','Mcknight','James','Apartado núm.: 472, 4208 Odio, ','1983/09/30'),(1081,'Lev','Conrad','Wilkins','9035 Est, Avda.','1992/07/20'),(1082,'Flavia','Hutchinson','Sparks','7179 Ullamcorper, ','1988/08/25'),(1083,'Timothy','Gilbert','Savage','Apdo.:587-7769 Molestie Avenida','1982/09/11'),(1084,'Amethyst','Bean','Branch','981-9380 Orci. ','1984/04/05'),(1085,'Hamish','Vaughn','Benton','Apartado núm.: 674, 5996 Ac C/','1991/12/15'),(1086,'Todd','Wynn','Davenport','Apartado núm.: 797, 855 Egestas C/','1991/03/25'),(1087,'Desirae','Cochran','Barton','Apdo.:632-2641 A Calle','1984/05/17'),(1088,'Callum','Lawson','Mclaughlin','135-3452 Consectetuer ','1982/05/10'),(1089,'Randall','Parsons','Sweeney','Apartado núm.: 686, 9948 Libero Calle','1987/12/01');
INSERT INTO Empleado([No_empleado],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Direccion],[Fecha_nacimiento]) VALUES(1090,'Aquila','Cline','Mann','3728 Orci. Calle','1986/06/19'),(1091,'Eric','Bauer','Marquez','Apartado núm.: 229, 6906 Fusce Avenida','1987/03/10'),(1092,'Zelda','Bates','Lott','6212 Arcu. Av.','1987/01/01'),(1093,'Zena','Wallace','Snow','8019 Lectus. Ctra.','1980/02/12'),(1094,'Nash','Fleming','Adams','6748 Egestas. Calle','1994/02/09'),(1095,'Sonia','Hines','Love','Apdo.:577-4632 Erat. C.','1982/01/25'),(1096,'Quinn','Sloan','Stevenson','Apartado núm.: 968, 2876 A, C.','1993/06/27'),(1097,'Carol','Gallagher','Blanchard','7205 Libero. Carretera','1989/06/30'),(1098,'Jelani','Conrad','Golden','Apartado núm.: 769, 8181 Eu C.','1981/04/13'),(1099,'Basil','Benjamin','Dickerson','Apdo.:996-9990 Molestie Ctra.','1990/04/09');
INSERT INTO Empleado([No_empleado],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Direccion],[Fecha_nacimiento]) VALUES(1100,'Peter','Hines','Mathews','1438 Fermentum C/','1982/10/23'),(1101,'Ivan','Wise','Mercado','Apdo.:267-6299 Curae; C/','1985/09/09'),(1102,'Hedy','Alvarado','Swanson','5615 Morbi Carretera','1990/10/08'),(1103,'Salvador','Pugh','Cleveland','3292 Pharetra, C.','1992/09/16'),(1104,'Colton','Rowe','Olsen','1590 Aliquam C.','1980/06/21'),(1105,'Yoshi','Christensen','Howe','835-2664 Nisi. C/','1990/03/07'),(1106,'Briar','Walter','Chapman','241-5510 Dictum Calle','1984/05/10'),(1107,'Kelly','Bradley','Herring','568-5707 In Av.','1983/04/15'),(1108,'Jillian','Le','Hughes','827-157 Massa. Av.','1987/11/20'),(1109,'Victor','Collins','Chaney','3025 Nec C/','1984/07/31');
INSERT INTO Empleado([No_empleado],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Direccion],[Fecha_nacimiento]) VALUES(1110,'Linus','Aguilar','Sexton','Apdo.:475-9457 Proin Carretera','1993/07/27'),(1111,'Kessie','Hunt','Wall','Apdo.:518-3992 In C/','1983/08/06'),(1112,'Zeph','Ashley','Montoya','289-6640 Dictum Av.','1984/03/02'),(1113,'Cullen','Hunter','Winters','Apartado núm.: 994, 9869 Vivamus Avenida','1985/09/07'),(1114,'Connor','Mills','Tillman','Apdo.:918-1360 Consequat C.','1993/12/05'),(1115,'Beau','Sears','Vaughan','2028 Ac Avda.','1991/04/22'),(1116,'Sonia','Booth','Yang','188-7723 Sit Av.','1991/12/09'),(1117,'Elmo','Ballard','Cabrera','8089 Lacus. Av.','1982/07/26'),(1118,'Trevor','Mcguire','Fischer','Apartado núm.: 561, 104 Ut Av.','1982/06/03'),(1119,'Tiger','Kaufman','Tate','3339 Cursus Carretera','1988/06/07');
INSERT INTO Empleado([No_empleado],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Direccion],[Fecha_nacimiento]) VALUES(1120,'Leandra','Massey','Curry','Apdo.:436-1192 Ac Av.','1995/07/11'),(1121,'Richard','Conrad','Simmons','579-9251 Ridiculus C/','1993/07/21'),(1122,'Mira','Dudley','Keller','Apartado núm.: 814, 7439 Nulla. C/','1981/09/13'),(1123,'Remedios','Rowland','Jenkins','3946 Ante Carretera','1992/11/22'),(1124,'Nevada','Sims','Mcbride','Apartado núm.: 209, 1514 Consequat C.','1982/12/16'),(1125,'Sophia','Watts','Clay','Apartado núm.: 735, 9401 Erat Av.','1980/08/01'),(1126,'Mira','Smith','Blevins','Apdo.:656-8276 Integer Av.','1984/12/24'),(1127,'August','Nicholson','Zimmerman','713-409 Ligula. C/','1993/03/05'),(1128,'Acton','Rosario','Farmer','9965 Dui Calle','1987/02/08'),(1129,'Shelley','Holden','Golden','Apartado núm.: 394, 1548 Est Avda.','1991/12/22');
INSERT INTO Empleado([No_empleado],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Direccion],[Fecha_nacimiento]) VALUES(1130,'Kim','Durham','Villarreal','Apartado núm.: 309, 4163 Dolor. Ctra.','1984/01/09'),(1131,'Mira','Baldwin','Mejia','9454 Morbi Calle','1990/02/09'),(1132,'Molly','Cochran','Wise','Apartado núm.: 721, 4224 Nulla Avenida','1985/04/16'),(1133,'Miranda','Fletcher','Hartman','Apdo.:199-2538 Egestas. Avenida','1990/11/21'),(1134,'Helen','Gillespie','Hampton','235-1308 Duis Carretera','1987/02/08'),(1135,'Kerry','Marsh','Mendez','Apdo.:292-4977 Mauris C/','1983/03/29'),(1136,'Timothy','Wilkinson','Hull','3313 Dui C/','1992/01/01'),(1137,'Cole','Mack','Frank','Apdo.:777-7651 Nascetur C.','1992/07/23'),(1138,'Tallulah','Jefferson','Hurley','Apartado núm.: 117, 4792 Libero ','1991/11/30'),(1139,'Hammett','Christensen','Stewart','Apdo.:874-1162 Magna. Avda.','1981/03/20');
INSERT INTO Empleado([No_empleado],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Direccion],[Fecha_nacimiento]) VALUES(1140,'Iona','Shaffer','Walker','Apdo.:633-6155 Maecenas Ctra.','1992/04/03'),(1141,'Meghan','Mejia','Yates','Apartado núm.: 265, 3347 Et C/','1995/04/22'),(1142,'Justine','Mercer','Cline','Apartado núm.: 133, 7690 Dolor Ctra.','1982/05/11'),(1143,'Len','Bentley','Strickland','377-3197 Arcu Ctra.','1990/07/19'),(1144,'Yuli','Gonzalez','Mooney','Apdo.:823-1346 Proin C/','1986/09/25'),(1145,'Stella','Dennis','Myers','805-8946 Fermentum Carretera','1991/07/11'),(1146,'Prescott','Dillon','Combs','Apartado núm.: 430, 8316 Non C/','1985/09/08'),(1147,'Odette','Crawford','Duffy','Apdo.:346-9486 Dignissim Carretera','1982/03/08'),(1148,'Carolyn','Yang','Mayer','Apdo.:345-2593 Leo. Av.','1992/08/02'),(1149,'Ahmed','Wiley','Barton','9917 Libero. Calle','1990/06/13');
INSERT INTO Empleado([No_empleado],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Direccion],[Fecha_nacimiento]) VALUES(1150,'Maggie','Caldwell','Anthony','956 A, Ctra.','1989/04/30'),(1151,'Leah','Larson','Benjamin','Apdo.:157-5741 Porttitor ','1987/01/02'),(1152,'Keiko','Ryan','Jensen','5008 Hendrerit ','1987/03/31'),(1153,'Glenna','Ryan','Mathews','624-6990 Eu, Avda.','1990/10/02'),(1154,'Lucas','Lambert','Carver','Apdo.:169-7020 Vel Carretera','1984/04/08'),(1155,'Donna','Matthews','Benjamin','Apdo.:825-2741 Lobortis Av.','1992/04/03'),(1156,'Leila','Moreno','Caldwell','291-2028 Iaculis Avda.','1986/05/03'),(1157,'Ramona','Petty','Kerr','Apartado núm.: 596, 883 Fermentum Carretera','1983/08/21'),(1158,'Reuben','White','Patel','253-6347 Eu, C/','1990/08/19'),(1159,'Leigh','Roberts','Pope','Apdo.:673-1460 Pede, C.','1983/04/05');
INSERT INTO Empleado([No_empleado],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Direccion],[Fecha_nacimiento]) VALUES(1160,'Sydney','Conner','Lopez','Apartado núm.: 653, 8715 Vel, Carretera','1984/02/05'),(1161,'Audrey','England','Dominguez','260-1966 Gravida. ','1986/05/11'),(1162,'Caesar','Kinney','Solomon','Apartado núm.: 638, 4362 Nunc ','1983/05/11'),(1163,'Janna','Wood','Bender','Apdo.:820-1982 Lorem Avda.','1987/09/02'),(1164,'Juliet','Koch','Ingram','572-3162 Cursus C/','1983/03/07'),(1165,'Chanda','Mercer','Briggs','Apartado núm.: 692, 7558 Arcu. Ctra.','1991/04/21'),(1166,'Maxwell','Fisher','Davis','774 Volutpat C/','1994/09/10'),(1167,'Carissa','Chang','Peters','Apartado núm.: 166, 1960 Et Carretera','1990/08/03'),(1168,'Alden','Moon','Barrett','Apdo.:681-733 Facilisis Avda.','1993/02/02'),(1169,'Xandra','Mclaughlin','Berry','Apartado núm.: 932, 7031 Tincidunt Carretera','1982/08/22');
INSERT INTO Empleado([No_empleado],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Direccion],[Fecha_nacimiento]) VALUES(1170,'Avye','Carrillo','Goodwin','Apartado núm.: 849, 2811 Mauris Carretera','1984/01/07'),(1171,'Charde','Curry','Graham','Apdo.:388-2226 Integer Avda.','1988/11/28'),(1172,'Clio','Larson','Herrera','224-1777 Congue Av.','1986/01/31'),(1173,'Richard','Hubbard','Sutton','Apdo.:502-6693 Dictum ','1990/03/15'),(1174,'Hilda','Medina','Pate','5207 Tempus, Calle','1993/05/31'),(1175,'Leo','Kaufman','Richard','Apartado núm.: 614, 1210 Molestie C.','1983/08/10'),(1176,'Nissim','Pate','Olsen','Apdo.:737-946 Pellentesque Avda.','1995/11/21'),(1177,'Larissa','Cohen','Roman','723-3240 Tellus Avda.','1981/09/29'),(1178,'Ifeoma','Miranda','Cabrera','Apartado núm.: 682, 5701 Vitae ','1991/04/09'),(1179,'Tanek','Glass','Golden','Apdo.:471-7890 Congue. Avenida','1987/12/03');
INSERT INTO Empleado([No_empleado],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Direccion],[Fecha_nacimiento]) VALUES(1180,'Amelia','Reilly','Nixon','8317 Quis Calle','1992/02/28'),(1181,'Rhona','Dickerson','Byrd','Apartado núm.: 939, 2282 Pede Ctra.','1982/06/12'),(1182,'Dominic','Conley','Davidson','Apdo.:949-2185 Nam C.','1992/01/20'),(1183,'Rafael','Barnes','Blair','Apartado núm.: 972, 2028 Taciti C.','1994/08/21'),(1184,'Isabella','Curry','Bradford','7676 Aliquam ','1981/09/25'),(1185,'Renee','Stephens','Lindsey','Apartado núm.: 211, 8002 In C/','1984/05/11'),(1186,'Mark','Bass','Crane','958-6342 Nunc, C/','1986/10/13'),(1187,'Brynne','Glover','Kim','987-827 Lacinia. C/','1987/02/10'),(1188,'Brielle','Weber','Levine','731-4039 Sed Avda.','1989/03/25'),(1189,'Kieran','Mcleod','Wagner','Apdo.:890-9136 Cursus Av.','1992/06/09');
INSERT INTO Empleado([No_empleado],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Direccion],[Fecha_nacimiento]) VALUES(1190,'Dana','Murray','Cochran','9236 Aliquet Ctra.','1983/06/07'),(1191,'Lee','Stevenson','Colon','Apdo.:339-9792 Dignissim C.','1995/12/03'),(1192,'Pascale','Stevens','Webster','Apartado núm.: 733, 2721 Fringilla Calle','1995/07/07'),(1193,'Finn','Bennett','Fischer','Apdo.:770-1136 Blandit Av.','1995/07/27'),(1194,'Jacqueline','Lucas','Shepherd','845-5904 Lorem, C.','1987/12/01'),(1195,'Denise','Gray','Hahn','Apartado núm.: 961, 2878 Mus. Carretera','1993/11/05'),(1196,'Chaney','Strong','Carrillo','6088 Suspendisse Av.','1980/07/09'),(1197,'Sonia','Monroe','Bell','Apdo.:528-5355 Lorem, Carretera','1990/05/22'),(1198,'Gannon','Jenkins','Gross','Apdo.:766-8564 Ante, Av.','1984/06/11'),(1199,'Lev','Schultz','Haynes','114-2376 Convallis Av.','1988/08/13');

INSERT INTO Empleado([No_empleado],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Direccion],[Fecha_nacimiento]) VALUES(1200,'Byron','Cardenas','Young','Apartado núm.: 551, 1947 Scelerisque ','1985/06/26'),(1201,'Claire','Gray','Fischer','9983 Id Avenida','1995/03/02'),(1202,'Howard','Bass','Joseph','Apartado núm.: 253, 4578 Pellentesque Ctra.','1990/01/09'),(1203,'Oren','Foreman','Kirkland','5540 Suspendisse C/','1981/02/11'),(1204,'Susan','Cummings','Taylor','Apdo.:756-9845 Velit. Avenida','1989/06/16'),(1205,'Dustin','Dale','Kemp','169-3687 Magna C/','1992/11/03'),(1206,'Keith','Miles','Gutierrez','7109 Vulputate, Av.','1981/01/07'),(1207,'Asher','Cannon','Finley','Apdo.:165-2686 Ac Carretera','1994/09/19'),(1208,'Rebekah','Buchanan','Ortiz','Apdo.:119-6168 Ligula Ctra.','1983/12/21'),(1209,'Curran','Hampton','Poole','Apartado núm.: 214, 5869 Pede. Avda.','1988/10/04');
INSERT INTO Empleado([No_empleado],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Direccion],[Fecha_nacimiento]) VALUES(1210,'Belle','Eaton','Munoz','Apdo.:682-6753 Massa. Ctra.','1985/07/03'),(1211,'Stewart','Reed','Park','166-1072 Elit Carretera','1994/11/23'),(1212,'Brody','Garner','Baldwin','Apdo.:876-5383 Nisl C.','1981/01/12'),(1213,'Julie','Velasquez','Pitts','Apdo.:469-9285 Amet, C.','1989/09/11'),(1214,'Dahlia','Snider','Ellis','Apartado núm.: 727, 4367 Mus. Carretera','1984/11/13'),(1215,'Cade','Baldwin','Reese','379-8099 Quis Calle','1987/03/15'),(1216,'Paloma','Duffy','Patrick','608-3450 Ac, ','1993/01/25'),(1217,'Serina','Horn','Kirkland','Apartado núm.: 106, 3268 Faucibus C.','1983/10/20'),(1218,'Kylynn','Munoz','Robbins','Apartado núm.: 120, 2358 Erat Calle','1993/11/12'),(1219,'Tanek','Sheppard','Davis','275-5939 Elit ','1991/09/30');
INSERT INTO Empleado([No_empleado],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Direccion],[Fecha_nacimiento]) VALUES(1220,'Otto','Jacobson','Hebert','Apdo.:406-7794 Sed Avenida','1989/01/18'),(1221,'Fay','Nieves','Barton','469-213 Amet ','1992/12/20'),(1222,'Jeremy','Hickman','Wilkerson','9390 Congue Ctra.','1980/09/23'),(1223,'Amber','Ball','Goff','Apdo.:594-5770 Lectus C.','1992/09/15'),(1224,'Hall','Sloan','Glass','476-8282 Dui. Av.','1985/09/20'),(1225,'Phillip','Gross','Juarez','399-5593 Consectetuer C/','1987/11/01'),(1226,'Owen','Fry','Welch','129-1370 Suspendisse Carretera','1988/05/15'),(1227,'Lawrence','Short','Parker','Apartado núm.: 147, 431 Nibh. C/','1980/11/17'),(1228,'Asher','Galloway','Spears','Apartado núm.: 533, 4535 Egestas. ','1982/02/14'),(1229,'Wade','Parks','Colon','Apartado núm.: 119, 4307 Augue ','1980/03/08');
INSERT INTO Empleado([No_empleado],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Direccion],[Fecha_nacimiento]) VALUES(1230,'Skyler','Woods','Avery','3806 Donec Av.','1991/11/28'),(1231,'Dominic','Delacruz','Doyle','Apartado núm.: 975, 5722 Dictum ','1985/09/26'),(1232,'Rebecca','Fernandez','Whitfield','Apartado núm.: 863, 616 Dolor, Avenida','1980/09/18'),(1233,'Justine','Curry','Pate','Apdo.:998-5621 Nunc Calle','1988/11/18'),(1234,'Eagan','Duran','Mcneil','866-5756 Volutpat Calle','1986/05/14'),(1235,'Cyrus','Cameron','Barlow','Apdo.:536-9522 Ac, Calle','1987/09/01'),(1236,'Conan','Abbott','Herrera','8076 Euismod ','1987/06/19'),(1237,'Aline','Gilmore','Santos','Apartado núm.: 360, 4791 Ultrices. ','1982/12/20'),(1238,'Jacob','Cobb','Skinner','Apdo.:955-2438 Et Avenida','1982/06/28'),(1239,'Lila','Hayes','Golden','424-1584 Faucibus. C/','1983/08/10');
INSERT INTO Empleado([No_empleado],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Direccion],[Fecha_nacimiento]) VALUES(1240,'Orla','Alvarado','Smith','Apartado núm.: 478, 6519 Sagittis Avenida','1980/02/22'),(1241,'Alexander','Mack','Gregory','Apartado núm.: 295, 7763 Aliquet. Ctra.','1983/08/29'),(1242,'Lamar','Bates','Colon','9190 Lobortis Carretera','1986/04/17'),(1243,'Adena','Rowland','Castro','Apartado núm.: 402, 777 Fusce Calle','1989/04/25'),(1244,'Sade','Pate','Underwood','765-7833 Mauris C.','1986/11/20'),(1245,'Zorita','Hewitt','Casey','498-6079 Aliquet Carretera','1989/06/25'),(1246,'Hayley','Acosta','Michael','7955 Mauris Avda.','1983/08/07'),(1247,'Leilani','Aguirre','Stewart','823-6504 Vitae, Avenida','1993/07/03'),(1248,'Amethyst','Joyner','Osborne','681-3722 Eros Av.','1987/06/28'),(1249,'Kai','Moreno','Pittman','765-5700 Ac Ctra.','1993/09/08');
INSERT INTO Empleado([No_empleado],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Direccion],[Fecha_nacimiento]) VALUES(1250,'Zachary','Woods','Little','Apartado núm.: 591, 9018 Mollis. Carretera','1988/10/03'),(1251,'Iola','Flynn','Berry','9705 Mauris. C/','1982/09/14'),(1252,'Brianna','Davidson','Roy','Apartado núm.: 532, 390 Mattis C/','1983/07/31'),(1253,'Keith','Boone','Sherman','Apartado núm.: 661, 5818 Mollis. C/','1987/11/25'),(1254,'Laith','Sampson','Chavez','Apdo.:220-1664 Lectus Calle','1987/08/30'),(1255,'Zephania','Pennington','Conley','Apdo.:289-5041 Tristique Ctra.','1993/10/09'),(1256,'Hamish','Nixon','Gray','7672 Dignissim Carretera','1982/11/02'),(1257,'Gil','Castillo','Dorsey','Apdo.:372-3928 Ornare Calle','1984/02/06'),(1258,'Aaron','Snider','Hess','400-5824 Aliquam Calle','1982/05/12'),(1259,'Wing','Turner','Cooley','Apartado núm.: 384, 9080 In ','1990/05/08');
INSERT INTO Empleado([No_empleado],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Direccion],[Fecha_nacimiento]) VALUES(1260,'Ishmael','Hays','Beach','6408 Auctor C.','1988/04/26'),(1261,'Salvador','Cantu','Hansen','Apartado núm.: 319, 6846 Nullam Avenida','1985/12/22'),(1262,'Barrett','Cortez','Sandoval','Apartado núm.: 290, 9314 Enim, Avda.','1993/02/25'),(1263,'Tyler','Hunt','Whitfield','Apdo.:824-9443 Lacus. C/','1994/07/19'),(1264,'Kyle','Moon','William','183-891 Phasellus C/','1993/05/03'),(1265,'Talon','Beach','Stokes','Apdo.:629-8194 A Ctra.','1984/12/17'),(1266,'Nicholas','Hubbard','Dominguez','Apdo.:652-8057 Lacus. Ctra.','1991/11/20'),(1267,'Galena','Colon','Hurley','Apartado núm.: 609, 4927 Dui. Ctra.','1991/03/21'),(1268,'Randall','Maldonado','Baldwin','544-2967 Nulla Av.','1990/12/09'),(1269,'Hilda','Kline','Beasley','Apdo.:650-2999 Sed C/','1994/11/07');
INSERT INTO Empleado([No_empleado],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Direccion],[Fecha_nacimiento]) VALUES(1270,'Oliver','Montoya','Knapp','7776 Metus. Carretera','1991/07/04'),(1271,'Kareem','Campos','Maldonado','3988 Purus, ','1983/11/27'),(1272,'Destiny','Benson','Holman','311-4963 Mauris Avenida','1991/01/26'),(1273,'Natalie','Carlson','Obrien','Apartado núm.: 850, 584 Dolor Av.','1991/04/18'),(1274,'Mariam','Marks','Vance','882-2398 Eros Avenida','1981/01/03'),(1275,'Karyn','Whitley','Mcclure','Apartado núm.: 371, 8343 Egestas. C.','1982/02/26'),(1276,'Daniel','Walsh','Allison','824 Non C.','1992/12/11'),(1277,'Xaviera','Rose','Kramer','Apdo.:703-6826 Et, C/','1986/07/22'),(1278,'Yolanda','Romero','Tate','654-2002 Sit Av.','1990/08/17'),(1279,'Steven','Carroll','Gaines','Apdo.:801-667 Aliquam C.','1981/12/15');
INSERT INTO Empleado([No_empleado],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Direccion],[Fecha_nacimiento]) VALUES(1280,'Abraham','Battle','Hubbard','471-5704 Nunc Av.','1989/03/08'),(1281,'Gareth','Wynn','Jordan','4721 Nulla C/','1989/11/22'),(1282,'Imani','Murphy','Mccoy','Apartado núm.: 241, 227 Auctor, Av.','1980/10/28'),(1283,'Rhona','Herrera','Howard','1464 Quis ','1989/12/19'),(1284,'Beverly','Woodward','Riddle','Apartado núm.: 297, 5199 Quis C/','1986/05/20'),(1285,'Scarlett','Reed','Burt','799-3650 Varius. Avda.','1982/05/03'),(1286,'Kuame','Morrison','Cross','6110 Malesuada C.','1995/11/18'),(1287,'Chaim','Cannon','Booth','Apdo.:881-8414 Amet Av.','1994/06/03'),(1288,'Emery','Conway','Jimenez','261-9411 Mi. ','1988/02/27'),(1289,'Tatum','Wilkins','Young','4952 Faucibus Avenida','1987/05/28');
INSERT INTO Empleado([No_empleado],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Direccion],[Fecha_nacimiento]) VALUES(1290,'Nash','Macias','Hansen','4450 Ultricies C.','1984/01/11'),(1291,'Channing','Mendez','Puckett','Apartado núm.: 942, 1426 Vestibulum ','1995/05/16'),(1292,'Conan','Hart','Oliver','Apartado núm.: 242, 1179 Interdum Avda.','1991/08/14'),(1293,'Elizabeth','Larson','Douglas','6920 Lorem, ','1995/04/13'),(1294,'Rina','Miles','Bradley','617-1415 At Carretera','1984/08/06'),(1295,'Guinevere','Schultz','Roberson','4327 Nunc Av.','1993/05/26'),(1296,'Charlotte','Ramsey','Olsen','Apartado núm.: 852, 1159 A Av.','1992/09/02'),(1297,'Shelby','Thompson','Lyons','Apdo.:713-5665 Laoreet C.','1984/06/12'),(1298,'Davis','Davenport','Grimes','300-9610 Elit Carretera','1987/05/24'),(1299,'Timon','Tyson','Chavez','Apdo.:807-1354 Lectus Avda.','1991/01/13');


/*Profesores*/
INSERT INTO Profesor([Empleado_No_empleado],[Cuenta_ID],[Estatus_ID],[Area_ID],[GradoEstudio]) VALUES(1000,9,3,5,'Doctorado'),(1001,10,3,2,'Doctorado'),(1002,11,3,3,'Licenciatura'),(1003,12,3,6,'Doctorado'),(1004,13,3,2,'Licenciatura'),(1005,14,3,2,'Licenciatura'),(1006,15,3,1,'Maestria'),(1007,16,3,5,'Maestria'),(1008,17,3,1,'Licenciatura'),(1009,18,3,2,'Maestria');
INSERT INTO Profesor([Empleado_No_empleado],[Cuenta_ID],[Estatus_ID],[Area_ID],[GradoEstudio]) VALUES(1010,19,3,1,'Licenciatura'),(1011,20,3,5,'Doctorado'),(1012,21,3,6,'Licenciatura'),(1013,22,3,2,'Maestria'),(1014,23,3,4,'Licenciatura'),(1015,24,3,1,'Doctorado'),(1016,25,3,6,'Doctorado'),(1017,26,3,5,'Doctorado'),(1018,27,3,5,'Maestria'),(1019,28,3,1,'Licenciatura');
INSERT INTO Profesor([Empleado_No_empleado],[Cuenta_ID],[Estatus_ID],[Area_ID],[GradoEstudio]) VALUES(1020,29,3,4,'Doctorado'),(1021,30,3,5,'Maestria'),(1022,31,3,2,'Doctorado'),(1023,32,3,1,'Licenciatura'),(1024,33,3,5,'Doctorado'),(1025,34,3,6,'Maestria'),(1026,35,3,1,'Maestria'),(1027,36,3,1,'Maestria'),(1028,37,3,6,'Licenciatura'),(1029,38,3,3,'Licenciatura');
INSERT INTO Profesor([Empleado_No_empleado],[Cuenta_ID],[Estatus_ID],[Area_ID],[GradoEstudio]) VALUES(1030,39,3,6,'Doctorado'),(1031,40,3,2,'Maestria'),(1032,41,3,3,'Doctorado'),(1033,42,3,3,'Maestria'),(1034,43,3,5,'Maestria'),(1035,44,3,4,'Doctorado'),(1036,45,3,4,'Maestria'),(1037,46,3,2,'Doctorado'),(1038,47,3,1,'Maestria'),(1039,48,3,3,'Doctorado');
INSERT INTO Profesor([Empleado_No_empleado],[Cuenta_ID],[Estatus_ID],[Area_ID],[GradoEstudio]) VALUES(1040,49,3,6,'Doctorado'),(1041,50,3,2,'Maestria'),(1042,51,3,4,'Maestria'),(1043,52,3,5,'Licenciatura'),(1044,53,3,1,'Doctorado'),(1045,54,3,4,'Licenciatura'),(1046,55,3,1,'Licenciatura'),(1047,56,3,1,'Licenciatura'),(1048,57,3,5,'Maestria'),(1049,58,3,3,'Maestria');
INSERT INTO Profesor([Empleado_No_empleado],[Cuenta_ID],[Estatus_ID],[Area_ID],[GradoEstudio]) VALUES(1050,59,3,4,'Doctorado'),(1051,60,3,2,'Maestria'),(1052,61,3,6,'Licenciatura'),(1053,62,3,2,'Maestria'),(1054,63,3,4,'Maestria'),(1055,64,3,3,'Maestria'),(1056,65,3,5,'Maestria'),(1057,66,3,5,'Doctorado'),(1058,67,3,1,'Doctorado'),(1059,68,3,3,'Maestria');
INSERT INTO Profesor([Empleado_No_empleado],[Cuenta_ID],[Estatus_ID],[Area_ID],[GradoEstudio]) VALUES(1060,69,3,2,'Licenciatura'),(1061,70,3,5,'Maestria'),(1062,71,3,3,'Doctorado'),(1063,72,3,1,'Licenciatura'),(1064,73,3,4,'Maestria'),(1065,74,3,2,'Doctorado'),(1066,75,3,4,'Licenciatura'),(1067,76,3,6,'Doctorado'),(1068,77,3,4,'Licenciatura'),(1069,78,3,6,'Licenciatura');
INSERT INTO Profesor([Empleado_No_empleado],[Cuenta_ID],[Estatus_ID],[Area_ID],[GradoEstudio]) VALUES(1070,79,3,4,'Doctorado'),(1071,80,3,2,'Doctorado'),(1072,81,3,4,'Maestria'),(1073,82,3,2,'Licenciatura'),(1074,83,3,5,'Maestria'),(1075,84,3,4,'Maestria'),(1076,85,3,5,'Maestria'),(1077,86,3,2,'Licenciatura'),(1078,87,3,3,'Doctorado'),(1079,88,3,2,'Doctorado');
INSERT INTO Profesor([Empleado_No_empleado],[Cuenta_ID],[Estatus_ID],[Area_ID],[GradoEstudio]) VALUES(1080,89,3,5,'Licenciatura'),(1081,90,3,5,'Maestria'),(1082,91,3,3,'Maestria'),(1083,92,3,1,'Maestria'),(1084,93,3,5,'Maestria'),(1085,94,3,3,'Maestria'),(1086,95,3,5,'Doctorado'),(1087,96,3,6,'Doctorado'),(1088,97,3,2,'Doctorado'),(1089,98,3,1,'Licenciatura');
INSERT INTO Profesor([Empleado_No_empleado],[Cuenta_ID],[Estatus_ID],[Area_ID],[GradoEstudio]) VALUES(1090,99,3,3,'Licenciatura'),(1091,100,3,6,'Maestria'),(1092,101,3,3,'Licenciatura'),(1093,102,3,4,'Doctorado'),(1094,103,3,6,'Maestria'),(1095,104,3,5,'Doctorado'),(1096,105,3,3,'Licenciatura'),(1097,106,3,3,'Doctorado'),(1098,107,3,5,'Doctorado'),(1099,108,3,6,'Licenciatura');
INSERT INTO Profesor([Empleado_No_empleado],[Cuenta_ID],[Estatus_ID],[Area_ID],[GradoEstudio]) VALUES(1100,9,1,3,'Doctorado'),(1101,10,2,3,'Doctorado'),(1102,11,1,6,'Doctorado'),(1103,12,2,4,'Licenciatura'),(1104,13,2,3,'Licenciatura'),(1105,14,3,1,'Maestria'),(1106,15,1,2,'Maestria'),(1107,16,3,5,'Maestria'),(1108,17,1,1,'Licenciatura'),(1109,18,2,3,'Doctorado');
INSERT INTO Profesor([Empleado_No_empleado],[Cuenta_ID],[Estatus_ID],[Area_ID],[GradoEstudio]) VALUES(1110,19,2,2,'Doctorado'),(1111,20,3,1,'Maestria'),(1112,21,2,2,'Licenciatura'),(1113,22,3,5,'Licenciatura'),(1114,23,1,3,'Maestria'),(1115,24,3,5,'Licenciatura'),(1116,25,1,5,'Licenciatura'),(1117,26,2,2,'Doctorado'),(1118,27,3,5,'Licenciatura'),(1119,28,2,2,'Doctorado');
INSERT INTO Profesor([Empleado_No_empleado],[Cuenta_ID],[Estatus_ID],[Area_ID],[GradoEstudio]) VALUES(1120,29,1,5,'Maestria'),(1121,30,1,5,'Maestria'),(1122,31,1,1,'Maestria'),(1123,32,1,6,'Doctorado'),(1124,33,3,4,'Licenciatura'),(1125,34,3,6,'Maestria'),(1126,35,1,4,'Doctorado'),(1127,36,2,3,'Licenciatura'),(1128,37,3,4,'Licenciatura'),(1129,38,2,6,'Licenciatura');
INSERT INTO Profesor([Empleado_No_empleado],[Cuenta_ID],[Estatus_ID],[Area_ID],[GradoEstudio]) VALUES(1130,39,2,5,'Doctorado'),(1131,40,3,5,'Maestria'),(1132,41,2,5,'Doctorado'),(1133,42,2,1,'Doctorado'),(1134,43,1,2,'Licenciatura'),(1135,44,3,5,'Doctorado'),(1136,45,2,5,'Doctorado'),(1137,46,3,1,'Doctorado'),(1138,47,1,1,'Maestria'),(1139,48,1,6,'Licenciatura');
INSERT INTO Profesor([Empleado_No_empleado],[Cuenta_ID],[Estatus_ID],[Area_ID],[GradoEstudio]) VALUES(1140,49,1,5,'Licenciatura'),(1141,50,1,6,'Licenciatura'),(1142,51,1,5,'Licenciatura'),(1143,52,1,1,'Maestria'),(1144,53,3,2,'Doctorado'),(1145,54,2,2,'Doctorado'),(1146,55,2,5,'Licenciatura'),(1147,56,1,6,'Doctorado'),(1148,57,3,4,'Licenciatura'),(1149,58,3,3,'Doctorado');
INSERT INTO Profesor([Empleado_No_empleado],[Cuenta_ID],[Estatus_ID],[Area_ID],[GradoEstudio]) VALUES(1150,59,1,3,'Maestria'),(1151,60,2,4,'Licenciatura'),(1152,61,2,4,'Maestria'),(1153,62,2,4,'Maestria'),(1154,63,3,2,'Doctorado'),(1155,64,1,3,'Licenciatura'),(1156,65,3,5,'Maestria'),(1157,66,2,1,'Licenciatura'),(1158,67,3,1,'Licenciatura'),(1159,68,1,4,'Doctorado');
INSERT INTO Profesor([Empleado_No_empleado],[Cuenta_ID],[Estatus_ID],[Area_ID],[GradoEstudio]) VALUES(1160,69,1,6,'Maestria'),(1161,70,2,2,'Maestria'),(1162,71,2,6,'Doctorado'),(1163,72,2,2,'Maestria'),(1164,73,3,5,'Doctorado'),(1165,74,1,2,'Maestria'),(1166,75,3,3,'Maestria'),(1167,76,2,1,'Maestria'),(1168,77,3,6,'Maestria'),(1169,78,3,1,'Licenciatura');
INSERT INTO Profesor([Empleado_No_empleado],[Cuenta_ID],[Estatus_ID],[Area_ID],[GradoEstudio]) VALUES(1170,79,3,1,'Doctorado'),(1171,80,3,4,'Licenciatura'),(1172,81,1,3,'Maestria'),(1173,82,2,4,'Licenciatura'),(1174,83,1,4,'Maestria'),(1175,84,3,4,'Licenciatura'),(1176,85,3,4,'Doctorado'),(1177,86,3,5,'Maestria'),(1178,87,3,4,'Doctorado'),(1179,88,2,5,'Licenciatura');
INSERT INTO Profesor([Empleado_No_empleado],[Cuenta_ID],[Estatus_ID],[Area_ID],[GradoEstudio]) VALUES(1180,89,3,4,'Licenciatura'),(1181,90,2,3,'Doctorado'),(1182,91,2,6,'Licenciatura'),(1183,92,1,5,'Maestria'),(1184,93,3,6,'Licenciatura'),(1185,94,3,6,'Licenciatura'),(1186,95,1,6,'Maestria'),(1187,96,1,1,'Licenciatura'),(1188,97,3,1,'Licenciatura'),(1189,98,3,2,'Maestria');
INSERT INTO Profesor([Empleado_No_empleado],[Cuenta_ID],[Estatus_ID],[Area_ID],[GradoEstudio]) VALUES(1190,99,3,3,'Licenciatura'),(1191,100,1,6,'Doctorado'),(1192,101,1,3,'Licenciatura'),(1193,102,3,2,'Maestria'),(1194,103,3,6,'Maestria'),(1195,104,3,1,'Doctorado'),(1196,105,3,1,'Licenciatura'),(1197,106,1,6,'Maestria'),(1198,107,2,5,'Licenciatura'),(1199,108,1,3,'Maestria');

/*Clientes del 1 al 400 son alumnos y aspirantes */
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(1,'Barclay','Perez','Cook','sed.consequat.auctor@sem.co.uk','Apdo.:888-2122 Malesuada Calle','1999/05/23',9),(2,'Lila','Griffith','Joyce','felis.eget.varius@Donec.net','Apdo.:826-2467 Pede, C/','1998/05/24',8),(3,'Branden','Patel','Copeland','et@risus.ca','756-3939 Blandit Av.','1999/12/25',8),(4,'Kevin','Snyder','Pittman','massa@magna.net','878-3455 Lacus, C.','1998/07/28',8),(5,'Savannah','Singleton','Hartman','auctor.Mauris.vel@justonec.co.uk','Apdo.:404-1408 Ullamcorper Carretera','1998/10/10',8),(6,'Vladimir','Hart','Henderson','Sed.et@metusAliquam.org','Apartado núm.: 773, 5675 Magna. C/','1999/02/01',8),(7,'Benedict','Skinner','Pennington','sem@aliquetsemut.ca','Apartado núm.: 180, 2595 Sapien, Avda.','1999/10/18',7),(8,'Rhea','Hughes','Hyde','Curabitur.ut.odio@adipiscing.co.uk','Apdo.:568-1289 At Avda.','1998/04/30',9),(9,'Russell','Kim','Rosa','tellus.Suspendisse.sed@sitametornare.ca','Apartado núm.: 728, 7396 Lacus. C.','1998/05/07',9),(10,'Timothy','Bruce','Donaldson','nunc.id@libero.ca','7294 Nisi. Avenida','1999/07/10',8);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(11,'Daryl','Swanson','Newton','urna@aarcuSed.co.uk','Apartado núm.: 612, 7885 Risus ','1998/07/06',9),(12,'Dane','Rosario','Mooney','nibh@pharetrafeliseget.edu','Apartado núm.: 110, 4197 Dictum Calle','1998/08/24',7),(13,'Miriam','Barry','Hawkins','vulputate@nonbibendum.edu','780-1332 Sollicitudin C/','1998/04/08',7),(14,'Jakeem','Sheppard','Rosales','metus.Vivamus.euismod@Suspendissedui.org','Apdo.:362-7490 Elit, Ctra.','1998/10/07',8),(15,'Dale','Wade','Schroeder','netus.et.malesuada@anteblandit.edu','800-8413 At Av.','1998/03/03',7),(16,'Serena','Estrada','Flynn','Duis.sit.amet@sem.co.uk','197-654 Ipsum. C.','1999/08/25',7),(17,'Patrick','Jensen','Fletcher','et@anteNuncmauris.net','Apartado núm.: 212, 5872 Curabitur Ctra.','1999/12/18',8),(18,'Seth','Craig','Mcintyre','Morbi.neque@ullamcorpereu.net','7093 In Avda.','1998/10/23',8),(19,'Kay','Montoya','Haney','mi.lacinia.mattis@semperpretium.com','Apartado núm.: 453, 5532 Faucibus Carretera','1999/11/25',8),(20,'Maile','Jennings','Nash','egestas.rhoncus@urnaNullamlobortis.co.uk','144-6336 Elit, Av.','1998/07/19',7);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(21,'Martin','William','Cooper','risus.Duis.a@neque.edu','Apdo.:539-9445 At Avenida','1999/07/16',9),(22,'Hunter','Valenzuela','Whitehead','arcu.ac@interdumSedauctor.co.uk','532-6219 Enim Avda.','1998/12/06',8),(23,'Porter','Grant','Hughes','nec.enim@loremut.edu','3076 Ac Avda.','1998/03/22',9),(24,'Althea','Buck','Jennings','montes@magna.com','433-4943 Libero. Avenida','1998/03/08',7),(25,'Noble','Haynes','Solis','Suspendisse@Fusce.net','903-546 Fusce Calle','1998/11/13',8),(26,'Octavia','Cobb','Mann','Donec.vitae@hendreritDonec.ca','9976 Praesent Ctra.','1998/10/20',9),(27,'Wilma','Roth','Sheppard','fringilla.Donec@parturient.net','283-9882 Dui. Calle','1999/10/18',9),(28,'Nathan','Allen','Woodward','Nunc.ullamcorper@enimCurabitur.co.uk','423-9516 Nam Calle','1998/07/20',9),(29,'Stephen','Austin','Deleon','Vivamus@milacinia.net','Apdo.:421-3999 Luctus Calle','1999/07/03',8),(30,'Clayton','Slater','Hensley','velit@congueIn.ca','8856 Ac C/','1998/06/29',7);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(31,'Talon','Adkins','Wood','ligula@aliquamarcuAliquam.org','Apartado núm.: 638, 5603 Imperdiet Carretera','1998/07/01',8),(32,'Bertha','Gross','Newton','Nulla.tempor@metusVivamuseuismod.org','Apdo.:148-5063 Sed Calle','1999/03/16',8),(33,'Martena','Davis','Maddox','vulputate.ullamcorper.magna@lectusjusto.edu','667-3710 Nulla Ctra.','1998/02/26',9),(34,'Lester','Shields','Obrien','sit.amet@dapibus.edu','Apdo.:278-8390 Auctor Ctra.','1998/03/25',9),(35,'Nola','Kirkland','Sweet','orci@id.ca','Apartado núm.: 667, 2263 Enim. Avda.','1998/04/03',7),(36,'Asher','Casey','Welch','nec.urna.et@dapibusquam.org','7608 Consectetuer Carretera','1998/01/04',7),(37,'Lewis','Ramos','Hodge','ipsum.Phasellus@etipsumcursus.edu','Apdo.:929-1691 Tellus, Calle','1998/04/26',9),(38,'Dante','Hull','Flores','ridiculus.mus@consectetuercursus.edu','Apartado núm.: 880, 3408 Ligula Calle','1999/12/29',8),(39,'Driscoll','Young','Browning','purus.mauris.a@cursus.com','Apdo.:914-7625 Torquent ','1999/10/30',8),(40,'Elton','Guy','Kaufman','velit.Quisque@nonsollicitudin.net','Apartado núm.: 183, 9907 Ac, Ctra.','1999/08/03',8);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(41,'Inez','Roth','Gomez','imperdiet@sociisnatoque.co.uk','2622 Vel Carretera','1999/09/22',7),(42,'Jonah','Oneill','Glass','tempus@sitamet.ca','661-3356 Proin Carretera','1998/06/29',7),(43,'Benedict','Hahn','Mullen','elit@fermentumfermentumarcu.com','Apdo.:337-8593 Imperdiet, Avda.','1999/06/11',9),(44,'Rae','Orr','Rollins','turpis.non@sitamet.edu','678-7669 Sit Carretera','1998/09/30',9),(45,'Iris','Reeves','Dawson','luctus.et@faucibusorciluctus.co.uk','Apdo.:303-1679 Tincidunt. Avda.','1998/04/02',9),(46,'Kenneth','Vazquez','Roberts','est@risus.co.uk','Apdo.:441-2840 Convallis Av.','1998/01/22',8),(47,'Eleanor','Burns','English','ipsum.primis.in@nislsemconsequat.org','7525 Magna C.','1998/06/12',9),(48,'Quon','Le','Burke','Curabitur.vel@accumsan.net','6103 Purus Av.','1998/08/30',9),(49,'Talon','Ramirez','Bass','pede@odio.com','Apartado núm.: 394, 3076 Vulputate C.','1999/04/29',9),(50,'Sandra','Edwards','Madden','Aliquam@arcu.org','Apartado núm.: 477, 6921 Libero Calle','1998/12/17',7);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(51,'Olivia','Roth','Chandler','commodo.tincidunt.nibh@dignissimMaecenas.com','Apdo.:509-8841 Curae; Calle','1999/03/21',7),(52,'Hall','Gillespie','Frost','Cum@tellusNunc.org','307-2330 Sapien ','1998/02/21',9),(53,'Danielle','Blanchard','Sharp','dui@mattis.org','2781 Lorem, Av.','1999/10/06',8),(54,'Edward','Hines','Cummings','varius.ultrices.mauris@pedeCumsociis.com','Apartado núm.: 505, 429 Quam Avda.','1999/11/03',9),(55,'Vance','Newman','Osborne','amet.ante@sitamet.co.uk','3215 Tellus Avenida','1998/09/13',7),(56,'Paloma','Estes','Barker','libero@aliquetmetus.ca','7826 Donec Avenida','1999/11/03',7),(57,'Maggy','Aguirre','Cardenas','egestas.Aliquam.nec@quis.net','4788 Consectetuer C/','1998/05/01',8),(58,'Dane','Maldonado','Taylor','neque.non.quam@Suspendisse.net','Apartado núm.: 180, 1324 Non Avda.','1999/08/09',8),(59,'Ralph','Peters','Baxter','semper.dui@lacus.org','Apdo.:784-5773 Magna Ctra.','1999/03/29',9),(60,'Lila','Howell','Williams','congue.In.scelerisque@volutpat.edu','3799 Turpis ','1998/09/04',8);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(61,'Rafael','Fowler','Kerr','nec@Donec.ca','8975 Dui, Carretera','1999/08/07',9),(62,'Remedios','Noble','Brock','Etiam.imperdiet.dictum@aauctornon.org','Apdo.:241-8547 Nisi C.','1999/02/17',8),(63,'Wayne','Hurst','Herman','sodales@auctor.com','Apdo.:714-3905 Sit Av.','1998/03/06',8),(64,'Jelani','Estes','Cash','Curabitur@acmetusvitae.com','724-1110 Cursus. ','1999/10/09',9),(65,'Gavin','Burnett','Cline','placerat@eratVivamusnisi.ca','Apartado núm.: 737, 6052 Sed C/','1999/08/23',7),(66,'Noble','Santos','Frank','vel.faucibus@vehiculaaliquet.org','Apartado núm.: 961, 7067 Mi Ctra.','1999/02/08',8),(67,'Clementine','Armstrong','Grimes','et.ultrices.posuere@laciniaorciconsectetuer.net','6556 Primis ','1999/11/08',9),(68,'Ava','Murray','George','aliquet.nec.imperdiet@a.com','4877 Orci, Calle','1999/01/31',9),(69,'Hyacinth','Wade','Bush','quam.Curabitur.vel@hendreritconsectetuer.net','183-8279 Ante Carretera','1999/01/22',7),(70,'Calista','Peterson','Nichols','enim@idantedictum.com','283-9752 Tortor Av.','1999/08/19',8);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(71,'Blaine','Schmidt','Hood','malesuada.fames@nibhDonec.org','Apdo.:993-844 Purus, ','1999/11/15',8),(72,'Whilemina','Kerr','Bird','vel.turpis@auguemalesuadamalesuada.com','486-1594 Adipiscing Avda.','1998/04/20',9),(73,'Brandon','Sherman','Murray','sed@orcitincidunt.ca','Apartado núm.: 916, 3412 Pede, Calle','1999/05/11',9),(74,'Natalie','Fields','Guerra','Nulla.tempor.augue@Aliquamfringillacursus.org','444-3159 Nunc Ctra.','1999/02/08',7),(75,'Violet','Dickson','Haynes','ornare@luctusaliquetodio.edu','Apartado núm.: 755, 653 In Av.','1999/04/22',8),(76,'Bert','Blackwell','Watts','cursus@euismodenim.ca','4204 Commodo Calle','1998/02/14',7),(77,'Fatima','Harris','Cole','libero.Morbi@euturpis.ca','Apartado núm.: 136, 1269 Et, Avenida','1999/09/19',8),(78,'Michelle','Cortez','Haney','sagittis.lobortis@lacuspedesagittis.com','Apartado núm.: 688, 2411 Phasellus Calle','1999/08/04',9),(79,'Erica','Savage','Delaney','sociis.natoque.penatibus@liberoMorbiaccumsan.org','Apartado núm.: 855, 6343 Risus. Av.','1999/08/19',9),(80,'Xanthus','Meyers','Knight','a.nunc.In@sit.com','Apdo.:878-7536 Adipiscing Av.','1998/08/13',9);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(81,'Denton','Daugherty','York','ad.litora@vestibulum.com','Apartado núm.: 259, 1287 Aliquam Avenida','1998/12/27',9),(82,'Judah','Sweet','Alford','id.libero.Donec@Donecestmauris.ca','Apdo.:439-1692 Ac Ctra.','1998/08/03',8),(83,'Piper','Franklin','Moses','semper@eget.co.uk','7611 Ut ','1999/03/22',9),(84,'Wynne','Austin','Potts','Phasellus.dolor.elit@Utsagittislobortis.net','Apdo.:885-4551 Pellentesque C.','1999/03/16',9),(85,'Micah','George','Bryan','Aliquam.ornare.libero@acfermentum.edu','Apdo.:494-9955 Ligula. ','1998/05/16',7),(86,'Jeanette','Vaughn','Solomon','neque.non@vulputateeu.org','4727 Nunc Avda.','1998/08/17',9),(87,'Phillip','Chang','Harding','eleifend.nec.malesuada@Sedauctor.edu','565-5710 Est, Avenida','1999/07/21',9),(88,'Tasha','Farrell','Graham','posuere.cubilia@semperetlacinia.com','Apdo.:295-3103 Nulla C.','1999/03/09',8),(89,'Keaton','Bartlett','Bradshaw','a.dui@diamdictumsapien.net','Apdo.:374-8296 Habitant Avenida','1998/10/10',7),(90,'Vance','Camacho','Sosa','ut.pharetra@atvelitPellentesque.ca','501-5835 Quam. Carretera','1999/12/20',8);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(91,'Carissa','Martinez','Woodward','ut.mi@varius.org','136-7037 Aenean Ctra.','1999/02/03',8),(92,'Kim','Wolfe','Trujillo','lacus.Nulla@odio.co.uk','Apartado núm.: 930, 2221 Mollis. Calle','1998/10/29',7),(93,'Victoria','Hutchinson','Avery','at.sem@sodales.com','1378 Tempor Calle','1998/09/04',9),(94,'Dominic','Combs','Waters','Proin.dolor@semper.net','706-613 Diam. Calle','1998/04/01',7),(95,'Warren','Ellis','Oneal','molestie.orci.tincidunt@purus.org','Apartado núm.: 523, 8853 Parturient Ctra.','1998/01/22',8),(96,'Deanna','Olsen','Whitley','Suspendisse.eleifend.Cras@lectusrutrumurna.com','Apartado núm.: 148, 1969 Quam. Carretera','1998/06/06',9),(97,'Nicole','Santana','Eaton','Nulla@volutpatornarefacilisis.com','659-3631 Egestas Carretera','1999/04/20',8),(98,'Karen','Dennis','Guthrie','augue.id.ante@asollicitudinorci.org','Apdo.:233-1819 Nulla ','1999/10/19',8),(99,'Lacey','Keith','Wilson','eu@ullamcorpermagnaSed.org','9718 Pellentesque ','1999/08/21',9),(100,'Beverly','Cohen','Hanson','lacus.Cras@Morbisit.com','Apartado núm.: 689, 3351 Ligula. C/','1999/02/04',8);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(1,'Michael','Stanley','Ball','Fusce.mollis@Phaselluslibero.net','2024 Vitae, C/','1998/10/17',4),(2,'Beverly','Hampton','England','sit.amet.faucibus@aliquetmagna.net','115-6379 Egestas ','1999/07/13',4),(3,'Grady','Velazquez','Huffman','ridiculus.mus@purusinmolestie.edu','8581 Nibh ','1998/08/21',6),(4,'Arsenio','Crosby','Hyde','mauris.Morbi.non@augueac.co.uk','6176 Nec, ','1998/06/23',6),(5,'Cally','Britt','Castillo','massa.Suspendisse.eleifend@miDuisrisus.edu','8764 Aliquet C/','1998/11/08',5),(6,'Amelia','Montgomery','Bennett','luctus.et.ultrices@lobortisClass.ca','Apdo.:905-1605 Nulla. ','1999/02/28',6),(7,'Unity','Bradley','Doyle','ipsum.nunc.id@purus.com','Apartado núm.: 251, 3431 Dui Carretera','1998/11/19',6),(8,'Dustin','Montgomery','Oneill','ante.Nunc.mauris@adipiscing.org','Apartado núm.: 845, 4288 Non, ','1999/10/11',6),(9,'Marny','Santana','Cannon','eu.arcu.Morbi@Aliquamtincidunt.edu','Apdo.:439-2227 Fringilla ','1998/06/11',5),(10,'Dalton','Woodward','Dejesus','faucibus.id@pedeblanditcongue.edu','5596 Ultricies Av.','1998/12/06',6);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(11,'Kendall','Head','Mccoy','Nunc.sed.orci@egetodioAliquam.net','6239 In Avenida','1999/05/11',5),(12,'Avye','Cox','Pickett','justo.eu@ornarelibero.ca','Apdo.:122-2277 Diam. ','1999/09/27',6),(13,'Mari','Romero','Moss','ornare.Fusce@et.org','Apdo.:424-6331 Sit Avda.','1999/07/13',6),(14,'Jayme','Slater','Schwartz','Phasellus@ipsumnon.co.uk','4193 Iaculis Av.','1999/12/23',4),(15,'Tallulah','Ray','Lawrence','neque.Nullam@dis.ca','Apdo.:787-586 Tortor. Ctra.','1998/09/23',6),(16,'Blaze','Morales','Conrad','dui.Cras@cursuset.org','Apartado núm.: 266, 778 Tellus C/','1998/05/14',6),(17,'Callum','Mclean','Reid','nonummy@lacusvariuset.net','Apartado núm.: 597, 2673 Lacus. Carretera','1998/11/02',6),(18,'Cullen','Frost','Farley','vitae@accumsanlaoreet.org','306-2225 Aliquam Ctra.','1999/09/10',5),(19,'Susan','Ellis','Stein','tellus.imperdiet.non@amet.co.uk','4134 Adipiscing Carretera','1999/06/26',5),(20,'Jelani','Keller','Beck','sed.tortor@orci.com','6261 Scelerisque ','1998/10/06',6);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(21,'Stuart','Deleon','Marsh','eget@nullaIntegerurna.edu','Apdo.:147-5156 Diam. Calle','1999/01/01',4),(22,'Roth','Benjamin','Rosales','varius@porttitorscelerisque.edu','Apartado núm.: 382, 7821 Sem C/','1998/12/10',4),(23,'Ruby','Hensley','Moore','eleifend.egestas@utlacusNulla.ca','Apdo.:811-6669 Diam C/','1999/09/27',5),(24,'Howard','Hernandez','Walters','id.libero@tellusjustosit.com','7188 Orci. C.','1998/06/05',6),(25,'Dillon','Gates','Lindsey','malesuada@vel.edu','Apdo.:415-1775 Consectetuer Ctra.','1998/04/15',6),(26,'Mohammad','Shaffer','Mclaughlin','neque@rhoncusNullam.net','Apartado núm.: 653, 3659 Ipsum Avda.','1999/07/06',4),(27,'Martena','Hahn','Harding','varius@ut.ca','Apartado núm.: 324, 7845 Sed Avda.','1999/04/17',4),(28,'Mariko','Roy','Maldonado','amet.metus@feugiat.edu','6556 Mollis C.','1999/09/30',4),(29,'Lucius','Hayden','Bush','orci.Donec@liberoProinsed.com','1904 Aliquam Avenida','1998/03/14',4),(30,'Evan','Stewart','Payne','Donec.est.Nunc@parturientmontesnascetur.edu','Apartado núm.: 622, 694 Neque ','1999/10/30',6);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(31,'Rashad','Casey','Anthony','tempor.est@odioPhasellus.co.uk','Apdo.:969-998 Nulla Avda.','1998/09/13',5),(32,'Barry','Lowe','Snyder','nec.cursus.a@CrasinterdumNunc.org','Apdo.:625-6390 Aenean Av.','1998/12/28',4),(33,'Dahlia','Lara','Benton','molestie.tortor.nibh@fermentumrisus.co.uk','Apartado núm.: 780, 4057 Cras Avda.','1998/10/02',6),(34,'Ramona','Berger','Lawrence','tortor.at.risus@incursus.co.uk','Apartado núm.: 453, 7692 Sed ','1998/02/02',5),(35,'Jaime','Lara','Miller','ultrices.iaculis@diam.com','5548 Pretium ','1998/02/25',4),(36,'Ella','Hess','Mcdaniel','nisi.dictum.augue@ipsum.co.uk','4991 Malesuada Carretera','1999/04/26',5),(37,'Kyle','Monroe','Kramer','Phasellus@sem.net','793-9061 Nunc Avenida','1999/09/02',4),(38,'Sloane','Cox','Whitehead','posuere@quismassa.com','Apartado núm.: 595, 7296 Enim C/','1998/09/11',5),(39,'Ulric','Myers','Nash','Nam.interdum@miAliquamgravida.com','745-513 Nam Avda.','1998/06/03',5),(40,'Ann','Diaz','Weiss','enim@aliquetProinvelit.co.uk','906-6288 A Calle','1999/05/25',6);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(41,'Daquan','Sullivan','Dotson','In.nec.orci@nonlobortisquis.net','Apartado núm.: 417, 3414 Massa. Avenida','1999/11/18',6),(42,'Flynn','Witt','Harding','iaculis.nec.eleifend@habitant.ca','Apartado núm.: 114, 3592 Ac ','1998/10/24',4),(43,'Clark','Griffith','Oneal','enim.Etiam@Curabiturvel.org','2699 Ut C.','1999/12/10',6),(44,'Fay','Mcmillan','Dillard','gravida.Aliquam.tincidunt@ipsumcursus.net','3997 Dictum. C/','1999/01/12',5),(45,'Asher','Wilkerson','Holloway','dui@nonummyFuscefermentum.org','982-598 Est Av.','1999/02/23',4),(46,'Zephr','Doyle','Kirby','vulputate.dui.nec@SuspendissesagittisNullam.com','Apartado núm.: 185, 331 A Avda.','1998/03/29',4),(47,'Cade','Simpson','Chase','a@pellentesquemassa.com','5083 Posuere C.','1998/11/03',5),(48,'Demetria','Anderson','Le','lorem.ipsum@ultricies.edu','3763 Cras Av.','1998/06/14',5),(49,'Trevor','Bean','Stephens','facilisis.eget.ipsum@aliquetlibero.org','Apdo.:589-9993 Orci, C.','1999/04/11',4),(50,'Harrison','Collins','Tucker','ac@pedesagittis.com','Apartado núm.: 491, 935 Sed Avda.','1999/11/10',6);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(51,'Caldwell','Pope','Sims','aliquet@Inornaresagittis.ca','Apdo.:781-3958 Eleifend Ctra.','1999/02/11',6),(52,'Berk','Levine','Gray','cursus.a.enim@sitamet.co.uk','509-6291 Proin Calle','1999/07/16',6),(53,'Colin','Ellison','Vargas','pellentesque.massa@ac.co.uk','7454 Vel, Avenida','1999/07/07',6),(54,'Fletcher','Fowler','Burgess','eu.ultrices@elitpede.co.uk','8262 Leo. C.','1999/06/28',6),(55,'Rina','Parker','Rowland','sagittis.semper.Nam@pede.net','8902 Ligula. Avda.','1998/01/25',5),(56,'Eaton','Wiley','Hobbs','Nunc.sollicitudin@cursusNuncmauris.ca','550-944 Vitae Ctra.','1998/04/01',5),(57,'Lacota','Sparks','Fitzpatrick','ac@elitEtiamlaoreet.edu','202 Lorem, Avenida','1999/05/04',4),(58,'Pandora','Hester','Wilkerson','tempus.non.lacinia@semperetlacinia.org','608-3905 Integer C/','1998/12/06',5),(59,'Britanni','Green','Chandler','malesuada@Aliquamornarelibero.org','Apartado núm.: 304, 977 Quis Avda.','1998/03/14',5),(60,'Indira','Fitzgerald','Middleton','erat@ligulaNullamfeugiat.com','822-3662 Velit C.','1998/01/11',4);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(61,'Laith','Wells','Rodgers','bibendum.Donec.felis@Aeneaneget.co.uk','635 Erat. Ctra.','1998/05/09',6),(62,'Imani','Thomas','Black','ac.urna@tempusrisusDonec.net','Apdo.:360-3141 Ipsum Avda.','1998/01/09',4),(63,'Latifah','Mcneil','Gillespie','est@morbitristiquesenectus.ca','Apdo.:618-7218 Et, Carretera','1998/01/12',5),(64,'Charde','Butler','Reilly','Pellentesque@convallis.org','Apdo.:189-8101 Proin Carretera','1999/08/07',4),(65,'Ursula','Parks','Horton','hendrerit.id@Mauris.co.uk','Apdo.:405-4036 Non, Ctra.','1999/06/07',4),(66,'Zephania','Carey','Waller','sed@loremvehicula.org','Apartado núm.: 302, 7576 Gravida. Avda.','1998/01/08',6),(67,'Julian','Stephenson','Baker','Phasellus@Etiam.com','Apartado núm.: 680, 8395 Fringilla Avenida','1999/01/19',4),(68,'Mercedes','Campbell','Luna','ligula@Sedegetlacus.org','Apartado núm.: 704, 1087 Duis Ctra.','1999/02/22',6),(69,'Fay','Blackburn','Barber','aliquet.sem.ut@ligulaelitpretium.com','988-1049 Sed Av.','1998/05/25',4),(70,'Rhonda','Santiago','Roman','dui@sedlibero.ca','Apdo.:425-6133 Ornare, Avenida','1998/06/02',5);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(71,'Kibo','Wynn','Villarreal','montes.nascetur@arcuiaculis.net','4316 Mauris. ','1998/01/23',4),(72,'Katell','Everett','Klein','cursus@velitSedmalesuada.com','568-6810 Sed Carretera','1999/05/19',5),(73,'Bryar','Gilbert','Mcbride','In.condimentum@lacus.edu','6608 Primis Av.','1998/11/03',4),(74,'Chantale','Waller','Yates','urna.justo.faucibus@eleifend.edu','5430 Nisl Avenida','1999/01/19',4),(75,'Calvin','Church','Finch','vehicula.aliquet.libero@Quisquenonummy.ca','Apdo.:888-3708 Metus. Avenida','1998/07/12',4),(76,'Tanek','Strong','Reynolds','congue.turpis@orciUtsagittis.co.uk','Apdo.:926-569 Nunc C.','1999/01/29',4),(77,'Idola','Shaw','Dyer','sagittis.Nullam.vitae@eu.org','157-1041 Etiam Av.','1999/02/15',4),(78,'Marshall','Carroll','Curtis','ac@purus.ca','Apartado núm.: 928, 1066 Vulputate Carretera','1998/09/01',6),(79,'Xandra','Olson','Cotton','libero.at.auctor@Uttincidunt.com','Apartado núm.: 499, 7614 Consequat, Avenida','1998/06/10',4),(80,'Cherokee','Schwartz','Owen','nostra.per.inceptos@Crassed.com','281-4375 Blandit Ctra.','1998/03/23',5);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(81,'Regina','Ingram','Maynard','amet.ornare@dis.net','Apdo.:645-320 Cras Avenida','1998/10/22',5),(82,'Ronan','Stevenson','Gamble','erat.Etiam.vestibulum@velpedeblandit.com','242-4427 Tempor Calle','1998/01/17',5),(83,'Edan','Mckee','Bush','odio.Nam.interdum@elitAliquamauctor.net','618-3516 Amet Avda.','1998/12/20',6),(84,'Riley','Elliott','Moses','ligula.Nullam.feugiat@Nullamscelerisque.ca','133-7804 Diam Ctra.','1998/11/09',4),(85,'Tashya','Schmidt','Houston','orci.Phasellus.dapibus@ipsumSuspendissesagittis.ca','6071 Et Avda.','1999/07/10',4),(86,'Merrill','Merritt','Tillman','interdum.Nunc@quispede.edu','746-803 Et, Avenida','1998/05/14',5),(87,'Brandon','Benson','Gilbert','egestas.blandit@neque.ca','363 Sodales Ctra.','1999/05/01',5),(88,'Valentine','Dunlap','Lott','eget@utipsumac.co.uk','Apdo.:292-1336 Aliquet. Avenida','1998/02/10',5),(89,'Tyrone','Navarro','Whitley','vestibulum.massa.rutrum@temporeratneque.ca','Apartado núm.: 296, 973 Lectus Calle','1998/12/13',4),(90,'Quynn','Glover','Rosario','Mauris@SeddictumProin.com','852-795 Proin Av.','1998/11/06',4);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(91,'Dawn','Sweeney','Case','eu@elitafeugiat.com','Apartado núm.: 121, 6328 Vel Av.','1998/07/04',4),(92,'Serina','Richard','Love','Aliquam@hendreritDonec.co.uk','410-6536 Auctor C.','1998/01/14',5),(93,'Dillon','Marks','Kaufman','Curae.Donec.tincidunt@enimCurabiturmassa.co.uk','3704 At, Av.','1998/08/12',4),(94,'Kathleen','Roth','Leon','Fusce.fermentum@Aeneaneget.com','396-7519 Bibendum. Av.','1999/12/14',6),(95,'Lawrence','Logan','Andrews','nec@nunc.com','9495 Cras Carretera','1999/10/15',4),(96,'Lacy','Humphrey','Mcgee','aliquam.eros@urna.ca','972-7211 Odio Avda.','1999/08/07',5),(97,'Theodore','Rodgers','Lowery','dis@et.ca','116-2481 Nullam Calle','1999/03/18',6),(98,'Hayley','Wheeler','Barlow','fermentum.arcu.Vestibulum@hendreritconsectetuercursus.ca','468-3059 Integer Avenida','1998/05/13',5),(99,'Lael','Holcomb','Rasmussen','sociis.natoque.penatibus@magna.edu','Apartado núm.: 685, 4560 Aliquam C/','1998/12/21',5),(100,'Lynn','Lott','Gilbert','Integer.vitae.nibh@etrisus.org','859 Non, Carretera','1998/03/02',5);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(200,'Noelani','Sheppard','Stephens','Proin.nisl@acorci.edu','Apartado núm.: 209, 2134 Tortor. Av.','1999/03/15',1),(101,'Drew','Travis','Pearson','nulla.Cras.eu@Suspendisse.edu','8464 In C.','1999/04/15',1),(102,'Kellie','Gray','Mcgee','facilisi@venenatis.ca','Apartado núm.: 153, 4429 Duis Avenida','1999/07/07',1),(103,'Erich','Lewis','Fleming','luctus@Morbi.org','Apartado núm.: 691, 5109 Morbi ','1998/08/14',1),(104,'Roanna','Patterson','Montgomery','nascetur@Utnecurna.co.uk','9585 Donec Carretera','1999/04/15',1),(105,'Oren','Dean','Peck','mi@accumsanneque.org','Apartado núm.: 142, 7960 Sociis C.','1999/03/16',1),(106,'Lillith','Farley','Sutton','sagittis.lobortis.mauris@utcursus.net','161-9861 Rutrum Av.','1999/08/10',1),(107,'Henry','Buck','Ferguson','massa@Sedauctor.org','Apartado núm.: 354, 1256 Etiam Avda.','1998/10/31',1),(108,'Samuel','Molina','Burton','Cum@nostraper.org','Apdo.:167-4447 Est. Carretera','1998/01/17',1),(109,'Judah','Juarez','Hendricks','volutpat.Nulla@consequatdolor.org','797-912 Malesuada Av.','1999/09/07',1);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(110,'Ulric','Park','Rivas','sem@amet.edu','Apartado núm.: 297, 4196 Lobortis Avda.','1999/05/30',1),(111,'Mark','Holder','Hobbs','pretium.et@primis.co.uk','552-4676 Vivamus ','1998/02/12',1),(112,'Melissa','King','Stein','Nullam.velit.dui@Fusce.edu','Apdo.:277-3009 Iaculis ','1998/05/24',1),(113,'Orli','Petty','Herrera','Pellentesque@mauris.edu','Apdo.:317-8629 Mauris Carretera','1999/09/18',1),(114,'Heather','Acevedo','Welch','sed@orciUtsemper.org','Apdo.:616-1830 Consectetuer Avenida','1999/11/08',1),(115,'Richard','Tucker','Becker','auctor.Mauris.vel@musProin.com','2306 Dui, Avda.','1998/11/04',1),(116,'Bruno','Greer','Willis','Fusce.mollis@mipede.net','181-5531 Mauris Calle','1999/10/22',1),(117,'Adara','Marquez','Weeks','nec.urna@lectussit.ca','Apartado núm.: 916, 7233 Bibendum Av.','1998/02/07',1),(118,'Liberty','Clements','Duran','purus.gravida@sitametorci.net','Apdo.:249-9484 Dolor ','1998/06/23',1),(119,'Darius','Mcgee','Petty','feugiat@etpede.co.uk','Apartado núm.: 338, 4081 Felis Ctra.','1999/09/07',1);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(120,'Jana','Woods','Graves','consequat.purus@ullamcorpernislarcu.net','Apartado núm.: 126, 5405 Turpis ','1998/04/13',1),(121,'Raja','Booker','Walsh','Nam.interdum.enim@magnatellus.edu','Apartado núm.: 619, 6926 Ac Avda.','1999/06/05',1),(122,'Demetria','Cooley','Le','hendrerit.neque.In@leoelementum.ca','Apartado núm.: 249, 2410 Non, Ctra.','1999/12/27',1),(123,'Shaeleigh','Welch','Gutierrez','Nunc.mauris.sapien@erategettincidunt.org','1325 Eros. Av.','1998/01/09',1),(124,'Brent','Serrano','Coleman','ultrices.Vivamus@in.co.uk','494-3140 Phasellus Avenida','1998/02/10',1),(125,'Anjolie','Hopper','Reeves','pede.sagittis@libero.ca','2321 Consequat C/','1999/02/20',1),(126,'Ray','Nieves','Jefferson','penatibus@lectuspedeet.com','Apdo.:327-6954 Pellentesque ','1999/02/21',1),(127,'Carissa','Head','Blanchard','Fusce.aliquam.enim@ametrisus.co.uk','Apdo.:128-6867 Proin Avenida','1998/10/22',1),(128,'Owen','Fisher','Wood','nibh@tristique.org','Apdo.:477-7752 Donec Av.','1998/02/22',1),(129,'Donna','Garrison','Good','pellentesque.massa.lobortis@diamloremauctor.org','206-5783 Sodales. ','1998/11/17',1);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(130,'Macy','Townsend','Keith','non.justo@dictumcursusNunc.ca','Apdo.:393-9192 Et C.','1998/09/10',1),(131,'Kasper','Nunez','Gaines','sagittis@metusfacilisis.co.uk','1470 Nulla. Calle','1999/09/21',1),(132,'Sopoline','Coleman','Beach','Suspendisse.ac@odioNam.org','560-9735 Metus Avenida','1998/08/07',1),(133,'Leroy','Hatfield','Norton','risus@sedpedenec.net','332-4793 Tempor Avenida','1998/06/01',1),(134,'Rajah','Sears','Morales','Nulla.semper@ullamcorpereueuismod.ca','Apdo.:146-3548 Duis ','1999/05/20',1),(135,'Alvin','Jimenez','Estes','elit.a.feugiat@sitamet.co.uk','9303 Pharetra. Avenida','1998/08/19',1),(136,'Phoebe','Sargent','Stevenson','elit.Curabitur@mollisnec.org','143-6092 Et C/','1998/10/21',1),(137,'Alfonso','Klein','Cote','condimentum.eget.volutpat@eutempor.org','Apartado núm.: 413, 1029 Id, Av.','1999/06/17',1),(138,'Aurelia','David','Rowland','auctor.vitae@acorciUt.org','Apdo.:274-2240 Rutrum Avenida','1998/06/09',1),(139,'Rose','Delaney','Roberts','Vivamus.nisi@Morbi.edu','183-7381 Tempus ','1999/05/24',1);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(140,'Brooke','Dodson','Moss','risus@Integer.edu','Apdo.:492-3606 Sem Av.','1999/09/16',1),(141,'Lacey','Aguilar','Farmer','nibh@diamSed.ca','197-6539 Fringilla C/','1998/11/23',1),(142,'Linus','Morin','Velazquez','auctor.velit@risusvariusorci.com','3379 Volutpat Ctra.','1998/05/05',1),(143,'Felix','Charles','Foreman','ac.facilisis.facilisis@Proin.edu','5281 Luctus Calle','1998/07/07',1),(144,'Macaulay','Daniels','Travis','nisl.Maecenas.malesuada@mollis.co.uk','509-3150 Nec Calle','1999/10/28',1),(145,'Tatum','Farley','Hudson','Aenean@interdumligula.co.uk','Apdo.:150-5572 Ut Avda.','1999/05/08',1),(146,'Tucker','Day','Wyatt','Sed.nec.metus@pedeSuspendisse.co.uk','202-8663 Posuere Calle','1999/10/06',1),(147,'Galvin','Kerr','Tate','placerat@magnisdisparturient.edu','2647 Vulputate, Ctra.','1998/05/02',1),(148,'Brooke','Maddox','Collier','posuere.cubilia.Curae@velconvallis.net','Apartado núm.: 134, 925 Iaculis Av.','1999/05/27',1),(149,'Dexter','Finch','Hoffman','velit@magnisdisparturient.edu','4633 Egestas Avda.','1998/07/22',1);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(150,'Kennedy','Morrow','Conley','Praesent.luctus.Curabitur@eget.org','Apartado núm.: 425, 3739 Magna. Avda.','1998/06/23',1),(151,'Deirdre','Turner','Hanson','metus.eu@felis.edu','Apdo.:348-8735 Tellus. Avenida','1998/07/30',1),(152,'Madison','Welch','Dickerson','vestibulum.lorem.sit@ipsumcursus.com','Apdo.:998-683 Lacus. ','1999/08/28',1),(153,'Forrest','Pitts','Ingram','sed.orci@quis.co.uk','Apdo.:317-6669 Nisl. Avenida','1999/04/14',1),(154,'Cally','Stephenson','Henson','laoreet.posuere.enim@turpis.org','Apdo.:640-8082 Cras C.','1999/08/18',1),(155,'Carolyn','Floyd','Gray','inceptos@rhoncusNullam.co.uk','Apdo.:148-2182 Nam Calle','1998/04/24',1),(156,'Xander','Solomon','Ayers','euismod.est@et.edu','Apartado núm.: 818, 4764 Ut Avda.','1998/11/17',1),(157,'Nolan','Cardenas','Diaz','rutrum.justo.Praesent@bibendumsedest.co.uk','Apdo.:396-7971 Praesent Ctra.','1999/07/12',1),(158,'Marsden','Meyer','Cochran','molestie.dapibus@pharetranibhAliquam.com','Apartado núm.: 973, 3174 Elementum C/','1998/04/01',1),(159,'Dante','Callahan','Noble','convallis.erat.eget@felispurusac.org','Apdo.:548-4687 Dolor Avda.','1999/06/17',1);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(160,'Kadeem','Albert','Curry','Donec.fringilla.Donec@tincidunt.org','5302 Non Avenida','1999/08/26',1),(161,'Kelsey','Crawford','Cox','dolor@sagittislobortis.net','5256 Vel ','1999/04/18',1),(162,'Kimberley','Mcdowell','Stewart','tellus@mi.com','673-5753 Aliquam C/','1999/03/27',1),(163,'Adele','Baldwin','Castaneda','tristique@Vestibulumut.net','Apdo.:778-189 Sociis Avda.','1999/08/25',1),(164,'Lars','Leblanc','Johns','auctor.quis@egetodioAliquam.net','5479 Commodo ','1998/01/14',1),(165,'Steel','Rich','Fletcher','Integer.mollis@eleifendvitae.co.uk','Apartado núm.: 922, 1500 In Avenida','1998/05/23',1),(166,'Florence','Mcdowell','Bowman','augue.eu.tellus@tellus.co.uk','6112 Ante. Av.','1999/08/25',1),(167,'Damian','Buckley','Ramsey','enim@etrisusQuisque.net','Apdo.:330-4231 Egestas Avenida','1999/12/19',1),(168,'Jillian','Larson','Buck','Mauris@consectetuereuismod.com','Apartado núm.: 835, 4594 Dolor, Avda.','1998/11/25',1),(169,'Tasha','Reid','Kirk','molestie.tortor.nibh@pedesagittis.edu','Apartado núm.: 624, 4091 Nulla. Calle','1999/06/29',1);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(170,'Blaze','Bean','Wright','eu@tinciduntnunc.co.uk','Apdo.:919-7766 Elit. Av.','1998/08/14',1),(171,'Wayne','Roach','Deleon','non.sapien@rhoncusDonec.com','Apdo.:484-1093 Lorem Avenida','1999/08/27',1),(172,'Lance','Mathis','Rosario','Fusce.aliquam.enim@erosnec.org','Apartado núm.: 661, 9584 Sollicitudin C/','1999/08/25',1),(173,'Noble','Andrews','Farmer','blandit@acfermentum.net','Apartado núm.: 310, 5248 Dui. Carretera','1999/06/28',1),(174,'Yolanda','Gibbs','Weiss','urna.Ut.tincidunt@etnetus.net','Apartado núm.: 278, 1939 Elit C/','1998/01/25',1),(175,'Asher','Lara','Huber','et@ac.net','Apdo.:861-5933 Nascetur Carretera','1999/09/09',1),(176,'Guy','Walsh','Cleveland','accumsan.interdum.libero@tristiqueaceleifend.edu','Apartado núm.: 452, 4487 Sed C.','1999/07/28',1),(177,'Beverly','Banks','Lawrence','gravida.sit@Nullamnisl.org','Apartado núm.: 175, 9064 Mi Av.','1998/03/06',1),(178,'Quincy','Perez','Cochran','turpis.non@Donecfringilla.org','422-4076 Neque C.','1999/03/24',1),(179,'Yasir','Wade','Compton','gravida@ac.edu','Apartado núm.: 244, 3800 Lorem Avenida','1998/12/21',1);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(180,'Kristen','Cooley','Suarez','auctor.quis@hendrerit.net','3018 Eu ','1999/08/10',1),(181,'Emily','Hurst','Miller','urna@lectuspedeultrices.com','Apartado núm.: 271, 8133 Mauris Ctra.','1999/08/06',1),(182,'Lynn','Holloway','Foreman','semper@pharetra.org','669-3960 Nisi. Avenida','1998/10/28',1),(183,'Belle','Ramirez','Schultz','vulputate.nisi.sem@et.net','954-8873 Nunc ','1998/01/11',1),(184,'Justine','Hartman','Hayden','Aliquam@neccursusa.com','804 Euismod Avenida','1998/08/28',1),(185,'Ahmed','Justice','Salinas','feugiat@atiaculisquis.ca','2588 Ante, Calle','1999/01/12',1),(186,'Colin','Coleman','Frederick','In.faucibus.Morbi@mollis.edu','9793 Magna. Calle','1999/04/23',1),(187,'Ella','Dunlap','Golden','Praesent.eu@eusemPellentesque.com','Apartado núm.: 572, 6913 Nam Carretera','1999/02/17',1),(188,'Leo','Hayes','Turner','nec.tempus.mauris@Phasellusfermentum.edu','5659 Odio. Av.','1998/03/02',1),(189,'Velma','Diaz','Hooper','interdum.feugiat.Sed@acmattisvelit.ca','997-2662 Proin Calle','1998/05/21',1);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(190,'Rogan','Joyce','Martin','pretium.aliquet@Sed.ca','Apartado núm.: 714, 2637 Ridiculus Av.','1998/11/29',1),(191,'Desiree','Duran','Serrano','ac@dictummiac.com','453-1746 Nec Carretera','1998/03/08',1),(192,'Anika','Bright','Ware','mi.enim.condimentum@pedenec.edu','Apartado núm.: 990, 3711 Dui, C/','1999/03/23',1),(193,'Tanya','Barnes','Knight','ullamcorper.eu@luctusvulputatenisi.com','Apdo.:772-2140 Natoque Carretera','1998/08/10',1),(194,'Mara','Adams','Grant','mauris.erat@Quisque.org','Apartado núm.: 688, 9693 Elit. C/','1999/05/22',1),(195,'Tasha','Tyler','Wall','quis@adipiscingfringillaporttitor.com','159-6248 Neque Avenida','1998/02/14',1),(196,'Ezra','Wiggins','Houston','Sed@ametorci.co.uk','Apdo.:482-8781 Duis Calle','1998/10/06',1),(197,'Devin','Rosales','Joseph','aliquet.Proin.velit@euultrices.ca','9463 Semper ','1998/09/30',1),(198,'Kieran','Anderson','Flowers','dictum.placerat@atauctorullamcorper.ca','Apartado núm.: 240, 4297 Ligula Av.','1999/07/26',1),(199,'Tanisha','Dickerson','Cherry','pellentesque.a@tempus.com','Apartado núm.: 119, 6133 Vitae, Ctra.','1999/08/03',1);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(201,'Sybill','York','Berg','molestie.tellus.Aenean@Phasellusvitae.edu','Apdo.:115-3848 Sed C/','1999/07/21',8),(202,'Guy','Mendoza','Spencer','Nam.ac.nulla@laoreetlectusquis.com','Apdo.:365-9050 Sit C/','1998/02/22',8),(203,'Hakeem','Baldwin','Mcmahon','est.ac.facilisis@pellentesqueSed.edu','308-5548 Id, C/','1998/10/01',9),(204,'Holly','Ramos','Pennington','pretium.neque.Morbi@tinciduntvehicularisus.org','1831 Egestas. ','1999/12/10',7),(205,'Plato','Faulkner','Reyes','vel.arcu.eu@ridiculus.com','1302 A Ctra.','1999/12/15',7),(206,'Velma','Ellis','Edwards','enim@Nullamfeugiat.ca','8636 Ac Av.','1998/11/16',9),(207,'Chaim','Norris','Grimes','ornare@magnaUttincidunt.net','Apartado núm.: 740, 2591 Eget Avenida','1998/08/19',7),(208,'Shannon','Haynes','Craft','nec.tempus@venenatisa.ca','7229 Enim. Av.','1999/03/04',7),(209,'Reagan','Byrd','Bean','varius@mattissemperdui.edu','Apdo.:340-6054 Libero Carretera','1998/06/12',8),(210,'Ariel','Waters','Stephens','nonummy@arcu.org','211-377 Aliquet. Carretera','1999/10/12',7);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(211,'Mason','Jefferson','Kline','placerat.augue.Sed@vitaealiquetnec.edu','452-1209 Nec Calle','1999/04/25',9),(212,'Ahmed','Carney','Mendez','aliquet.diam.Sed@eu.ca','561-6461 Felis Ctra.','1998/08/08',9),(213,'Jacob','Maxwell','Moody','enim@iaculisaliquet.ca','8448 Massa C/','1999/04/03',9),(214,'Charlotte','Ochoa','Leonard','sit.amet.consectetuer@Donecfelis.edu','Apartado núm.: 494, 3124 Mattis. Calle','1999/04/03',9),(215,'Carter','Knowles','Keith','blandit.at@leoelementum.org','110-126 Diam ','1998/06/21',9),(216,'Cora','Spencer','Reilly','ullamcorper.Duis@ullamcorperDuis.org','981-9582 Magna C/','1998/09/08',9),(217,'Tiger','Singleton','Bender','facilisis.eget.ipsum@nulla.com','703-8810 Eget Calle','1998/01/23',7),(218,'Teegan','Atkinson','Sargent','vel@congueelitsed.co.uk','8227 Pharetra Av.','1999/07/05',8),(219,'Quamar','Stephens','Garrett','amet@Phasellus.net','Apdo.:140-7535 Natoque Avda.','1999/03/03',7),(220,'Deborah','Bullock','Roth','iaculis.quis.pede@imperdietullamcorperDuis.co.uk','Apartado núm.: 501, 9011 Facilisi. ','1999/08/07',7);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(221,'Ocean','Case','Koch','pretium.neque@est.net','9992 Magna Ctra.','1998/05/21',9),(222,'Ross','Shields','Riddle','dis.parturient.montes@risusNulla.ca','Apartado núm.: 720, 8922 Nullam Avenida','1999/04/06',8),(223,'Kaseem','Richards','Johnson','commodo.hendrerit.Donec@magna.net','366-5843 Ante C/','1998/06/29',8),(224,'Oliver','Travis','Cobb','sit.amet@antedictum.net','863-1411 Sit Carretera','1999/03/21',9),(225,'Ivor','Ellis','Morales','faucibus.Morbi@ut.net','Apartado núm.: 761, 5687 Nullam Calle','1999/09/19',7),(226,'Calvin','Glenn','Mcintyre','Vivamus.euismod.urna@adipiscingMauris.com','Apartado núm.: 617, 5708 Eros. C/','1999/03/05',9),(227,'Bert','Delacruz','Lang','Donec.est.Nunc@magna.org','306 Odio. ','1999/11/27',8),(228,'Abel','Navarro','Woods','vulputate@nequeNullamnisl.net','746-3609 Libero. Calle','1998/07/02',9),(229,'Kirestin','Patel','Rosario','urna@fringilla.co.uk','Apdo.:606-1834 Vehicula Avda.','1998/08/28',7),(230,'Tucker','Mccarthy','Moss','viverra@Vivamusnonlorem.co.uk','8066 Donec Calle','1999/12/14',9);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(231,'Cole','Harrison','Owen','mi.fringilla.mi@sempertellusid.org','Apdo.:751-442 Ut Avenida','1999/05/16',9),(232,'Grant','Steele','Thornton','dolor.sit@est.edu','Apartado núm.: 199, 6827 Dui. Avenida','1998/02/17',9),(233,'Gage','Talley','Calhoun','hendrerit.id@aliquameros.org','175-6764 Vehicula Avenida','1998/10/09',8),(234,'Alika','Munoz','Sears','enim.sit.amet@musProin.edu','8837 A, C.','1999/12/22',9),(235,'Noble','Galloway','Foreman','Donec.elementum@ut.net','Apdo.:680-9483 Vivamus Avenida','1998/06/03',9),(236,'Grady','Cooke','Bradley','feugiat@nectempus.org','Apartado núm.: 926, 5742 Ut, C.','1999/11/26',9),(237,'Robin','Roberts','Lee','diam.Proin.dolor@dapibus.edu','4406 Mauris. Ctra.','1999/09/23',7),(238,'Petra','Gordon','Castaneda','felis@purusaccumsaninterdum.co.uk','Apartado núm.: 581, 2232 Vestibulum Avenida','1998/08/26',9),(239,'Clinton','Wood','Dyer','arcu.Sed@Donec.ca','6281 Lectus Ctra.','1998/09/22',7),(240,'Erin','Chambers','Moore','dolor@Innecorci.com','392-2532 Mauris. Avda.','1998/03/01',9);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(241,'Karly','Spencer','Dejesus','orci@in.org','Apdo.:935-6262 Sociis C/','1998/04/22',8),(242,'Remedios','Dominguez','Hester','enim.mi@Nam.co.uk','Apartado núm.: 580, 6088 Volutpat. C/','1998/05/05',9),(243,'Odysseus','Clarke','Hughes','mi.ac@Integer.net','Apartado núm.: 981, 9795 Mattis Avenida','1999/05/05',9),(244,'Sonia','Faulkner','Martin','mi.fringilla@tincidunt.org','845-5366 Eu Carretera','1998/09/27',7),(245,'Teagan','Maldonado','Haynes','a.sollicitudin@Nullafacilisis.net','5433 Massa. Carretera','1998/07/15',8),(246,'Fiona','Oneill','Reese','mattis.velit@semperet.ca','Apdo.:502-5939 Tempor C/','1998/09/17',8),(247,'Sybil','Parker','Castillo','Sed.auctor@Crasdolor.net','Apdo.:362-9689 Egestas. C/','1998/10/28',9),(248,'Paul','Holland','Johnston','elit.fermentum.risus@enimsit.org','Apartado núm.: 904, 4865 Eget ','1999/07/13',7),(249,'Kermit','Tran','Bray','at.velit@tristiquepharetra.co.uk','Apdo.:966-8471 Ante Calle','1999/07/20',8),(250,'Noelani','Hartman','Kerr','tincidunt@Nullam.net','Apartado núm.: 251, 3855 Lorem C/','1998/05/08',8);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(251,'Wyatt','Greer','Duran','tellus.sem@sem.edu','Apartado núm.: 915, 2702 Dolor Avenida','1998/10/17',7),(252,'Aurelia','Pickett','Mccray','Duis@tristiquesenectuset.co.uk','Apdo.:947-7133 Gravida Av.','1999/06/04',7),(253,'Shay','Clayton','Colon','Vestibulum.accumsan@neque.com','Apdo.:901-3723 Et Carretera','1998/12/08',8),(254,'Gareth','Sampson','Calderon','facilisi.Sed@maurisSuspendisse.com','9665 Fringilla Avenida','1999/10/29',8),(255,'Vielka','Mclean','Cote','dictum.magna@pedePraesent.net','9664 Sed C.','1998/06/17',8),(256,'Stephanie','Mueller','Hogan','Phasellus@odioNaminterdum.com','Apdo.:606-5612 Tristique Avda.','1998/11/26',7),(257,'Damian','Lamb','Weaver','sapien@ametultricies.net','Apartado núm.: 870, 4169 Natoque Calle','1998/01/27',9),(258,'Trevor','Church','Bates','eget.laoreet.posuere@lacusQuisque.ca','Apdo.:818-2937 Auctor Avda.','1999/09/21',9),(259,'Wendy','Goodman','Kelley','Etiam.imperdiet.dictum@velit.net','Apartado núm.: 768, 4060 Aenean Carretera','1999/07/12',9),(260,'Lewis','Douglas','Donaldson','mattis@erat.co.uk','Apdo.:807-8632 Vel Carretera','1998/03/18',8);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(261,'Elvis','Manning','Kent','metus.In@dolordapibus.ca','469-7259 Nisi Calle','1998/06/18',7),(262,'Gray','Buck','Robles','sit.amet.faucibus@ornarelectus.co.uk','Apdo.:529-8266 Lacinia C.','1999/09/19',8),(263,'Jared','Silva','Mann','mauris.Suspendisse@dui.edu','Apartado núm.: 895, 708 Interdum C/','1998/12/27',8),(264,'Vivian','Landry','Hebert','risus@Phaselluselitpede.com','Apdo.:938-365 Ullamcorper. Carretera','1999/11/21',8),(265,'Tana','Noble','Aguirre','Sed.dictum.Proin@ullamcorperDuis.com','Apartado núm.: 600, 6910 Nunc C/','1999/06/19',7),(266,'Kaseem','Salinas','Whitehead','sodales@molestiepharetra.co.uk','4230 Eu Carretera','1998/03/14',8),(267,'Charde','Justice','Ayers','primis@risusquisdiam.net','Apdo.:361-8551 Mauris Avenida','1998/03/09',8),(268,'Buckminster','Chaney','Villarreal','lacus.Quisque.imperdiet@tinciduntpedeac.com','Apdo.:736-3333 Facilisis Calle','1998/10/20',8),(269,'Eve','Mullins','Quinn','Nulla.facilisis.Suspendisse@Suspendisseac.com','Apdo.:738-1207 Tellus. Avenida','1999/01/03',7),(270,'Blythe','Fowler','Gaines','dolor.vitae@lectuspedeet.co.uk','Apartado núm.: 921, 1054 Vulputate Avenida','1998/08/21',8);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(271,'Nasim','Hess','Carey','in.hendrerit.consectetuer@neque.com','Apartado núm.: 121, 6617 Non, Carretera','1998/10/27',7),(272,'Bruno','Hicks','Hicks','ipsum@variusorci.org','Apartado núm.: 973, 9924 Pretium ','1999/07/06',9),(273,'Mariko','Meyers','Benton','Proin@gravidamolestiearcu.com','Apdo.:682-5479 Ante ','1998/11/21',8),(274,'Uma','Bryan','Rutledge','lacus.Etiam@mus.ca','Apdo.:895-5611 Eu Av.','1999/08/08',9),(275,'Noah','James','Short','tincidunt.nibh.Phasellus@montesnasceturridiculus.co.uk','946-7334 Duis Calle','1998/08/21',7),(276,'Barry','Weeks','Blevins','dolor.Quisque@elitafeugiat.com','Apartado núm.: 666, 2128 Cursus C.','1999/01/01',9),(277,'Yael','Roberts','Burch','felis.Nulla@enim.org','7258 Integer Ctra.','1999/09/25',7),(278,'Anthony','Mooney','Wilkinson','odio.Nam.interdum@eget.ca','439-3514 Integer C.','1998/09/12',7),(279,'Libby','Robbins','Norton','fermentum.arcu@pedenonummyut.org','Apartado núm.: 711, 5261 Sodales Ctra.','1999/02/03',7),(280,'Brock','Duncan','Rojas','nec.urna@pede.edu','380-4756 Iaculis Avda.','1999/10/03',8);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(281,'Alexa','Snider','Morris','sed.orci@variusorci.co.uk','278-9424 Non, Ctra.','1999/01/15',7),(282,'Paki','Parsons','Stone','sodales.purus.in@augueporttitor.co.uk','Apartado núm.: 753, 1006 Fusce Av.','1999/09/15',9),(283,'Hyatt','Pittman','Bishop','sapien@ipsumdolorsit.net','6243 Sed ','1999/05/11',7),(284,'Jana','Duke','Dyer','mi.eleifend@parturientmontes.com','733-4613 Ipsum ','1998/10/03',7),(285,'Reagan','Valdez','Black','tempor.augue@Sedmalesuada.org','6823 Eget Avda.','1998/03/15',7),(286,'Lesley','Curtis','Mcdonald','vitae@pede.net','Apdo.:618-6721 Vivamus Avenida','1999/08/07',9),(287,'Kitra','Carey','Pitts','velit.Pellentesque.ultricies@dolor.com','1723 Ipsum ','1998/08/23',9),(288,'Sage','Shannon','Barrett','Suspendisse.aliquet@lectus.edu','Apartado núm.: 558, 5006 Phasellus Ctra.','1999/02/12',9),(289,'Genevieve','Larson','Dickerson','orci.sem.eget@nuncullamcorpereu.ca','Apdo.:250-8510 Eget C/','1998/09/29',8),(290,'Leroy','Clarke','Matthews','quam@sedfacilisisvitae.co.uk','8525 In Avda.','1998/05/16',8);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(291,'Sheila','Bowman','Griffith','torquent.per@sitamet.com','Apartado núm.: 931, 4625 Taciti Ctra.','1999/02/16',9),(292,'Althea','Burke','Acevedo','eu@Etiambibendumfermentum.edu','227-1289 Faucibus Avenida','1999/12/18',7),(293,'Abra','Parsons','Massey','Mauris.non.dui@porttitorscelerisque.edu','7012 Magnis C.','1998/03/31',8),(294,'Yeo','Hess','Strickland','et.netus@vestibulummassarutrum.edu','Apartado núm.: 156, 6847 Augue ','1998/02/04',7),(295,'Maile','Sweeney','Wise','Nullam.vitae@mattisvelitjusto.co.uk','Apartado núm.: 982, 7161 Vel Carretera','1998/10/25',9),(296,'Ella','Haley','Austin','libero.Proin.sed@vitaeerat.co.uk','Apartado núm.: 186, 807 Tellus Av.','1999/01/27',7),(297,'Kerry','Hayes','Branch','aliquet.Phasellus@non.org','Apartado núm.: 488, 177 Dictum Carretera','1999/03/28',8),(298,'Baker','Flores','Dyer','Nulla.interdum.Curabitur@erat.co.uk','Apdo.:683-3279 Metus Avenida','1999/11/12',8),(299,'Lev','Hatfield','Bernard','sed@malesuada.org','655-7138 Leo, Carretera','1998/07/06',7),(300,'Owen','Klein','Mckay','Aliquam.nisl.Nulla@nequeNullamnisl.ca','9710 Donec Ctra.','1998/11/17',8);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(301,'Wynter','Woodward','Preston','lobortis.nisi.nibh@interdum.ca','Apdo.:770-7295 Sapien. Av.','1998/10/07',5),(302,'Hu','Glenn','James','lorem.eu.metus@Cumsociisnatoque.net','Apdo.:665-6249 Aliquam C/','1998/06/30',4),(303,'Hayes','Avery','Holden','convallis@Nuncsed.org','6574 Mauris Ctra.','1998/02/19',6),(304,'Celeste','Lucas','Vang','porttitor.scelerisque.neque@dolorvitae.com','8679 Massa. Avenida','1998/04/10',4),(305,'Drew','Maldonado','Ramsey','bibendum@In.edu','623-3466 A, Avda.','1999/02/16',5),(306,'Chelsea','Wiggins','Greene','est@tinciduntdui.co.uk','716-3420 Praesent Ctra.','1998/06/23',6),(307,'Howard','Key','Griffith','ac@necmalesuada.edu','Apdo.:828-5000 Vel Avenida','1999/12/18',6),(308,'Petra','Humphrey','Pittman','luctus.sit.amet@In.com','461 Eget, Avda.','1998/12/27',5),(309,'Larissa','Forbes','Crane','aliquet@ridiculus.net','Apdo.:973-2078 Dignissim ','1999/08/06',6),(310,'Germane','Fitzgerald','Berg','suscipit.est.ac@aliquamiaculislacus.ca','Apdo.:587-7518 Aliquam C/','1998/07/10',5);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(311,'Maxine','Butler','Holman','eleifend@nuncQuisqueornare.com','Apartado núm.: 339, 8369 Accumsan C.','1998/01/09',6),(312,'Azalia','Chaney','Snider','mauris@gravidamauris.net','Apartado núm.: 133, 3586 Elit Avenida','1999/06/01',4),(313,'Erasmus','Mcclure','Odom','diam@Crasconvallisconvallis.net','574-1605 Neque C.','1999/04/09',6),(314,'Doris','Mckinney','Baldwin','eget@necquam.net','627-2663 Libero. Calle','1999/04/05',4),(315,'Ashton','Ross','Pate','primis@mollisInteger.net','577-4519 Duis Avenida','1998/02/14',6),(316,'Melvin','George','Estes','Quisque.libero@pedemalesuadavel.com','7980 Orci ','1998/10/22',5),(317,'Hammett','Fulton','James','Duis.cursus@nullaat.com','Apdo.:127-6052 Vel, Av.','1998/04/28',6),(318,'Lane','Sanford','Nichols','est.Nunc.ullamcorper@nunc.org','232-3071 Dolor. Ctra.','1998/01/06',4),(319,'Emmanuel','Reed','Newman','tempus.non.lacinia@pedeblandit.org','281-7187 Nec ','1998/01/06',5),(320,'Kato','Cooper','Hines','eu.placerat.eget@est.com','Apdo.:888-937 Lobortis C.','1999/08/29',4);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(321,'Ainsley','Reynolds','Delacruz','Nam.nulla.magna@ligulaDonecluctus.co.uk','593-869 Ipsum C/','1998/10/11',6),(322,'Bo','Flowers','Calhoun','lorem.ipsum@Donecfringilla.edu','Apdo.:436-4803 Sociis C.','1998/02/13',6),(323,'Reece','Tyson','Weber','lorem.vehicula.et@pedeCumsociis.org','4182 Aliquam, Carretera','1998/02/23',4),(324,'Beatrice','Mccoy','David','lacus.Cras.interdum@acfacilisisfacilisis.com','5607 Etiam Ctra.','1999/05/27',4),(325,'Mohammad','Rivers','Hendricks','magna.sed@vulputatenisisem.net','Apartado núm.: 197, 2278 Vehicula Calle','1999/08/11',5),(326,'Alisa','Finley','Kane','pede.ultrices@arcu.org','2269 Et, C/','1999/12/09',5),(327,'Sacha','Hayden','Lynch','enim@nisinibh.org','Apdo.:151-8783 Urna. Avda.','1998/10/25',4),(328,'Lionel','Lloyd','Hess','augue.id@porttitor.edu','762-5895 Dis C/','1999/07/30',4),(329,'Maia','Brady','Santiago','eros.Proin@aarcu.edu','3788 Dictum Avda.','1998/10/21',5),(330,'Deirdre','Obrien','Fulton','ac@rhoncusNullam.co.uk','457-2298 Sem C.','1999/02/07',5);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(331,'Madaline','Ratliff','Owens','nibh.Donec@eratvel.edu','6775 Elementum Ctra.','1999/06/24',5),(332,'Matthew','Schroeder','Oconnor','nulla.vulputate@fermentumvel.net','Apdo.:661-204 Elementum C/','1998/08/24',4),(333,'Jaden','Randall','Hebert','aliquet@lacus.co.uk','Apartado núm.: 408, 851 Libero Ctra.','1999/12/03',4),(334,'Ramona','Finley','Baldwin','urna.Nunc@acliberonec.org','615-7834 Ac Avda.','1999/01/25',6),(335,'Flynn','Trevino','Dickerson','mauris@Sedet.ca','Apdo.:710-7540 Erat C.','1998/03/19',4),(336,'Colleen','Phillips','William','nascetur.ridiculus.mus@urnaconvallis.net','Apartado núm.: 867, 7484 Maecenas C/','1998/12/22',4),(337,'Kenyon','Valdez','Bolton','tincidunt.neque@sollicitudincommodo.co.uk','411-7774 Sociis Av.','1998/04/08',5),(338,'Azalia','Riggs','Farmer','hendrerit.Donec.porttitor@vehicularisus.edu','6657 Nullam Avenida','1999/08/07',6),(339,'Felicia','Oliver','Berg','tempor@quis.net','7320 Dolor Avenida','1999/02/19',4),(340,'Demetrius','Sears','Erickson','laoreet.libero@lobortisClass.com','362-8248 Nunc ','1998/09/10',6);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(341,'Cullen','Booth','Keith','velit.Cras@sitamet.edu','289-7435 Et, C.','1998/03/15',5),(342,'Germane','Koch','Clayton','tempor.est@parturient.net','1062 Ultrices Avda.','1998/11/27',6),(343,'Leroy','Wagner','Cardenas','fringilla.euismod.enim@a.net','555-4887 Nunc Av.','1999/09/11',5),(344,'Odysseus','Glover','Albert','eget@aliquetlibero.co.uk','Apdo.:399-651 Tortor Avda.','1998/05/19',5),(345,'Riley','Hicks','Stark','malesuada.malesuada@lacinia.ca','7233 Faucibus Ctra.','1999/07/06',4),(346,'Keegan','Snow','Rosa','egestas.hendrerit.neque@pretiumaliquetmetus.com','Apdo.:508-9964 Dictum Ctra.','1999/05/08',4),(347,'Yasir','Maldonado','Greer','nec.eleifend.non@risus.edu','Apartado núm.: 242, 8430 Lectus ','1999/09/23',6),(348,'Ifeoma','Owens','Gilliam','tempus.mauris.erat@nuncsitamet.co.uk','Apdo.:438-4807 Urna. Avenida','1999/10/30',4),(349,'Leo','Hart','Brock','volutpat@egestashendreritneque.org','4977 Orci, ','1999/07/14',5),(350,'Solomon','Mckinney','Boyer','ipsum.Suspendisse.sagittis@placeratorcilacus.edu','755-1953 Nunc Ctra.','1999/04/18',4);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(351,'Dane','Guthrie','Matthews','sed@vitaediam.com','719-3508 Dis Av.','1999/06/19',4),(352,'Luke','Langley','Beard','varius@ornareInfaucibus.co.uk','540-1687 Vitae C.','1998/01/21',6),(353,'Ira','Atkinson','Chen','Aliquam@ametultriciessem.org','Apartado núm.: 401, 306 Sed Avda.','1998/05/16',6),(354,'Ross','Christensen','Glenn','elit@ornaresagittis.ca','1288 Nam C.','1999/03/13',4),(355,'Maggie','Mcdaniel','Neal','Donec@Duis.edu','Apdo.:218-1222 Ullamcorper. ','1999/06/19',6),(356,'Kessie','Whitney','Conley','turpis.egestas.Aliquam@pharetra.org','Apartado núm.: 571, 3717 Non C.','1999/06/22',6),(357,'Ian','Boyle','Rhodes','rutrum@non.com','Apdo.:316-4131 Lorem Av.','1999/02/06',5),(358,'Pearl','Walsh','Salas','suscipit.est@dolorelitpellentesque.ca','4082 Enim, Ctra.','1999/07/03',4),(359,'Mollie','Benson','Mooney','aliquam.iaculis@hendrerit.co.uk','Apartado núm.: 278, 3751 Odio Av.','1998/05/23',5),(360,'Alexis','Mack','Larson','enim.nec.tempus@nequeNullamnisl.co.uk','Apartado núm.: 578, 2072 Sapien Av.','1999/02/21',6);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(361,'Reed','Mills','Glass','ad.litora@cursusdiamat.com','Apdo.:808-4893 Auctor Avda.','1998/07/18',4),(362,'Octavia','Hayden','Knox','volutpat.nunc.sit@vulputate.edu','Apartado núm.: 399, 869 Nec, Av.','1998/05/09',6),(363,'Ferris','Gillespie','Russell','Quisque.ornare@nullaIntegerurna.net','Apdo.:918-9859 Ac ','1998/11/19',5),(364,'Drake','Pennington','Bowen','felis.adipiscing@congue.com','Apdo.:776-617 Sem Avda.','1999/12/22',6),(365,'Joel','Harrison','Bray','fringilla@insodaleselit.com','Apdo.:488-1407 Vitae C.','1998/03/12',6),(366,'Keiko','Cross','Barber','Phasellus.ornare.Fusce@tempus.com','421-9670 Sed Carretera','1999/08/24',4),(367,'Shad','Blevins','Hunter','felis.orci.adipiscing@nulla.edu','2447 Ac Avda.','1998/04/05',5),(368,'Ivor','Conner','Buckley','turpis.Nulla@dignissim.com','Apdo.:136-5212 Auctor, Avda.','1998/06/25',5),(369,'Destiny','Stone','May','vulputate.dui@ipsumSuspendissesagittis.ca','Apartado núm.: 259, 9375 Felis Av.','1998/02/24',5),(370,'Jada','Meyer','Burke','Aliquam.nec.enim@euismodacfermentum.ca','4195 Turpis. ','1998/02/04',4);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(371,'Giacomo','Conner','Brooks','metus@odiotristique.co.uk','Apartado núm.: 799, 9926 Faucibus ','1998/08/24',4),(372,'Jarrod','Morton','Hensley','orci.luctus.et@Aliquamornare.net','549 Eu Av.','1998/02/17',6),(373,'Hedda','Pennington','Cox','iaculis@porttitorvulputate.net','8224 Vel ','1999/08/09',6),(374,'Bell','Beard','Dunn','mollis.dui.in@orcilacusvestibulum.com','9294 Nonummy. C.','1999/03/10',4),(375,'Nasim','Holland','Dominguez','Curabitur.massa@acmattisvelit.com','Apartado núm.: 392, 9897 Convallis C/','1998/08/20',5),(376,'Laura','Brewer','Battle','dictum.mi@et.co.uk','Apdo.:642-6438 Imperdiet Av.','1998/09/10',6),(377,'Berk','Wagner','Welch','Suspendisse.dui@ornare.ca','Apdo.:394-3299 Sed ','1998/01/06',4),(378,'Fitzgerald','Carrillo','Alvarez','malesuada@veliteget.org','Apdo.:521-111 Varius Avenida','1998/03/30',6),(379,'Solomon','Valdez','Kennedy','bibendum.Donec.felis@arcu.co.uk','Apartado núm.: 410, 7652 Faucibus Av.','1999/09/08',4),(380,'Hashim','Howell','Anthony','pharetra@vestibulum.edu','8072 Eu, Ctra.','1998/04/03',4);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(381,'Ryder','Wall','Ruiz','Donec.non@feugiat.ca','2433 Leo, Av.','1998/07/08',4),(382,'Christen','Castaneda','Rocha','elementum.at.egestas@ultriciesornare.net','6723 Nec Avenida','1998/10/22',6),(383,'Abigail','Riddle','Snyder','Sed@in.co.uk','Apartado núm.: 994, 1778 Est C/','1998/06/10',6),(384,'Ignatius','Joyce','Glenn','imperdiet@Aliquam.edu','Apartado núm.: 110, 8883 Elit ','1999/01/11',4),(385,'Darryl','Mcdowell','Blake','sodales.at.velit@egestasrhoncusProin.com','655-321 Sociis Avenida','1999/10/27',5),(386,'Brynn','Johns','Ellison','cursus.Nunc@Maurisquisturpis.co.uk','254-7293 Luctus ','1999/06/09',6),(387,'Akeem','Patterson','Hyde','et.arcu.imperdiet@magnaPraesentinterdum.net','Apdo.:894-3521 Tincidunt. Avenida','1999/08/16',4),(388,'Lunea','Elliott','Dillon','penatibus@Sedmolestie.net','Apartado núm.: 449, 6808 Malesuada ','1998/11/17',4),(389,'Harlan','Obrien','Sanford','dictum@tellus.co.uk','1497 Tristique Ctra.','1999/04/26',6),(390,'Forrest','Ellison','Parks','elit.a.feugiat@etrutrum.org','Apdo.:457-4413 In C.','1999/12/14',5);
INSERT INTO Cliente([ID],[Nombre],[Apellido_Paterno],[Apellido_Materno],[Correo],[Direccion],[Fecha_nacimiento],[Estatus_Id]) VALUES(391,'Cooper','Bolton','Guzman','nonummy.ultricies@mauris.co.uk','Apdo.:706-5381 Suspendisse Avda.','1999/04/28',4),(392,'Sybil','Savage','Montoya','et.arcu.imperdiet@infelisNulla.com','344-8460 Sed Av.','1998/01/17',4),(393,'Aquila','Mcclure','Flores','Integer@Nunc.com','2795 Dapibus ','1999/10/13',6),(394,'Tatiana','Delacruz','Mckay','nunc.ac@esttempor.net','Apdo.:845-908 Rhoncus. C.','1998/03/24',4),(395,'Kerry','Kidd','Whitney','at@idantedictum.ca','5448 Imperdiet Av.','1998/07/27',6),(396,'Octavia','Warner','Webster','Cras.dolor@vellectus.net','834-7556 Ultrices. ','1999/01/16',4),(397,'Raja','Obrien','Melendez','et.tristique.pellentesque@erosturpis.com','Apdo.:327-6501 Dolor. Av.','1998/10/15',6),(398,'Scarlett','Duncan','Rollins','non.arcu.Vivamus@facilisisegetipsum.co.uk','Apdo.:490-2139 Egestas C/','1998/02/28',4),(399,'Kenyon','Pennington','Mason','sociis.natoque.penatibus@veliteget.edu','Apdo.:508-4580 Aliquam Avda.','1998/06/25',6),(400,'Bert','Macdonald','Rosales','dolor@utlacusNulla.com','6424 Dictum Av.','1998/06/04',5);

/*Tipo_Aula*/
insert into Tipo_Aula values (1,'Laboratorio')
insert into Tipo_Aula values (2,'Salon')

/*Aula*/
INSERT INTO Aula([Numero],[Capacidad],[Tipo_aula]) VALUES(100,45,2),(101,40,1),(102,39,1),(103,36,2),(104,47,1),(105,36,2),(106,40,1),(107,36,1),(108,45,2),(109,45,2);
INSERT INTO Aula([Numero],[Capacidad],[Tipo_aula]) VALUES(110,35,1),(111,35,2),(112,39,2),(113,47,2),(114,49,2),(115,41,2),(116,47,1),(117,50,2),(118,49,1),(119,42,1);
INSERT INTO Aula([Numero],[Capacidad],[Tipo_aula]) VALUES(120,48,2),(121,36,2),(122,48,1),(123,42,1),(124,50,1),(125,40,2),(126,44,2),(127,49,2),(128,42,1),(129,35,2);
INSERT INTO Aula([Numero],[Capacidad],[Tipo_aula]) VALUES(130,48,2),(131,38,2),(132,36,2),(133,35,2),(134,38,1),(135,44,1),(136,46,1),(137,38,1),(138,50,1),(139,43,2);
INSERT INTO Aula([Numero],[Capacidad],[Tipo_aula]) VALUES(140,44,2),(141,43,1),(142,48,2),(143,41,2),(144,43,2),(145,47,1),(146,39,1),(147,45,2),(148,49,2),(149,47,1);
INSERT INTO Aula([Numero],[Capacidad],[Tipo_aula]) VALUES(150,47,1),(151,45,2),(152,49,1),(153,45,2),(154,39,2),(155,50,2),(156,41,2),(157,38,2),(158,41,2),(159,50,1);
INSERT INTO Aula([Numero],[Capacidad],[Tipo_aula]) VALUES(160,36,2),(161,35,1),(162,43,1),(163,44,2),(164,42,1),(165,38,2),(166,38,1),(167,43,1),(168,39,1),(169,36,2);
INSERT INTO Aula([Numero],[Capacidad],[Tipo_aula]) VALUES(170,35,2),(171,38,1),(172,43,2),(173,37,2),(174,37,2),(175,39,2),(176,39,1),(177,38,1),(178,43,2),(179,47,2);
INSERT INTO Aula([Numero],[Capacidad],[Tipo_aula]) VALUES(180,36,2),(181,47,1),(182,46,2),(183,35,2),(184,50,1),(185,42,1),(186,46,2),(187,39,2),(188,40,2),(189,48,2);
INSERT INTO Aula([Numero],[Capacidad],[Tipo_aula]) VALUES(190,41,2),(191,44,2),(192,47,1),(193,48,1),(194,37,1),(195,40,2),(196,46,1),(197,48,2),(198,45,1),(199,36,1);

/*Inserta Horarios*/
insert into Horario values('07:00','08:00','Lunes');
insert into Horario values('08:00','09:00','Lunes');
insert into Horario values('09:00','10:00','Lunes');
insert into Horario values('10:00','11:00','Lunes');
insert into Horario values('11:00','12:00','Lunes');
insert into Horario values('12:00','13:00','Lunes');
insert into Horario values('13:00','14:00','Lunes');
insert into Horario values('14:00','15:00','Lunes');
insert into Horario values('15:00','16:00','Lunes');
insert into Horario values('16:00','17:00','Lunes');
insert into Horario values('17:00','18:00','Lunes');
insert into Horario values('18:00','19:00','Lunes');

insert into Horario values('07:00','08:00','Martes');
insert into Horario values('08:00','09:00','Martes');
insert into Horario values('09:00','10:00','Martes');
insert into Horario values('10:00','11:00','Martes');
insert into Horario values('11:00','12:00','Martes');
insert into Horario values('12:00','13:00','Martes');
insert into Horario values('13:00','14:00','Martes');
insert into Horario values('14:00','15:00','Martes');
insert into Horario values('15:00','16:00','Martes');
insert into Horario values('16:00','17:00','Martes');
insert into Horario values('17:00','18:00','Martes');
insert into Horario values('18:00','19:00','Martes');

insert into Horario values('07:00','08:00','Miercoles');
insert into Horario values('08:00','09:00','Miercoles');
insert into Horario values('09:00','10:00','Miercoles');
insert into Horario values('10:00','11:00','Miercoles');
insert into Horario values('11:00','12:00','Miercoles');
insert into Horario values('12:00','13:00','Miercoles');
insert into Horario values('13:00','14:00','Miercoles');
insert into Horario values('14:00','15:00','Miercoles');
insert into Horario values('15:00','16:00','Miercoles');
insert into Horario values('16:00','17:00','Miercoles');
insert into Horario values('17:00','18:00','Miercoles');
insert into Horario values('18:00','19:00','Miercoles');

insert into Horario values('07:00','08:00','Jueves');
insert into Horario values('08:00','09:00','Jueves');
insert into Horario values('09:00','10:00','Jueves');
insert into Horario values('10:00','11:00','Jueves');
insert into Horario values('11:00','12:00','Jueves');
insert into Horario values('12:00','13:00','Jueves');
insert into Horario values('13:00','14:00','Jueves');
insert into Horario values('14:00','15:00','Jueves');
insert into Horario values('15:00','16:00','Jueves');
insert into Horario values('16:00','17:00','Jueves');
insert into Horario values('17:00','18:00','Jueves');
insert into Horario values('18:00','19:00','Jueves');

insert into Horario values('07:00','08:00','Viernes');
insert into Horario values('08:00','09:00','Viernes');
insert into Horario values('09:00','10:00','Viernes');
insert into Horario values('10:00','11:00','Viernes');
insert into Horario values('11:00','12:00','Viernes');
insert into Horario values('12:00','13:00','Viernes');
insert into Horario values('13:00','14:00','Viernes');
insert into Horario values('14:00','15:00','Viernes');
insert into Horario values('15:00','16:00','Viernes');
insert into Horario values('16:00','17:00','Viernes');
insert into Horario values('17:00','18:00','Viernes');
insert into Horario values('18:00','19:00','Viernes');

/*Inserta Cursos*/
insert into Curso values(1,101,1001),(2,102,1002),(3,103,1003),(4,104,1004),(5,105,1005),(6,106,1006),(7,107,1007),(8,108,1008),(9,109,1009),(10,110,1010);
insert into Curso values(11,111,1011),(12,112,1012),(13,113,1013),(14,114,1014),(15,115,1015),(16,116,1016),(17,117,1017),(18,118,1018),(19,119,1019),(20,120,1020);
insert into Curso values(21,111,1011),(22,122,1022),(23,123,1023),(24,124,1024),(25,125,1025),(26,126,1026),(27,127,1027),(28,128,1028),(29,129,1029),(30,130,1030);
insert into Curso values(31,131,1031),(32,132,1032),(33,133,1033),(34,134,1034),(35,135,1035),(36,136,1036),(37,137,1037),(38,138,1038),(39,139,1039),(40,140,1040);

/*Inserta clases*/
insert into Clases values(1,10),(1,13),(1,40);
insert into Clases values(2,14), (2,15), (2,16), (2,12);
insert into Clases values(3,11),(3,22),(3,23),(3,24);
insert into Clases values(4,12),(4,14),(4,20),(4,30),(4,10);
insert into Clases values(5,13),(5,14),(5,15),(5,16);
insert into Clases values(6,16),(6,12),(6,18),(6,24),(6,30);
insert into Clases values(8,18),(8,16);
insert into Clases values(9,14),(9,28);
insert into Clases values(10,11);
insert into Clases values(12,20);
insert into Clases values(13,13),(13,36);
insert into Clases values(14,14),(14,24);
insert into Clases values(15,20),(15,29);

/*inserta cursos horarios*/
insert into Curso_Horario values(1,1);
insert into Curso_Horario values(1,12);
insert into Curso_Horario values(1,15);
insert into Curso_Horario values(2,15);
insert into Curso_Horario values(1,20);

insert into Curso_Horario values(35,1);
insert into Curso_Horario values(33,1);
insert into Curso_Horario values(19,1);
insert into Curso_Horario values(13,1);
insert into Curso_Horario values(2,2);

insert into Curso_Horario values(30,1);
insert into Curso_Horario values(31,12);
insert into Curso_Horario values(32,15);
insert into Curso_Horario values(33,15);
insert into Curso_Horario values(34,20);

insert into Curso_Horario values(21,1);
insert into Curso_Horario values(22,12);
insert into Curso_Horario values(25,15);
insert into Curso_Horario values(24,15);
insert into Curso_Horario values(11,20);

/*Inserta grupos*/
insert into Grupo values(1,40,NULL,400);
insert into Grupo values(2,37,NULL,350);
insert into Grupo values(3,33,NULL,300);
insert into Grupo values(4,29,NULL,250);
insert into Grupo values(5,26,NULL,200);
insert into Grupo values(6,23,NULL,150);
insert into Grupo values(7,20,NULL,100);
insert into Grupo values(8,17,NULL,50);
insert into Grupo values(9,14,NULL,10);
insert into Grupo values(10,11,NULL,100);
insert into Grupo values(11,9,NULL,20);
insert into Grupo values(12,6,NULL,300);
insert into Grupo values(13,3,NULL,400);
insert into Grupo values(14,1,NULL,319);
insert into Grupo values(15,40,NULL,219);
insert into Grupo values(16,18,NULL,119);
insert into Grupo values(17,16,NULL,19);
insert into Grupo values(18,8,NULL,133);
insert into Grupo values(19,4,NULL,233);
insert into Grupo values(20,2,NULL,333);
insert into Grupo values(21,1,NULL,399); 

/*Materias*/
INSERT INTO Materia VALUES(1,'Español I',4,1,2);
INSERT INTO Materia VALUES(2,'Español II',4,2,2);
INSERT INTO Materia VALUES(3,'Español III',4,3,2);
INSERT INTO Materia VALUES(4,'Biologia',3,1,3);
INSERT INTO Materia VALUES(5,'Fisica',3,2,3);
INSERT INTO Materia VALUES(6,'Quimica',3,3,3);
INSERT INTO Materia VALUES(7,'Matematicas I',5,1,1);
INSERT INTO Materia VALUES(8,'Matematicas II',5,2,1);
INSERT INTO Materia VALUES(9,'Matematicas III',5,3,1);
INSERT INTO Materia VALUES(10,'Cultura Física y Salud I',2,1,5);
INSERT INTO Materia VALUES(11,'Cultura Física y Salud II',2,2,5);
INSERT INTO Materia VALUES(12,'Cultura Física y Salud III',2,3,5);
INSERT INTO Materia VALUES(13,'Historia del mundo',4,2,4);
INSERT INTO Materia VALUES(14,'Historia de mexico',4,3,4);
INSERT INTO Materia VALUES(15,'Musica',1,3,6); 

Create view ClientesAceptados AS
Select Estatus.Nombre AS 'Tipo de Estatus', Cliente.ID, Cliente.Nombre, Cliente.Apellido_Paterno, Cliente.Apellido_Materno
From Estatus inner join Cliente ON Estatus.ID = Cliente.Estatus_ID
Where Estatus.Nombre = 'Aceptado'

Create view ProfesoresActivos AS
Select Estatus.Nombre AS 'Tipo de Estatus', Profesor.Empleado_No_empleado, Profesor.Cuenta_ID, Profesor.GradoEstudio
From Estatus inner join Profesor ON Estatus.ID = Profesor.Estatus_ID
Where Estatus.ID = 3

Create view AreaEspañol AS
Select Profesor.Empleado_No_empleado, Profesor.Area_ID, Profesor.GradoEstudio, Area.Nombre
From Profesor inner join Area ON Profesor.Area_ID = Area.ID
Where Area.ID = 2

Create view AreaArteCultura AS
Select Profesor.Empleado_No_empleado, Profesor.Area_ID, Profesor.GradoEstudio, Area.Nombre
From Profesor inner join Area ON Profesor.Area_ID = Area.ID
Where Area.ID = 6

Create view AreaCienciasN AS
Select Profesor.Empleado_No_empleado, Profesor.Area_ID, Profesor.GradoEstudio, Area.Nombre
From Profesor inner join Area ON Profesor.Area_ID = Area.ID
Where Area.ID = 3

Create view AreaCienciasS AS
Select Profesor.Empleado_No_empleado, Profesor.Area_ID, Profesor.GradoEstudio, Area.Nombre
From Profesor inner join Area ON Profesor.Area_ID = Area.ID
Where Area.ID = 4

Create view AreaDeportes AS
Select Profesor.Empleado_No_empleado, Profesor.Area_ID, Profesor.GradoEstudio, Area.Nombre
From Profesor inner join Area ON Profesor.Area_ID = Area.ID
Where Area.ID = 5

Create view AreaMatematicas AS
Select Profesor.Empleado_No_empleado, Profesor.Area_ID, Profesor.GradoEstudio, Area.Nombre
From Profesor inner join Area ON Profesor.Area_ID = Area.ID
Where Area.ID = 1

create view HorarioEspecifico AS
select Curso.Aula_Numero, Curso.Profesor_Empleado_No_empleado AS 'No. Profesor', Horario.Hora_inicio, Horario.Hora_fin, Horario.Dia
From Curso inner join Horario ON Horario.Clave = Curso.Clave


select *
from AreaEspañol

select *
from AreaMatematicas

select *
from AreaArteCultura

select *
from AreaCienciasN

select *
from AreaCienciasS

select *
from AreaDeportes

select *
from ClientesAceptados

select *
from ProfesoresActivos

select *
from HorarioEspecifico

create procedure ClientesAceptadosSP (@Estatus varchar(15))
AS BEGIN
	Select Estatus.ID, Estatus.Descripcion, Cliente.ID, Cliente.Nombre
	From Estatus inner join Cliente ON Estatus.ID = Cliente.Estatus_ID
	where Estatus.Nombre = @Estatus
END

exec [ClientesAceptadosSP] 'Aceptado'

create procedure UltimosAlumnosRegSP (@ID int)
AS BEGIN
	Select ID, Nombre, Apellido_Paterno, Apellido_Materno
	From Cliente
	Where ID >= @ID
END

exec [UltimosAlumnosRegSP] 350

select Count (ID) AS Total_Alumnos
from Cliente


SELECT AVG(Capacidad) as Capacidad_Promedio
FROM Aula 


CREATE TRIGGER ListadoAceptados
ON Estatus
AFTER INSERT, UPDATE, DELETE   
AS  
  exec [ClientesAceptadosSP] 'Aceptado'  
GO

CREATE TRIGGER Lista_Grupos
ON Grupo
After INSERT, UPDATE, DELETE  
AS
	SELECT * FROM Grupo
GO

insert into Grupo values(80,40,NULL,400);
-------Procedimientos Almacenados---------------------------------------------------------------------------------------
CREATE PROCEDURE Obtener_Por_Area
( @Area varchar(50)) AS 
begin
	SELECT e.Nombre,e.Apellido_Paterno,e.Apellido_Materno,p.GradoEstudio AS Grado FROM Profesor p
		JOIN Empleado AS e ON p.Empleado_No_empleado = e.No_empleado
		JOIN Area AS a ON a.ID = p.Area_ID
		WHERE a.Nombre = @Area
end;

exec Obtener_Por_Area 'Ciencias Naturales'; 

-------Funciones--------------------------------------------------------------------------------------------------------
CREATE FUNCTION Calificaciones_de (@Matricula int)
RETURNS TABLE
	RETURN SELECT cli.ID, Calificacion,m.Nombre
				FROM Grupo 
				JOIN Curso AS C ON Grupo.Curso_Clave = C.Clave
				JOIN Clases AS Cl ON Cl.Curso_Clave = C.Clave
				JOIN Materia AS m ON Cl.Materia_Clave = m.Clave
				JOIN Cliente AS cli ON cli.ID = Grupo.Cliente_ID
				WHERE Cliente_ID = @Matricula;
;

SELECT * FROM Calificaciones_de(100);

CREATE FUNCTION Edad_Cliente (@Cliente int)
RETURNS INT
WITH EXECUTE AS CALLER
AS
BEGIN
	DECLARE @Edad int;
	DECLARE @FechaNacimiento Date;
	SET @FechaNacimiento = (SELECT c.Fecha_nacimiento FROM Cliente c WHERE c.ID = @Cliente);
	SET @Edad = DATEDIFF(year,@FechaNacimiento,GETDATE());
	RETURN (@Edad)
END;

SELECT dbo.Edad_Cliente(1) AS 'Edad';
-------Triggers---------------------------------------------------------------------------------------------------------

--Al crear una clase, el area de la materia y del profesor deben coincidir
--Sino se muestra un mensaje de error

CREATE TRIGGER Area_Clase_Valida
ON dbo.Clases 
AFTER INSERT AS
	IF EXISTS (SELECT * FROM Clases c
				JOIN inserted AS i ON i.Curso_Clave = c.Curso_Clave AND i.Materia_Clave = c.Materia_Clave
				JOIN Curso AS cu ON cu.Clave = c.Curso_Clave
				JOIN Profesor AS p ON p.Empleado_No_empleado = cu.Profesor_Empleado_No_empleado
				JOIN Materia AS m ON m.Clave = c.Materia_Clave
				WHERE p.Area_ID <> m.Area_ID
)	
BEGIN 
RAISERROR('El area de la materia y el area del profesor no coinciden.',5,5);
ROLLBACK TRANSACTION;
RETURN
END

--Un cliente debe tener estatus inscrito o revalidante para poder inscribirse 
--a un curso
CREATE TRIGGER Grupo_Cliente
ON dbo.Grupo
AFTER INSERT AS
	IF EXISTS (SELECT * FROM Grupo g
				JOIN inserted AS i ON i.ID = g.ID
				JOIN Cliente c ON c.ID = g.Cliente_ID
				JOIN Estatus AS e ON e.ID = c.Estatus_ID
				WHERE c.Estatus_ID NOT IN(4,6)
)
BEGIN 
RAISERROR('No puede inscribir a un cliente con un estatus diferente a inscrito o revalidante.',5,5);
ROLLBACK TRANSACTION;
RETURN
END