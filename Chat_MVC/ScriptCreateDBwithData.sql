USE [master]
GO
/****** Object:  Database [ChatReenbit]    Script Date: 25.08.2022 19:05:08 ******/
CREATE DATABASE [ChatReenbit]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ChatReenbit', FILENAME = N'D:\programs\ms sql\MSSQL15.SQLEXPRESS\MSSQL\DATA\ChatReenbit.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ChatReenbit_log', FILENAME = N'D:\programs\ms sql\MSSQL15.SQLEXPRESS\MSSQL\DATA\ChatReenbit.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [ChatReenbit] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ChatReenbit].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ChatReenbit] SET ANSI_NULL_DEFAULT ON 
GO
ALTER DATABASE [ChatReenbit] SET ANSI_NULLS ON 
GO
ALTER DATABASE [ChatReenbit] SET ANSI_PADDING ON 
GO
ALTER DATABASE [ChatReenbit] SET ANSI_WARNINGS ON 
GO
ALTER DATABASE [ChatReenbit] SET ARITHABORT ON 
GO
ALTER DATABASE [ChatReenbit] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ChatReenbit] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ChatReenbit] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ChatReenbit] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ChatReenbit] SET CURSOR_DEFAULT  LOCAL 
GO
ALTER DATABASE [ChatReenbit] SET CONCAT_NULL_YIELDS_NULL ON 
GO
ALTER DATABASE [ChatReenbit] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ChatReenbit] SET QUOTED_IDENTIFIER ON 
GO
ALTER DATABASE [ChatReenbit] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ChatReenbit] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ChatReenbit] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ChatReenbit] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ChatReenbit] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ChatReenbit] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ChatReenbit] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ChatReenbit] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ChatReenbit] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ChatReenbit] SET RECOVERY FULL 
GO
ALTER DATABASE [ChatReenbit] SET  MULTI_USER 
GO
ALTER DATABASE [ChatReenbit] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ChatReenbit] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ChatReenbit] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ChatReenbit] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ChatReenbit] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ChatReenbit] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [ChatReenbit] SET QUERY_STORE = OFF
GO
USE [ChatReenbit]
GO
/****** Object:  Table [dbo].[Chats]    Script Date: 25.08.2022 19:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chats](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[IsGroup] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Messages]    Script Date: 25.08.2022 19:05:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messages](
	[Id] [int] IDENTITY(0,1) NOT NULL,
	[Date] [smalldatetime] NOT NULL,
	[Text] [nvarchar](max) NOT NULL,
	[IdSender] [int] NOT NULL,
	[ChatId] [int] NOT NULL,
	[IsVisible] [bit] NOT NULL,
	[WithAnswer] [bit] NOT NULL,
	[AnswerText] [nvarchar](max) NULL,
	[Edited] [bit] NOT NULL,
 CONSTRAINT [PK_Messages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[Chats] ([Id], [Name], [IsGroup]) VALUES (0, N'Group', 1)
INSERT [dbo].[Chats] ([Id], [Name], [IsGroup]) VALUES (1, N'Max', 0)
INSERT [dbo].[Chats] ([Id], [Name], [IsGroup]) VALUES (2, N'Maxim', 0)
INSERT [dbo].[Chats] ([Id], [Name], [IsGroup]) VALUES (3, N'Oleg', 0)
INSERT [dbo].[Chats] ([Id], [Name], [IsGroup]) VALUES (4, N'Group2', 1)
INSERT [dbo].[Chats] ([Id], [Name], [IsGroup]) VALUES (5, N'Yaroslav', 0)
GO
SET IDENTITY_INSERT [dbo].[Messages] ON 

INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (76, CAST(N'2022-08-24T16:05:00' AS SmallDateTime), N'Первая группа, всем привет!', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (77, CAST(N'2022-08-24T16:05:00' AS SmallDateTime), N'Привет Ярик, я Максим!', 1, 0, 1, 1, N'Yaroslav:Первая группа, всем привет!', 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (78, CAST(N'2022-08-24T16:06:00' AS SmallDateTime), N'Всем привет, я Олег!', 3, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (79, CAST(N'2022-08-24T16:06:00' AS SmallDateTime), N'Тебя реально олег зовут?', 2, 3, 1, 1, N'Oleg:Всем привет, я Олег!', 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (80, CAST(N'2022-08-24T16:17:00' AS SmallDateTime), N'Короче анекдот! Плюс в чат кому в лс ответить, жду', 5, 0, 1, 1, N'Oleg:Всем привет, я Олег!', 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (81, CAST(N'2022-08-24T16:17:00' AS SmallDateTime), N'Что за анекдот то??', 3, 5, 1, 1, N'Yaroslav:Короче анекдот! Плюс в чат кому в лс ответить, жду', 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (82, CAST(N'2022-08-24T16:17:00' AS SmallDateTime), N'++++++', 1, 0, 1, 1, N'Yaroslav:Короче анекдот! Плюс в чат кому в лс ответить, жду', 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (83, CAST(N'2022-08-24T16:17:00' AS SmallDateTime), N'Та это шутка была ', 5, 1, 1, 1, N'Max:++++++', 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (84, CAST(N'2022-08-24T16:18:00' AS SmallDateTime), N'Крутой анекдот', 1, 5, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (85, CAST(N'2022-08-24T16:18:00' AS SmallDateTime), N'Забыл уже', 5, 3, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (86, CAST(N'2022-08-24T16:18:00' AS SmallDateTime), N'Поговорю пожалуй с умным человеком', 5, 5, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (87, CAST(N'2022-08-24T16:18:00' AS SmallDateTime), N'Тогда почему пишешь сюда?))))', 5, 5, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (88, CAST(N'2022-08-24T16:19:00' AS SmallDateTime), N'Спасибо. Лан, Макс. Я сейчас напишу смс и удалю только у себя, ок?', 5, 1, 0, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (90, CAST(N'2022-08-24T16:20:00' AS SmallDateTime), N'Крч пишу смс и удаляю Только для себя)', 3, 0, 0, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (91, CAST(N'2022-08-24T16:20:00' AS SmallDateTime), N'молодец, но нам то видно)', 1, 0, 1, 1, N'Oleg:Крч пишу смс и удаляю Только для себя)', 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (93, CAST(N'2022-08-24T16:22:00' AS SmallDateTime), N'Я проверяю проект или у меня шиза и я говорю сам с собой?', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (94, CAST(N'2022-08-24T16:22:00' AS SmallDateTime), N'похоже на то)', 2, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (95, CAST(N'2022-08-24T16:39:00' AS SmallDateTime), N'10', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (96, CAST(N'2022-08-24T16:39:00' AS SmallDateTime), N'11', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (97, CAST(N'2022-08-24T16:39:00' AS SmallDateTime), N'12', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (98, CAST(N'2022-08-24T16:39:00' AS SmallDateTime), N'13', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (99, CAST(N'2022-08-24T16:39:00' AS SmallDateTime), N'14', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (100, CAST(N'2022-08-24T16:39:00' AS SmallDateTime), N'15', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (101, CAST(N'2022-08-24T16:39:00' AS SmallDateTime), N'16', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (102, CAST(N'2022-08-24T16:39:00' AS SmallDateTime), N'17', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (103, CAST(N'2022-08-24T16:39:00' AS SmallDateTime), N'18', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (104, CAST(N'2022-08-24T16:39:00' AS SmallDateTime), N'19', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (105, CAST(N'2022-08-24T16:39:00' AS SmallDateTime), N'20', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (106, CAST(N'2022-08-24T16:39:00' AS SmallDateTime), N'21', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (107, CAST(N'2022-08-24T16:39:00' AS SmallDateTime), N'22', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (108, CAST(N'2022-08-24T16:39:00' AS SmallDateTime), N'23', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (109, CAST(N'2022-08-24T16:39:00' AS SmallDateTime), N'24', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (110, CAST(N'2022-08-24T16:39:00' AS SmallDateTime), N'25', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (111, CAST(N'2022-08-24T16:39:00' AS SmallDateTime), N'26', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (112, CAST(N'2022-08-24T16:39:00' AS SmallDateTime), N'27', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (113, CAST(N'2022-08-24T16:39:00' AS SmallDateTime), N'28', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (114, CAST(N'2022-08-24T16:39:00' AS SmallDateTime), N'29', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (115, CAST(N'2022-08-24T16:39:00' AS SmallDateTime), N'30', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (116, CAST(N'2022-08-24T16:39:00' AS SmallDateTime), N'31', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (117, CAST(N'2022-08-24T16:39:00' AS SmallDateTime), N'32', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (118, CAST(N'2022-08-24T16:39:00' AS SmallDateTime), N'33', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (119, CAST(N'2022-08-24T16:39:00' AS SmallDateTime), N'34', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (120, CAST(N'2022-08-24T16:40:00' AS SmallDateTime), N'35', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (121, CAST(N'2022-08-24T16:40:00' AS SmallDateTime), N'36', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (122, CAST(N'2022-08-24T16:40:00' AS SmallDateTime), N'37', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (123, CAST(N'2022-08-24T16:40:00' AS SmallDateTime), N'38', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (124, CAST(N'2022-08-24T16:40:00' AS SmallDateTime), N'39', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (125, CAST(N'2022-08-24T16:40:00' AS SmallDateTime), N'40', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (126, CAST(N'2022-08-24T16:40:00' AS SmallDateTime), N'41', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (127, CAST(N'2022-08-24T16:40:00' AS SmallDateTime), N'42', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (129, CAST(N'2022-08-24T17:20:00' AS SmallDateTime), N'43434343434343 43434343434343 43434343434343 43434343434343 43434343434343 43434343434343 43434343434343 43434343434343 43434343434343 43434343434343 43434343434343 43434343434343 43434343434343 43434343434343 43434343434343 43434343434343 43434343434343 43434343434343 43434343434343 43434343434343 43434343434343 43434343434343 43434343434343 43434343434343 ', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (130, CAST(N'2022-08-24T20:38:00' AS SmallDateTime), N'привет, это первое смс', 2, 5, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (131, CAST(N'2022-08-24T20:54:00' AS SmallDateTime), N'Отредактировал несколько раз', 5, 0, 1, 0, NULL, 1)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (132, CAST(N'2022-08-24T20:54:00' AS SmallDateTime), N'45', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (133, CAST(N'2022-08-24T20:54:00' AS SmallDateTime), N'46', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (134, CAST(N'2022-08-24T20:54:00' AS SmallDateTime), N'47', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (135, CAST(N'2022-08-24T20:54:00' AS SmallDateTime), N'48', 5, 0, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (136, CAST(N'2022-08-24T20:54:00' AS SmallDateTime), N'49=>50', 5, 0, 1, 0, NULL, 1)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (138, CAST(N'2022-08-25T08:16:00' AS SmallDateTime), N'50 ', 5, 0, 0, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (139, CAST(N'2022-08-25T08:39:00' AS SmallDateTime), N'd', 2, 4, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (140, CAST(N'2022-08-25T08:39:00' AS SmallDateTime), N'2', 2, 4, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (141, CAST(N'2022-08-25T08:39:00' AS SmallDateTime), N'3', 2, 4, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (142, CAST(N'2022-08-25T08:39:00' AS SmallDateTime), N'4', 2, 4, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (143, CAST(N'2022-08-25T08:39:00' AS SmallDateTime), N'5', 2, 4, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (144, CAST(N'2022-08-25T08:39:00' AS SmallDateTime), N'6', 2, 4, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (145, CAST(N'2022-08-25T08:39:00' AS SmallDateTime), N'7', 2, 4, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (146, CAST(N'2022-08-25T08:39:00' AS SmallDateTime), N'8', 2, 4, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (147, CAST(N'2022-08-25T08:39:00' AS SmallDateTime), N'9', 2, 4, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (148, CAST(N'2022-08-25T08:39:00' AS SmallDateTime), N'10', 2, 4, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (149, CAST(N'2022-08-25T08:39:00' AS SmallDateTime), N'11', 2, 4, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (150, CAST(N'2022-08-25T08:39:00' AS SmallDateTime), N'12', 2, 4, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (151, CAST(N'2022-08-25T08:39:00' AS SmallDateTime), N'13', 2, 4, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (152, CAST(N'2022-08-25T08:39:00' AS SmallDateTime), N'14', 2, 4, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (153, CAST(N'2022-08-25T08:39:00' AS SmallDateTime), N'15', 2, 4, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (154, CAST(N'2022-08-25T08:39:00' AS SmallDateTime), N'17', 2, 4, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (155, CAST(N'2022-08-25T08:39:00' AS SmallDateTime), N'17', 2, 4, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (156, CAST(N'2022-08-25T08:39:00' AS SmallDateTime), N'18', 2, 4, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (157, CAST(N'2022-08-25T08:39:00' AS SmallDateTime), N'19', 2, 4, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (158, CAST(N'2022-08-25T08:39:00' AS SmallDateTime), N'20', 2, 4, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (159, CAST(N'2022-08-25T08:39:00' AS SmallDateTime), N'21', 2, 4, 1, 0, NULL, 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (160, CAST(N'2022-08-25T08:46:00' AS SmallDateTime), N'51', 2, 0, 1, 1, N'Yaroslav:44', 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (161, CAST(N'2022-08-25T08:56:00' AS SmallDateTime), N'Сам себе ответил мда', 5, 0, 1, 1, N'Yaroslav:31', 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (166, CAST(N'2022-08-25T14:04:00' AS SmallDateTime), N'Не получилось отредактировать?', 5, 0, 0, 1, N'Yaroslav:49=>50', 0)
INSERT [dbo].[Messages] ([Id], [Date], [Text], [IdSender], [ChatId], [IsVisible], [WithAnswer], [AnswerText], [Edited]) VALUES (167, CAST(N'2022-08-25T14:15:00' AS SmallDateTime), N'ну дя', 5, 0, 0, 1, N'Yaroslav:Сам себе ответил мда', 0)
SET IDENTITY_INSERT [dbo].[Messages] OFF
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD  CONSTRAINT [FK_Messages_Chat_ChatId] FOREIGN KEY([ChatId])
REFERENCES [dbo].[Chats] ([Id])
GO
ALTER TABLE [dbo].[Messages] CHECK CONSTRAINT [FK_Messages_Chat_ChatId]
GO
USE [master]
GO
ALTER DATABASE [ChatReenbit] SET  READ_WRITE 
GO
