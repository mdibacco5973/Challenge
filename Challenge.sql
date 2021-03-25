USE [master]
GO

/****** Object:  Database [Challenge]    Script Date: 20/3/2021 20:18:51 ******/
DROP DATABASE [Challenge]
GO

/****** Object:  Database [Challenge]    Script Date: 20/3/2021 20:18:51 ******/
CREATE DATABASE [Challenge]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Challenge', FILENAME = N'C:\Users\mdibacco\Challenge.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Challenge_log', FILENAME = N'C:\Users\mdibacco\Challenge_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

ALTER DATABASE [Challenge] SET COMPATIBILITY_LEVEL = 140
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Challenge].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [Challenge] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [Challenge] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [Challenge] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [Challenge] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [Challenge] SET ARITHABORT OFF 
GO

ALTER DATABASE [Challenge] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [Challenge] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [Challenge] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [Challenge] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [Challenge] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [Challenge] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [Challenge] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [Challenge] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [Challenge] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [Challenge] SET  DISABLE_BROKER 
GO

ALTER DATABASE [Challenge] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [Challenge] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [Challenge] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [Challenge] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [Challenge] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [Challenge] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [Challenge] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [Challenge] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [Challenge] SET  MULTI_USER 
GO

ALTER DATABASE [Challenge] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [Challenge] SET DB_CHAINING OFF 
GO

ALTER DATABASE [Challenge] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [Challenge] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [Challenge] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [Challenge] SET QUERY_STORE = OFF
GO

ALTER DATABASE [Challenge] SET  READ_WRITE 
GO

USE [Challenge]
GO

/****** Object:  Table [dbo].[Persona]    Script Date: 20/3/2021 20:19:30 ******/
DROP TABLE [dbo].[Persona]
GO

/****** Object:  Table [dbo].[Persona]    Script Date: 20/3/2021 20:19:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Persona](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[Company] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[PhoneNumber] [nvarchar](50) NULL,
 CONSTRAINT [PK_Persona] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE PROCEDURE [dbo].[Persona_g]    
	@id int,
	@FirstName nvarchar(50),
	@LastName nvarchar(50),
	@Company nvarchar(50),
	@Email nvarchar(50),
	@PhoneNumber nvarchar(50)
AS     
BEGIN  
SET LANGUAGE Spanish        

  Select P.id, P.FirstName, P.LastName, P.Company, P.Email,P.PhoneNumber
  From Persona P   WITH(NOLOCK)
  WHERE ((P.id = @Id) OR (@Id = 0) OR (@Id is null))        
  AND ((P.FirstName LIKE '%' + @FirstName + '%') OR (@FirstName = '') OR (@FirstName IS NULL))   
  AND ((P.LastName LIKE '%' + @LastName + '%') OR (@LastName = '') OR (@LastName IS NULL))   
  AND ((P.Company LIKE '%' + @Company + '%') OR (@Company = '') OR (@Company IS NULL))   
  AND ((P.Email LIKE '%' + @Email + '%') OR (@Email = '') OR (@Email IS NULL))
  AND ((P.PhoneNumber LIKE '%' + @PhoneNumber + '%') OR (@PhoneNumber = '') OR (@PhoneNumber IS NULL))
  ORDER BY P.FirstName  
  
END  
GO
  
CREATE PROCEDURE [dbo].[Persona_i]    
	@id int,
	@FirstName nvarchar(50),
	@LastName nvarchar(50),
	@Company nvarchar(50),
	@Email nvarchar(50),
	@PhoneNumber nvarchar(50)    
AS        
BEGIN         
        
SET LANGUAGE Spanish          

BEGIN TRAN T1    
BEGIN TRY    

 INSERT INTO Persona(FirstName,LastName,Company,Email,PhoneNumber)  
 VALUES(@FirstName,@LastName,@Company,@Email,@PhoneNumber)
  
COMMIT TRAN T1    
    
 Select 'Id' + CAST(@@Identity AS varchar(20)) 
    
END TRY    
BEGIN CATCH    
  ROLLBACK TRAN T1    
   Select 'Error' + CAST(ERROR_NUMBER() AS varchar(10)) 
  RETURN     
END CATCH    
END        
GO
 
CREATE PROCEDURE [dbo].[Persona_u]    
    @id int,
	@FirstName nvarchar(50),
	@LastName nvarchar(50),
	@Company nvarchar(50),
	@Email nvarchar(50),
	@PhoneNumber nvarchar(50)       
AS        
BEGIN         
        
SET LANGUAGE Spanish          
    
BEGIN TRAN T1    
BEGIN TRY    
  
 UPDATE Persona  
 SET FirstName = @FirstName,
	LastName = @LastName,
	Company = @Company,
	Email = @Email,
	PhoneNumber = @PhoneNumber
 WHERE id = @id
    
COMMIT TRAN T1    
    
 Select 'Id' + CAST(@Id AS varchar(20))
    
END TRY    
BEGIN CATCH    
  ROLLBACK TRAN T1    
   Select 'Error' + CAST(ERROR_NUMBER() AS varchar(10)) 
  RETURN     
END CATCH    
END         
GO

CREATE PROCEDURE [dbo].[Persona_d]    
	@id int    
AS        
BEGIN         
        
SET LANGUAGE Spanish          
    
BEGIN TRAN T1    
BEGIN TRY    

 Delete From Persona 
 WHERE Id = @id
    
COMMIT TRAN T1    
    
 Select 'Id' + CAST(@Id AS varchar(20))
    
END TRY    
BEGIN CATCH    
  ROLLBACK TRAN T1    
   Select 'Error ' + CAST(ERROR_NUMBER() AS varchar(10)) 
  RETURN     
END CATCH    
END         
GO


