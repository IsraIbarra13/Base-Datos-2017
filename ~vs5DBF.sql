USE [master]
GO
/****** Object:  Database [Practica1]    Script Date: 02/09/2017 11:30:44 a.m. ******/
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'Practica1')
BEGIN
CREATE DATABASE [Practica1]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Practica1', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Practica1.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Practica1_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Practica1_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
END

GO
ALTER DATABASE [Practica1] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Practica1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Practica1] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Practica1] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Practica1] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Practica1] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Practica1] SET ARITHABORT OFF 
GO
ALTER DATABASE [Practica1] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Practica1] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Practica1] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Practica1] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Practica1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Practica1] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Practica1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Practica1] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Practica1] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Practica1] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Practica1] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Practica1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Practica1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Practica1] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Practica1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Practica1] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Practica1] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Practica1] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Practica1] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Practica1] SET  MULTI_USER 
GO
ALTER DATABASE [Practica1] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Practica1] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Practica1] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Practica1] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Practica1] SET  READ_WRITE 
GO
