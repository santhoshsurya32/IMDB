USE [master]
GO
/****** Object:  Database [IMDB]    Script Date: 21-11-2022 19:47:19 ******/
CREATE DATABASE [IMDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'IMDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\IMDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'IMDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\IMDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [IMDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [IMDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [IMDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [IMDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [IMDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [IMDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [IMDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [IMDB] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [IMDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [IMDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [IMDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [IMDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [IMDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [IMDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [IMDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [IMDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [IMDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [IMDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [IMDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [IMDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [IMDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [IMDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [IMDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [IMDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [IMDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [IMDB] SET  MULTI_USER 
GO
ALTER DATABASE [IMDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [IMDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [IMDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [IMDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [IMDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [IMDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [IMDB] SET QUERY_STORE = OFF
GO
USE [IMDB]
GO
/****** Object:  UserDefinedTableType [dbo].[MovieRequest]    Script Date: 21-11-2022 19:47:19 ******/
CREATE TYPE [dbo].[MovieRequest] AS TABLE(
	[MOVIEID] [int] NULL,
	[NAME] [nvarchar](50) NULL,
	[PLOT] [nvarchar](100) NULL,
	[RELEASEDATE] [datetime] NULL,
	[ISDELETED] [tinyint] NULL,
	[UPDATEDON] [datetime] NULL,
	[ACTORID] [int] NULL,
	[PRODUCERID] [int] NULL
)
GO
/****** Object:  Table [dbo].[Actor]    Script Date: 21-11-2022 19:47:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Actor](
	[ActorId] [int] IDENTITY(1,1) NOT NULL,
	[ActorName] [nvarchar](30) NOT NULL,
	[Bio] [nvarchar](100) NULL,
	[DOB] [datetime] NULL,
	[GENDER] [nvarchar](10) NULL,
	[UpdatedOn] [datetime] NULL,
	[isDeleted] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[ActorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ActorName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MOVIE]    Script Date: 21-11-2022 19:47:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVIE](
	[MovieId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[UpdatedOn] [datetime] NULL,
	[isDeleted] [tinyint] NULL,
	[Plot] [nvarchar](100) NULL,
	[ReleaseDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[MovieId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovieActorMapping]    Script Date: 21-11-2022 19:47:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovieActorMapping](
	[MovieActorId] [int] IDENTITY(1,1) NOT NULL,
	[movieId] [int] NOT NULL,
	[ActorId] [int] NOT NULL,
	[UpdatedOn] [datetime] NULL,
	[isDeleted] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[MovieActorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovieProducerMapping]    Script Date: 21-11-2022 19:47:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovieProducerMapping](
	[MovieProducerId] [int] IDENTITY(1,1) NOT NULL,
	[movieId] [int] NOT NULL,
	[ProducerId] [int] NOT NULL,
	[UpdatedOn] [datetime] NULL,
	[isDeleted] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[MovieProducerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Persons]    Script Date: 21-11-2022 19:47:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Persons](
	[PersonID] [int] NULL,
	[LastName] [varchar](255) NULL,
	[FirstName] [varchar](255) NULL,
	[Address] [varchar](255) NULL,
	[City] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Producer]    Script Date: 21-11-2022 19:47:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Producer](
	[ProducerId] [int] IDENTITY(1,1) NOT NULL,
	[ProducerName] [nvarchar](30) NOT NULL,
	[Bio] [nvarchar](100) NULL,
	[DOB] [datetime] NULL,
	[GENDER] [nvarchar](10) NULL,
	[Company] [nvarchar](50) NOT NULL,
	[UpdatedOn] [datetime] NULL,
	[isDeleted] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProducerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MovieActorMapping]  WITH CHECK ADD FOREIGN KEY([ActorId])
REFERENCES [dbo].[Actor] ([ActorId])
GO
ALTER TABLE [dbo].[MovieActorMapping]  WITH CHECK ADD FOREIGN KEY([movieId])
REFERENCES [dbo].[MOVIE] ([MovieId])
GO
ALTER TABLE [dbo].[MovieProducerMapping]  WITH CHECK ADD FOREIGN KEY([movieId])
REFERENCES [dbo].[MOVIE] ([MovieId])
GO
ALTER TABLE [dbo].[MovieProducerMapping]  WITH CHECK ADD FOREIGN KEY([ProducerId])
REFERENCES [dbo].[Producer] ([ProducerId])
GO
ALTER TABLE [dbo].[Actor]  WITH CHECK ADD CHECK  (([GENDER]='OTHERS' OR [GENDER]='fEMALE' OR [GENDER]='MALE'))
GO
ALTER TABLE [dbo].[Producer]  WITH CHECK ADD CHECK  (([GENDER]='OTHERS' OR [GENDER]='fEMALE' OR [GENDER]='MALE'))
GO
/****** Object:  StoredProcedure [dbo].[AddOrUpdateActor]    Script Date: 21-11-2022 19:47:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------SP--------------------------------    
--Date : 17-NOV-2022    
--Purpose : To Add or Update Actor   
--Provoke : EXEC AddOrUpdateActor '9','test2','TEST','2021-11-17 13:40:45.923','FEmale','TEST1'    
----------------------------------------------------------------    
CREATE PROC [dbo].[AddOrUpdateActor](    
@actorId int =null,    
@actorName nvarchar(50)=NULL,    
@Bio nvarchar(100)=NULL,    
@DOB datetime=NULL,    
@Gender nvarchar(10)=NULL   
)    
AS    
BEGIN    
BEGIN TRY    
IF(@DOB IS NOT NULL AND @DOB>GETUTCDATE())  
BEGIN  
    RAISERROR('Date of Birth must not be in future',16,1)  
END  
    
--ADD PRODUCER    
IF(@actorId=0)    
BEGIN    
  
IF EXISTS(SELECT TOP 1* FROM actor WHERE LOWER(actorname)=LOWER(@actorName) AND ISDELETED=0)    
BEGIN     
   RAISERROR('Actor Name Already Exists',16,1)    
END   

   INSERT INTO ACTOR(ACTORNAME,Bio,DOB,Gender,UpdatedOn,isDeleted)    
   VALUES (@actorName,@Bio,@DOB,UPPER(@Gender),GETUTCDATE(),0)     
   SELECT SCOPE_IDENTITY() ActorId 
   
END    
    
--UPDATE PRODUCER    
ELSE    
BEGIN    
 IF NOT EXISTS(SELECT TOP 1* FROM Actor WHERE ActorId=@actorId AND ISDELETED=0)    
 BEGIN    
     RAISERROR('INVALID ACTOR ID',16,1)    
 END    
  
IF(@actorName IS NOT NULL AND @actorId<>(SELECT TOP 1 ACTORID FROM ACTOR WHERE LOWER(ACTORNAME)=LOWER(@actorName) AND ISDELETED=0))    
BEGIN     
   RAISERROR('Actor Name Already Exists',16,1)    
END    
 
  
 UPDATE ACTOR SET    
 ACTORNAME=CASE WHEN @actorName IS NULL THEN ACTORNAME ELSE @actorName END,    
 BIO=CASE WHEN @BIO IS NULL THEN BIO ELSE @Bio END,    
 DOB=CASE WHEN @DOB IS NULL THEN DOB ELSE @DOB END,    
 GENDER=CASE WHEN @Gender IS NULL THEN GENDER ELSE @Gender END  
 WHERE ACTORID=@actorId SELECT @actorId ActorId  
   
END    
    
    
END TRY    
BEGIN CATCH    
DECLARE @Message nvarchar(200)    
SET @Message=ERROR_MESSAGE()    
RAISERROR(@Message,16,1)    
END CATCH    
    
END
GO
/****** Object:  StoredProcedure [dbo].[AddOrUpdateMovie]    Script Date: 21-11-2022 19:47:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------SP--------------------------------      
--Date : 18-NOV-2022      
--Purpose : To Add or Update Movie Details  
--Invoke : EXEC AddOrUpdateMovie '3','baasa','11','','action','12/12/2012'  
----------------------------------------------------------------      
CREATE PROC [dbo].[AddOrUpdateMovie](      
@movieId int =0,  
@movieName nvarchar(50),  
@producerId int,  
@actorId nvarchar(100),  
@plot nvarchar(100),  
@releaseDate datetime  
)      
AS      
BEGIN      
BEGIN TRY     
BEGIN TRANSACTION AM  
CREATE TABLE #TempActor( ActorId int,MovieId int,UpdatedOn datetime,isDeleted tinyint)  

IF(LEN(LTRIM(RTRIM(@actorId)))<=0)
BEGIN
  RAISERROR('Add Atleast one actor',16,1)
END
  
INSERT INTO #TempActor (ActorId)(SELECT CONVERT(nvarchar,[value]) from string_split(@actorId,','))  
  

  
IF EXISTS(SELECT ActorId FROM #TempActor WHERE ActorId NOT IN (SELECT ACTORID FROM Actor WHERE isDeleted=0))  
BEGIN  
   RAISERROR('Invalid actor/actor does not exist',16,1)  
END  
  
IF(@producerId<>0)  
BEGIN  
IF NOT EXISTS(SELECT TOP 1 PRODUCERID FROM Producer WHERE ProducerId=@producerId AND isDeleted=0)  
BEGIN  
   RAISERROR('Invalid Producer/Producer does not exist',16,1)  
END  
END  
  
  
--ADD MOVIE  
IF(@movieId = 0)  
BEGIN  
   IF EXISTS(SELECT TOP 1 Name FROM MOVIE WHERE LOWER(Name)=LOWER(@movieName))  
   BEGIN  
      RAISERROR('Insertion Failed,Movie Name Already Exists',16,1)  
   END  
  
   UPDATE #TempActor SET ISDELETED=0,UPDATEDON=GETUTCDATE()  
   --MOVIE DETAIL  
   INSERT INTO MOVIE(Name,Plot,isDeleted,UpdatedOn,ReleaseDate)VALUES(@movieName,@plot,0,GETUTCDATE(),@releaseDate)  
   SET @movieId=SCOPE_IDENTITY()  
  
   --PRODUCER DETAIL  
     
   INSERT INTO MovieProducerMapping(ProducerId,movieId,UpdatedOn,isDeleted)VALUES(@producerId,@movieId,GETUTCDATE(),0)  
     
   --ACTOR DETAIL  
   UPDATE #TempActor SET MovieId=@movieId  
   INSERT INTO MovieActorMapping(movieId,ActorId,UpdatedOn,isDeleted) SELECT MOVIEID,ACTORID,UPDATEDON,ISDELETED FROM #TempActor  
   select @movieId MOVIEID  
   SET @movieId=0  
END   
  
--UPDATE MOVIE  
ELSE  
BEGIN  
   IF (@movieId <> (SELECT TOP 1 MovieId FROM MOVIE WHERE LOWER(Name)=LOWER(@movieName)))  
   BEGIN  
      RAISERROR('Insertion Failed,Movie Name Already Exists',16,1)  
   END   
  
   UPDATE MOVIE SET  
   Name=CASE WHEN @movieName IS NULL THEN Name ELSE @movieName END,  
   PLOT=CASE WHEN @plot IS NULL THEN PLOT ELSE @plot END,  
   ReleaseDate = CASE WHEN @releaseDate IS NULL THEN ReleaseDate ELSE @releaseDate END,  
   UPDATEDON = GETUTCDATE()  
   WHERE MovieId=@movieId  
  
   UPDATE #TempActor SET ISDELETED=0,UPDATEDON=GETUTCDATE(),MovieId=@movieId  
   IF (@producerId<>0)  
   BEGIN  
   IF NOT EXISTS(SELECT PRODUCERID,MOVIEID FROM MovieProducerMapping WHERE ProducerId=@producerId AND movieId=@movieId AND isDeleted=0)  
   BEGIN  
      UPDATE MovieProducerMapping SET isDeleted=1,UpdatedOn=GETUTCDATE() WHERE movieId=@movieId  
   INSERT INTO MovieProducerMapping(ProducerId,movieId,UpdatedOn,isDeleted)VALUES(@producerId,@movieId,GETUTCDATE(),0)  
   END  
   END  
  
  
   DELETE FROM #TempActor WHERE ActorId IS NULL   
      UPDATE MovieActorMapping SET isDeleted=1,UpdatedOn=GETUTCDATE() WHERE movieId=@movieId   
   INSERT INTO MovieActorMapping(movieId,ActorId,UpdatedOn,isDeleted) SELECT MOVIEID,ACTORID,UPDATEDON,ISDELETED FROM #TempActor  
  
  
   select @movieId MOVIEID  
  
END  
  
  
COMMIT TRANSACTION AM  
   
END TRY      
BEGIN CATCH      
ROLLBACK TRANSACTION AM  
DECLARE @Message nvarchar(200)      
SET @Message=ERROR_MESSAGE()      
RAISERROR(@Message,16,1)      
END CATCH      
      
END
GO
/****** Object:  StoredProcedure [dbo].[AddOrUpdateProducer]    Script Date: 21-11-2022 19:47:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------SP--------------------------------  
--Date : 17-NOV-2022  
--Purpose : To Add or Update Producer  
--Provoke : EXEC AddOrUpdateProducer '9','test2','TEST','2021-11-17 13:40:45.923','FEmale','TEST1'  
----------------------------------------------------------------  
CREATE PROC [dbo].[AddOrUpdateProducer](  
@producerId int =null,  
@ProducerName nvarchar(50)=NULL,  
@Bio nvarchar(100)=NULL,  
@DOB datetime=NULL,  
@Gender nvarchar(10)=NULL,  
@Company nvarchar(50)=NULL  
)  
AS  
BEGIN  
BEGIN TRY  
IF(@DOB IS NOT NULL AND @DOB>GETUTCDATE())
BEGIN
    RAISERROR('Date of Birth must not be in future',16,1)
END
  
--ADD PRODUCER  
IF(@ProducerId=0)  
BEGIN  

IF EXISTS(SELECT TOP 1* FROM PRODUCER WHERE LOWER(PRODUCERNAME)=LOWER(@ProducerName) AND ISDELETED=0)  
BEGIN   
   RAISERROR('Producer Name Already Exists',16,1)  
END  
IF EXISTS(SELECT TOP 1* FROM PRODUCER WHERE LOWER(Company)=LOWER(@Company) AND ISDELETED=0)  
BEGIN   
   RAISERROR('Producer Company Already Exists',16,1)  
END  
   INSERT INTO PRODUCER(ProducerName,Bio,DOB,Gender,Company,UpdatedOn,isDeleted)  
   VALUES (@ProducerName,@Bio,@DOB,UPPER(@Gender),@Company,GETUTCDATE(),0)   
   SELECT SCOPE_IDENTITY() ProducerId  
END  
  
--UPDATE PRODUCER  
ELSE  
BEGIN  
 IF NOT EXISTS(SELECT TOP 1* FROM PRODUCER WHERE PRODUCERID=@producerId AND ISDELETED=0)  
 BEGIN  
     RAISERROR('INVALID PRODUCER ID',16,1)  
 END  

IF(@ProducerName IS NOT NULL AND @producerId<>(SELECT TOP 1 PRODUCERID FROM PRODUCER WHERE LOWER(PRODUCERNAME)=LOWER(@ProducerName) AND ISDELETED=0))  
BEGIN   
   RAISERROR('Producer Name Already Exists',16,1)  
END  

IF(@Company IS NOT NULL AND @producerId <> (SELECT TOP 1 ProducerID FROM PRODUCER WHERE LOWER(Company)=LOWER(@Company) AND ISDELETED=0))  
BEGIN   
   RAISERROR('Producer Company Already Exists',16,1)  
END 

 UPDATE PRODUCER SET  
 PRODUCERNAME=CASE WHEN @ProducerName IS NULL THEN PRODUCERNAME ELSE @ProducerName END,  
 BIO=CASE WHEN @BIO IS NULL THEN BIO ELSE @Bio END,  
 DOB=CASE WHEN @DOB IS NULL THEN DOB ELSE @DOB END,  
 GENDER=CASE WHEN @Gender IS NULL THEN GENDER ELSE @Gender END,  
 COMPANY=CASE WHEN @Company IS NULL THEN COMPANY ELSE @Company END  
 WHERE PRODUCERID=@producerId SELECT @producerId ProducerId 
 
END  
  
  
END TRY  
BEGIN CATCH  
DECLARE @Message nvarchar(200)  
SET @Message=ERROR_MESSAGE()  
RAISERROR(@Message,16,1)  
END CATCH  
  
END
GO
/****** Object:  StoredProcedure [dbo].[DELETEACTOR]    Script Date: 21-11-2022 19:47:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------SP--------------------------------      
--Date : 18-NOV-2022      
--Purpose : To Delete Actor  
--Invoke : EXEC DeleteActor 4 
----------------------------------------------------------------      
CREATE PROC [dbo].[DELETEACTOR](      
@actorId int  
)      
AS      
BEGIN      
BEGIN TRY     
  
IF NOT EXISTS(SELECT TOP 1 actorId FROM Actor WHERE ActorId=@actorId AND isDeleted=0)  
BEGIN  
   RAISERROR('Invalid actor/actor does not exist',16,1)  
END  
  
UPDATE Actor SET isDeleted=1,UpdatedOn=GETUTCDATE() where ActorId=@actorId
SELECT @actorId actorID  
   
END TRY      
BEGIN CATCH      
DECLARE @Message nvarchar(200)      
SET @Message=ERROR_MESSAGE()      
RAISERROR(@Message,16,1)      
END CATCH      
      
END
GO
/****** Object:  StoredProcedure [dbo].[DELETEMOVIE]    Script Date: 21-11-2022 19:47:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------SP--------------------------------      
--Date : 18-NOV-2022      
--Purpose : To Delete Movie  
--Invoke : EXEC DeleteMovie 1  
----------------------------------------------------------------      
CREATE PROC [dbo].[DELETEMOVIE](      
@movieId int  
)      
AS      
BEGIN      
BEGIN TRY     
  
IF NOT EXISTS(SELECT TOP 1 movieId FROM MOVIE WHERE movieId=@movieId AND isDeleted=0)  
BEGIN  
   RAISERROR('Invalid movie/movie does not exist',16,1)  
END  
  
UPDATE MOVIE SET isDeleted=1,UpdatedOn=GETUTCDATE() where MovieId=@movieId
SELECT @movieId movieID  
   
END TRY      
BEGIN CATCH      
DECLARE @Message nvarchar(200)      
SET @Message=ERROR_MESSAGE()      
RAISERROR(@Message,16,1)      
END CATCH      
      
END
GO
/****** Object:  StoredProcedure [dbo].[DELETEPRODUCER]    Script Date: 21-11-2022 19:47:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------SP--------------------------------      
--Date : 18-NOV-2022      
--Purpose : To Delete Producer  
--Invoke : EXEC DeleteProducer 9  
----------------------------------------------------------------      
CREATE PROC [dbo].[DELETEPRODUCER](      
@producerId int  
)      
AS      
BEGIN      
BEGIN TRY     
  
IF NOT EXISTS(SELECT TOP 1 PRODUCERID FROM Producer WHERE ProducerId=@producerId AND isDeleted=0)  
BEGIN  
   RAISERROR('Invalid Producer/Producer does not exist',16,1)  
END  
  
UPDATE PRODUCER SET isDeleted=1,UpdatedOn=GETUTCDATE()  WHERE ProducerId=@producerId
SELECT @producerId PRODUCERID  
   
END TRY      
BEGIN CATCH      
DECLARE @Message nvarchar(200)      
SET @Message=ERROR_MESSAGE()      
RAISERROR(@Message,16,1)      
END CATCH      
      
END
GO
/****** Object:  StoredProcedure [dbo].[GetActorDetails]    Script Date: 21-11-2022 19:47:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------SP--------------------------------      
--Date : 18-NOV-2022      
--Purpose : To Prepopulate Actor Detais for Editing
--Invoke : EXEC GetActorDetails 9
----------------------------------------------------------------      
CREATE PROC [dbo].[GetActorDetails](      
@actorId int  
)      
AS      
BEGIN      
BEGIN TRY     
  
IF NOT EXISTS(SELECT TOP 1 ActorId FROM Actor WHERE ActorId=@actorId AND isDeleted=0)  
BEGIN  
   RAISERROR('Invalid actorId/actor does not exist',16,1)  
END  
  
SELECT * from Actor where ActorId=@actorId AND isDeleted=0


END TRY      
BEGIN CATCH      
DECLARE @Message nvarchar(200)      
SET @Message=ERROR_MESSAGE()      
RAISERROR(@Message,16,1)      
END CATCH      
      
END
GO
/****** Object:  StoredProcedure [dbo].[GetActorList]    Script Date: 21-11-2022 19:47:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------SP--------------------------------      
--Date : 17-NOV-2022      
--Purpose : To fetch Actor list for Dropdown     
--Provoke : EXEC GetActorList ''    
----------------------------------------------------------------      
CREATE PROC [dbo].[GetActorList](      
@SearchText nvarchar(50) ='' 
)      
AS      
BEGIN      
BEGIN TRY      
    SELECT ACTORNAME AS Name,ActorId as Value from Actor where ActorName like '%'+@SearchText+'%'  AND IsDeleted=0
        
END TRY      
BEGIN CATCH      
DECLARE @Message nvarchar(200)      
SET @Message=ERROR_MESSAGE()      
RAISERROR(@Message,16,1)      
END CATCH      
      
END
GO
/****** Object:  StoredProcedure [dbo].[GetMovieDetails]    Script Date: 21-11-2022 19:47:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------SP--------------------------------      
--Date : 18-NOV-2022      
--Purpose : To Prepopulate Movie Detais
--Invoke : EXEC GetMovieDetails 3
----------------------------------------------------------------      
CREATE PROC [dbo].[GetMovieDetails](      
@movieId int  
)      
AS      
BEGIN      
BEGIN TRY     
  
IF NOT EXISTS(SELECT TOP 1 MovieId FROM MOVIE WHERE MovieId=@movieId AND isDeleted=0)  
BEGIN  
   RAISERROR('Invalid movieId/movie does not exist',16,1)  
END  
  
SELECT DISTINCT M.MOVIEID,M.NAME,M.RELEASEDATE,MP.ProducerId, PLOT,ProducerName FROM MOVIE M   
LEFT JOIN MovieActorMapping MA ON M.MovieId=MA.movieId AND MA.isDeleted=0  
LEFT JOIN MovieProducerMapping MP ON M.MovieId=MP.movieId AND MP.isDeleted=0  
INNER JOIN Producer P ON MP.ProducerId=P.ProducerId  
WHERE M.isDeleted=0 AND M.MovieId=@movieId

SELECT DISTINCT A.ActorId,A.ActorName From Movie M inner join MovieActorMapping MA on MA.MovieId=M.MovieId inner join Actor A on A.ActorId=MA.ActorId WHERE MA.movieId=@movieId AND mA.isDeleted=0
   
END TRY      
BEGIN CATCH      
DECLARE @Message nvarchar(200)      
SET @Message=ERROR_MESSAGE()      
RAISERROR(@Message,16,1)      
END CATCH      
      
END
GO
/****** Object:  StoredProcedure [dbo].[GetMoviesList]    Script Date: 21-11-2022 19:47:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------SP--------------------------------    
--Date : 18-NOV-2022    
--Purpose : To Fetch Movies list
--Invoke : EXEC GetMoviesList '1','20','','',''
----------------------------------------------------------------    
CREATE PROC [dbo].[GetMoviesList](    
@pageIndex int=null,
@pageSize int=null,
@searchText nvarchar(50)='',
@actorsFilter nvarchar(50)=null,
@producersFilter nvarchar(50)=null
)    
AS    
BEGIN    
BEGIN TRY  

IF @pageIndex IS NOT NULL AND @pageIndex=0
BEGIN
   RAISERROR('Invalid Page Size',16,1)
END

ELSE IF @pageIndex is not null
begin
   SET @pageIndex=@pageIndex-1
end

DECLARE @offsetSize INT = @pageIndex*@pageSize

CREATE TABLE #TempMovie(MovieId int,name nvarchar(50),ReleasedDate datetime,ActorId int,ProducerId int,plot nvarchar(100),ActorName nvarchar(50),ProducerName nvarchar(50))

INSERT INTO #TempMovie 
SELECT DISTINCT M.MOVIEID,M.NAME,M.RELEASEDATE,A.ACTORID,MP.ProducerId, PLOT,ActorName,ProducerName FROM MOVIE M 
LEFT JOIN MovieActorMapping MA ON M.MovieId=MA.movieId AND MA.isDeleted=0
LEFT JOIN MovieProducerMapping MP ON M.MovieId=MP.movieId AND MP.isDeleted=0
INNER JOIN Actor A ON MA.ActorId=A.ActorId
INNER JOIN Producer P ON MP.ProducerId=P.ProducerId
WHERE M.isDeleted=0 AND (M.Name LIKE '%'+@searchText+'%' OR ActorName LIKE '%'+@searchText+'%' OR ProducerName LIKE '%'+@searchText+'%')

IF(LEN(LTRIM(RTRIM(ISNULL(@actorsFilter,''))))>0)
BEGIN
   DELETE FROM #TempMovie WHERE ACTORID NOT IN(SELECT CONVERT(NVARCHAR,[VALUE]) FROM string_split(@actorsFilter,','))
END

IF(LEN(LTRIM(RTRIM(ISNULL(@producersFilter,''))))>0)
BEGIN
   DELETE FROM #TempMovie WHERE PRODUCERID NOT IN(SELECT CONVERT(NVARCHAR,[VALUE]) FROM string_split(@producersFilter,','))
END

IF(@offsetSize IS NULL)
BEGIN 
   SELECT DISTINCT MovieId,name,ReleasedDate,ProducerId,plot,ProducerName FROM #TempMovie order by MovieId asc
END

ELSE
BEGIN
    SELECT DISTINCT MovieId,name,ReleasedDate,ProducerId,plot,ProducerName FROM #TempMovie order by MovieId asc OFFSET @offsetSize ROWS FETCH NEXT @pageSize ROWs only
END

select DISTINCT MovieActorMapping.movieId,Actor.ActorName,Actor.ActorId from #TempMovie join MovieActorMapping on #TempMovie.MovieId=MovieActorMapping.movieId
inner join Actor on MovieActorMapping.ActorId=Actor.ActorId WHERE MovieActorMapping.isDeleted=0

select  COUNT (DISTINCT MOVIEID) TotalMovieCount from #TempMovie
 
END TRY    
BEGIN CATCH    
DECLARE @Message nvarchar(200)    
SET @Message=ERROR_MESSAGE()    
RAISERROR(@Message,16,1)    
END CATCH    
    
END
GO
/****** Object:  StoredProcedure [dbo].[GetProducerDetails]    Script Date: 21-11-2022 19:47:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------SP--------------------------------      
--Date : 18-NOV-2022      
--Purpose : To Prepopulate Producer Detais
--Invoke : EXEC GetProducerDetails 3
----------------------------------------------------------------      
CREATE PROC [dbo].[GetProducerDetails](      
@producerId int  
)      
AS      
BEGIN      
BEGIN TRY     
  
IF NOT EXISTS(SELECT TOP 1 ProducerId FROM Producer WHERE ProducerId=@producerId AND isDeleted=0)  
BEGIN  
   RAISERROR('Invalid producerId/producer does not exist',16,1)  
END  
  
SELECT * from Producer where ProducerId=@producerId AND isDeleted=0


END TRY      
BEGIN CATCH      
DECLARE @Message nvarchar(200)      
SET @Message=ERROR_MESSAGE()      
RAISERROR(@Message,16,1)      
END CATCH      
      
END
GO
/****** Object:  StoredProcedure [dbo].[GetProducerList]    Script Date: 21-11-2022 19:47:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------SP--------------------------------    
--Date : 17-NOV-2022    
--Purpose : To fetch Producer list for Dropdown   
--Provoke : EXEC GetProducerList ''  
----------------------------------------------------------------    
CREATE PROC [dbo].[GetProducerList](    
@SearchText nvarchar(50) = ''
)    
AS    
BEGIN    
BEGIN TRY    
    SELECT PRODUCERNAME AS Name,PRODUCERID as Value from PRODUCER where PRODUCERNAME like '%'+@SearchText+'%' AND ISDELETED=0
      
END TRY    
BEGIN CATCH    
DECLARE @Message nvarchar(200)    
SET @Message=ERROR_MESSAGE()    
RAISERROR(@Message,16,1)    
END CATCH    
    
END
GO
/****** Object:  StoredProcedure [dbo].[Test]    Script Date: 21-11-2022 19:47:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[Test]
As
Begin
   Select * from Persons
end
GO
USE [master]
GO
ALTER DATABASE [IMDB] SET  READ_WRITE 
GO
