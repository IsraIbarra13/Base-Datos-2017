USE [master]
GO
/****** Object:  Database [PIA]    Script Date: 11/11/2017 22:02:35 ******/
CREATE DATABASE [PIA]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PIA', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\PIA.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'PIA_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\PIA_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [PIA] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PIA].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PIA] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PIA] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PIA] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PIA] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PIA] SET ARITHABORT OFF 
GO
ALTER DATABASE [PIA] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PIA] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [PIA] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PIA] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PIA] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PIA] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PIA] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PIA] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PIA] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PIA] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PIA] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PIA] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PIA] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PIA] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PIA] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PIA] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PIA] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PIA] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PIA] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [PIA] SET  MULTI_USER 
GO
ALTER DATABASE [PIA] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PIA] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PIA] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PIA] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [PIA]
GO
/****** Object:  StoredProcedure [dbo].[BuscadorEstudiantes]    Script Date: 11/11/2017 22:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[BuscadorEstudiantes]
@Matricula int
as 
begin
	select Matricula, Nombre, Apellido_Paterno, Apellido_Materno, Correo from Estudiante
	where Matricula = @Matricula
end

GO
/****** Object:  StoredProcedure [dbo].[ClientesAceptadosSP]    Script Date: 11/11/2017 22:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ClientesAceptadosSP] (@Estatus varchar(15))
AS BEGIN
	Select Estatus.ID, Estatus.Descripcion, Cliente.ID, Cliente.Nombre
	From Estatus inner join Cliente ON Estatus.ID = Cliente.Estatus_ID
	where Estatus.Nombre = @Estatus
END

exec [ClientesAceptadosSP] 'Aceptado'
GO
/****** Object:  StoredProcedure [dbo].[Obtener_Por_Area]    Script Date: 11/11/2017 22:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Obtener_Por_Area]
( @Area varchar(50)) AS 
begin
	SELECT e.Nombre,e.Apellido_Paterno,e.Apellido_Materno,p.GradoEstudio AS Grado FROM Profesor p
		JOIN Empleado AS e ON p.Empleado_No_empleado = e.No_empleado
		JOIN Area AS a ON a.ID = p.Area_ID
		WHERE a.Nombre = @Area
end;

exec Obtener_Por_Area 'Ciencias Naturales'; 
GO
/****** Object:  StoredProcedure [dbo].[UltimosAlumnosRegSP]    Script Date: 11/11/2017 22:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[UltimosAlumnosRegSP] (@ID int)
AS BEGIN
	Select ID, Nombre, Apellido_Paterno, Apellido_Materno
	From Cliente
	Where ID >= @ID
END

exec [UltimosAlumnosRegSP] 350
GO
/****** Object:  UserDefinedFunction [dbo].[Edad_Cliente]    Script Date: 11/11/2017 22:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Edad_Cliente] (@Cliente int)
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

GO
/****** Object:  Table [dbo].[Area]    Script Date: 11/11/2017 22:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Area](
	[ID] [int] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
 CONSTRAINT [Area_pk] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Aula]    Script Date: 11/11/2017 22:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Aula](
	[Numero] [int] NOT NULL,
	[Capacidad] [smallint] NOT NULL,
	[Tipo_aula] [int] NOT NULL,
 CONSTRAINT [Aula_pk] PRIMARY KEY CLUSTERED 
(
	[Numero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Clases]    Script Date: 11/11/2017 22:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clases](
	[Materia_Clave] [int] NOT NULL,
	[Curso_Clave] [int] NOT NULL,
 CONSTRAINT [Clases_pk] PRIMARY KEY CLUSTERED 
(
	[Materia_Clave] ASC,
	[Curso_Clave] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 11/11/2017 22:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cliente](
	[ID] [int] NOT NULL,
	[Nombre] [varchar](70) NOT NULL,
	[Apellido_Paterno] [varchar](40) NOT NULL,
	[Apellido_Materno] [varchar](40) NULL,
	[Correo] [varchar](100) NOT NULL,
	[Direccion] [varchar](150) NULL,
	[Fecha_nacimiento] [date] NOT NULL,
	[Estatus_ID] [int] NOT NULL,
 CONSTRAINT [Cliente_pk] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cuenta]    Script Date: 11/11/2017 22:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cuenta](
	[ID] [int] NOT NULL,
	[Usuario] [varchar](100) NOT NULL,
	[PasswordCuenta] [varchar](700) NOT NULL,
	[NivelAutorizacion] [int] NOT NULL,
 CONSTRAINT [Cuenta_pk] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Curso]    Script Date: 11/11/2017 22:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Curso](
	[Clave] [int] NOT NULL,
	[Aula_Numero] [int] NOT NULL,
	[Profesor_Empleado_No_empleado] [int] NOT NULL,
 CONSTRAINT [Curso_pk] PRIMARY KEY CLUSTERED 
(
	[Clave] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Curso_Horario]    Script Date: 11/11/2017 22:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Curso_Horario](
	[Curso_Clave] [int] NOT NULL,
	[Horario_Clave] [int] NOT NULL,
 CONSTRAINT [Curso_Horario_pk] PRIMARY KEY CLUSTERED 
(
	[Curso_Clave] ASC,
	[Horario_Clave] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Empleado]    Script Date: 11/11/2017 22:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Empleado](
	[No_empleado] [int] NOT NULL,
	[Nombre] [varchar](70) NOT NULL,
	[Apellido_Paterno] [varchar](40) NOT NULL,
	[Apellido_Materno] [varchar](40) NULL,
	[Direccion] [varchar](150) NULL,
	[Fecha_nacimiento] [date] NOT NULL,
 CONSTRAINT [Empleado_pk] PRIMARY KEY CLUSTERED 
(
	[No_empleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Estatus]    Script Date: 11/11/2017 22:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Estatus](
	[ID] [int] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Descripcion] [varchar](500) NOT NULL,
 CONSTRAINT [Estatus_pk] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Grupo]    Script Date: 11/11/2017 22:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Grupo](
	[ID] [int] NOT NULL,
	[Curso_Clave] [int] NOT NULL,
	[Calificacion] [numeric](4, 2) NULL,
	[Cliente_ID] [int] NOT NULL,
 CONSTRAINT [Grupo_pk] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Horario]    Script Date: 11/11/2017 22:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Horario](
	[Clave] [int] IDENTITY(1,1) NOT NULL,
	[Hora_inicio] [time](7) NOT NULL,
	[Hora_fin] [time](7) NOT NULL,
	[Dia] [varchar](15) NOT NULL,
 CONSTRAINT [Horario_pk] PRIMARY KEY CLUSTERED 
(
	[Clave] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Materia]    Script Date: 11/11/2017 22:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Materia](
	[Clave] [int] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Hora_semanal] [smallint] NOT NULL,
	[Grado] [smallint] NOT NULL,
	[Area_ID] [int] NOT NULL,
 CONSTRAINT [Materia_pk] PRIMARY KEY CLUSTERED 
(
	[Clave] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Profesor]    Script Date: 11/11/2017 22:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Profesor](
	[Empleado_No_empleado] [int] NOT NULL,
	[Cuenta_ID] [int] NULL,
	[Estatus_ID] [int] NOT NULL,
	[Area_ID] [int] NOT NULL,
	[GradoEstudio] [varchar](100) NOT NULL,
 CONSTRAINT [Profesor_pk] PRIMARY KEY CLUSTERED 
(
	[Empleado_No_empleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tipo_Aula]    Script Date: 11/11/2017 22:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tipo_Aula](
	[ID] [int] NOT NULL,
	[TIPO] [varchar](50) NOT NULL,
 CONSTRAINT [Tipo_pk] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedFunction [dbo].[Calificaciones_de]    Script Date: 11/11/2017 22:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Calificaciones_de] (@Matricula int)
RETURNS TABLE
	RETURN SELECT cli.ID, Calificacion,m.Nombre
				FROM Grupo 
				JOIN Curso AS C ON Grupo.Curso_Clave = C.Clave
				JOIN Clases AS Cl ON Cl.Curso_Clave = C.Clave
				JOIN Materia AS m ON Cl.Materia_Clave = m.Clave
				JOIN Cliente AS cli ON cli.ID = Grupo.Cliente_ID
				WHERE Cliente_ID = @Matricula;
;
GO
/****** Object:  View [dbo].[AreaArteCultura]    Script Date: 11/11/2017 22:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[AreaArteCultura] AS
Select Profesor.Empleado_No_empleado, Profesor.Area_ID, Profesor.GradoEstudio, Area.Nombre
From Profesor inner join Area ON Profesor.Area_ID = Area.ID
Where Area.ID = 6
GO
/****** Object:  View [dbo].[AreaCienciasN]    Script Date: 11/11/2017 22:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[AreaCienciasN] AS
Select Profesor.Empleado_No_empleado, Profesor.Area_ID, Profesor.GradoEstudio, Area.Nombre
From Profesor inner join Area ON Profesor.Area_ID = Area.ID
Where Area.ID = 3
GO
/****** Object:  View [dbo].[AreaCienciasS]    Script Date: 11/11/2017 22:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[AreaCienciasS] AS
Select Profesor.Empleado_No_empleado, Profesor.Area_ID, Profesor.GradoEstudio, Area.Nombre
From Profesor inner join Area ON Profesor.Area_ID = Area.ID
Where Area.ID = 4
GO
/****** Object:  View [dbo].[AreaDeportes]    Script Date: 11/11/2017 22:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[AreaDeportes] AS
Select Profesor.Empleado_No_empleado, Profesor.Area_ID, Profesor.GradoEstudio, Area.Nombre
From Profesor inner join Area ON Profesor.Area_ID = Area.ID
Where Area.ID = 5
GO
/****** Object:  View [dbo].[AreaEspañol]    Script Date: 11/11/2017 22:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[AreaEspañol] AS
Select Profesor.Empleado_No_empleado, Profesor.Area_ID, Profesor.GradoEstudio, Area.Nombre
From Profesor inner join Area ON Profesor.Area_ID = Area.ID
Where Area.ID = 2
GO
/****** Object:  View [dbo].[AreaMatematicas]    Script Date: 11/11/2017 22:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[AreaMatematicas] AS
Select Profesor.Empleado_No_empleado, Profesor.Area_ID, Profesor.GradoEstudio, Area.Nombre
From Profesor inner join Area ON Profesor.Area_ID = Area.ID
Where Area.ID = 1
GO
/****** Object:  View [dbo].[ClientesAceptados]    Script Date: 11/11/2017 22:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[ClientesAceptados] AS
Select Estatus.Nombre AS 'Tipo de Estatus', Cliente.ID, Cliente.Nombre, Cliente.Apellido_Paterno, Cliente.Apellido_Materno
From Estatus inner join Cliente ON Estatus.ID = Cliente.Estatus_ID
Where Estatus.Nombre = 'Aceptado'
GO
/****** Object:  View [dbo].[CorreosClientes]    Script Date: 11/11/2017 22:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CorreosClientes] AS
SELECT Cliente.ID, Cliente.Correo
FROM Cliente
GO
/****** Object:  View [dbo].[Doctores]    Script Date: 11/11/2017 22:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Doctores] AS
SELECT Profesor.GradoEstudio, Profesor.Empleado_No_empleado
FROM Profesor
WHERE Profesor.GradoEstudio = 'Doctorado'

GO
/****** Object:  View [dbo].[EstudiantesSuspendidos]    Script Date: 11/11/2017 22:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[EstudiantesSuspendidos] AS
SELECT COUNT(ID) as 'Cantidad de alumnos suspendidos'
FROM Cliente
WHERE Estatus_ID =  3 
GO
/****** Object:  View [dbo].[Laboratorios]    Script Date: 11/11/2017 22:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Laboratorios] AS
SELECT Numero, Capacidad
FROM Aula
WHERE Tipo_aula = 1
GO
/****** Object:  View [dbo].[Licenciaturas]    Script Date: 11/11/2017 22:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Licenciaturas] AS
SELECT Profesor.GradoEstudio, Profesor.Empleado_No_empleado
FROM Profesor
WHERE Profesor.GradoEstudio = 'Licenciatura'
GO
/****** Object:  View [dbo].[Maestrias]    Script Date: 11/11/2017 22:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Maestrias] AS
SELECT Profesor.GradoEstudio, Profesor.Empleado_No_empleado
FROM Profesor
WHERE Profesor.GradoEstudio = 'Maestria'
GO
/****** Object:  View [dbo].[ProfesoresActivos]    Script Date: 11/11/2017 22:02:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[ProfesoresActivos] AS
Select Estatus.Nombre AS 'Tipo de Estatus', Profesor.Empleado_No_empleado, Profesor.Cuenta_ID, Profesor.GradoEstudio
From Estatus inner join Profesor ON Estatus.ID = Profesor.Estatus_ID
Where Estatus.ID = 3
GO
INSERT [dbo].[Area] ([ID], [Nombre]) VALUES (6, N'Arte y Cultura')
INSERT [dbo].[Area] ([ID], [Nombre]) VALUES (3, N'Ciencias Naturales')
INSERT [dbo].[Area] ([ID], [Nombre]) VALUES (4, N'Ciencias Sociales')
INSERT [dbo].[Area] ([ID], [Nombre]) VALUES (5, N'Deportes')
INSERT [dbo].[Area] ([ID], [Nombre]) VALUES (2, N'Español')
INSERT [dbo].[Area] ([ID], [Nombre]) VALUES (1, N'Matematicas')
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (100, 45, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (101, 40, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (102, 39, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (103, 36, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (104, 47, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (105, 36, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (106, 40, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (107, 36, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (108, 45, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (109, 45, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (110, 35, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (111, 35, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (112, 39, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (113, 47, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (114, 49, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (115, 41, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (116, 47, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (117, 50, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (118, 49, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (119, 42, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (120, 48, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (121, 36, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (122, 48, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (123, 42, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (124, 50, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (125, 40, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (126, 44, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (127, 49, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (128, 42, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (129, 35, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (130, 48, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (131, 38, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (132, 36, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (133, 35, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (134, 38, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (135, 44, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (136, 46, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (137, 38, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (138, 50, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (139, 43, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (140, 44, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (141, 43, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (142, 48, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (143, 41, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (144, 43, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (145, 47, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (146, 39, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (147, 45, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (148, 49, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (149, 47, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (150, 47, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (151, 45, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (152, 49, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (153, 45, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (154, 39, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (155, 50, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (156, 41, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (157, 38, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (158, 41, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (159, 50, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (160, 36, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (161, 35, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (162, 43, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (163, 44, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (164, 42, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (165, 38, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (166, 38, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (167, 43, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (168, 39, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (169, 36, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (170, 35, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (171, 38, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (172, 43, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (173, 37, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (174, 37, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (175, 39, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (176, 39, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (177, 38, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (178, 43, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (179, 47, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (180, 36, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (181, 47, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (182, 46, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (183, 35, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (184, 50, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (185, 42, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (186, 46, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (187, 39, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (188, 40, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (189, 48, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (190, 41, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (191, 44, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (192, 47, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (193, 48, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (194, 37, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (195, 40, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (196, 46, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (197, 48, 2)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (198, 45, 1)
INSERT [dbo].[Aula] ([Numero], [Capacidad], [Tipo_aula]) VALUES (199, 36, 1)
GO
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (1, N'Barclay', N'Perez', N'Cook', N'sed.consequat.auctor@sem.co.uk', N'Apdo.:888-2122 Malesuada Calle', CAST(0x28230B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (2, N'Lila', N'Griffith', N'Joyce', N'felis.eget.varius@Donec.net', N'Apdo.:826-2467 Pede, C/', CAST(0xBC210B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (3, N'Branden', N'Patel', N'Copeland', N'et@risus.ca', N'756-3939 Blandit Av.', CAST(0x00240B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (4, N'Kevin', N'Snyder', N'Pittman', N'massa@magna.net', N'878-3455 Lacus, C.', CAST(0xFD210B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (5, N'Savannah', N'Singleton', N'Hartman', N'auctor.Mauris.vel@justonec.co.uk', N'Apdo.:404-1408 Ullamcorper Carretera', CAST(0x47220B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (6, N'Vladimir', N'Hart', N'Henderson', N'Sed.et@metusAliquam.org', N'Apartado núm.: 773, 5675 Magna. C/', CAST(0xB9220B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (7, N'Benedict', N'Skinner', N'Pennington', N'sem@aliquetsemut.ca', N'Apartado núm.: 180, 2595 Sapien, Avda.', CAST(0xBC230B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (8, N'Rhea', N'Hughes', N'Hyde', N'Curabitur.ut.odio@adipiscing.co.uk', N'Apdo.:568-1289 At Avda.', CAST(0xA4210B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (9, N'Russell', N'Kim', N'Rosa', N'tellus.Suspendisse.sed@sitametornare.ca', N'Apartado núm.: 728, 7396 Lacus. C.', CAST(0xAB210B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (10, N'Timothy', N'Bruce', N'Donaldson', N'nunc.id@libero.ca', N'7294 Nisi. Avenida', CAST(0x58230B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (11, N'Daryl', N'Swanson', N'Newton', N'urna@aarcuSed.co.uk', N'Apartado núm.: 612, 7885 Risus ', CAST(0xE7210B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (12, N'Dane', N'Rosario', N'Mooney', N'nibh@pharetrafeliseget.edu', N'Apartado núm.: 110, 4197 Dictum Calle', CAST(0x18220B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (13, N'Miriam', N'Barry', N'Hawkins', N'vulputate@nonbibendum.edu', N'780-1332 Sollicitudin C/', CAST(0x8E210B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (14, N'Jakeem', N'Sheppard', N'Rosales', N'metus.Vivamus.euismod@Suspendissedui.org', N'Apdo.:362-7490 Elit, Ctra.', CAST(0x44220B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (15, N'Dale', N'Wade', N'Schroeder', N'netus.et.malesuada@anteblandit.edu', N'800-8413 At Av.', CAST(0x6A210B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (16, N'Serena', N'Estrada', N'Flynn', N'Duis.sit.amet@sem.co.uk', N'197-654 Ipsum. C.', CAST(0x86230B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (17, N'Patrick', N'Jensen', N'Fletcher', N'et@anteNuncmauris.net', N'Apartado núm.: 212, 5872 Curabitur Ctra.', CAST(0xF9230B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (18, N'Seth', N'Craig', N'Mcintyre', N'Morbi.neque@ullamcorpereu.net', N'7093 In Avda.', CAST(0x54220B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (19, N'Kay', N'Montoya', N'Haney', N'mi.lacinia.mattis@semperpretium.com', N'Apartado núm.: 453, 5532 Faucibus Carretera', CAST(0xE2230B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (20, N'Maile', N'Jennings', N'Nash', N'egestas.rhoncus@urnaNullamlobortis.co.uk', N'144-6336 Elit, Av.', CAST(0xF4210B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (21, N'Martin', N'William', N'Cooper', N'risus.Duis.a@neque.edu', N'Apdo.:539-9445 At Avenida', CAST(0x5E230B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (22, N'Hunter', N'Valenzuela', N'Whitehead', N'arcu.ac@interdumSedauctor.co.uk', N'532-6219 Enim Avda.', CAST(0x80220B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (23, N'Porter', N'Grant', N'Hughes', N'nec.enim@loremut.edu', N'3076 Ac Avda.', CAST(0x7D210B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (24, N'Althea', N'Buck', N'Jennings', N'montes@magna.com', N'433-4943 Libero. Avenida', CAST(0x6F210B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (25, N'Noble', N'Haynes', N'Solis', N'Suspendisse@Fusce.net', N'903-546 Fusce Calle', CAST(0x69220B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (26, N'Octavia', N'Cobb', N'Mann', N'Donec.vitae@hendreritDonec.ca', N'9976 Praesent Ctra.', CAST(0x51220B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (27, N'Wilma', N'Roth', N'Sheppard', N'fringilla.Donec@parturient.net', N'283-9882 Dui. Calle', CAST(0xBC230B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (28, N'Nathan', N'Allen', N'Woodward', N'Nunc.ullamcorper@enimCurabitur.co.uk', N'423-9516 Nam Calle', CAST(0xF5210B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (29, N'Stephen', N'Austin', N'Deleon', N'Vivamus@milacinia.net', N'Apdo.:421-3999 Luctus Calle', CAST(0x51230B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (30, N'Clayton', N'Slater', N'Hensley', N'velit@congueIn.ca', N'8856 Ac C/', CAST(0xE0210B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (31, N'Talon', N'Adkins', N'Wood', N'ligula@aliquamarcuAliquam.org', N'Apartado núm.: 638, 5603 Imperdiet Carretera', CAST(0xE2210B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (32, N'Bertha', N'Gross', N'Newton', N'Nulla.tempor@metusVivamuseuismod.org', N'Apdo.:148-5063 Sed Calle', CAST(0xE4220B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (33, N'Martena', N'Davis', N'Maddox', N'vulputate.ullamcorper.magna@lectusjusto.edu', N'667-3710 Nulla Ctra.', CAST(0x65210B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (34, N'Lester', N'Shields', N'Obrien', N'sit.amet@dapibus.edu', N'Apdo.:278-8390 Auctor Ctra.', CAST(0x80210B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (35, N'Nola', N'Kirkland', N'Sweet', N'orci@id.ca', N'Apartado núm.: 667, 2263 Enim. Avda.', CAST(0x89210B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (36, N'Asher', N'Casey', N'Welch', N'nec.urna.et@dapibusquam.org', N'7608 Consectetuer Carretera', CAST(0x30210B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (37, N'Lewis', N'Ramos', N'Hodge', N'ipsum.Phasellus@etipsumcursus.edu', N'Apdo.:929-1691 Tellus, Calle', CAST(0xA0210B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (38, N'Dante', N'Hull', N'Flores', N'ridiculus.mus@consectetuercursus.edu', N'Apartado núm.: 880, 3408 Ligula Calle', CAST(0x04240B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (39, N'Driscoll', N'Young', N'Browning', N'purus.mauris.a@cursus.com', N'Apdo.:914-7625 Torquent ', CAST(0xC8230B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (40, N'Elton', N'Guy', N'Kaufman', N'velit.Quisque@nonsollicitudin.net', N'Apartado núm.: 183, 9907 Ac, Ctra.', CAST(0x70230B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (41, N'Inez', N'Roth', N'Gomez', N'imperdiet@sociisnatoque.co.uk', N'2622 Vel Carretera', CAST(0xA2230B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (42, N'Jonah', N'Oneill', N'Glass', N'tempus@sitamet.ca', N'661-3356 Proin Carretera', CAST(0xE0210B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (43, N'Benedict', N'Hahn', N'Mullen', N'elit@fermentumfermentumarcu.com', N'Apdo.:337-8593 Imperdiet, Avda.', CAST(0x3B230B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (44, N'Rae', N'Orr', N'Rollins', N'turpis.non@sitamet.edu', N'678-7669 Sit Carretera', CAST(0x3D220B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (45, N'Iris', N'Reeves', N'Dawson', N'luctus.et@faucibusorciluctus.co.uk', N'Apdo.:303-1679 Tincidunt. Avda.', CAST(0x88210B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (46, N'Kenneth', N'Vazquez', N'Roberts', N'est@risus.co.uk', N'Apdo.:441-2840 Convallis Av.', CAST(0x42210B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (47, N'Eleanor', N'Burns', N'English', N'ipsum.primis.in@nislsemconsequat.org', N'7525 Magna C.', CAST(0xCF210B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (48, N'Quon', N'Le', N'Burke', N'Curabitur.vel@accumsan.net', N'6103 Purus Av.', CAST(0x1E220B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (49, N'Talon', N'Ramirez', N'Bass', N'pede@odio.com', N'Apartado núm.: 394, 3076 Vulputate C.', CAST(0x10230B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (50, N'Sandra', N'Edwards', N'Madden', N'Aliquam@arcu.org', N'Apartado núm.: 477, 6921 Libero Calle', CAST(0x8B220B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (51, N'Olivia', N'Roth', N'Chandler', N'commodo.tincidunt.nibh@dignissimMaecenas.com', N'Apdo.:509-8841 Curae; Calle', CAST(0xE9220B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (52, N'Hall', N'Gillespie', N'Frost', N'Cum@tellusNunc.org', N'307-2330 Sapien ', CAST(0x60210B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (53, N'Danielle', N'Blanchard', N'Sharp', N'dui@mattis.org', N'2781 Lorem, Av.', CAST(0xB0230B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (54, N'Edward', N'Hines', N'Cummings', N'varius.ultrices.mauris@pedeCumsociis.com', N'Apartado núm.: 505, 429 Quam Avda.', CAST(0xCC230B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (55, N'Vance', N'Newman', N'Osborne', N'amet.ante@sitamet.co.uk', N'3215 Tellus Avenida', CAST(0x2C220B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (56, N'Paloma', N'Estes', N'Barker', N'libero@aliquetmetus.ca', N'7826 Donec Avenida', CAST(0xCC230B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (57, N'Maggy', N'Aguirre', N'Cardenas', N'egestas.Aliquam.nec@quis.net', N'4788 Consectetuer C/', CAST(0xA5210B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (58, N'Dane', N'Maldonado', N'Taylor', N'neque.non.quam@Suspendisse.net', N'Apartado núm.: 180, 1324 Non Avda.', CAST(0x76230B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (59, N'Ralph', N'Peters', N'Baxter', N'semper.dui@lacus.org', N'Apdo.:784-5773 Magna Ctra.', CAST(0xF1220B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (60, N'Lila', N'Howell', N'Williams', N'congue.In.scelerisque@volutpat.edu', N'3799 Turpis ', CAST(0x23220B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (61, N'Rafael', N'Fowler', N'Kerr', N'nec@Donec.ca', N'8975 Dui, Carretera', CAST(0x74230B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (62, N'Remedios', N'Noble', N'Brock', N'Etiam.imperdiet.dictum@aauctornon.org', N'Apdo.:241-8547 Nisi C.', CAST(0xC9220B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (63, N'Wayne', N'Hurst', N'Herman', N'sodales@auctor.com', N'Apdo.:714-3905 Sit Av.', CAST(0x6D210B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (64, N'Jelani', N'Estes', N'Cash', N'Curabitur@acmetusvitae.com', N'724-1110 Cursus. ', CAST(0xB3230B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (65, N'Gavin', N'Burnett', N'Cline', N'placerat@eratVivamusnisi.ca', N'Apartado núm.: 737, 6052 Sed C/', CAST(0x84230B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (66, N'Noble', N'Santos', N'Frank', N'vel.faucibus@vehiculaaliquet.org', N'Apartado núm.: 961, 7067 Mi Ctra.', CAST(0xC0220B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (67, N'Clementine', N'Armstrong', N'Grimes', N'et.ultrices.posuere@laciniaorciconsectetuer.net', N'6556 Primis ', CAST(0xD1230B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (68, N'Ava', N'Murray', N'George', N'aliquet.nec.imperdiet@a.com', N'4877 Orci, Calle', CAST(0xB8220B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (69, N'Hyacinth', N'Wade', N'Bush', N'quam.Curabitur.vel@hendreritconsectetuer.net', N'183-8279 Ante Carretera', CAST(0xAF220B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (70, N'Calista', N'Peterson', N'Nichols', N'enim@idantedictum.com', N'283-9752 Tortor Av.', CAST(0x80230B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (71, N'Blaine', N'Schmidt', N'Hood', N'malesuada.fames@nibhDonec.org', N'Apdo.:993-844 Purus, ', CAST(0xD8230B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (72, N'Whilemina', N'Kerr', N'Bird', N'vel.turpis@auguemalesuadamalesuada.com', N'486-1594 Adipiscing Avda.', CAST(0x9A210B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (73, N'Brandon', N'Sherman', N'Murray', N'sed@orcitincidunt.ca', N'Apartado núm.: 916, 3412 Pede, Calle', CAST(0x1C230B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (74, N'Natalie', N'Fields', N'Guerra', N'Nulla.tempor.augue@Aliquamfringillacursus.org', N'444-3159 Nunc Ctra.', CAST(0xC0220B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (75, N'Violet', N'Dickson', N'Haynes', N'ornare@luctusaliquetodio.edu', N'Apartado núm.: 755, 653 In Av.', CAST(0x09230B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (76, N'Bert', N'Blackwell', N'Watts', N'cursus@euismodenim.ca', N'4204 Commodo Calle', CAST(0x59210B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (77, N'Fatima', N'Harris', N'Cole', N'libero.Morbi@euturpis.ca', N'Apartado núm.: 136, 1269 Et, Avenida', CAST(0x9F230B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (78, N'Michelle', N'Cortez', N'Haney', N'sagittis.lobortis@lacuspedesagittis.com', N'Apartado núm.: 688, 2411 Phasellus Calle', CAST(0x71230B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (79, N'Erica', N'Savage', N'Delaney', N'sociis.natoque.penatibus@liberoMorbiaccumsan.org', N'Apartado núm.: 855, 6343 Risus. Av.', CAST(0x80230B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (80, N'Xanthus', N'Meyers', N'Knight', N'a.nunc.In@sit.com', N'Apdo.:878-7536 Adipiscing Av.', CAST(0x0D220B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (81, N'Denton', N'Daugherty', N'York', N'ad.litora@vestibulum.com', N'Apartado núm.: 259, 1287 Aliquam Avenida', CAST(0x95220B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (82, N'Judah', N'Sweet', N'Alford', N'id.libero.Donec@Donecestmauris.ca', N'Apdo.:439-1692 Ac Ctra.', CAST(0x03220B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (83, N'Piper', N'Franklin', N'Moses', N'semper@eget.co.uk', N'7611 Ut ', CAST(0xEA220B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (84, N'Wynne', N'Austin', N'Potts', N'Phasellus.dolor.elit@Utsagittislobortis.net', N'Apdo.:885-4551 Pellentesque C.', CAST(0xE4220B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (85, N'Micah', N'George', N'Bryan', N'Aliquam.ornare.libero@acfermentum.edu', N'Apdo.:494-9955 Ligula. ', CAST(0xB4210B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (86, N'Jeanette', N'Vaughn', N'Solomon', N'neque.non@vulputateeu.org', N'4727 Nunc Avda.', CAST(0x11220B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (87, N'Phillip', N'Chang', N'Harding', N'eleifend.nec.malesuada@Sedauctor.edu', N'565-5710 Est, Avenida', CAST(0x63230B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (88, N'Tasha', N'Farrell', N'Graham', N'posuere.cubilia@semperetlacinia.com', N'Apdo.:295-3103 Nulla C.', CAST(0xDD220B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (89, N'Keaton', N'Bartlett', N'Bradshaw', N'a.dui@diamdictumsapien.net', N'Apdo.:374-8296 Habitant Avenida', CAST(0x47220B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (90, N'Vance', N'Camacho', N'Sosa', N'ut.pharetra@atvelitPellentesque.ca', N'501-5835 Quam. Carretera', CAST(0xFB230B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (91, N'Carissa', N'Martinez', N'Woodward', N'ut.mi@varius.org', N'136-7037 Aenean Ctra.', CAST(0xBB220B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (92, N'Kim', N'Wolfe', N'Trujillo', N'lacus.Nulla@odio.co.uk', N'Apartado núm.: 930, 2221 Mollis. Calle', CAST(0x5A220B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (93, N'Victoria', N'Hutchinson', N'Avery', N'at.sem@sodales.com', N'1378 Tempor Calle', CAST(0x23220B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (94, N'Dominic', N'Combs', N'Waters', N'Proin.dolor@semper.net', N'706-613 Diam. Calle', CAST(0x87210B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (95, N'Warren', N'Ellis', N'Oneal', N'molestie.orci.tincidunt@purus.org', N'Apartado núm.: 523, 8853 Parturient Ctra.', CAST(0x42210B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (96, N'Deanna', N'Olsen', N'Whitley', N'Suspendisse.eleifend.Cras@lectusrutrumurna.com', N'Apartado núm.: 148, 1969 Quam. Carretera', CAST(0xC9210B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (97, N'Nicole', N'Santana', N'Eaton', N'Nulla@volutpatornarefacilisis.com', N'659-3631 Egestas Carretera', CAST(0x07230B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (98, N'Karen', N'Dennis', N'Guthrie', N'augue.id.ante@asollicitudinorci.org', N'Apdo.:233-1819 Nulla ', CAST(0xBD230B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (99, N'Lacey', N'Keith', N'Wilson', N'eu@ullamcorpermagnaSed.org', N'9718 Pellentesque ', CAST(0x82230B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (100, N'Beverly', N'Cohen', N'Hanson', N'lacus.Cras@Morbisit.com', N'Apartado núm.: 689, 3351 Ligula. C/', CAST(0xBC220B00 AS Date), 8)
GO
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (101, N'Drew', N'Travis', N'Pearson', N'nulla.Cras.eu@Suspendisse.edu', N'8464 In C.', CAST(0x02230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (102, N'Kellie', N'Gray', N'Mcgee', N'facilisi@venenatis.ca', N'Apartado núm.: 153, 4429 Duis Avenida', CAST(0x55230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (103, N'Erich', N'Lewis', N'Fleming', N'luctus@Morbi.org', N'Apartado núm.: 691, 5109 Morbi ', CAST(0x0E220B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (104, N'Roanna', N'Patterson', N'Montgomery', N'nascetur@Utnecurna.co.uk', N'9585 Donec Carretera', CAST(0x02230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (105, N'Oren', N'Dean', N'Peck', N'mi@accumsanneque.org', N'Apartado núm.: 142, 7960 Sociis C.', CAST(0xE4220B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (106, N'Lillith', N'Farley', N'Sutton', N'sagittis.lobortis.mauris@utcursus.net', N'161-9861 Rutrum Av.', CAST(0x77230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (107, N'Henry', N'Buck', N'Ferguson', N'massa@Sedauctor.org', N'Apartado núm.: 354, 1256 Etiam Avda.', CAST(0x5C220B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (108, N'Samuel', N'Molina', N'Burton', N'Cum@nostraper.org', N'Apdo.:167-4447 Est. Carretera', CAST(0x3D210B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (109, N'Judah', N'Juarez', N'Hendricks', N'volutpat.Nulla@consequatdolor.org', N'797-912 Malesuada Av.', CAST(0x93230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (110, N'Ulric', N'Park', N'Rivas', N'sem@amet.edu', N'Apartado núm.: 297, 4196 Lobortis Avda.', CAST(0x2F230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (111, N'Mark', N'Holder', N'Hobbs', N'pretium.et@primis.co.uk', N'552-4676 Vivamus ', CAST(0x57210B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (112, N'Melissa', N'King', N'Stein', N'Nullam.velit.dui@Fusce.edu', N'Apdo.:277-3009 Iaculis ', CAST(0xBC210B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (113, N'Orli', N'Petty', N'Herrera', N'Pellentesque@mauris.edu', N'Apdo.:317-8629 Mauris Carretera', CAST(0x9E230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (114, N'Heather', N'Acevedo', N'Welch', N'sed@orciUtsemper.org', N'Apdo.:616-1830 Consectetuer Avenida', CAST(0xD1230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (115, N'Richard', N'Tucker', N'Becker', N'auctor.Mauris.vel@musProin.com', N'2306 Dui, Avda.', CAST(0x60220B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (116, N'Bruno', N'Greer', N'Willis', N'Fusce.mollis@mipede.net', N'181-5531 Mauris Calle', CAST(0xC0230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (117, N'Adara', N'Marquez', N'Weeks', N'nec.urna@lectussit.ca', N'Apartado núm.: 916, 7233 Bibendum Av.', CAST(0x52210B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (118, N'Liberty', N'Clements', N'Duran', N'purus.gravida@sitametorci.net', N'Apdo.:249-9484 Dolor ', CAST(0xDA210B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (119, N'Darius', N'Mcgee', N'Petty', N'feugiat@etpede.co.uk', N'Apartado núm.: 338, 4081 Felis Ctra.', CAST(0x93230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (120, N'Jana', N'Woods', N'Graves', N'consequat.purus@ullamcorpernislarcu.net', N'Apartado núm.: 126, 5405 Turpis ', CAST(0x93210B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (121, N'Raja', N'Booker', N'Walsh', N'Nam.interdum.enim@magnatellus.edu', N'Apartado núm.: 619, 6926 Ac Avda.', CAST(0x35230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (122, N'Demetria', N'Cooley', N'Le', N'hendrerit.neque.In@leoelementum.ca', N'Apartado núm.: 249, 2410 Non, Ctra.', CAST(0x02240B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (123, N'Shaeleigh', N'Welch', N'Gutierrez', N'Nunc.mauris.sapien@erategettincidunt.org', N'1325 Eros. Av.', CAST(0x35210B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (124, N'Brent', N'Serrano', N'Coleman', N'ultrices.Vivamus@in.co.uk', N'494-3140 Phasellus Avenida', CAST(0x55210B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (125, N'Anjolie', N'Hopper', N'Reeves', N'pede.sagittis@libero.ca', N'2321 Consequat C/', CAST(0xCC220B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (126, N'Ray', N'Nieves', N'Jefferson', N'penatibus@lectuspedeet.com', N'Apdo.:327-6954 Pellentesque ', CAST(0xCD220B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (127, N'Carissa', N'Head', N'Blanchard', N'Fusce.aliquam.enim@ametrisus.co.uk', N'Apdo.:128-6867 Proin Avenida', CAST(0x53220B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (128, N'Owen', N'Fisher', N'Wood', N'nibh@tristique.org', N'Apdo.:477-7752 Donec Av.', CAST(0x61210B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (129, N'Donna', N'Garrison', N'Good', N'pellentesque.massa.lobortis@diamloremauctor.org', N'206-5783 Sodales. ', CAST(0x6D220B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (130, N'Macy', N'Townsend', N'Keith', N'non.justo@dictumcursusNunc.ca', N'Apdo.:393-9192 Et C.', CAST(0x29220B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (131, N'Kasper', N'Nunez', N'Gaines', N'sagittis@metusfacilisis.co.uk', N'1470 Nulla. Calle', CAST(0xA1230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (132, N'Sopoline', N'Coleman', N'Beach', N'Suspendisse.ac@odioNam.org', N'560-9735 Metus Avenida', CAST(0x07220B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (133, N'Leroy', N'Hatfield', N'Norton', N'risus@sedpedenec.net', N'332-4793 Tempor Avenida', CAST(0xC4210B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (134, N'Rajah', N'Sears', N'Morales', N'Nulla.semper@ullamcorpereueuismod.ca', N'Apdo.:146-3548 Duis ', CAST(0x25230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (135, N'Alvin', N'Jimenez', N'Estes', N'elit.a.feugiat@sitamet.co.uk', N'9303 Pharetra. Avenida', CAST(0x13220B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (136, N'Phoebe', N'Sargent', N'Stevenson', N'elit.Curabitur@mollisnec.org', N'143-6092 Et C/', CAST(0x52220B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (137, N'Alfonso', N'Klein', N'Cote', N'condimentum.eget.volutpat@eutempor.org', N'Apartado núm.: 413, 1029 Id, Av.', CAST(0x41230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (138, N'Aurelia', N'David', N'Rowland', N'auctor.vitae@acorciUt.org', N'Apdo.:274-2240 Rutrum Avenida', CAST(0xCC210B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (139, N'Rose', N'Delaney', N'Roberts', N'Vivamus.nisi@Morbi.edu', N'183-7381 Tempus ', CAST(0x29230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (140, N'Brooke', N'Dodson', N'Moss', N'risus@Integer.edu', N'Apdo.:492-3606 Sem Av.', CAST(0x9C230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (141, N'Lacey', N'Aguilar', N'Farmer', N'nibh@diamSed.ca', N'197-6539 Fringilla C/', CAST(0x73220B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (142, N'Linus', N'Morin', N'Velazquez', N'auctor.velit@risusvariusorci.com', N'3379 Volutpat Ctra.', CAST(0xA9210B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (143, N'Felix', N'Charles', N'Foreman', N'ac.facilisis.facilisis@Proin.edu', N'5281 Luctus Calle', CAST(0xE8210B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (144, N'Macaulay', N'Daniels', N'Travis', N'nisl.Maecenas.malesuada@mollis.co.uk', N'509-3150 Nec Calle', CAST(0xC6230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (145, N'Tatum', N'Farley', N'Hudson', N'Aenean@interdumligula.co.uk', N'Apdo.:150-5572 Ut Avda.', CAST(0x19230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (146, N'Tucker', N'Day', N'Wyatt', N'Sed.nec.metus@pedeSuspendisse.co.uk', N'202-8663 Posuere Calle', CAST(0xB0230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (147, N'Galvin', N'Kerr', N'Tate', N'placerat@magnisdisparturient.edu', N'2647 Vulputate, Ctra.', CAST(0xA6210B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (148, N'Brooke', N'Maddox', N'Collier', N'posuere.cubilia.Curae@velconvallis.net', N'Apartado núm.: 134, 925 Iaculis Av.', CAST(0x2C230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (149, N'Dexter', N'Finch', N'Hoffman', N'velit@magnisdisparturient.edu', N'4633 Egestas Avda.', CAST(0xF7210B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (150, N'Kennedy', N'Morrow', N'Conley', N'Praesent.luctus.Curabitur@eget.org', N'Apartado núm.: 425, 3739 Magna. Avda.', CAST(0xDA210B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (151, N'Deirdre', N'Turner', N'Hanson', N'metus.eu@felis.edu', N'Apdo.:348-8735 Tellus. Avenida', CAST(0xFF210B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (152, N'Madison', N'Welch', N'Dickerson', N'vestibulum.lorem.sit@ipsumcursus.com', N'Apdo.:998-683 Lacus. ', CAST(0x89230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (153, N'Forrest', N'Pitts', N'Ingram', N'sed.orci@quis.co.uk', N'Apdo.:317-6669 Nisl. Avenida', CAST(0x01230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (154, N'Cally', N'Stephenson', N'Henson', N'laoreet.posuere.enim@turpis.org', N'Apdo.:640-8082 Cras C.', CAST(0x7F230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (155, N'Carolyn', N'Floyd', N'Gray', N'inceptos@rhoncusNullam.co.uk', N'Apdo.:148-2182 Nam Calle', CAST(0x9E210B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (156, N'Xander', N'Solomon', N'Ayers', N'euismod.est@et.edu', N'Apartado núm.: 818, 4764 Ut Avda.', CAST(0x6D220B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (157, N'Nolan', N'Cardenas', N'Diaz', N'rutrum.justo.Praesent@bibendumsedest.co.uk', N'Apdo.:396-7971 Praesent Ctra.', CAST(0x5A230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (158, N'Marsden', N'Meyer', N'Cochran', N'molestie.dapibus@pharetranibhAliquam.com', N'Apartado núm.: 973, 3174 Elementum C/', CAST(0x87210B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (159, N'Dante', N'Callahan', N'Noble', N'convallis.erat.eget@felispurusac.org', N'Apdo.:548-4687 Dolor Avda.', CAST(0x41230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (160, N'Kadeem', N'Albert', N'Curry', N'Donec.fringilla.Donec@tincidunt.org', N'5302 Non Avenida', CAST(0x87230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (161, N'Kelsey', N'Crawford', N'Cox', N'dolor@sagittislobortis.net', N'5256 Vel ', CAST(0x05230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (162, N'Kimberley', N'Mcdowell', N'Stewart', N'tellus@mi.com', N'673-5753 Aliquam C/', CAST(0xEF220B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (163, N'Adele', N'Baldwin', N'Castaneda', N'tristique@Vestibulumut.net', N'Apdo.:778-189 Sociis Avda.', CAST(0x86230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (164, N'Lars', N'Leblanc', N'Johns', N'auctor.quis@egetodioAliquam.net', N'5479 Commodo ', CAST(0x3A210B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (165, N'Steel', N'Rich', N'Fletcher', N'Integer.mollis@eleifendvitae.co.uk', N'Apartado núm.: 922, 1500 In Avenida', CAST(0xBB210B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (166, N'Florence', N'Mcdowell', N'Bowman', N'augue.eu.tellus@tellus.co.uk', N'6112 Ante. Av.', CAST(0x86230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (167, N'Damian', N'Buckley', N'Ramsey', N'enim@etrisusQuisque.net', N'Apdo.:330-4231 Egestas Avenida', CAST(0xFA230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (168, N'Jillian', N'Larson', N'Buck', N'Mauris@consectetuereuismod.com', N'Apartado núm.: 835, 4594 Dolor, Avda.', CAST(0x75220B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (169, N'Tasha', N'Reid', N'Kirk', N'molestie.tortor.nibh@pedesagittis.edu', N'Apartado núm.: 624, 4091 Nulla. Calle', CAST(0x4D230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (170, N'Blaze', N'Bean', N'Wright', N'eu@tinciduntnunc.co.uk', N'Apdo.:919-7766 Elit. Av.', CAST(0x0E220B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (171, N'Wayne', N'Roach', N'Deleon', N'non.sapien@rhoncusDonec.com', N'Apdo.:484-1093 Lorem Avenida', CAST(0x88230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (172, N'Lance', N'Mathis', N'Rosario', N'Fusce.aliquam.enim@erosnec.org', N'Apartado núm.: 661, 9584 Sollicitudin C/', CAST(0x86230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (173, N'Noble', N'Andrews', N'Farmer', N'blandit@acfermentum.net', N'Apartado núm.: 310, 5248 Dui. Carretera', CAST(0x4C230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (174, N'Yolanda', N'Gibbs', N'Weiss', N'urna.Ut.tincidunt@etnetus.net', N'Apartado núm.: 278, 1939 Elit C/', CAST(0x45210B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (175, N'Asher', N'Lara', N'Huber', N'et@ac.net', N'Apdo.:861-5933 Nascetur Carretera', CAST(0x95230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (176, N'Guy', N'Walsh', N'Cleveland', N'accumsan.interdum.libero@tristiqueaceleifend.edu', N'Apartado núm.: 452, 4487 Sed C.', CAST(0x6A230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (177, N'Beverly', N'Banks', N'Lawrence', N'gravida.sit@Nullamnisl.org', N'Apartado núm.: 175, 9064 Mi Av.', CAST(0x6D210B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (178, N'Quincy', N'Perez', N'Cochran', N'turpis.non@Donecfringilla.org', N'422-4076 Neque C.', CAST(0xEC220B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (179, N'Yasir', N'Wade', N'Compton', N'gravida@ac.edu', N'Apartado núm.: 244, 3800 Lorem Avenida', CAST(0x8F220B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (180, N'Kristen', N'Cooley', N'Suarez', N'auctor.quis@hendrerit.net', N'3018 Eu ', CAST(0x77230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (181, N'Emily', N'Hurst', N'Miller', N'urna@lectuspedeultrices.com', N'Apartado núm.: 271, 8133 Mauris Ctra.', CAST(0x73230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (182, N'Lynn', N'Holloway', N'Foreman', N'semper@pharetra.org', N'669-3960 Nisi. Avenida', CAST(0x59220B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (183, N'Belle', N'Ramirez', N'Schultz', N'vulputate.nisi.sem@et.net', N'954-8873 Nunc ', CAST(0x37210B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (184, N'Justine', N'Hartman', N'Hayden', N'Aliquam@neccursusa.com', N'804 Euismod Avenida', CAST(0x1C220B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (185, N'Ahmed', N'Justice', N'Salinas', N'feugiat@atiaculisquis.ca', N'2588 Ante, Calle', CAST(0xA5220B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (186, N'Colin', N'Coleman', N'Frederick', N'In.faucibus.Morbi@mollis.edu', N'9793 Magna. Calle', CAST(0x0A230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (187, N'Ella', N'Dunlap', N'Golden', N'Praesent.eu@eusemPellentesque.com', N'Apartado núm.: 572, 6913 Nam Carretera', CAST(0xC9220B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (188, N'Leo', N'Hayes', N'Turner', N'nec.tempus.mauris@Phasellusfermentum.edu', N'5659 Odio. Av.', CAST(0x69210B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (189, N'Velma', N'Diaz', N'Hooper', N'interdum.feugiat.Sed@acmattisvelit.ca', N'997-2662 Proin Calle', CAST(0xB9210B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (190, N'Rogan', N'Joyce', N'Martin', N'pretium.aliquet@Sed.ca', N'Apartado núm.: 714, 2637 Ridiculus Av.', CAST(0x79220B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (191, N'Desiree', N'Duran', N'Serrano', N'ac@dictummiac.com', N'453-1746 Nec Carretera', CAST(0x6F210B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (192, N'Anika', N'Bright', N'Ware', N'mi.enim.condimentum@pedenec.edu', N'Apartado núm.: 990, 3711 Dui, C/', CAST(0xEB220B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (193, N'Tanya', N'Barnes', N'Knight', N'ullamcorper.eu@luctusvulputatenisi.com', N'Apdo.:772-2140 Natoque Carretera', CAST(0x0A220B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (194, N'Mara', N'Adams', N'Grant', N'mauris.erat@Quisque.org', N'Apartado núm.: 688, 9693 Elit. C/', CAST(0x27230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (195, N'Tasha', N'Tyler', N'Wall', N'quis@adipiscingfringillaporttitor.com', N'159-6248 Neque Avenida', CAST(0x59210B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (196, N'Ezra', N'Wiggins', N'Houston', N'Sed@ametorci.co.uk', N'Apdo.:482-8781 Duis Calle', CAST(0x43220B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (197, N'Devin', N'Rosales', N'Joseph', N'aliquet.Proin.velit@euultrices.ca', N'9463 Semper ', CAST(0x3D220B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (198, N'Kieran', N'Anderson', N'Flowers', N'dictum.placerat@atauctorullamcorper.ca', N'Apartado núm.: 240, 4297 Ligula Av.', CAST(0x68230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (199, N'Tanisha', N'Dickerson', N'Cherry', N'pellentesque.a@tempus.com', N'Apartado núm.: 119, 6133 Vitae, Ctra.', CAST(0x70230B00 AS Date), 1)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (200, N'Noelani', N'Sheppard', N'Stephens', N'Proin.nisl@acorci.edu', N'Apartado núm.: 209, 2134 Tortor. Av.', CAST(0xE3220B00 AS Date), 1)
GO
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (201, N'Sybill', N'York', N'Berg', N'molestie.tellus.Aenean@Phasellusvitae.edu', N'Apdo.:115-3848 Sed C/', CAST(0x63230B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (202, N'Guy', N'Mendoza', N'Spencer', N'Nam.ac.nulla@laoreetlectusquis.com', N'Apdo.:365-9050 Sit C/', CAST(0x61210B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (203, N'Hakeem', N'Baldwin', N'Mcmahon', N'est.ac.facilisis@pellentesqueSed.edu', N'308-5548 Id, C/', CAST(0x3E220B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (204, N'Holly', N'Ramos', N'Pennington', N'pretium.neque.Morbi@tinciduntvehicularisus.org', N'1831 Egestas. ', CAST(0xF1230B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (205, N'Plato', N'Faulkner', N'Reyes', N'vel.arcu.eu@ridiculus.com', N'1302 A Ctra.', CAST(0xF6230B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (206, N'Velma', N'Ellis', N'Edwards', N'enim@Nullamfeugiat.ca', N'8636 Ac Av.', CAST(0x6C220B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (207, N'Chaim', N'Norris', N'Grimes', N'ornare@magnaUttincidunt.net', N'Apartado núm.: 740, 2591 Eget Avenida', CAST(0x13220B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (208, N'Shannon', N'Haynes', N'Craft', N'nec.tempus@venenatisa.ca', N'7229 Enim. Av.', CAST(0xD8220B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (209, N'Reagan', N'Byrd', N'Bean', N'varius@mattissemperdui.edu', N'Apdo.:340-6054 Libero Carretera', CAST(0xCF210B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (210, N'Ariel', N'Waters', N'Stephens', N'nonummy@arcu.org', N'211-377 Aliquet. Carretera', CAST(0xB6230B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (211, N'Mason', N'Jefferson', N'Kline', N'placerat.augue.Sed@vitaealiquetnec.edu', N'452-1209 Nec Calle', CAST(0x0C230B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (212, N'Ahmed', N'Carney', N'Mendez', N'aliquet.diam.Sed@eu.ca', N'561-6461 Felis Ctra.', CAST(0x08220B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (213, N'Jacob', N'Maxwell', N'Moody', N'enim@iaculisaliquet.ca', N'8448 Massa C/', CAST(0xF6220B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (214, N'Charlotte', N'Ochoa', N'Leonard', N'sit.amet.consectetuer@Donecfelis.edu', N'Apartado núm.: 494, 3124 Mattis. Calle', CAST(0xF6220B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (215, N'Carter', N'Knowles', N'Keith', N'blandit.at@leoelementum.org', N'110-126 Diam ', CAST(0xD8210B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (216, N'Cora', N'Spencer', N'Reilly', N'ullamcorper.Duis@ullamcorperDuis.org', N'981-9582 Magna C/', CAST(0x27220B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (217, N'Tiger', N'Singleton', N'Bender', N'facilisis.eget.ipsum@nulla.com', N'703-8810 Eget Calle', CAST(0x43210B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (218, N'Teegan', N'Atkinson', N'Sargent', N'vel@congueelitsed.co.uk', N'8227 Pharetra Av.', CAST(0x53230B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (219, N'Quamar', N'Stephens', N'Garrett', N'amet@Phasellus.net', N'Apdo.:140-7535 Natoque Avda.', CAST(0xD7220B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (220, N'Deborah', N'Bullock', N'Roth', N'iaculis.quis.pede@imperdietullamcorperDuis.co.uk', N'Apartado núm.: 501, 9011 Facilisi. ', CAST(0x74230B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (221, N'Ocean', N'Case', N'Koch', N'pretium.neque@est.net', N'9992 Magna Ctra.', CAST(0xB9210B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (222, N'Ross', N'Shields', N'Riddle', N'dis.parturient.montes@risusNulla.ca', N'Apartado núm.: 720, 8922 Nullam Avenida', CAST(0xF9220B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (223, N'Kaseem', N'Richards', N'Johnson', N'commodo.hendrerit.Donec@magna.net', N'366-5843 Ante C/', CAST(0xE0210B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (224, N'Oliver', N'Travis', N'Cobb', N'sit.amet@antedictum.net', N'863-1411 Sit Carretera', CAST(0xE9220B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (225, N'Ivor', N'Ellis', N'Morales', N'faucibus.Morbi@ut.net', N'Apartado núm.: 761, 5687 Nullam Calle', CAST(0x9F230B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (226, N'Calvin', N'Glenn', N'Mcintyre', N'Vivamus.euismod.urna@adipiscingMauris.com', N'Apartado núm.: 617, 5708 Eros. C/', CAST(0xD9220B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (227, N'Bert', N'Delacruz', N'Lang', N'Donec.est.Nunc@magna.org', N'306 Odio. ', CAST(0xE4230B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (228, N'Abel', N'Navarro', N'Woods', N'vulputate@nequeNullamnisl.net', N'746-3609 Libero. Calle', CAST(0xE3210B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (229, N'Kirestin', N'Patel', N'Rosario', N'urna@fringilla.co.uk', N'Apdo.:606-1834 Vehicula Avda.', CAST(0x1C220B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (230, N'Tucker', N'Mccarthy', N'Moss', N'viverra@Vivamusnonlorem.co.uk', N'8066 Donec Calle', CAST(0xF5230B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (231, N'Cole', N'Harrison', N'Owen', N'mi.fringilla.mi@sempertellusid.org', N'Apdo.:751-442 Ut Avenida', CAST(0x21230B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (232, N'Grant', N'Steele', N'Thornton', N'dolor.sit@est.edu', N'Apartado núm.: 199, 6827 Dui. Avenida', CAST(0x5C210B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (233, N'Gage', N'Talley', N'Calhoun', N'hendrerit.id@aliquameros.org', N'175-6764 Vehicula Avenida', CAST(0x46220B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (234, N'Alika', N'Munoz', N'Sears', N'enim.sit.amet@musProin.edu', N'8837 A, C.', CAST(0xFD230B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (235, N'Noble', N'Galloway', N'Foreman', N'Donec.elementum@ut.net', N'Apdo.:680-9483 Vivamus Avenida', CAST(0xC6210B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (236, N'Grady', N'Cooke', N'Bradley', N'feugiat@nectempus.org', N'Apartado núm.: 926, 5742 Ut, C.', CAST(0xE3230B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (237, N'Robin', N'Roberts', N'Lee', N'diam.Proin.dolor@dapibus.edu', N'4406 Mauris. Ctra.', CAST(0xA3230B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (238, N'Petra', N'Gordon', N'Castaneda', N'felis@purusaccumsaninterdum.co.uk', N'Apartado núm.: 581, 2232 Vestibulum Avenida', CAST(0x1A220B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (239, N'Clinton', N'Wood', N'Dyer', N'arcu.Sed@Donec.ca', N'6281 Lectus Ctra.', CAST(0x35220B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (240, N'Erin', N'Chambers', N'Moore', N'dolor@Innecorci.com', N'392-2532 Mauris. Avda.', CAST(0x68210B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (241, N'Karly', N'Spencer', N'Dejesus', N'orci@in.org', N'Apdo.:935-6262 Sociis C/', CAST(0x9C210B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (242, N'Remedios', N'Dominguez', N'Hester', N'enim.mi@Nam.co.uk', N'Apartado núm.: 580, 6088 Volutpat. C/', CAST(0xA9210B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (243, N'Odysseus', N'Clarke', N'Hughes', N'mi.ac@Integer.net', N'Apartado núm.: 981, 9795 Mattis Avenida', CAST(0x16230B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (244, N'Sonia', N'Faulkner', N'Martin', N'mi.fringilla@tincidunt.org', N'845-5366 Eu Carretera', CAST(0x3A220B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (245, N'Teagan', N'Maldonado', N'Haynes', N'a.sollicitudin@Nullafacilisis.net', N'5433 Massa. Carretera', CAST(0xF0210B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (246, N'Fiona', N'Oneill', N'Reese', N'mattis.velit@semperet.ca', N'Apdo.:502-5939 Tempor C/', CAST(0x30220B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (247, N'Sybil', N'Parker', N'Castillo', N'Sed.auctor@Crasdolor.net', N'Apdo.:362-9689 Egestas. C/', CAST(0x59220B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (248, N'Paul', N'Holland', N'Johnston', N'elit.fermentum.risus@enimsit.org', N'Apartado núm.: 904, 4865 Eget ', CAST(0x5B230B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (249, N'Kermit', N'Tran', N'Bray', N'at.velit@tristiquepharetra.co.uk', N'Apdo.:966-8471 Ante Calle', CAST(0x62230B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (250, N'Noelani', N'Hartman', N'Kerr', N'tincidunt@Nullam.net', N'Apartado núm.: 251, 3855 Lorem C/', CAST(0xAC210B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (251, N'Wyatt', N'Greer', N'Duran', N'tellus.sem@sem.edu', N'Apartado núm.: 915, 2702 Dolor Avenida', CAST(0x4E220B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (252, N'Aurelia', N'Pickett', N'Mccray', N'Duis@tristiquesenectuset.co.uk', N'Apdo.:947-7133 Gravida Av.', CAST(0x34230B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (253, N'Shay', N'Clayton', N'Colon', N'Vestibulum.accumsan@neque.com', N'Apdo.:901-3723 Et Carretera', CAST(0x82220B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (254, N'Gareth', N'Sampson', N'Calderon', N'facilisi.Sed@maurisSuspendisse.com', N'9665 Fringilla Avenida', CAST(0xC7230B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (255, N'Vielka', N'Mclean', N'Cote', N'dictum.magna@pedePraesent.net', N'9664 Sed C.', CAST(0xD4210B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (256, N'Stephanie', N'Mueller', N'Hogan', N'Phasellus@odioNaminterdum.com', N'Apdo.:606-5612 Tristique Avda.', CAST(0x76220B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (257, N'Damian', N'Lamb', N'Weaver', N'sapien@ametultricies.net', N'Apartado núm.: 870, 4169 Natoque Calle', CAST(0x47210B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (258, N'Trevor', N'Church', N'Bates', N'eget.laoreet.posuere@lacusQuisque.ca', N'Apdo.:818-2937 Auctor Avda.', CAST(0xA1230B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (259, N'Wendy', N'Goodman', N'Kelley', N'Etiam.imperdiet.dictum@velit.net', N'Apartado núm.: 768, 4060 Aenean Carretera', CAST(0x5A230B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (260, N'Lewis', N'Douglas', N'Donaldson', N'mattis@erat.co.uk', N'Apdo.:807-8632 Vel Carretera', CAST(0x79210B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (261, N'Elvis', N'Manning', N'Kent', N'metus.In@dolordapibus.ca', N'469-7259 Nisi Calle', CAST(0xD5210B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (262, N'Gray', N'Buck', N'Robles', N'sit.amet.faucibus@ornarelectus.co.uk', N'Apdo.:529-8266 Lacinia C.', CAST(0x9F230B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (263, N'Jared', N'Silva', N'Mann', N'mauris.Suspendisse@dui.edu', N'Apartado núm.: 895, 708 Interdum C/', CAST(0x95220B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (264, N'Vivian', N'Landry', N'Hebert', N'risus@Phaselluselitpede.com', N'Apdo.:938-365 Ullamcorper. Carretera', CAST(0xDE230B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (265, N'Tana', N'Noble', N'Aguirre', N'Sed.dictum.Proin@ullamcorperDuis.com', N'Apartado núm.: 600, 6910 Nunc C/', CAST(0x43230B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (266, N'Kaseem', N'Salinas', N'Whitehead', N'sodales@molestiepharetra.co.uk', N'4230 Eu Carretera', CAST(0x75210B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (267, N'Charde', N'Justice', N'Ayers', N'primis@risusquisdiam.net', N'Apdo.:361-8551 Mauris Avenida', CAST(0x70210B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (268, N'Buckminster', N'Chaney', N'Villarreal', N'lacus.Quisque.imperdiet@tinciduntpedeac.com', N'Apdo.:736-3333 Facilisis Calle', CAST(0x51220B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (269, N'Eve', N'Mullins', N'Quinn', N'Nulla.facilisis.Suspendisse@Suspendisseac.com', N'Apdo.:738-1207 Tellus. Avenida', CAST(0x9C220B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (270, N'Blythe', N'Fowler', N'Gaines', N'dolor.vitae@lectuspedeet.co.uk', N'Apartado núm.: 921, 1054 Vulputate Avenida', CAST(0x15220B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (271, N'Nasim', N'Hess', N'Carey', N'in.hendrerit.consectetuer@neque.com', N'Apartado núm.: 121, 6617 Non, Carretera', CAST(0x58220B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (272, N'Bruno', N'Hicks', N'Hicks', N'ipsum@variusorci.org', N'Apartado núm.: 973, 9924 Pretium ', CAST(0x54230B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (273, N'Mariko', N'Meyers', N'Benton', N'Proin@gravidamolestiearcu.com', N'Apdo.:682-5479 Ante ', CAST(0x71220B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (274, N'Uma', N'Bryan', N'Rutledge', N'lacus.Etiam@mus.ca', N'Apdo.:895-5611 Eu Av.', CAST(0x75230B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (275, N'Noah', N'James', N'Short', N'tincidunt.nibh.Phasellus@montesnasceturridiculus.co.uk', N'946-7334 Duis Calle', CAST(0x15220B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (276, N'Barry', N'Weeks', N'Blevins', N'dolor.Quisque@elitafeugiat.com', N'Apartado núm.: 666, 2128 Cursus C.', CAST(0x9A220B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (277, N'Yael', N'Roberts', N'Burch', N'felis.Nulla@enim.org', N'7258 Integer Ctra.', CAST(0xA5230B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (278, N'Anthony', N'Mooney', N'Wilkinson', N'odio.Nam.interdum@eget.ca', N'439-3514 Integer C.', CAST(0x2B220B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (279, N'Libby', N'Robbins', N'Norton', N'fermentum.arcu@pedenonummyut.org', N'Apartado núm.: 711, 5261 Sodales Ctra.', CAST(0xBB220B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (280, N'Brock', N'Duncan', N'Rojas', N'nec.urna@pede.edu', N'380-4756 Iaculis Avda.', CAST(0xAD230B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (281, N'Alexa', N'Snider', N'Morris', N'sed.orci@variusorci.co.uk', N'278-9424 Non, Ctra.', CAST(0xA8220B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (282, N'Paki', N'Parsons', N'Stone', N'sodales.purus.in@augueporttitor.co.uk', N'Apartado núm.: 753, 1006 Fusce Av.', CAST(0x9B230B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (283, N'Hyatt', N'Pittman', N'Bishop', N'sapien@ipsumdolorsit.net', N'6243 Sed ', CAST(0x1C230B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (284, N'Jana', N'Duke', N'Dyer', N'mi.eleifend@parturientmontes.com', N'733-4613 Ipsum ', CAST(0x40220B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (285, N'Reagan', N'Valdez', N'Black', N'tempor.augue@Sedmalesuada.org', N'6823 Eget Avda.', CAST(0x76210B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (286, N'Lesley', N'Curtis', N'Mcdonald', N'vitae@pede.net', N'Apdo.:618-6721 Vivamus Avenida', CAST(0x74230B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (287, N'Kitra', N'Carey', N'Pitts', N'velit.Pellentesque.ultricies@dolor.com', N'1723 Ipsum ', CAST(0x17220B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (288, N'Sage', N'Shannon', N'Barrett', N'Suspendisse.aliquet@lectus.edu', N'Apartado núm.: 558, 5006 Phasellus Ctra.', CAST(0xC4220B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (289, N'Genevieve', N'Larson', N'Dickerson', N'orci.sem.eget@nuncullamcorpereu.ca', N'Apdo.:250-8510 Eget C/', CAST(0x3C220B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (290, N'Leroy', N'Clarke', N'Matthews', N'quam@sedfacilisisvitae.co.uk', N'8525 In Avda.', CAST(0xB4210B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (291, N'Sheila', N'Bowman', N'Griffith', N'torquent.per@sitamet.com', N'Apartado núm.: 931, 4625 Taciti Ctra.', CAST(0xC8220B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (292, N'Althea', N'Burke', N'Acevedo', N'eu@Etiambibendumfermentum.edu', N'227-1289 Faucibus Avenida', CAST(0xF9230B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (293, N'Abra', N'Parsons', N'Massey', N'Mauris.non.dui@porttitorscelerisque.edu', N'7012 Magnis C.', CAST(0x86210B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (294, N'Yeo', N'Hess', N'Strickland', N'et.netus@vestibulummassarutrum.edu', N'Apartado núm.: 156, 6847 Augue ', CAST(0x4F210B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (295, N'Maile', N'Sweeney', N'Wise', N'Nullam.vitae@mattisvelitjusto.co.uk', N'Apartado núm.: 982, 7161 Vel Carretera', CAST(0x56220B00 AS Date), 9)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (296, N'Ella', N'Haley', N'Austin', N'libero.Proin.sed@vitaeerat.co.uk', N'Apartado núm.: 186, 807 Tellus Av.', CAST(0xB4220B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (297, N'Kerry', N'Hayes', N'Branch', N'aliquet.Phasellus@non.org', N'Apartado núm.: 488, 177 Dictum Carretera', CAST(0xF0220B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (298, N'Baker', N'Flores', N'Dyer', N'Nulla.interdum.Curabitur@erat.co.uk', N'Apdo.:683-3279 Metus Avenida', CAST(0xD5230B00 AS Date), 8)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (299, N'Lev', N'Hatfield', N'Bernard', N'sed@malesuada.org', N'655-7138 Leo, Carretera', CAST(0xE7210B00 AS Date), 7)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (300, N'Owen', N'Klein', N'Mckay', N'Aliquam.nisl.Nulla@nequeNullamnisl.ca', N'9710 Donec Ctra.', CAST(0x6D220B00 AS Date), 8)
GO
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (301, N'Wynter', N'Woodward', N'Preston', N'lobortis.nisi.nibh@interdum.ca', N'Apdo.:770-7295 Sapien. Av.', CAST(0x44220B00 AS Date), 5)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (302, N'Hu', N'Glenn', N'James', N'lorem.eu.metus@Cumsociisnatoque.net', N'Apdo.:665-6249 Aliquam C/', CAST(0xE1210B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (303, N'Hayes', N'Avery', N'Holden', N'convallis@Nuncsed.org', N'6574 Mauris Ctra.', CAST(0x5E210B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (304, N'Celeste', N'Lucas', N'Vang', N'porttitor.scelerisque.neque@dolorvitae.com', N'8679 Massa. Avenida', CAST(0x90210B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (305, N'Drew', N'Maldonado', N'Ramsey', N'bibendum@In.edu', N'623-3466 A, Avda.', CAST(0xC8220B00 AS Date), 5)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (306, N'Chelsea', N'Wiggins', N'Greene', N'est@tinciduntdui.co.uk', N'716-3420 Praesent Ctra.', CAST(0xDA210B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (307, N'Howard', N'Key', N'Griffith', N'ac@necmalesuada.edu', N'Apdo.:828-5000 Vel Avenida', CAST(0xF9230B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (308, N'Petra', N'Humphrey', N'Pittman', N'luctus.sit.amet@In.com', N'461 Eget, Avda.', CAST(0x95220B00 AS Date), 5)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (309, N'Larissa', N'Forbes', N'Crane', N'aliquet@ridiculus.net', N'Apdo.:973-2078 Dignissim ', CAST(0x73230B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (310, N'Germane', N'Fitzgerald', N'Berg', N'suscipit.est.ac@aliquamiaculislacus.ca', N'Apdo.:587-7518 Aliquam C/', CAST(0xEB210B00 AS Date), 5)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (311, N'Maxine', N'Butler', N'Holman', N'eleifend@nuncQuisqueornare.com', N'Apartado núm.: 339, 8369 Accumsan C.', CAST(0x35210B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (312, N'Azalia', N'Chaney', N'Snider', N'mauris@gravidamauris.net', N'Apartado núm.: 133, 3586 Elit Avenida', CAST(0x31230B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (313, N'Erasmus', N'Mcclure', N'Odom', N'diam@Crasconvallisconvallis.net', N'574-1605 Neque C.', CAST(0xFC220B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (314, N'Doris', N'Mckinney', N'Baldwin', N'eget@necquam.net', N'627-2663 Libero. Calle', CAST(0xF8220B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (315, N'Ashton', N'Ross', N'Pate', N'primis@mollisInteger.net', N'577-4519 Duis Avenida', CAST(0x59210B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (316, N'Melvin', N'George', N'Estes', N'Quisque.libero@pedemalesuadavel.com', N'7980 Orci ', CAST(0x53220B00 AS Date), 5)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (317, N'Hammett', N'Fulton', N'James', N'Duis.cursus@nullaat.com', N'Apdo.:127-6052 Vel, Av.', CAST(0xA2210B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (318, N'Lane', N'Sanford', N'Nichols', N'est.Nunc.ullamcorper@nunc.org', N'232-3071 Dolor. Ctra.', CAST(0x32210B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (319, N'Emmanuel', N'Reed', N'Newman', N'tempus.non.lacinia@pedeblandit.org', N'281-7187 Nec ', CAST(0x32210B00 AS Date), 5)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (320, N'Kato', N'Cooper', N'Hines', N'eu.placerat.eget@est.com', N'Apdo.:888-937 Lobortis C.', CAST(0x8A230B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (321, N'Ainsley', N'Reynolds', N'Delacruz', N'Nam.nulla.magna@ligulaDonecluctus.co.uk', N'593-869 Ipsum C/', CAST(0x48220B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (322, N'Bo', N'Flowers', N'Calhoun', N'lorem.ipsum@Donecfringilla.edu', N'Apdo.:436-4803 Sociis C.', CAST(0x58210B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (323, N'Reece', N'Tyson', N'Weber', N'lorem.vehicula.et@pedeCumsociis.org', N'4182 Aliquam, Carretera', CAST(0x62210B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (324, N'Beatrice', N'Mccoy', N'David', N'lacus.Cras.interdum@acfacilisisfacilisis.com', N'5607 Etiam Ctra.', CAST(0x2C230B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (325, N'Mohammad', N'Rivers', N'Hendricks', N'magna.sed@vulputatenisisem.net', N'Apartado núm.: 197, 2278 Vehicula Calle', CAST(0x78230B00 AS Date), 5)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (326, N'Alisa', N'Finley', N'Kane', N'pede.ultrices@arcu.org', N'2269 Et, C/', CAST(0xF0230B00 AS Date), 5)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (327, N'Sacha', N'Hayden', N'Lynch', N'enim@nisinibh.org', N'Apdo.:151-8783 Urna. Avda.', CAST(0x56220B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (328, N'Lionel', N'Lloyd', N'Hess', N'augue.id@porttitor.edu', N'762-5895 Dis C/', CAST(0x6C230B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (329, N'Maia', N'Brady', N'Santiago', N'eros.Proin@aarcu.edu', N'3788 Dictum Avda.', CAST(0x52220B00 AS Date), 5)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (330, N'Deirdre', N'Obrien', N'Fulton', N'ac@rhoncusNullam.co.uk', N'457-2298 Sem C.', CAST(0xBF220B00 AS Date), 5)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (331, N'Madaline', N'Ratliff', N'Owens', N'nibh.Donec@eratvel.edu', N'6775 Elementum Ctra.', CAST(0x48230B00 AS Date), 5)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (332, N'Matthew', N'Schroeder', N'Oconnor', N'nulla.vulputate@fermentumvel.net', N'Apdo.:661-204 Elementum C/', CAST(0x18220B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (333, N'Jaden', N'Randall', N'Hebert', N'aliquet@lacus.co.uk', N'Apartado núm.: 408, 851 Libero Ctra.', CAST(0xEA230B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (334, N'Ramona', N'Finley', N'Baldwin', N'urna.Nunc@acliberonec.org', N'615-7834 Ac Avda.', CAST(0xB2220B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (335, N'Flynn', N'Trevino', N'Dickerson', N'mauris@Sedet.ca', N'Apdo.:710-7540 Erat C.', CAST(0x7A210B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (336, N'Colleen', N'Phillips', N'William', N'nascetur.ridiculus.mus@urnaconvallis.net', N'Apartado núm.: 867, 7484 Maecenas C/', CAST(0x90220B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (337, N'Kenyon', N'Valdez', N'Bolton', N'tincidunt.neque@sollicitudincommodo.co.uk', N'411-7774 Sociis Av.', CAST(0x8E210B00 AS Date), 5)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (338, N'Azalia', N'Riggs', N'Farmer', N'hendrerit.Donec.porttitor@vehicularisus.edu', N'6657 Nullam Avenida', CAST(0x74230B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (339, N'Felicia', N'Oliver', N'Berg', N'tempor@quis.net', N'7320 Dolor Avenida', CAST(0xCB220B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (340, N'Demetrius', N'Sears', N'Erickson', N'laoreet.libero@lobortisClass.com', N'362-8248 Nunc ', CAST(0x29220B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (341, N'Cullen', N'Booth', N'Keith', N'velit.Cras@sitamet.edu', N'289-7435 Et, C.', CAST(0x76210B00 AS Date), 5)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (342, N'Germane', N'Koch', N'Clayton', N'tempor.est@parturient.net', N'1062 Ultrices Avda.', CAST(0x77220B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (343, N'Leroy', N'Wagner', N'Cardenas', N'fringilla.euismod.enim@a.net', N'555-4887 Nunc Av.', CAST(0x97230B00 AS Date), 5)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (344, N'Odysseus', N'Glover', N'Albert', N'eget@aliquetlibero.co.uk', N'Apdo.:399-651 Tortor Avda.', CAST(0xB7210B00 AS Date), 5)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (345, N'Riley', N'Hicks', N'Stark', N'malesuada.malesuada@lacinia.ca', N'7233 Faucibus Ctra.', CAST(0x54230B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (346, N'Keegan', N'Snow', N'Rosa', N'egestas.hendrerit.neque@pretiumaliquetmetus.com', N'Apdo.:508-9964 Dictum Ctra.', CAST(0x19230B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (347, N'Yasir', N'Maldonado', N'Greer', N'nec.eleifend.non@risus.edu', N'Apartado núm.: 242, 8430 Lectus ', CAST(0xA3230B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (348, N'Ifeoma', N'Owens', N'Gilliam', N'tempus.mauris.erat@nuncsitamet.co.uk', N'Apdo.:438-4807 Urna. Avenida', CAST(0xC8230B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (349, N'Leo', N'Hart', N'Brock', N'volutpat@egestashendreritneque.org', N'4977 Orci, ', CAST(0x5C230B00 AS Date), 5)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (350, N'Solomon', N'Mckinney', N'Boyer', N'ipsum.Suspendisse.sagittis@placeratorcilacus.edu', N'755-1953 Nunc Ctra.', CAST(0x05230B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (351, N'Dane', N'Guthrie', N'Matthews', N'sed@vitaediam.com', N'719-3508 Dis Av.', CAST(0x43230B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (352, N'Luke', N'Langley', N'Beard', N'varius@ornareInfaucibus.co.uk', N'540-1687 Vitae C.', CAST(0x41210B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (353, N'Ira', N'Atkinson', N'Chen', N'Aliquam@ametultriciessem.org', N'Apartado núm.: 401, 306 Sed Avda.', CAST(0xB4210B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (354, N'Ross', N'Christensen', N'Glenn', N'elit@ornaresagittis.ca', N'1288 Nam C.', CAST(0xE1220B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (355, N'Maggie', N'Mcdaniel', N'Neal', N'Donec@Duis.edu', N'Apdo.:218-1222 Ullamcorper. ', CAST(0x43230B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (356, N'Kessie', N'Whitney', N'Conley', N'turpis.egestas.Aliquam@pharetra.org', N'Apartado núm.: 571, 3717 Non C.', CAST(0x46230B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (357, N'Ian', N'Boyle', N'Rhodes', N'rutrum@non.com', N'Apdo.:316-4131 Lorem Av.', CAST(0xBE220B00 AS Date), 5)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (358, N'Pearl', N'Walsh', N'Salas', N'suscipit.est@dolorelitpellentesque.ca', N'4082 Enim, Ctra.', CAST(0x51230B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (359, N'Mollie', N'Benson', N'Mooney', N'aliquam.iaculis@hendrerit.co.uk', N'Apartado núm.: 278, 3751 Odio Av.', CAST(0xBB210B00 AS Date), 5)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (360, N'Alexis', N'Mack', N'Larson', N'enim.nec.tempus@nequeNullamnisl.co.uk', N'Apartado núm.: 578, 2072 Sapien Av.', CAST(0xCD220B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (361, N'Reed', N'Mills', N'Glass', N'ad.litora@cursusdiamat.com', N'Apdo.:808-4893 Auctor Avda.', CAST(0xF3210B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (362, N'Octavia', N'Hayden', N'Knox', N'volutpat.nunc.sit@vulputate.edu', N'Apartado núm.: 399, 869 Nec, Av.', CAST(0xAD210B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (363, N'Ferris', N'Gillespie', N'Russell', N'Quisque.ornare@nullaIntegerurna.net', N'Apdo.:918-9859 Ac ', CAST(0x6F220B00 AS Date), 5)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (364, N'Drake', N'Pennington', N'Bowen', N'felis.adipiscing@congue.com', N'Apdo.:776-617 Sem Avda.', CAST(0xFD230B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (365, N'Joel', N'Harrison', N'Bray', N'fringilla@insodaleselit.com', N'Apdo.:488-1407 Vitae C.', CAST(0x73210B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (366, N'Keiko', N'Cross', N'Barber', N'Phasellus.ornare.Fusce@tempus.com', N'421-9670 Sed Carretera', CAST(0x85230B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (367, N'Shad', N'Blevins', N'Hunter', N'felis.orci.adipiscing@nulla.edu', N'2447 Ac Avda.', CAST(0x8B210B00 AS Date), 5)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (368, N'Ivor', N'Conner', N'Buckley', N'turpis.Nulla@dignissim.com', N'Apdo.:136-5212 Auctor, Avda.', CAST(0xDC210B00 AS Date), 5)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (369, N'Destiny', N'Stone', N'May', N'vulputate.dui@ipsumSuspendissesagittis.ca', N'Apartado núm.: 259, 9375 Felis Av.', CAST(0x63210B00 AS Date), 5)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (370, N'Jada', N'Meyer', N'Burke', N'Aliquam.nec.enim@euismodacfermentum.ca', N'4195 Turpis. ', CAST(0x4F210B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (371, N'Giacomo', N'Conner', N'Brooks', N'metus@odiotristique.co.uk', N'Apartado núm.: 799, 9926 Faucibus ', CAST(0x18220B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (372, N'Jarrod', N'Morton', N'Hensley', N'orci.luctus.et@Aliquamornare.net', N'549 Eu Av.', CAST(0x5C210B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (373, N'Hedda', N'Pennington', N'Cox', N'iaculis@porttitorvulputate.net', N'8224 Vel ', CAST(0x76230B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (374, N'Bell', N'Beard', N'Dunn', N'mollis.dui.in@orcilacusvestibulum.com', N'9294 Nonummy. C.', CAST(0xDE220B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (375, N'Nasim', N'Holland', N'Dominguez', N'Curabitur.massa@acmattisvelit.com', N'Apartado núm.: 392, 9897 Convallis C/', CAST(0x14220B00 AS Date), 5)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (376, N'Laura', N'Brewer', N'Battle', N'dictum.mi@et.co.uk', N'Apdo.:642-6438 Imperdiet Av.', CAST(0x29220B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (377, N'Berk', N'Wagner', N'Welch', N'Suspendisse.dui@ornare.ca', N'Apdo.:394-3299 Sed ', CAST(0x32210B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (378, N'Fitzgerald', N'Carrillo', N'Alvarez', N'malesuada@veliteget.org', N'Apdo.:521-111 Varius Avenida', CAST(0x85210B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (379, N'Solomon', N'Valdez', N'Kennedy', N'bibendum.Donec.felis@arcu.co.uk', N'Apartado núm.: 410, 7652 Faucibus Av.', CAST(0x94230B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (380, N'Hashim', N'Howell', N'Anthony', N'pharetra@vestibulum.edu', N'8072 Eu, Ctra.', CAST(0x89210B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (381, N'Ryder', N'Wall', N'Ruiz', N'Donec.non@feugiat.ca', N'2433 Leo, Av.', CAST(0xE9210B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (382, N'Christen', N'Castaneda', N'Rocha', N'elementum.at.egestas@ultriciesornare.net', N'6723 Nec Avenida', CAST(0x53220B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (383, N'Abigail', N'Riddle', N'Snyder', N'Sed@in.co.uk', N'Apartado núm.: 994, 1778 Est C/', CAST(0xCD210B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (384, N'Ignatius', N'Joyce', N'Glenn', N'imperdiet@Aliquam.edu', N'Apartado núm.: 110, 8883 Elit ', CAST(0xA4220B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (385, N'Darryl', N'Mcdowell', N'Blake', N'sodales.at.velit@egestasrhoncusProin.com', N'655-321 Sociis Avenida', CAST(0xC5230B00 AS Date), 5)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (386, N'Brynn', N'Johns', N'Ellison', N'cursus.Nunc@Maurisquisturpis.co.uk', N'254-7293 Luctus ', CAST(0x39230B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (387, N'Akeem', N'Patterson', N'Hyde', N'et.arcu.imperdiet@magnaPraesentinterdum.net', N'Apdo.:894-3521 Tincidunt. Avenida', CAST(0x7D230B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (388, N'Lunea', N'Elliott', N'Dillon', N'penatibus@Sedmolestie.net', N'Apartado núm.: 449, 6808 Malesuada ', CAST(0x6D220B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (389, N'Harlan', N'Obrien', N'Sanford', N'dictum@tellus.co.uk', N'1497 Tristique Ctra.', CAST(0x0D230B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (390, N'Forrest', N'Ellison', N'Parks', N'elit.a.feugiat@etrutrum.org', N'Apdo.:457-4413 In C.', CAST(0xF5230B00 AS Date), 5)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (391, N'Cooper', N'Bolton', N'Guzman', N'nonummy.ultricies@mauris.co.uk', N'Apdo.:706-5381 Suspendisse Avda.', CAST(0x0F230B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (392, N'Sybil', N'Savage', N'Montoya', N'et.arcu.imperdiet@infelisNulla.com', N'344-8460 Sed Av.', CAST(0x3D210B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (393, N'Aquila', N'Mcclure', N'Flores', N'Integer@Nunc.com', N'2795 Dapibus ', CAST(0xB7230B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (394, N'Tatiana', N'Delacruz', N'Mckay', N'nunc.ac@esttempor.net', N'Apdo.:845-908 Rhoncus. C.', CAST(0x7F210B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (395, N'Kerry', N'Kidd', N'Whitney', N'at@idantedictum.ca', N'5448 Imperdiet Av.', CAST(0xFC210B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (396, N'Octavia', N'Warner', N'Webster', N'Cras.dolor@vellectus.net', N'834-7556 Ultrices. ', CAST(0xA9220B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (397, N'Raja', N'Obrien', N'Melendez', N'et.tristique.pellentesque@erosturpis.com', N'Apdo.:327-6501 Dolor. Av.', CAST(0x4C220B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (398, N'Scarlett', N'Duncan', N'Rollins', N'non.arcu.Vivamus@facilisisegetipsum.co.uk', N'Apdo.:490-2139 Egestas C/', CAST(0x67210B00 AS Date), 4)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (399, N'Kenyon', N'Pennington', N'Mason', N'sociis.natoque.penatibus@veliteget.edu', N'Apdo.:508-4580 Aliquam Avda.', CAST(0xDC210B00 AS Date), 6)
INSERT [dbo].[Cliente] ([ID], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Correo], [Direccion], [Fecha_nacimiento], [Estatus_ID]) VALUES (400, N'Bert', N'Macdonald', N'Rosales', N'dolor@utlacusNulla.com', N'6424 Dictum Av.', CAST(0xC7210B00 AS Date), 5)
GO
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (1, N'Usuario1', N'ContrasenaDefault', 3)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (2, N'admin', N'admin', 1)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (3, N'Profesor1', N'Profesor1', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (4, N'root', N'root', 1)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (5, N'Usuario2', N' ', 3)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (6, N'Usuario3', N'Contrasenia', 3)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (7, N'Julio', N'Julio', 3)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (8, N'Mancha', N'Mancha', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (9, N'Nam.ligula.elit@convallisest.ca', N'GHQ09LRX3WM', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (10, N'suscipit.nonummy.Fusce@tortornibhsit.org', N'PKE25LJA4WM', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (11, N'orci.Donec@Integervitaenibh.co.uk', N'KWT98ZJQ7AW', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (12, N'vestibulum.nec@Phasellusdapibus.com', N'LAG88IKI1FF', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (13, N'arcu.Nunc.mauris@Crasdictumultricies.net', N'OTF09OMB0JR', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (14, N'faucibus@Aeneanegestas.com', N'UQC57ZAS2FV', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (15, N'gravida.nunc.sed@feugiat.net', N'BMG70MCD7UH', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (16, N'malesuada.fames.ac@malesuada.edu', N'FXI40PEI6NJ', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (17, N'lorem.vitae@semutcursus.com', N'KDL16NHX2LR', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (18, N'sed.turpis.nec@interdumlibero.co.uk', N'YKM97GZU9FC', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (19, N'mi@cursusnonegestas.org', N'UXY00XQT9WA', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (20, N'Cras@aliquetPhasellusfermentum.edu', N'FVI53ULC4FJ', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (21, N'habitant.morbi@vulputate.co.uk', N'HXE91ALI5AV', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (22, N'egestas.Duis.ac@seddictum.ca', N'OLL84PGI1CB', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (23, N'pellentesque.massa@Praesent.org', N'DUZ04PJK5WD', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (24, N'tempus.non@velmaurisInteger.org', N'ATI16DWV8LB', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (25, N'vitae@Pellentesquehabitant.com', N'SIL55VOJ9ZC', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (26, N'nascetur.ridiculus.mus@necdiam.net', N'VDY27CJW5YV', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (27, N'sagittis@dapibus.com', N'RUP69LZA4RH', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (28, N'Cum.sociis@semNullainterdum.com', N'RHI95XJY8IO', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (29, N'Donec.egestas.Duis@nuncestmollis.org', N'SKC36LGD9KR', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (30, N'Sed.nunc@euturpisNulla.ca', N'VWH71NNT5BP', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (31, N'mi.Duis.risus@Nullamvitaediam.com', N'EMT94QPX5YC', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (32, N'egestas.ligula@dictumsapien.net', N'UNO85CTN7XV', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (33, N'blandit.at@turpis.edu', N'SKH62YRD7FM', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (34, N'magna@semut.org', N'BMM16LUY6NC', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (35, N'mi.fringilla.mi@tincidunt.edu', N'SGD09LWM2FF', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (36, N'semper.tellus@risus.edu', N'XUO96GOE8EO', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (37, N'lobortis@Donecfelisorci.org', N'CPN69FWC0FN', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (38, N'vitae.dolor@Nullamvitaediam.co.uk', N'YYA44MTC0LL', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (39, N'sodales@nisinibh.edu', N'VGF78YGB4ZR', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (40, N'felis.ullamcorper@ut.com', N'LBO75ZWP5SJ', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (41, N'lacus@Aeneaneget.edu', N'KAW64DRO5YM', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (42, N'dictum.eleifend@eu.edu', N'APN23CDY9UU', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (43, N'turpis.vitae@a.co.uk', N'WCB63FOF8KA', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (44, N'dui.Fusce.aliquam@tristiqueneque.co.uk', N'LGW09YRM2AJ', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (45, N'et.rutrum@Duis.edu', N'QKH45MHR7IO', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (46, N'lectus.pede@Integeraliquam.com', N'BXI86VAH3KO', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (47, N'Aliquam@a.com', N'ICD07XCC5RG', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (48, N'nisl@Vivamusnibhdolor.ca', N'OGT46YUU8AY', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (49, N'dui@Vivamusmolestie.edu', N'JHR88HBM1LK', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (50, N'Ut.tincidunt.orci@consectetueradipiscing.org', N'NEW07PBP4SA', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (51, N'penatibus.et@lacus.org', N'TQV83NQF7VN', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (52, N'dictum@orciluctus.edu', N'OQV05OJK2GF', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (53, N'et@ametluctusvulputate.edu', N'XGS78OIQ5XM', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (54, N'fermentum@loremipsum.com', N'OBX63SWF9QW', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (55, N'nunc@porttitorvulputate.co.uk', N'IDM53XQR7JI', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (56, N'hendrerit.Donec.porttitor@laoreetlectusquis.ca', N'UQO96NHX0TY', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (57, N'sociis@accumsan.co.uk', N'YNT41IOA5HK', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (58, N'lacus@conguea.co.uk', N'YFX60JIN1KJ', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (59, N'at@leoVivamusnibh.ca', N'TFB81ALJ9AZ', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (60, N'Integer.eu.lacus@Mauris.ca', N'LOA94VAY7XG', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (61, N'Mauris@Suspendissecommodotincidunt.ca', N'DEO41OJO2DP', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (62, N'turpis.In@Aliquamtinciduntnunc.edu', N'LER21HND2ZT', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (63, N'dui.Fusce.aliquam@quis.com', N'EYQ94BZV9TX', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (64, N'orci.Ut@CuraePhasellusornare.edu', N'KAQ63ZMA3YP', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (65, N'Duis.volutpat@tempor.co.uk', N'KWR47FKS0DN', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (66, N'tristique.pellentesque@maurisa.ca', N'JAY46SVP3ZF', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (67, N'ipsum.non@consequat.com', N'UHG20PJD0VE', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (68, N'nisi@elit.com', N'ZRR91LCK7DX', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (69, N'est.ac.mattis@famesacturpis.edu', N'QDM90QUS7IB', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (70, N'tristique.senectus@doloregestasrhoncus.edu', N'RDP32RLP8WO', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (71, N'a@diamnunc.ca', N'WJL15BQU3UF', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (72, N'auctor@est.co.uk', N'WJR87GYC1WA', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (73, N'arcu.et@mieleifend.ca', N'ZUF23UNX9JM', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (74, N'Sed@ullamcorpereu.ca', N'VWC73AAN2GV', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (75, N'lacus.varius.et@imperdietdictum.net', N'IEX92HPH9IJ', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (76, N'sed.sem.egestas@etrutrum.com', N'CEC15IFF3DL', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (77, N'Donec.sollicitudin.adipiscing@eu.co.uk', N'KGV24VPY9FH', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (78, N'arcu.iaculis.enim@Nunc.edu', N'DPC11NCU0VW', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (79, N'justo.Praesent.luctus@pellentesque.net', N'WCI00GQX4YU', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (80, N'elit.Nulla@sitametrisus.net', N'RLG84TGN5QP', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (81, N'blandit.viverra@quam.co.uk', N'ERO24IVQ4WU', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (82, N'Pellentesque.habitant.morbi@nuncullamcorper.com', N'DAY04QBT8AY', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (83, N'sed.dolor@eueros.com', N'KRB01LJD8BI', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (84, N'vel.venenatis.vel@ligulaNullamfeugiat.com', N'ESU35NES3HY', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (85, N'dolor@morbi.com', N'UMJ57FJP5YD', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (86, N'a.aliquet.vel@erosProinultrices.org', N'NQM43WNU1GF', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (87, N'tincidunt@egestasDuis.co.uk', N'RAH99FUC7AF', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (88, N'quis.diam.Pellentesque@duiCumsociis.edu', N'HKB31SUX7ZH', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (89, N'sem.ut@vulputate.co.uk', N'RZB69EHQ6BP', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (90, N'a.nunc@eueratsemper.com', N'CDG13PDM5SY', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (91, N'Aliquam@quis.net', N'MBS84FMB0HS', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (92, N'vel@erosnectellus.com', N'VGF81CAW7GC', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (93, N'magna.Praesent@viverraMaecenasiaculis.co.uk', N'ZKZ39HDX3XS', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (94, N'fermentum.fermentum@consequat.net', N'XCJ78NPH8II', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (95, N'massa@facilisismagnatellus.net', N'HJR51JTV4FY', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (96, N'rutrum.magna@elit.org', N'OSW92KTP1VL', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (97, N'augue.eu.tempor@diam.co.uk', N'ZBB97QES5NK', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (98, N'dui@leoVivamusnibh.com', N'MYA48BUQ7XE', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (99, N'fermentum@quisarcuvel.net', N'ACO14SFT2LU', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (100, N'interdum@magnaDuisdignissim.org', N'BUG62HST3MP', 2)
GO
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (101, N'Duis@metussit.net', N'GTY50KAQ9DD', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (102, N'Sed@ultriciesligula.com', N'LWN30UZI6SK', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (103, N'aliquet.odio@sedfacilisisvitae.edu', N'NKP91EWJ3BD', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (104, N'augue@arcuMorbi.edu', N'TPN18EFB8KI', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (105, N'tempus@vehicula.com', N'FLC14JLI2WZ', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (106, N'eros.turpis@Nullasemper.edu', N'AOC40HNS8TQ', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (107, N'Suspendisse.aliquet@lectus.co.uk', N'SAM56RPD4AO', 2)
INSERT [dbo].[Cuenta] ([ID], [Usuario], [PasswordCuenta], [NivelAutorizacion]) VALUES (108, N'montes@egestas.org', N'XJO87IPT6PT', 2)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (1, 101, 1001)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (2, 102, 1002)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (3, 103, 1003)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (4, 104, 1004)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (5, 105, 1005)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (6, 106, 1006)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (7, 107, 1007)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (8, 108, 1008)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (9, 109, 1009)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (10, 110, 1010)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (11, 111, 1011)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (12, 112, 1012)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (13, 113, 1013)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (14, 114, 1014)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (15, 115, 1015)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (16, 116, 1016)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (17, 117, 1017)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (18, 118, 1018)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (19, 119, 1019)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (20, 120, 1020)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (21, 111, 1011)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (22, 122, 1022)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (23, 123, 1023)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (24, 124, 1024)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (25, 125, 1025)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (26, 126, 1026)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (27, 127, 1027)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (28, 128, 1028)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (29, 129, 1029)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (30, 130, 1030)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (31, 131, 1031)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (32, 132, 1032)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (33, 133, 1033)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (34, 134, 1034)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (35, 135, 1035)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (36, 136, 1036)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (37, 137, 1037)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (38, 138, 1038)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (39, 139, 1039)
INSERT [dbo].[Curso] ([Clave], [Aula_Numero], [Profesor_Empleado_No_empleado]) VALUES (40, 140, 1040)
INSERT [dbo].[Curso_Horario] ([Curso_Clave], [Horario_Clave]) VALUES (1, 1)
INSERT [dbo].[Curso_Horario] ([Curso_Clave], [Horario_Clave]) VALUES (1, 12)
INSERT [dbo].[Curso_Horario] ([Curso_Clave], [Horario_Clave]) VALUES (1, 15)
INSERT [dbo].[Curso_Horario] ([Curso_Clave], [Horario_Clave]) VALUES (1, 20)
INSERT [dbo].[Curso_Horario] ([Curso_Clave], [Horario_Clave]) VALUES (2, 2)
INSERT [dbo].[Curso_Horario] ([Curso_Clave], [Horario_Clave]) VALUES (2, 15)
INSERT [dbo].[Curso_Horario] ([Curso_Clave], [Horario_Clave]) VALUES (11, 20)
INSERT [dbo].[Curso_Horario] ([Curso_Clave], [Horario_Clave]) VALUES (13, 1)
INSERT [dbo].[Curso_Horario] ([Curso_Clave], [Horario_Clave]) VALUES (19, 1)
INSERT [dbo].[Curso_Horario] ([Curso_Clave], [Horario_Clave]) VALUES (21, 1)
INSERT [dbo].[Curso_Horario] ([Curso_Clave], [Horario_Clave]) VALUES (22, 12)
INSERT [dbo].[Curso_Horario] ([Curso_Clave], [Horario_Clave]) VALUES (24, 15)
INSERT [dbo].[Curso_Horario] ([Curso_Clave], [Horario_Clave]) VALUES (25, 15)
INSERT [dbo].[Curso_Horario] ([Curso_Clave], [Horario_Clave]) VALUES (30, 1)
INSERT [dbo].[Curso_Horario] ([Curso_Clave], [Horario_Clave]) VALUES (31, 12)
INSERT [dbo].[Curso_Horario] ([Curso_Clave], [Horario_Clave]) VALUES (32, 15)
INSERT [dbo].[Curso_Horario] ([Curso_Clave], [Horario_Clave]) VALUES (33, 1)
INSERT [dbo].[Curso_Horario] ([Curso_Clave], [Horario_Clave]) VALUES (33, 15)
INSERT [dbo].[Curso_Horario] ([Curso_Clave], [Horario_Clave]) VALUES (34, 20)
INSERT [dbo].[Curso_Horario] ([Curso_Clave], [Horario_Clave]) VALUES (35, 1)
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1000, N'Penelope', N'England', N'Gibbs', N'Apdo.:718-9158 Ligula. C.', CAST(0x50170B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1001, N'Sarah', N'Vinson', N'Rasmussen', N'Apartado núm.: 324, 7681 Metus C/', CAST(0xB3120B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1002, N'Laurel', N'Alexander', N'Franco', N'Apdo.:863-2467 Mattis Av.', CAST(0x40100B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1003, N'Shelly', N'Gay', N'Hendricks', N'7915 Eros C/', CAST(0x20130B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1004, N'Kiayada', N'Roth', N'Cabrera', N'Apdo.:269-5265 Mauris Av.', CAST(0x1B1D0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1005, N'Jane', N'Pate', N'Sweeney', N'496-4400 Nunc Carretera', CAST(0x551D0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1006, N'Kelsey', N'Blankenship', N'Maldonado', N'7273 In Av.', CAST(0x821A0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1007, N'Hiroko', N'Palmer', N'Kline', N'Apdo.:513-5757 Orci. C.', CAST(0x4D1D0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1008, N'Wyatt', N'Rollins', N'Dodson', N'Apartado núm.: 323, 6411 Adipiscing Avenida', CAST(0x510B0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1009, N'Ingrid', N'Snider', N'Delgado', N'Apdo.:511-2076 Eu C/', CAST(0xF4160B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1010, N'Amena', N'Rodriquez', N'Haynes', N'Apdo.:973-934 Iaculis C.', CAST(0x661B0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1011, N'Lara', N'Lyons', N'Price', N'5977 Sodales Ctra.', CAST(0xE2180B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1012, N'Xenos', N'Powell', N'Lane', N'178-4428 Non Avda.', CAST(0xDC160B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1013, N'Roanna', N'Mosley', N'Lawrence', N'931-7016 Eros ', CAST(0x77080B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1014, N'Zeph', N'Lawrence', N'Dunlap', N'1693 Nec Carretera', CAST(0xE00A0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1015, N'Ferris', N'Barlow', N'Farley', N'Apartado núm.: 417, 3741 Lacinia Ctra.', CAST(0x5B170B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1016, N'Hyacinth', N'Carrillo', N'Harrell', N'1360 Tempus Ctra.', CAST(0x31140B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1017, N'Ashton', N'Hess', N'Marsh', N'4459 Nullam Ctra.', CAST(0xB20D0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1018, N'Cain', N'Castillo', N'Knapp', N'Apartado núm.: 398, 5562 Pellentesque C.', CAST(0xD91A0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1019, N'Richard', N'Mcmillan', N'Kirk', N'714-6391 Magnis Carretera', CAST(0x8C080B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1020, N'Wing', N'Conner', N'Koch', N'178 Eleifend, C/', CAST(0xBF1B0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1021, N'Micah', N'Merritt', N'Cunningham', N'Apdo.:699-4072 Nisi ', CAST(0x5C160B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1022, N'Scarlett', N'Montgomery', N'Hinton', N'698 In Avda.', CAST(0x0C180B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1023, N'Audra', N'Kline', N'Rich', N'579-8483 Massa. Avenida', CAST(0xF6150B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1024, N'Owen', N'Higgins', N'Mccullough', N'817-3266 Penatibus C.', CAST(0xAF0A0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1025, N'Benedict', N'Vazquez', N'Carpenter', N'Apartado núm.: 466, 4859 Ut C/', CAST(0x37180B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1026, N'Warren', N'Ellis', N'Oliver', N'108-6559 Pharetra C/', CAST(0x851C0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1027, N'Jenna', N'Ferrell', N'Wilkerson', N'Apdo.:661-2773 Odio Carretera', CAST(0x3E090B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1028, N'Jack', N'Palmer', N'Grimes', N'5303 Nisi. Avda.', CAST(0x6A0D0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1029, N'Abra', N'Brewer', N'Mcintosh', N'Apartado núm.: 664, 3845 Sodales. Av.', CAST(0x641B0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1030, N'Theodore', N'Lynn', N'Pittman', N'Apartado núm.: 952, 9465 Ac Calle', CAST(0x121A0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1031, N'Ferris', N'Whitfield', N'Terry', N'Apdo.:602-9325 Fringilla C.', CAST(0xCC0B0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1032, N'Beatrice', N'Knight', N'Weiss', N'Apdo.:411-4673 Tristique Calle', CAST(0xFF160B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1033, N'Xenos', N'Fuller', N'Burnett', N'9786 Sed Av.', CAST(0x7F1A0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1034, N'Dahlia', N'Bradshaw', N'Kline', N'Apdo.:177-3052 Aliquam Ctra.', CAST(0xCB0F0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1035, N'Fiona', N'Finley', N'Reynolds', N'9313 Enim Carretera', CAST(0x0A190B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1036, N'David', N'Mckenzie', N'Kelley', N'Apartado núm.: 509, 5228 Sed Ctra.', CAST(0x62160B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1037, N'Gage', N'Bright', N'Malone', N'Apartado núm.: 705, 1541 Dui Avenida', CAST(0x3F1A0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1038, N'Keiko', N'Hampton', N'Mckenzie', N'Apdo.:365-2192 Ac C/', CAST(0xFE110B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1039, N'Malik', N'Obrien', N'Parrish', N'Apartado núm.: 367, 2147 Ornare. Calle', CAST(0x04100B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1040, N'Cody', N'Finley', N'Sargent', N'429-5850 Ipsum Carretera', CAST(0xFA090B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1041, N'Acton', N'Bush', N'Cash', N'Apdo.:808-3535 Nec Av.', CAST(0xAE110B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1042, N'Natalie', N'Kirk', N'Moss', N'Apdo.:620-1088 Quisque ', CAST(0xF1130B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1043, N'Colorado', N'Drake', N'Pratt', N'Apdo.:524-2623 Eleifend Calle', CAST(0x270A0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1044, N'Hasad', N'Fuller', N'Mcmahon', N'Apdo.:583-4710 Elit. Carretera', CAST(0x99160B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1045, N'Angelica', N'Wolf', N'Hanson', N'Apdo.:281-3222 Lobortis Carretera', CAST(0x3E100B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1046, N'Kirestin', N'Love', N'Hatfield', N'Apartado núm.: 325, 1992 Pellentesque Ctra.', CAST(0xEB150B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1047, N'Matthew', N'Webb', N'Ayala', N'Apdo.:311-2436 Augue Carretera', CAST(0xD30C0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1048, N'Melvin', N'Cardenas', N'Church', N'138-3897 Eleifend Avenida', CAST(0x80110B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1049, N'Daryl', N'Burnett', N'Fuller', N'224-1173 Fusce Avenida', CAST(0x62150B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1050, N'Rogan', N'Jacobson', N'Clayton', N'967-2614 Sed Carretera', CAST(0xC30C0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1051, N'Serina', N'Day', N'Ray', N'Apartado núm.: 151, 6284 Rutrum Calle', CAST(0x00080B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1052, N'Heather', N'Carr', N'Potts', N'Apdo.:343-5820 Cursus Av.', CAST(0x52110B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1053, N'Azalia', N'Conway', N'Stevenson', N'8404 Diam Calle', CAST(0xE41B0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1054, N'Melissa', N'Serrano', N'Blankenship', N'828-4664 Elit, Avenida', CAST(0x66180B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1055, N'Jelani', N'Tran', N'Morris', N'Apartado núm.: 388, 5382 Velit. Ctra.', CAST(0xF8140B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1056, N'Otto', N'Hayden', N'Richard', N'Apartado núm.: 514, 4956 Ridiculus Avenida', CAST(0xD60F0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1057, N'Hedley', N'Cameron', N'Shepherd', N'Apartado núm.: 625, 2654 Bibendum ', CAST(0xF50A0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1058, N'Jasper', N'Becker', N'Casey', N'726-5962 Sit Av.', CAST(0x8A1B0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1059, N'Leah', N'Harper', N'Knapp', N'Apdo.:763-237 Est. ', CAST(0x6C130B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1060, N'Lucian', N'Ochoa', N'Maxwell', N'Apdo.:411-9829 Pharetra Avenida', CAST(0x351B0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1061, N'Shay', N'Long', N'Christensen', N'9957 Blandit Avenida', CAST(0x5C1A0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1062, N'Kyle', N'Johns', N'Grant', N'5986 Aliquam ', CAST(0xCF100B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1063, N'Chloe', N'Grimes', N'Cunningham', N'546 Nunc C.', CAST(0x13150B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1064, N'Patience', N'Boyle', N'Stein', N'806-8610 Euismod Avenida', CAST(0x620D0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1065, N'Ulric', N'Fisher', N'Joyce', N'Apdo.:483-846 Vulputate Avda.', CAST(0xBE120B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1066, N'Jelani', N'Kirby', N'Hull', N'Apartado núm.: 728, 1362 Volutpat ', CAST(0x451D0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1067, N'Idola', N'Buckley', N'Ratliff', N'Apdo.:996-8932 Mauris Carretera', CAST(0xD8130B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1068, N'Isaac', N'Barlow', N'Perkins', N'383-7230 Odio, Carretera', CAST(0x331D0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1069, N'Colorado', N'Bright', N'Knight', N'720-1495 Inceptos Avenida', CAST(0xAC090B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1070, N'Xavier', N'Massey', N'Dyer', N'Apartado núm.: 117, 9222 Justo. Av.', CAST(0xE9150B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1071, N'Octavius', N'Atkinson', N'Johnson', N'Apdo.:594-7432 Mi Av.', CAST(0xE81C0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1072, N'Martin', N'Shepard', N'Coffey', N'Apartado núm.: 906, 4403 Tincidunt Ctra.', CAST(0x4D0B0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1073, N'Willa', N'Savage', N'Sosa', N'Apdo.:288-489 Lacinia Calle', CAST(0xD30F0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1074, N'Laith', N'Richmond', N'Mccoy', N'Apartado núm.: 469, 6192 Fringilla Calle', CAST(0x42080B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1075, N'Cameron', N'Martin', N'Hobbs', N'Apartado núm.: 442, 3507 Dictum C.', CAST(0x09170B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1076, N'Darryl', N'Buckley', N'Russo', N'296-7205 Nec Avda.', CAST(0x42190B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1077, N'Cleo', N'Bird', N'Holland', N'4331 Leo. C/', CAST(0x7F1D0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1078, N'Quynn', N'Cardenas', N'Walsh', N'362-4779 Ornare Ctra.', CAST(0xCF110B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1079, N'Grant', N'Petersen', N'Bray', N'128-5790 Urna, C.', CAST(0xD7130B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1080, N'Elijah', N'Mcknight', N'James', N'Apartado núm.: 472, 4208 Odio, ', CAST(0xD60C0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1081, N'Lev', N'Conrad', N'Wilkins', N'9035 Est, Avda.', CAST(0x66190B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1082, N'Flavia', N'Hutchinson', N'Sparks', N'7179 Ullamcorper, ', CAST(0xD5130B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1083, N'Timothy', N'Gilbert', N'Savage', N'Apdo.:587-7769 Molestie Avenida', CAST(0x560B0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1084, N'Amethyst', N'Bean', N'Branch', N'981-9380 Orci. ', CAST(0x920D0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1085, N'Hamish', N'Vaughn', N'Benton', N'Apartado núm.: 674, 5996 Ac C/', CAST(0x8C180B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1086, N'Todd', N'Wynn', N'Davenport', N'Apartado núm.: 797, 855 Egestas C/', CAST(0x83170B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1087, N'Desirae', N'Cochran', N'Barton', N'Apdo.:632-2641 A Calle', CAST(0xBC0D0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1088, N'Callum', N'Lawson', N'Mclaughlin', N'135-3452 Consectetuer ', CAST(0xDA0A0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1089, N'Randall', N'Parsons', N'Sweeney', N'Apartado núm.: 686, 9948 Libero Calle', CAST(0xC9120B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1090, N'Aquila', N'Cline', N'Mann', N'3728 Orci. Calle', CAST(0xB7100B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1091, N'Eric', N'Bauer', N'Marquez', N'Apartado núm.: 229, 6906 Fusce Avenida', CAST(0xBF110B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1092, N'Zelda', N'Bates', N'Lott', N'6212 Arcu. Av.', CAST(0x7B110B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1093, N'Zena', N'Wallace', N'Snow', N'8019 Lectus. Ctra.', CAST(0xA8070B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1094, N'Nash', N'Fleming', N'Adams', N'6748 Egestas. Calle', CAST(0x9F1B0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1095, N'Sonia', N'Hines', N'Love', N'Apdo.:577-4632 Erat. C.', CAST(0x710A0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1096, N'Quinn', N'Sloan', N'Stevenson', N'Apartado núm.: 968, 2876 A, C.', CAST(0xBC1A0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1097, N'Carol', N'Gallagher', N'Blanchard', N'7205 Libero. Carretera', CAST(0x0A150B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1098, N'Jelani', N'Conrad', N'Golden', N'Apartado núm.: 769, 8181 Eu C.', CAST(0x52090B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1099, N'Basil', N'Benjamin', N'Dickerson', N'Apdo.:996-9990 Molestie Ctra.', CAST(0x25160B00 AS Date))
GO
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1100, N'Peter', N'Hines', N'Mathews', N'1438 Fermentum C/', CAST(0x800B0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1101, N'Ivan', N'Wise', N'Mercado', N'Apdo.:267-6299 Curae; C/', CAST(0x9C0F0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1102, N'Hedy', N'Alvarado', N'Swanson', N'5615 Morbi Carretera', CAST(0xDB160B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1103, N'Salvador', N'Pugh', N'Cleveland', N'3292 Pharetra, C.', CAST(0xA0190B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1104, N'Colton', N'Rowe', N'Olsen', N'1590 Aliquam C.', CAST(0x2A080B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1105, N'Yoshi', N'Christensen', N'Howe', N'835-2664 Nisi. C/', CAST(0x04160B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1106, N'Briar', N'Walter', N'Chapman', N'241-5510 Dictum Calle', CAST(0xB50D0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1107, N'Kelly', N'Bradley', N'Herring', N'568-5707 In Av.', CAST(0x2E0C0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1108, N'Jillian', N'Le', N'Hughes', N'827-157 Massa. Av.', CAST(0xBE120B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1109, N'Victor', N'Collins', N'Chaney', N'3025 Nec C/', CAST(0x070E0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1110, N'Linus', N'Aguilar', N'Sexton', N'Apdo.:475-9457 Proin Carretera', CAST(0xDA1A0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1111, N'Kessie', N'Hunt', N'Wall', N'Apdo.:518-3992 In C/', CAST(0x9F0C0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1112, N'Zeph', N'Ashley', N'Montoya', N'289-6640 Dictum Av.', CAST(0x700D0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1113, N'Cullen', N'Hunter', N'Winters', N'Apartado núm.: 994, 9869 Vivamus Avenida', CAST(0x9A0F0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1114, N'Connor', N'Mills', N'Tillman', N'Apdo.:918-1360 Consequat C.', CAST(0x5D1B0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1115, N'Beau', N'Sears', N'Vaughan', N'2028 Ac Avda.', CAST(0x9F170B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1116, N'Sonia', N'Booth', N'Yang', N'188-7723 Sit Av.', CAST(0x86180B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1117, N'Elmo', N'Ballard', N'Cabrera', N'8089 Lacus. Av.', CAST(0x270B0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1118, N'Trevor', N'Mcguire', N'Fischer', N'Apartado núm.: 561, 104 Ut Av.', CAST(0xF20A0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1119, N'Tiger', N'Kaufman', N'Tate', N'3339 Cursus Carretera', CAST(0x86130B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1120, N'Leandra', N'Massey', N'Curry', N'Apdo.:436-1192 Ac Av.', CAST(0xA41D0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1121, N'Richard', N'Conrad', N'Simmons', N'579-9251 Ridiculus C/', CAST(0xD41A0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1122, N'Mira', N'Dudley', N'Keller', N'Apartado núm.: 814, 7439 Nulla. C/', CAST(0xEB090B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1123, N'Remedios', N'Rowland', N'Jenkins', N'3946 Ante Carretera', CAST(0xE3190B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1124, N'Nevada', N'Sims', N'Mcbride', N'Apartado núm.: 209, 1514 Consequat C.', CAST(0xB60B0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1125, N'Sophia', N'Watts', N'Clay', N'Apartado núm.: 735, 9401 Erat Av.', CAST(0x53080B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1126, N'Mira', N'Smith', N'Blevins', N'Apdo.:656-8276 Integer Av.', CAST(0x990E0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1127, N'August', N'Nicholson', N'Zimmerman', N'713-409 Ligula. C/', CAST(0x4A1A0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1128, N'Acton', N'Rosario', N'Farmer', N'9965 Dui Calle', CAST(0xA1110B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1129, N'Shelley', N'Holden', N'Golden', N'Apartado núm.: 394, 1548 Est Avda.', CAST(0x93180B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1130, N'Kim', N'Durham', N'Villarreal', N'Apartado núm.: 309, 4163 Dolor. Ctra.', CAST(0x3B0D0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1131, N'Mira', N'Baldwin', N'Mejia', N'9454 Morbi Calle', CAST(0xEA150B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1132, N'Molly', N'Cochran', N'Wise', N'Apartado núm.: 721, 4224 Nulla Avenida', CAST(0x0A0F0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1133, N'Miranda', N'Fletcher', N'Hartman', N'Apdo.:199-2538 Egestas. Avenida', CAST(0x07170B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1134, N'Helen', N'Gillespie', N'Hampton', N'235-1308 Duis Carretera', CAST(0xA1110B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1135, N'Kerry', N'Marsh', N'Mendez', N'Apdo.:292-4977 Mauris C/', CAST(0x1D0C0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1136, N'Timothy', N'Wilkinson', N'Hull', N'3313 Dui C/', CAST(0x9D180B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1137, N'Cole', N'Mack', N'Frank', N'Apdo.:777-7651 Nascetur C.', CAST(0x69190B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1138, N'Tallulah', N'Jefferson', N'Hurley', N'Apartado núm.: 117, 4792 Libero ', CAST(0x7D180B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1139, N'Hammett', N'Christensen', N'Stewart', N'Apdo.:874-1162 Magna. Avda.', CAST(0x3A090B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1140, N'Iona', N'Shaffer', N'Walker', N'Apdo.:633-6155 Maecenas Ctra.', CAST(0xFA180B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1141, N'Meghan', N'Mejia', N'Yates', N'Apartado núm.: 265, 3347 Et C/', CAST(0x541D0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1142, N'Justine', N'Mercer', N'Cline', N'Apartado núm.: 133, 7690 Dolor Ctra.', CAST(0xDB0A0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1143, N'Len', N'Bentley', N'Strickland', N'377-3197 Arcu Ctra.', CAST(0x8A160B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1144, N'Yuli', N'Gonzalez', N'Mooney', N'Apdo.:823-1346 Proin C/', CAST(0x19110B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1145, N'Stella', N'Dennis', N'Myers', N'805-8946 Fermentum Carretera', CAST(0xEF170B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1146, N'Prescott', N'Dillon', N'Combs', N'Apartado núm.: 430, 8316 Non C/', CAST(0x9B0F0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1147, N'Odette', N'Crawford', N'Duffy', N'Apdo.:346-9486 Dignissim Carretera', CAST(0x9B0A0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1148, N'Carolyn', N'Yang', N'Mayer', N'Apdo.:345-2593 Leo. Av.', CAST(0x73190B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1149, N'Ahmed', N'Wiley', N'Barton', N'9917 Libero. Calle', CAST(0x66160B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1150, N'Maggie', N'Caldwell', N'Anthony', N'956 A, Ctra.', CAST(0xCD140B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1151, N'Leah', N'Larson', N'Benjamin', N'Apdo.:157-5741 Porttitor ', CAST(0x7C110B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1152, N'Keiko', N'Ryan', N'Jensen', N'5008 Hendrerit ', CAST(0xD4110B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1153, N'Glenna', N'Ryan', N'Mathews', N'624-6990 Eu, Avda.', CAST(0xD5160B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1154, N'Lucas', N'Lambert', N'Carver', N'Apdo.:169-7020 Vel Carretera', CAST(0x950D0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1155, N'Donna', N'Matthews', N'Benjamin', N'Apdo.:825-2741 Lobortis Av.', CAST(0xFA180B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1156, N'Leila', N'Moreno', N'Caldwell', N'291-2028 Iaculis Avda.', CAST(0x88100B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1157, N'Ramona', N'Petty', N'Kerr', N'Apartado núm.: 596, 883 Fermentum Carretera', CAST(0xAE0C0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1158, N'Reuben', N'White', N'Patel', N'253-6347 Eu, C/', CAST(0xA9160B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1159, N'Leigh', N'Roberts', N'Pope', N'Apdo.:673-1460 Pede, C.', CAST(0x240C0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1160, N'Sydney', N'Conner', N'Lopez', N'Apartado núm.: 653, 8715 Vel, Carretera', CAST(0x560D0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1161, N'Audrey', N'England', N'Dominguez', N'260-1966 Gravida. ', CAST(0x90100B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1162, N'Caesar', N'Kinney', N'Solomon', N'Apartado núm.: 638, 4362 Nunc ', CAST(0x480C0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1163, N'Janna', N'Wood', N'Bender', N'Apdo.:820-1982 Lorem Avda.', CAST(0x6F120B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1164, N'Juliet', N'Koch', N'Ingram', N'572-3162 Cursus C/', CAST(0x070C0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1165, N'Chanda', N'Mercer', N'Briggs', N'Apartado núm.: 692, 7558 Arcu. Ctra.', CAST(0x9E170B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1166, N'Maxwell', N'Fisher', N'Davis', N'774 Volutpat C/', CAST(0x741C0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1167, N'Carissa', N'Chang', N'Peters', N'Apartado núm.: 166, 1960 Et Carretera', CAST(0x99160B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1168, N'Alden', N'Moon', N'Barrett', N'Apdo.:681-733 Facilisis Avda.', CAST(0x2B1A0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1169, N'Xandra', N'Mclaughlin', N'Berry', N'Apartado núm.: 932, 7031 Tincidunt Carretera', CAST(0x420B0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1170, N'Avye', N'Carrillo', N'Goodwin', N'Apartado núm.: 849, 2811 Mauris Carretera', CAST(0x390D0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1171, N'Charde', N'Curry', N'Graham', N'Apdo.:388-2226 Integer Avda.', CAST(0x34140B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1172, N'Clio', N'Larson', N'Herrera', N'224-1777 Congue Av.', CAST(0x2C100B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1173, N'Richard', N'Hubbard', N'Sutton', N'Apdo.:502-6693 Dictum ', CAST(0x0C160B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1174, N'Hilda', N'Medina', N'Pate', N'5207 Tempus, Calle', CAST(0xA11A0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1175, N'Leo', N'Kaufman', N'Richard', N'Apartado núm.: 614, 1210 Molestie C.', CAST(0xA30C0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1176, N'Nissim', N'Pate', N'Olsen', N'Apdo.:737-946 Pellentesque Avda.', CAST(0x291E0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1177, N'Larissa', N'Cohen', N'Roman', N'723-3240 Tellus Avda.', CAST(0xFB090B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1178, N'Ifeoma', N'Miranda', N'Cabrera', N'Apartado núm.: 682, 5701 Vitae ', CAST(0x92170B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1179, N'Tanek', N'Glass', N'Golden', N'Apdo.:471-7890 Congue. Avenida', CAST(0xCB120B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1180, N'Amelia', N'Reilly', N'Nixon', N'8317 Quis Calle', CAST(0xD7180B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1181, N'Rhona', N'Dickerson', N'Byrd', N'Apartado núm.: 939, 2282 Pede Ctra.', CAST(0xFB0A0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1182, N'Dominic', N'Conley', N'Davidson', N'Apdo.:949-2185 Nam C.', CAST(0xB0180B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1183, N'Rafael', N'Barnes', N'Blair', N'Apartado núm.: 972, 2028 Taciti C.', CAST(0x601C0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1184, N'Isabella', N'Curry', N'Bradford', N'7676 Aliquam ', CAST(0xF7090B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1185, N'Renee', N'Stephens', N'Lindsey', N'Apartado núm.: 211, 8002 In C/', CAST(0xB60D0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1186, N'Mark', N'Bass', N'Crane', N'958-6342 Nunc, C/', CAST(0x2B110B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1187, N'Brynne', N'Glover', N'Kim', N'987-827 Lacinia. C/', CAST(0xA3110B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1188, N'Brielle', N'Weber', N'Levine', N'731-4039 Sed Avda.', CAST(0xA9140B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1189, N'Kieran', N'Mcleod', N'Wagner', N'Apdo.:890-9136 Cursus Av.', CAST(0x3D190B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1190, N'Dana', N'Murray', N'Cochran', N'9236 Aliquet Ctra.', CAST(0x630C0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1191, N'Lee', N'Stevenson', N'Colon', N'Apdo.:339-9792 Dignissim C.', CAST(0x351E0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1192, N'Pascale', N'Stevens', N'Webster', N'Apartado núm.: 733, 2721 Fringilla Calle', CAST(0xA01D0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1193, N'Finn', N'Bennett', N'Fischer', N'Apdo.:770-1136 Blandit Av.', CAST(0xB41D0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1194, N'Jacqueline', N'Lucas', N'Shepherd', N'845-5904 Lorem, C.', CAST(0xC9120B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1195, N'Denise', N'Gray', N'Hahn', N'Apartado núm.: 961, 2878 Mus. Carretera', CAST(0x3F1B0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1196, N'Chaney', N'Strong', N'Carrillo', N'6088 Suspendisse Av.', CAST(0x3C080B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1197, N'Sonia', N'Monroe', N'Bell', N'Apdo.:528-5355 Lorem, Carretera', CAST(0x50160B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1198, N'Gannon', N'Jenkins', N'Gross', N'Apdo.:766-8564 Ante, Av.', CAST(0xD50D0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1199, N'Lev', N'Schultz', N'Haynes', N'114-2376 Convallis Av.', CAST(0xC9130B00 AS Date))
GO
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1200, N'Byron', N'Cardenas', N'Young', N'Apartado núm.: 551, 1947 Scelerisque ', CAST(0x510F0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1201, N'Claire', N'Gray', N'Fischer', N'9983 Id Avenida', CAST(0x211D0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1202, N'Howard', N'Bass', N'Joseph', N'Apartado núm.: 253, 4578 Pellentesque Ctra.', CAST(0xCB150B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1203, N'Oren', N'Foreman', N'Kirkland', N'5540 Suspendisse C/', CAST(0x15090B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1204, N'Susan', N'Cummings', N'Taylor', N'Apdo.:756-9845 Velit. Avenida', CAST(0xFC140B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1205, N'Dustin', N'Dale', N'Kemp', N'169-3687 Magna C/', CAST(0xD0190B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1206, N'Keith', N'Miles', N'Gutierrez', N'7109 Vulputate, Av.', CAST(0xF2080B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1207, N'Asher', N'Cannon', N'Finley', N'Apdo.:165-2686 Ac Carretera', CAST(0x7D1C0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1208, N'Rebekah', N'Buchanan', N'Ortiz', N'Apdo.:119-6168 Ligula Ctra.', CAST(0x280D0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1209, N'Curran', N'Hampton', N'Poole', N'Apartado núm.: 214, 5869 Pede. Avda.', CAST(0xFD130B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1210, N'Belle', N'Eaton', N'Munoz', N'Apdo.:682-6753 Massa. Ctra.', CAST(0x580F0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1211, N'Stewart', N'Reed', N'Park', N'166-1072 Elit Carretera', CAST(0xBE1C0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1212, N'Brody', N'Garner', N'Baldwin', N'Apdo.:876-5383 Nisl C.', CAST(0xF7080B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1213, N'Julie', N'Velasquez', N'Pitts', N'Apdo.:469-9285 Amet, C.', CAST(0x53150B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1214, N'Dahlia', N'Snider', N'Ellis', N'Apartado núm.: 727, 4367 Mus. Carretera', CAST(0x700E0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1215, N'Cade', N'Baldwin', N'Reese', N'379-8099 Quis Calle', CAST(0xC4110B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1216, N'Paloma', N'Duffy', N'Patrick', N'608-3450 Ac, ', CAST(0x231A0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1217, N'Serina', N'Horn', N'Kirkland', N'Apartado núm.: 106, 3268 Faucibus C.', CAST(0xEA0C0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1218, N'Kylynn', N'Munoz', N'Robbins', N'Apartado núm.: 120, 2358 Erat Calle', CAST(0x461B0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1219, N'Tanek', N'Sheppard', N'Davis', N'275-5939 Elit ', CAST(0x40180B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1220, N'Otto', N'Jacobson', N'Hebert', N'Apdo.:406-7794 Sed Avenida', CAST(0x67140B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1221, N'Fay', N'Nieves', N'Barton', N'469-213 Amet ', CAST(0xFF190B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1222, N'Jeremy', N'Hickman', N'Wilkerson', N'9390 Congue Ctra.', CAST(0x88080B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1223, N'Amber', N'Ball', N'Goff', N'Apdo.:594-5770 Lectus C.', CAST(0x9F190B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1224, N'Hall', N'Sloan', N'Glass', N'476-8282 Dui. Av.', CAST(0xA70F0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1225, N'Phillip', N'Gross', N'Juarez', N'399-5593 Consectetuer C/', CAST(0xAB120B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1226, N'Owen', N'Fry', N'Welch', N'129-1370 Suspendisse Carretera', CAST(0x6F130B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1227, N'Lawrence', N'Short', N'Parker', N'Apartado núm.: 147, 431 Nibh. C/', CAST(0xBF080B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1228, N'Asher', N'Galloway', N'Spears', N'Apartado núm.: 533, 4535 Egestas. ', CAST(0x850A0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1229, N'Wade', N'Parks', N'Colon', N'Apartado núm.: 119, 4307 Augue ', CAST(0xC1070B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1230, N'Skyler', N'Woods', N'Avery', N'3806 Donec Av.', CAST(0x7B180B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1231, N'Dominic', N'Delacruz', N'Doyle', N'Apartado núm.: 975, 5722 Dictum ', CAST(0xAD0F0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1232, N'Rebecca', N'Fernandez', N'Whitfield', N'Apartado núm.: 863, 616 Dolor, Avenida', CAST(0x83080B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1233, N'Justine', N'Curry', N'Pate', N'Apdo.:998-5621 Nunc Calle', CAST(0x2A140B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1234, N'Eagan', N'Duran', N'Mcneil', N'866-5756 Volutpat Calle', CAST(0x93100B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1235, N'Cyrus', N'Cameron', N'Barlow', N'Apdo.:536-9522 Ac, Calle', CAST(0x6E120B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1236, N'Conan', N'Abbott', N'Herrera', N'8076 Euismod ', CAST(0x24120B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1237, N'Aline', N'Gilmore', N'Santos', N'Apartado núm.: 360, 4791 Ultrices. ', CAST(0xBA0B0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1238, N'Jacob', N'Cobb', N'Skinner', N'Apdo.:955-2438 Et Avenida', CAST(0x0B0B0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1239, N'Lila', N'Hayes', N'Golden', N'424-1584 Faucibus. C/', CAST(0xA30C0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1240, N'Orla', N'Alvarado', N'Smith', N'Apartado núm.: 478, 6519 Sagittis Avenida', CAST(0xB2070B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1241, N'Alexander', N'Mack', N'Gregory', N'Apartado núm.: 295, 7763 Aliquet. Ctra.', CAST(0xB60C0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1242, N'Lamar', N'Bates', N'Colon', N'9190 Lobortis Carretera', CAST(0x78100B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1243, N'Adena', N'Rowland', N'Castro', N'Apartado núm.: 402, 777 Fusce Calle', CAST(0xC8140B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1244, N'Sade', N'Pate', N'Underwood', N'765-7833 Mauris C.', CAST(0x51110B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1245, N'Zorita', N'Hewitt', N'Casey', N'498-6079 Aliquet Carretera', CAST(0x05150B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1246, N'Hayley', N'Acosta', N'Michael', N'7955 Mauris Avda.', CAST(0xA00C0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1247, N'Leilani', N'Aguirre', N'Stewart', N'823-6504 Vitae, Avenida', CAST(0xC21A0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1248, N'Amethyst', N'Joyner', N'Osborne', N'681-3722 Eros Av.', CAST(0x2D120B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1249, N'Kai', N'Moreno', N'Pittman', N'765-5700 Ac Ctra.', CAST(0x051B0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1250, N'Zachary', N'Woods', N'Little', N'Apartado núm.: 591, 9018 Mollis. Carretera', CAST(0xFC130B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1251, N'Iola', N'Flynn', N'Berry', N'9705 Mauris. C/', CAST(0x590B0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1252, N'Brianna', N'Davidson', N'Roy', N'Apartado núm.: 532, 390 Mattis C/', CAST(0x990C0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1253, N'Keith', N'Boone', N'Sherman', N'Apartado núm.: 661, 5818 Mollis. C/', CAST(0xC3120B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1254, N'Laith', N'Sampson', N'Chavez', N'Apdo.:220-1664 Lectus Calle', CAST(0x6C120B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1255, N'Zephania', N'Pennington', N'Conley', N'Apdo.:289-5041 Tristique Ctra.', CAST(0x241B0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1256, N'Hamish', N'Nixon', N'Gray', N'7672 Dignissim Carretera', CAST(0x8A0B0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1257, N'Gil', N'Castillo', N'Dorsey', N'Apdo.:372-3928 Ornare Calle', CAST(0x570D0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1258, N'Aaron', N'Snider', N'Hess', N'400-5824 Aliquam Calle', CAST(0xDC0A0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1259, N'Wing', N'Turner', N'Cooley', N'Apartado núm.: 384, 9080 In ', CAST(0x42160B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1260, N'Ishmael', N'Hays', N'Beach', N'6408 Auctor C.', CAST(0x5C130B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1261, N'Salvador', N'Cantu', N'Hansen', N'Apartado núm.: 319, 6846 Nullam Avenida', CAST(0x04100B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1262, N'Barrett', N'Cortez', N'Sandoval', N'Apartado núm.: 290, 9314 Enim, Avda.', CAST(0x421A0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1263, N'Tyler', N'Hunt', N'Whitfield', N'Apdo.:824-9443 Lacus. C/', CAST(0x3F1C0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1264, N'Kyle', N'Moon', N'William', N'183-891 Phasellus C/', CAST(0x851A0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1265, N'Talon', N'Beach', N'Stokes', N'Apdo.:629-8194 A Ctra.', CAST(0x920E0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1266, N'Nicholas', N'Hubbard', N'Dominguez', N'Apdo.:652-8057 Lacus. Ctra.', CAST(0x73180B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1267, N'Galena', N'Colon', N'Hurley', N'Apartado núm.: 609, 4927 Dui. Ctra.', CAST(0x7F170B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1268, N'Randall', N'Maldonado', N'Baldwin', N'544-2967 Nulla Av.', CAST(0x19170B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1269, N'Hilda', N'Kline', N'Beasley', N'Apdo.:650-2999 Sed C/', CAST(0xAE1C0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1270, N'Oliver', N'Montoya', N'Knapp', N'7776 Metus. Carretera', CAST(0xE8170B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1271, N'Kareem', N'Campos', N'Maldonado', N'3988 Purus, ', CAST(0x100D0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1272, N'Destiny', N'Benson', N'Holman', N'311-4963 Mauris Avenida', CAST(0x49170B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1273, N'Natalie', N'Carlson', N'Obrien', N'Apartado núm.: 850, 584 Dolor Av.', CAST(0x9B170B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1274, N'Mariam', N'Marks', N'Vance', N'882-2398 Eros Avenida', CAST(0xEE080B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1275, N'Karyn', N'Whitley', N'Mcclure', N'Apartado núm.: 371, 8343 Egestas. C.', CAST(0x910A0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1276, N'Daniel', N'Walsh', N'Allison', N'824 Non C.', CAST(0xF6190B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1277, N'Xaviera', N'Rose', N'Kramer', N'Apdo.:703-6826 Et, C/', CAST(0xD8100B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1278, N'Yolanda', N'Romero', N'Tate', N'654-2002 Sit Av.', CAST(0xA7160B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1279, N'Steven', N'Carroll', N'Gaines', N'Apdo.:801-667 Aliquam C.', CAST(0x480A0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1280, N'Abraham', N'Battle', N'Hubbard', N'471-5704 Nunc Av.', CAST(0x98140B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1281, N'Gareth', N'Wynn', N'Jordan', N'4721 Nulla C/', CAST(0x9B150B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1282, N'Imani', N'Murphy', N'Mccoy', N'Apartado núm.: 241, 227 Auctor, Av.', CAST(0xAB080B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1283, N'Rhona', N'Herrera', N'Howard', N'1464 Quis ', CAST(0xB6150B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1284, N'Beverly', N'Woodward', N'Riddle', N'Apartado núm.: 297, 5199 Quis C/', CAST(0x99100B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1285, N'Scarlett', N'Reed', N'Burt', N'799-3650 Varius. Avda.', CAST(0xD30A0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1286, N'Kuame', N'Morrison', N'Cross', N'6110 Malesuada C.', CAST(0x261E0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1287, N'Chaim', N'Cannon', N'Booth', N'Apdo.:881-8414 Amet Av.', CAST(0x111C0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1288, N'Emery', N'Conway', N'Jimenez', N'261-9411 Mi. ', CAST(0x21130B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1289, N'Tatum', N'Wilkins', N'Young', N'4952 Faucibus Avenida', CAST(0x0E120B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1290, N'Nash', N'Macias', N'Hansen', N'4450 Ultricies C.', CAST(0x3D0D0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1291, N'Channing', N'Mendez', N'Puckett', N'Apartado núm.: 942, 1426 Vestibulum ', CAST(0x6C1D0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1292, N'Conan', N'Hart', N'Oliver', N'Apartado núm.: 242, 1179 Interdum Avda.', CAST(0x11180B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1293, N'Elizabeth', N'Larson', N'Douglas', N'6920 Lorem, ', CAST(0x4B1D0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1294, N'Rina', N'Miles', N'Bradley', N'617-1415 At Carretera', CAST(0x0D0E0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1295, N'Guinevere', N'Schultz', N'Roberson', N'4327 Nunc Av.', CAST(0x9C1A0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1296, N'Charlotte', N'Ramsey', N'Olsen', N'Apartado núm.: 852, 1159 A Av.', CAST(0x92190B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1297, N'Shelby', N'Thompson', N'Lyons', N'Apdo.:713-5665 Laoreet C.', CAST(0xD60D0B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1298, N'Davis', N'Davenport', N'Grimes', N'300-9610 Elit Carretera', CAST(0x0A120B00 AS Date))
INSERT [dbo].[Empleado] ([No_empleado], [Nombre], [Apellido_Paterno], [Apellido_Materno], [Direccion], [Fecha_nacimiento]) VALUES (1299, N'Timon', N'Tyson', N'Chavez', N'Apdo.:807-1354 Lectus Avda.', CAST(0x3C170B00 AS Date))
GO
INSERT [dbo].[Estatus] ([ID], [Nombre], [Descripcion]) VALUES (1, N'baja', N'profesor,alumno')
INSERT [dbo].[Estatus] ([ID], [Nombre], [Descripcion]) VALUES (2, N'jubilado', N'profesor')
INSERT [dbo].[Estatus] ([ID], [Nombre], [Descripcion]) VALUES (3, N'activo', N'profesor')
INSERT [dbo].[Estatus] ([ID], [Nombre], [Descripcion]) VALUES (4, N'inscrito', N'alumno')
INSERT [dbo].[Estatus] ([ID], [Nombre], [Descripcion]) VALUES (5, N'suspendido', N'alumno')
INSERT [dbo].[Estatus] ([ID], [Nombre], [Descripcion]) VALUES (6, N'revalidante', N'alumno: es alumno, pero reprobo todos sus cursos')
INSERT [dbo].[Estatus] ([ID], [Nombre], [Descripcion]) VALUES (7, N'solicitante', N'cliente : Al momento de ingresar sus datos')
INSERT [dbo].[Estatus] ([ID], [Nombre], [Descripcion]) VALUES (8, N'en proceso', N'cliente: Cuando aun no ha pagado.')
INSERT [dbo].[Estatus] ([ID], [Nombre], [Descripcion]) VALUES (9, N'aceptado', N'cliente: Despues de haber pagado. Un dia despues se vuelve inscrito')
INSERT [dbo].[Grupo] ([ID], [Curso_Clave], [Calificacion], [Cliente_ID]) VALUES (1, 40, NULL, 400)
INSERT [dbo].[Grupo] ([ID], [Curso_Clave], [Calificacion], [Cliente_ID]) VALUES (2, 37, NULL, 350)
INSERT [dbo].[Grupo] ([ID], [Curso_Clave], [Calificacion], [Cliente_ID]) VALUES (3, 33, NULL, 300)
INSERT [dbo].[Grupo] ([ID], [Curso_Clave], [Calificacion], [Cliente_ID]) VALUES (4, 29, NULL, 250)
INSERT [dbo].[Grupo] ([ID], [Curso_Clave], [Calificacion], [Cliente_ID]) VALUES (5, 26, NULL, 200)
INSERT [dbo].[Grupo] ([ID], [Curso_Clave], [Calificacion], [Cliente_ID]) VALUES (6, 23, NULL, 150)
INSERT [dbo].[Grupo] ([ID], [Curso_Clave], [Calificacion], [Cliente_ID]) VALUES (7, 20, NULL, 100)
INSERT [dbo].[Grupo] ([ID], [Curso_Clave], [Calificacion], [Cliente_ID]) VALUES (8, 17, NULL, 50)
INSERT [dbo].[Grupo] ([ID], [Curso_Clave], [Calificacion], [Cliente_ID]) VALUES (9, 14, NULL, 10)
INSERT [dbo].[Grupo] ([ID], [Curso_Clave], [Calificacion], [Cliente_ID]) VALUES (10, 11, NULL, 100)
INSERT [dbo].[Grupo] ([ID], [Curso_Clave], [Calificacion], [Cliente_ID]) VALUES (11, 9, NULL, 20)
INSERT [dbo].[Grupo] ([ID], [Curso_Clave], [Calificacion], [Cliente_ID]) VALUES (12, 6, NULL, 300)
INSERT [dbo].[Grupo] ([ID], [Curso_Clave], [Calificacion], [Cliente_ID]) VALUES (13, 3, NULL, 400)
INSERT [dbo].[Grupo] ([ID], [Curso_Clave], [Calificacion], [Cliente_ID]) VALUES (14, 1, NULL, 319)
INSERT [dbo].[Grupo] ([ID], [Curso_Clave], [Calificacion], [Cliente_ID]) VALUES (15, 40, NULL, 219)
INSERT [dbo].[Grupo] ([ID], [Curso_Clave], [Calificacion], [Cliente_ID]) VALUES (16, 18, NULL, 119)
INSERT [dbo].[Grupo] ([ID], [Curso_Clave], [Calificacion], [Cliente_ID]) VALUES (17, 16, NULL, 19)
INSERT [dbo].[Grupo] ([ID], [Curso_Clave], [Calificacion], [Cliente_ID]) VALUES (18, 8, NULL, 133)
INSERT [dbo].[Grupo] ([ID], [Curso_Clave], [Calificacion], [Cliente_ID]) VALUES (19, 4, NULL, 233)
INSERT [dbo].[Grupo] ([ID], [Curso_Clave], [Calificacion], [Cliente_ID]) VALUES (20, 2, NULL, 333)
INSERT [dbo].[Grupo] ([ID], [Curso_Clave], [Calificacion], [Cliente_ID]) VALUES (21, 1, NULL, 399)
INSERT [dbo].[Grupo] ([ID], [Curso_Clave], [Calificacion], [Cliente_ID]) VALUES (80, 40, NULL, 400)
SET IDENTITY_INSERT [dbo].[Horario] ON 

INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (1, CAST(0x0700D85EAC3A0000 AS Time), CAST(0x070040230E430000 AS Time), N'Lunes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (2, CAST(0x070040230E430000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), N'Lunes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (3, CAST(0x0700A8E76F4B0000 AS Time), CAST(0x070010ACD1530000 AS Time), N'Lunes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (4, CAST(0x070010ACD1530000 AS Time), CAST(0x07007870335C0000 AS Time), N'Lunes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (5, CAST(0x07007870335C0000 AS Time), CAST(0x0700E03495640000 AS Time), N'Lunes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (6, CAST(0x0700E03495640000 AS Time), CAST(0x070048F9F66C0000 AS Time), N'Lunes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (7, CAST(0x070048F9F66C0000 AS Time), CAST(0x0700B0BD58750000 AS Time), N'Lunes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (8, CAST(0x0700B0BD58750000 AS Time), CAST(0x07001882BA7D0000 AS Time), N'Lunes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (9, CAST(0x07001882BA7D0000 AS Time), CAST(0x070080461C860000 AS Time), N'Lunes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (10, CAST(0x070080461C860000 AS Time), CAST(0x0700E80A7E8E0000 AS Time), N'Lunes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (11, CAST(0x0700E80A7E8E0000 AS Time), CAST(0x070050CFDF960000 AS Time), N'Lunes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (12, CAST(0x070050CFDF960000 AS Time), CAST(0x0700B893419F0000 AS Time), N'Lunes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (13, CAST(0x0700D85EAC3A0000 AS Time), CAST(0x070040230E430000 AS Time), N'Martes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (14, CAST(0x070040230E430000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), N'Martes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (15, CAST(0x0700A8E76F4B0000 AS Time), CAST(0x070010ACD1530000 AS Time), N'Martes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (16, CAST(0x070010ACD1530000 AS Time), CAST(0x07007870335C0000 AS Time), N'Martes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (17, CAST(0x07007870335C0000 AS Time), CAST(0x0700E03495640000 AS Time), N'Martes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (18, CAST(0x0700E03495640000 AS Time), CAST(0x070048F9F66C0000 AS Time), N'Martes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (19, CAST(0x070048F9F66C0000 AS Time), CAST(0x0700B0BD58750000 AS Time), N'Martes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (20, CAST(0x0700B0BD58750000 AS Time), CAST(0x07001882BA7D0000 AS Time), N'Martes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (21, CAST(0x07001882BA7D0000 AS Time), CAST(0x070080461C860000 AS Time), N'Martes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (22, CAST(0x070080461C860000 AS Time), CAST(0x0700E80A7E8E0000 AS Time), N'Martes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (23, CAST(0x0700E80A7E8E0000 AS Time), CAST(0x070050CFDF960000 AS Time), N'Martes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (24, CAST(0x070050CFDF960000 AS Time), CAST(0x0700B893419F0000 AS Time), N'Martes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (25, CAST(0x0700D85EAC3A0000 AS Time), CAST(0x070040230E430000 AS Time), N'Miercoles')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (26, CAST(0x070040230E430000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), N'Miercoles')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (27, CAST(0x0700A8E76F4B0000 AS Time), CAST(0x070010ACD1530000 AS Time), N'Miercoles')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (28, CAST(0x070010ACD1530000 AS Time), CAST(0x07007870335C0000 AS Time), N'Miercoles')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (29, CAST(0x07007870335C0000 AS Time), CAST(0x0700E03495640000 AS Time), N'Miercoles')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (30, CAST(0x0700E03495640000 AS Time), CAST(0x070048F9F66C0000 AS Time), N'Miercoles')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (31, CAST(0x070048F9F66C0000 AS Time), CAST(0x0700B0BD58750000 AS Time), N'Miercoles')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (32, CAST(0x0700B0BD58750000 AS Time), CAST(0x07001882BA7D0000 AS Time), N'Miercoles')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (33, CAST(0x07001882BA7D0000 AS Time), CAST(0x070080461C860000 AS Time), N'Miercoles')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (34, CAST(0x070080461C860000 AS Time), CAST(0x0700E80A7E8E0000 AS Time), N'Miercoles')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (35, CAST(0x0700E80A7E8E0000 AS Time), CAST(0x070050CFDF960000 AS Time), N'Miercoles')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (36, CAST(0x070050CFDF960000 AS Time), CAST(0x0700B893419F0000 AS Time), N'Miercoles')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (37, CAST(0x0700D85EAC3A0000 AS Time), CAST(0x070040230E430000 AS Time), N'Jueves')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (38, CAST(0x070040230E430000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), N'Jueves')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (39, CAST(0x0700A8E76F4B0000 AS Time), CAST(0x070010ACD1530000 AS Time), N'Jueves')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (40, CAST(0x070010ACD1530000 AS Time), CAST(0x07007870335C0000 AS Time), N'Jueves')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (41, CAST(0x07007870335C0000 AS Time), CAST(0x0700E03495640000 AS Time), N'Jueves')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (42, CAST(0x0700E03495640000 AS Time), CAST(0x070048F9F66C0000 AS Time), N'Jueves')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (43, CAST(0x070048F9F66C0000 AS Time), CAST(0x0700B0BD58750000 AS Time), N'Jueves')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (44, CAST(0x0700B0BD58750000 AS Time), CAST(0x07001882BA7D0000 AS Time), N'Jueves')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (45, CAST(0x07001882BA7D0000 AS Time), CAST(0x070080461C860000 AS Time), N'Jueves')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (46, CAST(0x070080461C860000 AS Time), CAST(0x0700E80A7E8E0000 AS Time), N'Jueves')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (47, CAST(0x0700E80A7E8E0000 AS Time), CAST(0x070050CFDF960000 AS Time), N'Jueves')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (48, CAST(0x070050CFDF960000 AS Time), CAST(0x0700B893419F0000 AS Time), N'Jueves')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (49, CAST(0x0700D85EAC3A0000 AS Time), CAST(0x070040230E430000 AS Time), N'Viernes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (50, CAST(0x070040230E430000 AS Time), CAST(0x0700A8E76F4B0000 AS Time), N'Viernes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (51, CAST(0x0700A8E76F4B0000 AS Time), CAST(0x070010ACD1530000 AS Time), N'Viernes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (52, CAST(0x070010ACD1530000 AS Time), CAST(0x07007870335C0000 AS Time), N'Viernes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (53, CAST(0x07007870335C0000 AS Time), CAST(0x0700E03495640000 AS Time), N'Viernes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (54, CAST(0x0700E03495640000 AS Time), CAST(0x070048F9F66C0000 AS Time), N'Viernes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (55, CAST(0x070048F9F66C0000 AS Time), CAST(0x0700B0BD58750000 AS Time), N'Viernes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (56, CAST(0x0700B0BD58750000 AS Time), CAST(0x07001882BA7D0000 AS Time), N'Viernes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (57, CAST(0x07001882BA7D0000 AS Time), CAST(0x070080461C860000 AS Time), N'Viernes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (58, CAST(0x070080461C860000 AS Time), CAST(0x0700E80A7E8E0000 AS Time), N'Viernes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (59, CAST(0x0700E80A7E8E0000 AS Time), CAST(0x070050CFDF960000 AS Time), N'Viernes')
INSERT [dbo].[Horario] ([Clave], [Hora_inicio], [Hora_fin], [Dia]) VALUES (60, CAST(0x070050CFDF960000 AS Time), CAST(0x0700B893419F0000 AS Time), N'Viernes')
SET IDENTITY_INSERT [dbo].[Horario] OFF
INSERT [dbo].[Materia] ([Clave], [Nombre], [Hora_semanal], [Grado], [Area_ID]) VALUES (1, N'Español I', 4, 1, 2)
INSERT [dbo].[Materia] ([Clave], [Nombre], [Hora_semanal], [Grado], [Area_ID]) VALUES (2, N'Español II', 4, 2, 2)
INSERT [dbo].[Materia] ([Clave], [Nombre], [Hora_semanal], [Grado], [Area_ID]) VALUES (3, N'Español III', 4, 3, 2)
INSERT [dbo].[Materia] ([Clave], [Nombre], [Hora_semanal], [Grado], [Area_ID]) VALUES (4, N'Biologia', 3, 1, 3)
INSERT [dbo].[Materia] ([Clave], [Nombre], [Hora_semanal], [Grado], [Area_ID]) VALUES (5, N'Fisica', 3, 2, 3)
INSERT [dbo].[Materia] ([Clave], [Nombre], [Hora_semanal], [Grado], [Area_ID]) VALUES (6, N'Quimica', 3, 3, 3)
INSERT [dbo].[Materia] ([Clave], [Nombre], [Hora_semanal], [Grado], [Area_ID]) VALUES (7, N'Matematicas I', 5, 1, 1)
INSERT [dbo].[Materia] ([Clave], [Nombre], [Hora_semanal], [Grado], [Area_ID]) VALUES (8, N'Matematicas II', 5, 2, 1)
INSERT [dbo].[Materia] ([Clave], [Nombre], [Hora_semanal], [Grado], [Area_ID]) VALUES (9, N'Matematicas III', 5, 3, 1)
INSERT [dbo].[Materia] ([Clave], [Nombre], [Hora_semanal], [Grado], [Area_ID]) VALUES (10, N'Cultura Física y Salud I', 2, 1, 5)
INSERT [dbo].[Materia] ([Clave], [Nombre], [Hora_semanal], [Grado], [Area_ID]) VALUES (11, N'Cultura Física y Salud II', 2, 2, 5)
INSERT [dbo].[Materia] ([Clave], [Nombre], [Hora_semanal], [Grado], [Area_ID]) VALUES (12, N'Cultura Física y Salud III', 2, 3, 5)
INSERT [dbo].[Materia] ([Clave], [Nombre], [Hora_semanal], [Grado], [Area_ID]) VALUES (13, N'Historia del mundo', 4, 2, 4)
INSERT [dbo].[Materia] ([Clave], [Nombre], [Hora_semanal], [Grado], [Area_ID]) VALUES (14, N'Historia de mexico', 4, 3, 4)
INSERT [dbo].[Materia] ([Clave], [Nombre], [Hora_semanal], [Grado], [Area_ID]) VALUES (15, N'Musica', 1, 3, 6)
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1000, 9, 3, 5, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1001, 10, 3, 2, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1002, 11, 3, 3, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1003, 12, 3, 6, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1004, 13, 3, 2, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1005, 14, 3, 2, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1006, 15, 3, 1, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1007, 16, 3, 5, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1008, 17, 3, 1, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1009, 18, 3, 2, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1010, 19, 3, 1, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1011, 20, 3, 5, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1012, 21, 3, 6, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1013, 22, 3, 2, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1014, 23, 3, 4, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1015, 24, 3, 1, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1016, 25, 3, 6, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1017, 26, 3, 5, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1018, 27, 3, 5, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1019, 28, 3, 1, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1020, 29, 3, 4, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1021, 30, 3, 5, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1022, 31, 3, 2, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1023, 32, 3, 1, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1024, 33, 3, 5, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1025, 34, 3, 6, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1026, 35, 3, 1, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1027, 36, 3, 1, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1028, 37, 3, 6, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1029, 38, 3, 3, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1030, 39, 3, 6, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1031, 40, 3, 2, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1032, 41, 3, 3, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1033, 42, 3, 3, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1034, 43, 3, 5, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1035, 44, 3, 4, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1036, 45, 3, 4, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1037, 46, 3, 2, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1038, 47, 3, 1, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1039, 48, 3, 3, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1040, 49, 3, 6, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1041, 50, 3, 2, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1042, 51, 3, 4, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1043, 52, 3, 5, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1044, 53, 3, 1, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1045, 54, 3, 4, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1046, 55, 3, 1, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1047, 56, 3, 1, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1048, 57, 3, 5, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1049, 58, 3, 3, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1050, 59, 3, 4, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1051, 60, 3, 2, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1052, 61, 3, 6, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1053, 62, 3, 2, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1054, 63, 3, 4, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1055, 64, 3, 3, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1056, 65, 3, 5, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1057, 66, 3, 5, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1058, 67, 3, 1, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1059, 68, 3, 3, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1060, 69, 3, 2, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1061, 70, 3, 5, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1062, 71, 3, 3, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1063, 72, 3, 1, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1064, 73, 3, 4, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1065, 74, 3, 2, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1066, 75, 3, 4, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1067, 76, 3, 6, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1068, 77, 3, 4, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1069, 78, 3, 6, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1070, 79, 3, 4, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1071, 80, 3, 2, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1072, 81, 3, 4, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1073, 82, 3, 2, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1074, 83, 3, 5, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1075, 84, 3, 4, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1076, 85, 3, 5, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1077, 86, 3, 2, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1078, 87, 3, 3, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1079, 88, 3, 2, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1080, 89, 3, 5, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1081, 90, 3, 5, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1082, 91, 3, 3, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1083, 92, 3, 1, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1084, 93, 3, 5, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1085, 94, 3, 3, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1086, 95, 3, 5, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1087, 96, 3, 6, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1088, 97, 3, 2, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1089, 98, 3, 1, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1090, 99, 3, 3, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1091, 100, 3, 6, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1092, 101, 3, 3, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1093, 102, 3, 4, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1094, 103, 3, 6, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1095, 104, 3, 5, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1096, 105, 3, 3, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1097, 106, 3, 3, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1098, 107, 3, 5, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1099, 108, 3, 6, N'Licenciatura')
GO
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1100, 9, 1, 3, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1101, 10, 2, 3, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1102, 11, 1, 6, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1103, 12, 2, 4, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1104, 13, 2, 3, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1105, 14, 3, 1, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1106, 15, 1, 2, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1107, 16, 3, 5, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1108, 17, 1, 1, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1109, 18, 2, 3, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1110, 19, 2, 2, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1111, 20, 3, 1, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1112, 21, 2, 2, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1113, 22, 3, 5, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1114, 23, 1, 3, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1115, 24, 3, 5, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1116, 25, 1, 5, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1117, 26, 2, 2, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1118, 27, 3, 5, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1119, 28, 2, 2, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1120, 29, 1, 5, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1121, 30, 1, 5, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1122, 31, 1, 1, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1123, 32, 1, 6, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1124, 33, 3, 4, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1125, 34, 3, 6, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1126, 35, 1, 4, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1127, 36, 2, 3, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1128, 37, 3, 4, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1129, 38, 2, 6, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1130, 39, 2, 5, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1131, 40, 3, 5, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1132, 41, 2, 5, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1133, 42, 2, 1, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1134, 43, 1, 2, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1135, 44, 3, 5, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1136, 45, 2, 5, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1137, 46, 3, 1, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1138, 47, 1, 1, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1139, 48, 1, 6, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1140, 49, 1, 5, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1141, 50, 1, 6, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1142, 51, 1, 5, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1143, 52, 1, 1, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1144, 53, 3, 2, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1145, 54, 2, 2, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1146, 55, 2, 5, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1147, 56, 1, 6, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1148, 57, 3, 4, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1149, 58, 3, 3, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1150, 59, 1, 3, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1151, 60, 2, 4, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1152, 61, 2, 4, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1153, 62, 2, 4, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1154, 63, 3, 2, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1155, 64, 1, 3, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1156, 65, 3, 5, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1157, 66, 2, 1, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1158, 67, 3, 1, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1159, 68, 1, 4, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1160, 69, 1, 6, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1161, 70, 2, 2, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1162, 71, 2, 6, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1163, 72, 2, 2, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1164, 73, 3, 5, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1165, 74, 1, 2, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1166, 75, 3, 3, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1167, 76, 2, 1, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1168, 77, 3, 6, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1169, 78, 3, 1, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1170, 79, 3, 1, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1171, 80, 3, 4, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1172, 81, 1, 3, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1173, 82, 2, 4, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1174, 83, 1, 4, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1175, 84, 3, 4, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1176, 85, 3, 4, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1177, 86, 3, 5, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1178, 87, 3, 4, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1179, 88, 2, 5, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1180, 89, 3, 4, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1181, 90, 2, 3, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1182, 91, 2, 6, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1183, 92, 1, 5, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1184, 93, 3, 6, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1185, 94, 3, 6, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1186, 95, 1, 6, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1187, 96, 1, 1, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1188, 97, 3, 1, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1189, 98, 3, 2, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1190, 99, 3, 3, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1191, 100, 1, 6, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1192, 101, 1, 3, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1193, 102, 3, 2, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1194, 103, 3, 6, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1195, 104, 3, 1, N'Doctorado')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1196, 105, 3, 1, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1197, 106, 1, 6, N'Maestria')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1198, 107, 2, 5, N'Licenciatura')
INSERT [dbo].[Profesor] ([Empleado_No_empleado], [Cuenta_ID], [Estatus_ID], [Area_ID], [GradoEstudio]) VALUES (1199, 108, 1, 3, N'Maestria')
GO
INSERT [dbo].[Tipo_Aula] ([ID], [TIPO]) VALUES (1, N'Laboratorio')
INSERT [dbo].[Tipo_Aula] ([ID], [TIPO]) VALUES (2, N'Salon')
/****** Object:  Index [UQ__Area__3214EC2607E52FC3]    Script Date: 11/11/2017 22:02:35 ******/
ALTER TABLE [dbo].[Area] ADD UNIQUE NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Area__75E3EFCF05216F59]    Script Date: 11/11/2017 22:02:35 ******/
ALTER TABLE [dbo].[Area] ADD UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Aula__7E532BC60340722B]    Script Date: 11/11/2017 22:02:35 ******/
ALTER TABLE [dbo].[Aula] ADD UNIQUE NONCLUSTERED 
(
	[Numero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Cliente__3214EC2686ADC3CB]    Script Date: 11/11/2017 22:02:35 ******/
ALTER TABLE [dbo].[Cliente] ADD UNIQUE NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Cuenta__3214EC26173ACC0C]    Script Date: 11/11/2017 22:02:35 ******/
ALTER TABLE [dbo].[Cuenta] ADD UNIQUE NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Cuenta__E3237CF764F8D385]    Script Date: 11/11/2017 22:02:35 ******/
ALTER TABLE [dbo].[Cuenta] ADD UNIQUE NONCLUSTERED 
(
	[Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Curso__E8181E1116F0B3E2]    Script Date: 11/11/2017 22:02:36 ******/
ALTER TABLE [dbo].[Curso] ADD UNIQUE NONCLUSTERED 
(
	[Clave] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Estatus__3214EC260F23683F]    Script Date: 11/11/2017 22:02:36 ******/
ALTER TABLE [dbo].[Estatus] ADD UNIQUE NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Estatus__75E3EFCF03D15B52]    Script Date: 11/11/2017 22:02:36 ******/
ALTER TABLE [dbo].[Estatus] ADD UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Grupo__3214EC26840CDFCE]    Script Date: 11/11/2017 22:02:36 ******/
ALTER TABLE [dbo].[Grupo] ADD UNIQUE NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Materia__E8181E119CEA8357]    Script Date: 11/11/2017 22:02:36 ******/
ALTER TABLE [dbo].[Materia] ADD UNIQUE NONCLUSTERED 
(
	[Clave] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Profesor__2C1BC25EDF60D486]    Script Date: 11/11/2017 22:02:36 ******/
ALTER TABLE [dbo].[Profesor] ADD UNIQUE NONCLUSTERED 
(
	[Empleado_No_empleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Tipo_Aul__3214EC26BBE0F3CF]    Script Date: 11/11/2017 22:02:36 ******/
ALTER TABLE [dbo].[Tipo_Aula] ADD UNIQUE NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Tipo_Aul__B6FCAAA275BA321F]    Script Date: 11/11/2017 22:02:36 ******/
ALTER TABLE [dbo].[Tipo_Aula] ADD UNIQUE NONCLUSTERED 
(
	[TIPO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Aula]  WITH CHECK ADD  CONSTRAINT [Tipo_fk] FOREIGN KEY([Tipo_aula])
REFERENCES [dbo].[Tipo_Aula] ([ID])
GO
ALTER TABLE [dbo].[Aula] CHECK CONSTRAINT [Tipo_fk]
GO
ALTER TABLE [dbo].[Clases]  WITH CHECK ADD  CONSTRAINT [Clases_Curso] FOREIGN KEY([Curso_Clave])
REFERENCES [dbo].[Curso] ([Clave])
GO
ALTER TABLE [dbo].[Clases] CHECK CONSTRAINT [Clases_Curso]
GO
ALTER TABLE [dbo].[Clases]  WITH CHECK ADD  CONSTRAINT [Clases_Materia] FOREIGN KEY([Materia_Clave])
REFERENCES [dbo].[Materia] ([Clave])
GO
ALTER TABLE [dbo].[Clases] CHECK CONSTRAINT [Clases_Materia]
GO
ALTER TABLE [dbo].[Cliente]  WITH CHECK ADD  CONSTRAINT [Cliente_Estatus] FOREIGN KEY([Estatus_ID])
REFERENCES [dbo].[Estatus] ([ID])
GO
ALTER TABLE [dbo].[Cliente] CHECK CONSTRAINT [Cliente_Estatus]
GO
ALTER TABLE [dbo].[Curso]  WITH CHECK ADD  CONSTRAINT [Curso_Aula] FOREIGN KEY([Aula_Numero])
REFERENCES [dbo].[Aula] ([Numero])
GO
ALTER TABLE [dbo].[Curso] CHECK CONSTRAINT [Curso_Aula]
GO
ALTER TABLE [dbo].[Curso]  WITH CHECK ADD  CONSTRAINT [Curso_Profesor] FOREIGN KEY([Profesor_Empleado_No_empleado])
REFERENCES [dbo].[Profesor] ([Empleado_No_empleado])
GO
ALTER TABLE [dbo].[Curso] CHECK CONSTRAINT [Curso_Profesor]
GO
ALTER TABLE [dbo].[Curso_Horario]  WITH CHECK ADD  CONSTRAINT [Curso_Horario_Curso] FOREIGN KEY([Curso_Clave])
REFERENCES [dbo].[Curso] ([Clave])
GO
ALTER TABLE [dbo].[Curso_Horario] CHECK CONSTRAINT [Curso_Horario_Curso]
GO
ALTER TABLE [dbo].[Curso_Horario]  WITH CHECK ADD  CONSTRAINT [Curso_Horario_Horario] FOREIGN KEY([Horario_Clave])
REFERENCES [dbo].[Horario] ([Clave])
GO
ALTER TABLE [dbo].[Curso_Horario] CHECK CONSTRAINT [Curso_Horario_Horario]
GO
ALTER TABLE [dbo].[Grupo]  WITH CHECK ADD  CONSTRAINT [Grupo_Estudiante] FOREIGN KEY([Cliente_ID])
REFERENCES [dbo].[Cliente] ([ID])
GO
ALTER TABLE [dbo].[Grupo] CHECK CONSTRAINT [Grupo_Estudiante]
GO
ALTER TABLE [dbo].[Grupo]  WITH CHECK ADD  CONSTRAINT [Inscripcion_Curso] FOREIGN KEY([Curso_Clave])
REFERENCES [dbo].[Curso] ([Clave])
GO
ALTER TABLE [dbo].[Grupo] CHECK CONSTRAINT [Inscripcion_Curso]
GO
ALTER TABLE [dbo].[Materia]  WITH CHECK ADD  CONSTRAINT [Materia_Area] FOREIGN KEY([Area_ID])
REFERENCES [dbo].[Area] ([ID])
GO
ALTER TABLE [dbo].[Materia] CHECK CONSTRAINT [Materia_Area]
GO
ALTER TABLE [dbo].[Profesor]  WITH CHECK ADD  CONSTRAINT [Profesor_Area] FOREIGN KEY([Area_ID])
REFERENCES [dbo].[Area] ([ID])
GO
ALTER TABLE [dbo].[Profesor] CHECK CONSTRAINT [Profesor_Area]
GO
ALTER TABLE [dbo].[Profesor]  WITH CHECK ADD  CONSTRAINT [Profesor_Cuenta] FOREIGN KEY([Cuenta_ID])
REFERENCES [dbo].[Cuenta] ([ID])
GO
ALTER TABLE [dbo].[Profesor] CHECK CONSTRAINT [Profesor_Cuenta]
GO
ALTER TABLE [dbo].[Profesor]  WITH CHECK ADD  CONSTRAINT [Profesor_Empleado] FOREIGN KEY([Empleado_No_empleado])
REFERENCES [dbo].[Empleado] ([No_empleado])
GO
ALTER TABLE [dbo].[Profesor] CHECK CONSTRAINT [Profesor_Empleado]
GO
ALTER TABLE [dbo].[Profesor]  WITH CHECK ADD  CONSTRAINT [Profesor_Estatus] FOREIGN KEY([Estatus_ID])
REFERENCES [dbo].[Estatus] ([ID])
GO
ALTER TABLE [dbo].[Profesor] CHECK CONSTRAINT [Profesor_Estatus]
GO
USE [master]
GO
ALTER DATABASE [PIA] SET  READ_WRITE 
GO