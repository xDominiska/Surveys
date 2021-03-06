USE [master]
GO
/****** Object:  Database [Ankiety]    Script Date: 2013-10-07 03:13:42 ******/
CREATE DATABASE [Ankiety] ON  PRIMARY 
( NAME = N'Ankiety', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.SQLEXPRESS\MSSQL\DATA\Ankiety.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Ankiety_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.SQLEXPRESS\MSSQL\DATA\Ankiety_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Ankiety] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Ankiety].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Ankiety] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Ankiety] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Ankiety] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Ankiety] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Ankiety] SET ARITHABORT OFF 
GO
ALTER DATABASE [Ankiety] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Ankiety] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Ankiety] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Ankiety] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Ankiety] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Ankiety] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Ankiety] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Ankiety] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Ankiety] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Ankiety] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Ankiety] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Ankiety] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Ankiety] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Ankiety] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Ankiety] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Ankiety] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Ankiety] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Ankiety] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Ankiety] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Ankiety] SET  MULTI_USER 
GO
ALTER DATABASE [Ankiety] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Ankiety] SET DB_CHAINING OFF 
GO
USE [Ankiety]
GO
/****** Object:  Table [dbo].[Answers]    Script Date: 2013-10-07 03:13:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Answers](
	[Id] [int] NOT NULL,
	[AnswerTypeId] [int] NOT NULL,
	[NumberOfPossibilities] [int] NOT NULL,
	[QuestionId] [int] NOT NULL,
 CONSTRAINT [PK_Answers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AnswersTypes]    Script Date: 2013-10-07 03:13:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AnswersTypes](
	[Id] [int] NOT NULL,
	[Description] [varchar](50) NOT NULL,
 CONSTRAINT [PK_AnswersTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Options]    Script Date: 2013-10-07 03:13:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Options](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Text] [text] NOT NULL,
	[NextQuestionId] [int] NULL,
	[AnswerId] [int] NOT NULL,
 CONSTRAINT [PK_Options] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Patients]    Script Date: 2013-10-07 03:13:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Patients](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](10) NOT NULL,
	[UserId] [int] NOT NULL,
	[Guardian] [varchar](15) NOT NULL,
	[BirthDate] [datetime] NOT NULL,
	[Gender] [varchar](10) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Patients] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PatientsChoices]    Script Date: 2013-10-07 03:13:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientsChoices](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[AnswerId] [int] NOT NULL,
	[Answer] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_PatientsChoices] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PatientsQuestionnaires]    Script Date: 2013-10-07 03:13:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientsQuestionnaires](
	[PatientId] [int] NOT NULL,
	[QuestionnaireId] [int] NOT NULL,
	[FillingDate] [datetime] NOT NULL,
	[ExaminationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_PatientQuestionnaires] PRIMARY KEY CLUSTERED 
(
	[PatientId] ASC,
	[QuestionnaireId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Questionnaires]    Script Date: 2013-10-07 03:13:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Questionnaires](
	[Id] [int] NOT NULL,
	[Name] [varchar](30) NOT NULL,
 CONSTRAINT [PK_Questionnaires] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Questions]    Script Date: 2013-10-07 03:13:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Questions](
	[Id] [int] NOT NULL,
	[QuestionnaireId] [int] NOT NULL,
	[Text] [text] NOT NULL,
	[NumberOfAnswers] [int] NOT NULL,
 CONSTRAINT [PK_Questions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserProfile]    Script Date: 2013-10-07 03:13:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserProfile](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](max) NULL,
 CONSTRAINT [PK_UserProfile] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[webpages_Membership]    Script Date: 2013-10-07 03:13:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_Membership](
	[UserId] [int] NOT NULL,
	[CreateDate] [datetime] NULL,
	[ConfirmationToken] [nvarchar](128) NULL,
	[IsConfirmed] [bit] NULL,
	[LastPasswordFailureDate] [datetime] NULL,
	[PasswordFailuresSinceLastSuccess] [int] NOT NULL,
	[Password] [nvarchar](128) NOT NULL,
	[PasswordChangedDate] [datetime] NULL,
	[PasswordSalt] [nvarchar](128) NOT NULL,
	[PasswordVerificationToken] [nvarchar](128) NULL,
	[PasswordVerificationTokenExpirationDate] [datetime] NULL,
 CONSTRAINT [PK_webpages_Membership] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[webpages_OAuthMembership]    Script Date: 2013-10-07 03:13:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_OAuthMembership](
	[Provider] [nvarchar](30) NOT NULL,
	[ProviderUserId] [nvarchar](100) NOT NULL,
	[UserId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Provider] ASC,
	[ProviderUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[webpages_Roles]    Script Date: 2013-10-07 03:13:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](256) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[webpages_UsersInRoles]    Script Date: 2013-10-07 03:13:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[webpages_UsersInRoles](
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (10011, 1, 2, 1001)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (10021, 1, 2, 1002)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (10031, 1, 2, 1003)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (10041, 1, 2, 1004)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (10051, 1, 2, 1005)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (10061, 1, 2, 1006)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (10071, 1, 2, 1007)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (10081, 1, 2, 1008)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (10091, 1, 2, 1009)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (10101, 1, 2, 1010)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (10111, 1, 2, 1011)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (15011, 1, 2, 1501)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (15021, 1, 2, 1502)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (15031, 1, 2, 1503)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (15041, 1, 2, 1504)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (15051, 1, 2, 1505)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (15061, 1, 2, 1506)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (15071, 1, 2, 1507)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (15081, 1, 2, 1508)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (15091, 1, 2, 1509)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (15101, 1, 2, 1510)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (15111, 1, 2, 1511)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (20011, 1, 2, 2001)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (20021, 1, 2, 2002)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (20031, 1, 2, 2003)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (20041, 1, 2, 2004)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (20051, 1, 2, 2005)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (20061, 1, 2, 2006)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (20071, 3, 8, 2007)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (20081, 3, 15, 2008)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (20091, 3, 4, 2009)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (20101, 3, 12, 2010)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (20111, 5, 0, 2011)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (20112, 5, 0, 2011)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (20121, 1, 2, 2012)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (20131, 1, 2, 2013)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (20141, 5, 0, 2014)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (20151, 1, 2, 2015)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (20161, 1, 2, 2016)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (20171, 1, 2, 2017)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (20181, 1, 2, 2018)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (20191, 3, 5, 2019)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (20192, 3, 5, 2019)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (20201, 1, 2, 2020)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (20211, 1, 2, 2021)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (20221, 1, 2, 2022)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (20231, 1, 2, 2023)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (20241, 1, 2, 2024)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (25011, 1, 2, 2501)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (25021, 1, 2, 2502)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (25022, 5, 0, 2502)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (25023, 5, 0, 2502)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (25031, 1, 2, 2503)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (25032, 4, 0, 2503)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (25041, 3, 10, 2504)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (25042, 5, 0, 2504)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (25043, 4, 0, 2504)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (25051, 1, 2, 2505)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (25061, 1, 2, 2506)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (25201, 1, 2, 2520)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (25211, 5, 0, 2521)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (25212, 5, 0, 2521)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (25213, 5, 0, 2521)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (25214, 5, 0, 2521)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (25215, 5, 0, 2521)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (25221, 5, 0, 2522)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (25222, 5, 0, 2522)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (25223, 5, 0, 2522)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (25224, 5, 0, 2522)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (25225, 5, 0, 2522)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (25231, 4, 0, 2523)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (25232, 4, 0, 2523)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (25233, 4, 0, 2523)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (25234, 4, 0, 2523)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (25235, 4, 0, 2523)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (25241, 4, 0, 2524)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (25242, 4, 0, 2524)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (25243, 4, 0, 2524)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (25244, 4, 0, 2524)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (25245, 4, 0, 2524)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (30011, 4, 0, 3001)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (30021, 1, 2, 3002)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (30031, 1, 2, 3003)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (30041, 1, 2, 3004)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (40011, 5, 0, 4001)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (40021, 5, 0, 4002)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (40031, 5, 0, 4003)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (40041, 5, 0, 4004)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (40051, 5, 0, 4005)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (40061, 5, 0, 4006)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (40071, 5, 0, 4007)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (40081, 5, 0, 4008)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (40091, 5, 0, 4009)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (40101, 5, 0, 4010)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (50011, 5, 0, 5001)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (50012, 5, 0, 5001)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (50021, 3, 2, 5002)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (50031, 1, 2, 5003)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (50041, 5, 0, 5004)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (50051, 3, 5, 5005)
GO
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (50061, 4, 0, 5006)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (50071, 4, 0, 5007)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (50081, 4, 0, 5008)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (50091, 4, 0, 5009)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (50101, 4, 0, 5010)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (50121, 4, 0, 5012)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (50131, 4, 0, 5013)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (50141, 4, 9, 5014)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (50171, 4, 0, 5011)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (55031, 4, 0, 5503)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (55032, 4, 0, 5503)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (60011, 3, 2, 6001)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (60021, 1, 2, 6002)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (60031, 4, 0, 6003)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (60032, 4, 0, 6003)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (60041, 4, 0, 6004)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (60042, 4, 0, 6004)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (60043, 4, 0, 6004)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (60044, 4, 0, 6004)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (60045, 4, 0, 6004)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (60051, 3, 4, 6005)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (65021, 4, 0, 6502)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (70011, 4, 0, 7001)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (70012, 4, 0, 7001)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (70013, 4, 0, 7001)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (70014, 4, 0, 7001)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (70015, 4, 0, 7001)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (70021, 3, 4, 7002)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (70031, 4, 0, 7003)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (70032, 4, 0, 7003)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (70033, 4, 0, 7003)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (80011, 1, 2, 8001)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (80021, 3, 3, 8002)
INSERT [dbo].[Answers] ([Id], [AnswerTypeId], [NumberOfPossibilities], [QuestionId]) VALUES (85011, 4, 0, 8501)
INSERT [dbo].[AnswersTypes] ([Id], [Description]) VALUES (1, N'RadioButton')
INSERT [dbo].[AnswersTypes] ([Id], [Description]) VALUES (2, N'CheckBox')
INSERT [dbo].[AnswersTypes] ([Id], [Description]) VALUES (3, N'ComboBox')
INSERT [dbo].[AnswersTypes] ([Id], [Description]) VALUES (4, N'Text')
INSERT [dbo].[AnswersTypes] ([Id], [Description]) VALUES (5, N'Number')
SET IDENTITY_INSERT [dbo].[Options] ON 

INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (1, N'Tak', 1501, 10011)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (2, N'Nie', NULL, 10011)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (3, N'Aktualnie', NULL, 15011)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (4, N'W wywiadzie', NULL, 15011)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (5, N'Tak', 1502, 10021)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (6, N'Nie', NULL, 10021)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (7, N'Aktualnie', NULL, 15021)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (8, N'W wywiadzie', NULL, 15021)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (9, N'Tak', 1503, 10031)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (10, N'Nie', NULL, 10031)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (11, N'Aktualnie', NULL, 15031)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (12, N'W wywiadzie', NULL, 15031)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (13, N'Tak', 1504, 10041)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (14, N'Nie', NULL, 10041)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (15, N'Aktualnie', NULL, 15041)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (16, N'W wywiadzie', NULL, 15041)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (17, N'Tak', 1505, 10051)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (18, N'Nie', NULL, 10051)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (19, N'Aktualnie', NULL, 15051)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (20, N'W wywiadzie', NULL, 15051)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (21, N'Tak', 1506, 10061)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (22, N'Nie', NULL, 10061)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (23, N'Aktualnie', NULL, 15061)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (24, N'W wywiadzie', NULL, 15061)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (25, N'Tak', 1507, 10071)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (26, N'Nie', NULL, 10071)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (27, N'Aktualnie', NULL, 15071)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (28, N'W wywiadzie', NULL, 15071)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (29, N'Tak', 1508, 10081)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (30, N'Nie', NULL, 10081)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (31, N'Aktualnie', NULL, 15081)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (32, N'W wywiadzie', NULL, 15081)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (33, N'Tak', 1509, 10091)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (34, N'Nie', NULL, 10091)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (35, N'Aktualnie', NULL, 15091)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (36, N'W wywiadzie', NULL, 15091)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (37, N'Tak', 1510, 10101)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (38, N'Nie', NULL, 10101)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (39, N'Aktualnie', NULL, 15101)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (40, N'W wywiadzie', NULL, 15101)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (41, N'Tak', 1511, 10111)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (42, N'Nie', NULL, 10111)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (43, N'Aktualnie', NULL, 15111)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (44, N'W wywiadzie', NULL, 15111)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (45, N'Tak', 2501, 20011)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (46, N'Nie', NULL, 20011)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (47, N'Aktualnie', NULL, 25011)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (48, N'W wywiadzie', NULL, 25011)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (49, N'Tak', 2502, 20021)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (50, N'Nie', NULL, 20021)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (51, N'Aktualnie', NULL, 25021)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (52, N'W wywiadzie', NULL, 25021)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (53, N'Ile razy w ciągu życia?', NULL, 25022)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (54, N'Ile razy w ciągu roku?', NULL, 25023)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (55, N'Tak', 2503, 20031)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (56, N'Nie', NULL, 20031)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (58, N'Aktualnie', NULL, 25031)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (59, N'W Wywiadzie', NULL, 25031)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (61, N'Tak', 2504, 20041)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (62, N'Nie', NULL, 20041)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (64, N'1', NULL, 25041)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (67, N'2', NULL, 25041)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (68, N'3', NULL, 25041)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (69, N'4', NULL, 25041)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (70, N'5', NULL, 25041)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (71, N'6', NULL, 25041)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (72, N'7', NULL, 25041)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (73, N'8', NULL, 25041)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (74, N'9', NULL, 25041)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (75, N'10', NULL, 25041)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (76, N'Tak', 2505, 20051)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (77, N'Nie', NULL, 20051)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (78, N'Aktualnie', NULL, 25051)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (79, N'W wywiadzie', NULL, 25051)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (80, N'Tak', 2506, 20061)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (81, N'Nie', NULL, 20061)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (82, N'Aktualnie', NULL, 25061)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (83, N'W wywiadzie', NULL, 25061)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (84, N'0', NULL, 20071)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (85, N'1', NULL, 20071)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (86, N'2', NULL, 20071)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (87, N'3', NULL, 20071)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (88, N'4', NULL, 20071)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (89, N'5', NULL, 20071)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (90, N'6', NULL, 20071)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (91, N'7', NULL, 20071)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (93, N'0', NULL, 20081)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (95, N'1', NULL, 20081)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (96, N'2', NULL, 20081)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (97, N'3', NULL, 20081)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (98, N'4', NULL, 20081)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (99, N'5', NULL, 20081)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (100, N'6', NULL, 20081)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (101, N'7', NULL, 20081)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (102, N'8', NULL, 20081)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (103, N'9', NULL, 20081)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (104, N'10', NULL, 20081)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (105, N'11', NULL, 20081)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (106, N'12', NULL, 20081)
GO
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (108, N'13', NULL, 20081)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (109, N'14', NULL, 20081)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (110, N'0', NULL, 20091)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (111, N'1', NULL, 20091)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (113, N'2 i więcej', NULL, 20091)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (115, N'0', NULL, 20101)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (116, N'1', NULL, 20101)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (117, N'2', NULL, 20101)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (118, N'3', NULL, 20101)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (119, N'4', NULL, 20101)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (120, N'5', NULL, 20101)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (121, N'6', NULL, 20101)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (122, N'7', NULL, 20101)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (123, N'8', NULL, 20101)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (124, N'9', NULL, 20101)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (125, N'10 i więcej', NULL, 20101)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (127, N'Tak', NULL, 20121)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (128, N'Nie', NULL, 20121)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (129, N'Tak', NULL, 20131)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (130, N'Nie', NULL, 20131)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (131, N'Tak', NULL, 20151)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (132, N'Nie', NULL, 20151)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (133, N'Tak', NULL, 20161)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (134, N'Nie', NULL, 20161)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (135, N'Tak', NULL, 20171)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (136, N'Nie', NULL, 20171)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (137, N'Tak', NULL, 20181)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (138, N'Nie', NULL, 20181)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (139, N'19', NULL, 20191)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (140, N'20', NULL, 20191)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (141, N'21', NULL, 20191)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (142, N'22', NULL, 20191)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (143, N'23', NULL, 20191)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (144, N'5', NULL, 20192)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (145, N'6', NULL, 20192)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (146, N'7', NULL, 20192)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (147, N'8', NULL, 20192)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (148, N'9', NULL, 20192)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (149, N'Tak', 2520, 20201)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (150, N'Nie', NULL, 20201)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (151, N'Tak', NULL, 25201)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (152, N'Nie', NULL, 25201)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (153, N'Tak', 2521, 20211)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (154, N'Nie', NULL, 20211)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (155, N'Tak', 2522, 20221)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (156, N'Nie', NULL, 20221)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (157, N'Matka', NULL, 25211)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (158, N'Ojciec', NULL, 25212)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (159, N'Młodsze rodzeństwo', NULL, 25213)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (160, N'Starsze rodzeństwo', NULL, 25214)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (161, N'Dalsza rodzina', NULL, 25215)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (162, N'Matka', NULL, 25221)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (163, N'Ojciec', NULL, 25222)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (164, N'Młodsze rodzeństwo', NULL, 25223)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (165, N'Starsze rodzeństwo', NULL, 25224)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (166, N'Dalsza rodzina', NULL, 25225)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (167, N'Tak', 2523, 20231)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (168, N'Nie', NULL, 20231)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (169, N'Tak', 2524, 20241)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (170, N'Nie', NULL, 20241)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (171, N'Prawidłowe', NULL, 30021)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (172, N'Nieprawidłowe', NULL, 30021)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (173, N'Prawidłowe', NULL, 30031)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (174, N'Nieprawidłowe', NULL, 30031)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (175, N'Prawidłowe', NULL, 30041)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (176, N'Nieprawidłowe', NULL, 30041)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (177, N'Jakie?', NULL, 25032)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (178, N'Tydzień porodu', NULL, 25042)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (179, N'Jakie?', NULL, 25043)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (181, N'Hormon antydiuretyczny', NULL, 25231)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (182, N'Leki antycholinergiczne', NULL, 25232)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (183, N'Alfablokery', NULL, 25233)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (184, N'Imipramina', NULL, 25234)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (185, N'Inne', NULL, 25235)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (186, N'Hormon antydiuretyczny', NULL, 25241)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (187, N'Leki antycholinergiczne', NULL, 25242)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (188, N'Alfablokery', NULL, 25243)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (189, N'Imipramina', NULL, 25244)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (190, N'Inne', NULL, 25245)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (193, N'NP [cm]', NULL, 50011)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (194, N'NL [cm]', NULL, 50012)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (195, N'Prawidłowe', NULL, 50021)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (197, N'Nieprawidłowe', NULL, 50021)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (198, N'Tak', 5503, 50031)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (199, N'Nie', NULL, 50031)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (200, N'a-p miedniczki', NULL, 55031)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (201, N'kielichów', NULL, 55032)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (202, N'niemonosymptomatyczne moczenie nocne', NULL, 60011)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (203, N'izolowane nietrzymanie moczu w dzień', NULL, 60011)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (204, N'Tak', 6502, 60021)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (205, N'Nie', NULL, 60021)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (206, N'CUM', NULL, 60031)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (207, N'urodynamika', NULL, 60032)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (208, N'Hormon antydiuretyczny', NULL, 60041)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (209, N'Leki antycholinergiczne', NULL, 60042)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (210, N'Alfablokery', NULL, 60043)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (211, N'Imipramina', NULL, 60044)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (212, N'Inne', NULL, 60045)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (213, N'Sukces kliniczny (100%)', NULL, 60051)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (214, N'Dobra odpowiedź kliniczna (powyżej 90%)', NULL, 60051)
GO
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (215, N'Częściowa odpowiedź kliniczna (50%-80%)', NULL, 60051)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (216, N'Brak odpowiedzi na leczenie (poniżej 50%)', NULL, 60051)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (217, N'Hormon antydiuretyczny', NULL, 70011)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (218, N'Leki antycholinergiczne', NULL, 70012)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (219, N'Alfablokery', NULL, 70013)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (220, N'Imipramina', NULL, 70014)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (221, N'Inne', NULL, 70015)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (228, N'Sukces kliniczny (100%)', NULL, 70021)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (229, N'Dobra odpowiedź kliniczna (powyżej 90%)', NULL, 70021)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (230, N'Częściowa odpowiedź kliniczna (50%-80%)', NULL, 70021)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (231, N'Brak odpowiedzi na leczenie (poniżej 50%)', NULL, 70021)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (232, N'Badanie urodynamiczne', NULL, 70031)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (233, N'CUM', NULL, 70032)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (234, N'Inne', NULL, 70033)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (235, N'Tak', NULL, 80011)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (236, N'Nie', NULL, 80011)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (237, N'Nazwa i dawka', NULL, 85011)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (242, N'Sukces nie utrwalony (nawrót poniżej 1 miesiąca)', NULL, 80021)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (243, N'Sukces utrwalony (brak nawrotów w ciągu 6 miesięcy po zakończeniu leczenia)', NULL, 80021)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (244, N'Całkowity sukces (brak nawrotu powyżej roku od zakończenia leczenia)', NULL, 80021)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (245, N'dzień', NULL, 20111)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (246, N'noc', NULL, 20112)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (247, N'dzwonek', NULL, 50051)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (248, N'wieża', NULL, 50051)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (249, N'plateau', NULL, 50051)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (250, N'nieregularna', NULL, 50051)
INSERT [dbo].[Options] ([Id], [Text], [NextQuestionId], [AnswerId]) VALUES (251, N'przerywana', NULL, 50051)
SET IDENTITY_INSERT [dbo].[Options] OFF
INSERT [dbo].[Questionnaires] ([Id], [Name]) VALUES (1, N'Wywiad1')
INSERT [dbo].[Questionnaires] ([Id], [Name]) VALUES (2, N'Wywiad2')
INSERT [dbo].[Questionnaires] ([Id], [Name]) VALUES (3, N'Fizykalne')
INSERT [dbo].[Questionnaires] ([Id], [Name]) VALUES (4, N'Laboratoryjne')
INSERT [dbo].[Questionnaires] ([Id], [Name]) VALUES (5, N'Obrazowe')
INSERT [dbo].[Questionnaires] ([Id], [Name]) VALUES (6, N'Aplikacja6A')
INSERT [dbo].[Questionnaires] ([Id], [Name]) VALUES (7, N'Aplikacja6B')
INSERT [dbo].[Questionnaires] ([Id], [Name]) VALUES (8, N'Aplikacja12')
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (1001, 1, N'1. Zwiększona/zmniejeszona częstość oddawania moczu?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (1002, 1, N'2. Nietrzymanie moczu w dzień?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (1003, 1, N'3. Parcia naglące?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (1004, 1, N'4. Trudności w rozpoczęciu mikcji?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (1005, 1, N'5.Mikcja przy użyciu tłoczni brzusznej?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (1006, 1, N'6. Słaby stumień moczu?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (1007, 1, N'7. Mikcja przerywana?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (1008, 1, N'8. Objawy zaciskania?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (1009, 1, N'9. Uczucie niepełnego opróżnienia pęcherza?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (1010, 1, N'10. Kropelkowy wyciek moczu po mikcji?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (1011, 1, N'11. Bóle ze strony układu moczowego oraz rodnego?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (1501, 1, N'Kiedy?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (1502, 1, N'Kiedy?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (1503, 1, N'Kiedy?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (1504, 1, N'Kiedy?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (1505, 1, N'Kiedy?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (1506, 1, N'Kiedy?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (1507, 1, N'Kiedy?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (1508, 1, N'Kiedy?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (1509, 1, N'Kiedy?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (1510, 1, N'Kiedy?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (1511, 1, N'Kiedy?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2001, 2, N'12. Zaparcia?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2002, 2, N'13. Zakażenia układu moczowego?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2003, 2, N'14. Przebyte choroby w tym operacja w obrębie jamy brzusznej?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2004, 2, N'15. Obciążenia okołoporodowe?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2005, 2, N'16. Urazy psychiczne?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2006, 2, N'17. Zaburzenia zachowania?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2007, 2, N'18. Liczba mokrych nocy/tydz. w ciągu 2 tygodniowej obserwacji', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2008, 2, N'19. Liczba epizodów nykturii w ciągu 2 tyg. obserwacji', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2009, 2, N'20. Ilość epizodów moczenia na noc', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2010, 2, N'21. Liczba mikcji na dobę', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2011, 2, N'22. Ocena diurezy dziennej do nocnej w ml DZIEŃ/NOC. Za nocną objętość moczu uważa się sumę ilości moczu oddanego w czasie godzin nocnych (do pieluszki, oddanego w trakcie wybudzania lub w trakcie nykturii) oraz ilość moczu z pierwszej porannej porcji.', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2012, 2, N'23.1 Czy ograniczenie płynów przynosi efekt w postaci mniejszej liczby mokrych dni?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2013, 2, N'23.2 Czy ograniczenie płynów przynosi efekt w postaci mniejszej objętości moczenia?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2014, 2, N'24. Pojemność pęcherza: maksymalna objętość mikcji odczytana z kontrolki mikcji w ml', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2015, 2, N'25.1 Ocena jakości snu. Czy dziecko budzi się po zmoczeniu?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2016, 2, N'25.2 Czy dziecko śpi niespokojnie?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2017, 2, N'25.3 Czy dziecko ma trudności z wybudzaniem się?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2018, 2, N'25.4 Czy dziecko lunatykuje?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2019, 2, N'26. Godzina rozpoczęcia i zakończenia snu:', 2)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2020, 2, N'27. Czy jest budzone w celu oprócznienia pęcherza?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2021, 2, N'28. Wywiad rodzinny w kierunku moczenia monosymptomatycznego.', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2022, 2, N'29. Wywiad rodzinny w kierunku objawów LUTS! (Jak na początku ankiety zarówno aktualnie jak i w wywiadzie.)', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2023, 2, N'30. Próby leczenia farmakologicznegon zaburzeń oddawania moczu.', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2024, 2, N'31. Stosowane leczenie z powodu innych chorób.', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2501, 2, N'Kiedy?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2502, 2, N'Kiedy?', 3)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2503, 2, N'Kiedy?', 2)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2504, 2, N'pkt wg Apgar', 3)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2505, 2, N'Kiedy?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2506, 2, N'Kiedy?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2520, 2, N'Z jakim efektem? (Czy moczy się powtórnie?)', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2521, 2, N'Kto i do jakiego wieku moczył się?', 5)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2522, 2, N'Kto i do jakiego wieku prezentował nieprawidłowe objawy?', 5)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2523, 2, N'Wymień nazwy leków.', 5)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (2524, 2, N'Wymień nazwy leków.', 5)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (3001, 3, N'1. Odchylenia w zakresie zewnętrznych narządów płciowych.', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (3002, 3, N'2. Ocena czucia w kroczu', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (3003, 3, N'3. Ocena chodu', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (3004, 3, N'4. Ocena okolicy krzyżowo ogonowej', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (4001, 4, N'1. Hematokryt (morfologia)', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (4002, 4, N'2. Kreatynina [mg%]', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (4003, 4, N'3.1 Elektrolity: Na', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (4004, 4, N'3.2 Ca', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (4005, 4, N'4. Glukoza', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (4006, 4, N'5. Osmolalność moczu po nocy (po co najmniej 12 godznnym okresie nie przyjmowania płynów)', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (4007, 4, N'6.1 Ocena dobowego wydalania moczu: DZM [ml]', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (4008, 4, N'6.2 Ca [mmol/l]', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (4009, 4, N'6.3 Na [mmol/l]', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (4010, 4, N'6.4 kreatynina [g/l]', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (5001, 5, N'1.1 USG: ocena wielkości nerek', 2)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (5002, 5, N'1.2 zróżnicowania korowo-rdzeniowego', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (5003, 5, N'1.3 poszerzenia UKM-ów', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (5004, 5, N'1.4 zaleganie po mikcji [ml]', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (5005, 5, N'2.1 UROFLOWMETRIA: krzywa', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (5006, 5, N'2.2 Maksymalne tempo przepływu', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (5007, 5, N'2.3 Średnie tempo przepływu', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (5008, 5, N'2.4 Czas mikcji', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (5009, 5, N'2.5 Czas do maksymalnego przepływu', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (5010, 5, N'2.6 Objętość mikcji', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (5011, 5, N'2.7 Zaleganie', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (5012, 5, N'2.8 Grubość ściany pęcherza przed mikcją', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (5013, 5, N'2.9 Grubość ściany pęcherza po mikcji', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (5014, 5, N'3. ABPM: parametry', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (5503, 5, N'wymiary', 2)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (6001, 6, N'1. Rozpoznanie', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (6002, 6, N'2.1 Odchylenia w badaniach laboratoryjnych?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (6003, 6, N'2.2 Odchylenia w badaniach obrazowych', 2)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (6004, 6, N'3. Zastosowane leczenie', 5)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (6005, 6, N'4. Efekty terapeutyczne', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (6502, 6, N'Jakie?', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (7001, 7, N'1. Leczenie', 5)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (7002, 7, N'2. Efekty terapeutyczne', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (7003, 7, N'3. Dalsze leczenie', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (8001, 8, N'1. Aktualnie stosowane leczenie', 5)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (8002, 8, N'2. Długotrwały efekt terapeutyczny', 1)
INSERT [dbo].[Questions] ([Id], [QuestionnaireId], [Text], [NumberOfAnswers]) VALUES (8501, 8, N'Jakie?', 1)
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__webpages__8A2B61606AEFE058]    Script Date: 2013-10-07 03:13:42 ******/
ALTER TABLE [dbo].[webpages_Roles] ADD UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Patients] ADD  CONSTRAINT [DF_Patients_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[webpages_Membership] ADD  DEFAULT ((0)) FOR [IsConfirmed]
GO
ALTER TABLE [dbo].[webpages_Membership] ADD  DEFAULT ((0)) FOR [PasswordFailuresSinceLastSuccess]
GO
ALTER TABLE [dbo].[Answers]  WITH CHECK ADD  CONSTRAINT [FK_Answers_AnswersTypes] FOREIGN KEY([AnswerTypeId])
REFERENCES [dbo].[AnswersTypes] ([Id])
GO
ALTER TABLE [dbo].[Answers] CHECK CONSTRAINT [FK_Answers_AnswersTypes]
GO
ALTER TABLE [dbo].[Answers]  WITH CHECK ADD  CONSTRAINT [FK_Answers_Questions] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Questions] ([Id])
GO
ALTER TABLE [dbo].[Answers] CHECK CONSTRAINT [FK_Answers_Questions]
GO
ALTER TABLE [dbo].[Options]  WITH CHECK ADD  CONSTRAINT [FK_Options_Answers] FOREIGN KEY([AnswerId])
REFERENCES [dbo].[Answers] ([Id])
GO
ALTER TABLE [dbo].[Options] CHECK CONSTRAINT [FK_Options_Answers]
GO
ALTER TABLE [dbo].[Options]  WITH CHECK ADD  CONSTRAINT [FK_Options_Questions] FOREIGN KEY([NextQuestionId])
REFERENCES [dbo].[Questions] ([Id])
GO
ALTER TABLE [dbo].[Options] CHECK CONSTRAINT [FK_Options_Questions]
GO
ALTER TABLE [dbo].[Patients]  WITH CHECK ADD  CONSTRAINT [FK_Patients_UserProfile] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserProfile] ([UserId])
GO
ALTER TABLE [dbo].[Patients] CHECK CONSTRAINT [FK_Patients_UserProfile]
GO
ALTER TABLE [dbo].[PatientsChoices]  WITH CHECK ADD  CONSTRAINT [FK_PatientsChoices_Answers] FOREIGN KEY([AnswerId])
REFERENCES [dbo].[Answers] ([Id])
GO
ALTER TABLE [dbo].[PatientsChoices] CHECK CONSTRAINT [FK_PatientsChoices_Answers]
GO
ALTER TABLE [dbo].[PatientsChoices]  WITH CHECK ADD  CONSTRAINT [FK_PatientsChoices_Patients] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patients] ([Id])
GO
ALTER TABLE [dbo].[PatientsChoices] CHECK CONSTRAINT [FK_PatientsChoices_Patients]
GO
ALTER TABLE [dbo].[PatientsQuestionnaires]  WITH CHECK ADD  CONSTRAINT [FK_PatientsQuestionnaires_Patients] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patients] ([Id])
GO
ALTER TABLE [dbo].[PatientsQuestionnaires] CHECK CONSTRAINT [FK_PatientsQuestionnaires_Patients]
GO
ALTER TABLE [dbo].[PatientsQuestionnaires]  WITH CHECK ADD  CONSTRAINT [FK_PatientsQuestionnaires_Questionnaires] FOREIGN KEY([QuestionnaireId])
REFERENCES [dbo].[Questionnaires] ([Id])
GO
ALTER TABLE [dbo].[PatientsQuestionnaires] CHECK CONSTRAINT [FK_PatientsQuestionnaires_Questionnaires]
GO
ALTER TABLE [dbo].[Questions]  WITH CHECK ADD  CONSTRAINT [FK_Questions_Questionnaires] FOREIGN KEY([QuestionnaireId])
REFERENCES [dbo].[Questionnaires] ([Id])
GO
ALTER TABLE [dbo].[Questions] CHECK CONSTRAINT [FK_Questions_Questionnaires]
GO
ALTER TABLE [dbo].[webpages_Membership]  WITH CHECK ADD  CONSTRAINT [FK_webpages_Membership_UserProfile] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserProfile] ([UserId])
GO
ALTER TABLE [dbo].[webpages_Membership] CHECK CONSTRAINT [FK_webpages_Membership_UserProfile]
GO
ALTER TABLE [dbo].[webpages_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [fk_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[webpages_Roles] ([RoleId])
GO
ALTER TABLE [dbo].[webpages_UsersInRoles] CHECK CONSTRAINT [fk_RoleId]
GO
ALTER TABLE [dbo].[webpages_UsersInRoles]  WITH CHECK ADD  CONSTRAINT [fk_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserProfile] ([UserId])
GO
ALTER TABLE [dbo].[webpages_UsersInRoles] CHECK CONSTRAINT [fk_UserId]
GO
USE [master]
GO
ALTER DATABASE [Ankiety] SET  READ_WRITE 
GO
