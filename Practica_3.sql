USE [master]
GO
/****** Object:  Database [Colegio]    Script Date: 07/10/2017 10:02:28 a.m. ******/
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'Colegio')
BEGIN
CREATE DATABASE [Colegio]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Colegio', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Colegio.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Colegio_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Colegio_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
END

GO
ALTER DATABASE [Colegio] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Colegio].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Colegio] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Colegio] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Colegio] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Colegio] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Colegio] SET ARITHABORT OFF 
GO
ALTER DATABASE [Colegio] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Colegio] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Colegio] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Colegio] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Colegio] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Colegio] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Colegio] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Colegio] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Colegio] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Colegio] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Colegio] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Colegio] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Colegio] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Colegio] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Colegio] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Colegio] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Colegio] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Colegio] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Colegio] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Colegio] SET  MULTI_USER 
GO
ALTER DATABASE [Colegio] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Colegio] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Colegio] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Colegio] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [Colegio]
GO
/****** Object:  Table [dbo].[Aula]    Script Date: 07/10/2017 10:02:28 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Aula]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Aula](
	[Numero_aula] [uniqueidentifier] NOT NULL,
	[Capacidad] [bigint] NOT NULL,
	[Tipo] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Aula] PRIMARY KEY CLUSTERED 
(
	[Numero_aula] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Curso1]    Script Date: 07/10/2017 10:02:28 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Curso1]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Curso1](
	[Id_curso] [uniqueidentifier] NOT NULL,
	[Id_materia] [uniqueidentifier] NOT NULL,
	[Id_horario] [uniqueidentifier] NOT NULL,
	[Id_estudiantes] [uniqueidentifier] NOT NULL,
	[Id_aula] [uniqueidentifier] NOT NULL,
	[Id_maestro] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Curso1] PRIMARY KEY CLUSTERED 
(
	[Id_curso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Empleado]    Script Date: 07/10/2017 10:02:28 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Empleado]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Empleado](
	[Id_empleado] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Empleado] PRIMARY KEY CLUSTERED 
(
	[Id_empleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Estudiante]    Script Date: 07/10/2017 10:02:28 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Estudiante]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Estudiante](
	[Matricula] [uniqueidentifier] NOT NULL,
	[Nombres] [varchar](50) NOT NULL,
	[Apellido_paterno] [varchar](50) NOT NULL,
	[Apellido_materno] [varchar](50) NOT NULL,
	[Correo] [varchar](50) NOT NULL,
	[Telefono] [tinyint] NOT NULL,
	[Fecha_ingreso] [datetime] NOT NULL,
	[Colonia] [varchar](50) NOT NULL,
	[Numero] [smallint] NOT NULL,
	[Calle] [nchar](50) NOT NULL,
	[Fecha_nacimiento] [datetime] NOT NULL,
	[Edad] [tinyint] NOT NULL,
	[Semestre] [tinyint] NOT NULL,
 CONSTRAINT [PK_Estudiante] PRIMARY KEY CLUSTERED 
(
	[Matricula] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Horario]    Script Date: 07/10/2017 10:02:28 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Horario]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Horario](
	[Id_horario] [uniqueidentifier] NOT NULL,
	[Hora_inicio] [datetime] NOT NULL,
	[Hora_fin] [datetime] NOT NULL,
 CONSTRAINT [PK_Horario] PRIMARY KEY CLUSTERED 
(
	[Id_horario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Materia]    Script Date: 07/10/2017 10:02:28 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Materia]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Materia](
	[Id_materia] [uniqueidentifier] NOT NULL,
	[Hora_semanales] [varchar](50) NOT NULL,
	[Semestre] [tinyint] NOT NULL,
	[Creditos] [bigint] NOT NULL,
 CONSTRAINT [PK_Materia] PRIMARY KEY CLUSTERED 
(
	[Id_materia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Curso1_Aula]') AND parent_object_id = OBJECT_ID(N'[dbo].[Curso1]'))
ALTER TABLE [dbo].[Curso1]  WITH CHECK ADD  CONSTRAINT [FK_Curso1_Aula] FOREIGN KEY([Id_aula])
REFERENCES [dbo].[Aula] ([Numero_aula])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Curso1_Aula]') AND parent_object_id = OBJECT_ID(N'[dbo].[Curso1]'))
ALTER TABLE [dbo].[Curso1] CHECK CONSTRAINT [FK_Curso1_Aula]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Curso1_Empleado]') AND parent_object_id = OBJECT_ID(N'[dbo].[Curso1]'))
ALTER TABLE [dbo].[Curso1]  WITH CHECK ADD  CONSTRAINT [FK_Curso1_Empleado] FOREIGN KEY([Id_maestro])
REFERENCES [dbo].[Empleado] ([Id_empleado])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Curso1_Empleado]') AND parent_object_id = OBJECT_ID(N'[dbo].[Curso1]'))
ALTER TABLE [dbo].[Curso1] CHECK CONSTRAINT [FK_Curso1_Empleado]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Curso1_Estudiante]') AND parent_object_id = OBJECT_ID(N'[dbo].[Curso1]'))
ALTER TABLE [dbo].[Curso1]  WITH CHECK ADD  CONSTRAINT [FK_Curso1_Estudiante] FOREIGN KEY([Id_estudiantes])
REFERENCES [dbo].[Estudiante] ([Matricula])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Curso1_Estudiante]') AND parent_object_id = OBJECT_ID(N'[dbo].[Curso1]'))
ALTER TABLE [dbo].[Curso1] CHECK CONSTRAINT [FK_Curso1_Estudiante]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Curso1_Horario]') AND parent_object_id = OBJECT_ID(N'[dbo].[Curso1]'))
ALTER TABLE [dbo].[Curso1]  WITH CHECK ADD  CONSTRAINT [FK_Curso1_Horario] FOREIGN KEY([Id_horario])
REFERENCES [dbo].[Horario] ([Id_horario])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Curso1_Horario]') AND parent_object_id = OBJECT_ID(N'[dbo].[Curso1]'))
ALTER TABLE [dbo].[Curso1] CHECK CONSTRAINT [FK_Curso1_Horario]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Curso1_Materia]') AND parent_object_id = OBJECT_ID(N'[dbo].[Curso1]'))
ALTER TABLE [dbo].[Curso1]  WITH CHECK ADD  CONSTRAINT [FK_Curso1_Materia] FOREIGN KEY([Id_materia])
REFERENCES [dbo].[Materia] ([Id_materia])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Curso1_Materia]') AND parent_object_id = OBJECT_ID(N'[dbo].[Curso1]'))
ALTER TABLE [dbo].[Curso1] CHECK CONSTRAINT [FK_Curso1_Materia]
GO
USE [master]
GO
ALTER DATABASE [Colegio] SET  READ_WRITE 
GO
