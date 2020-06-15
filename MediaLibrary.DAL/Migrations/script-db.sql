USE [master]
GO
/****** Object:  Database [MediaLibrary]    Script Date: 15/06/2020 13:34:51 ******/
CREATE DATABASE [MediaLibrary]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MediaLibrary', FILENAME = N'C:\Users\Ambroise\MediaLibrary.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MediaLibrary_log', FILENAME = N'C:\Users\Ambroise\MediaLibrary_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MediaLibrary].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MediaLibrary] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MediaLibrary] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MediaLibrary] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MediaLibrary] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MediaLibrary] SET ARITHABORT OFF 
GO
ALTER DATABASE [MediaLibrary] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [MediaLibrary] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [MediaLibrary] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MediaLibrary] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MediaLibrary] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MediaLibrary] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MediaLibrary] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MediaLibrary] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MediaLibrary] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MediaLibrary] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MediaLibrary] SET  ENABLE_BROKER 
GO
ALTER DATABASE [MediaLibrary] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MediaLibrary] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MediaLibrary] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MediaLibrary] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MediaLibrary] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MediaLibrary] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [MediaLibrary] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MediaLibrary] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MediaLibrary] SET  MULTI_USER 
GO
ALTER DATABASE [MediaLibrary] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MediaLibrary] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MediaLibrary] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MediaLibrary] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
USE [MediaLibrary]
GO
/****** Object:  StoredProcedure [dbo].[spAddCategory]    Script Date: 15/06/2020 13:34:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAddCategory]
	@Name nvarchar(MAX)
AS  
    INSERT INTO [dbo].[Categories](Name)    
    VALUES(@Name)    
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[spAddMedia]    Script Date: 15/06/2020 13:34:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAddMedia]
	@Name nvarchar(MAX),
	@Url nvarchar(MAX),
	@Path nvarchar(MAX),
	@Type int,
	@Done bit
AS  
    INSERT INTO [dbo].[Media](Name, Url, Path, Type, Done)    
    VALUES(@Name,@Url,@Path,@Type, @Done)    
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[spAddMediaCategory]    Script Date: 15/06/2020 13:34:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAddMediaCategory]
	@MediaId int,
	@CategoryId int
AS
	INSERT INTO MediaCategories(Media_Id, Category_Id)
	VALUES(@MediaId, @CategoryId)

RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[spDeleteMedia]    Script Date: 15/06/2020 13:34:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spDeleteMedia]
	@Id int
AS
	DELETE FROM Media
	WHERE Media.Id = @Id
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[spGetAllMedias]    Script Date: 15/06/2020 13:34:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetAllMedias]	
AS
	SELECT * FROM dbo.Media
GO
/****** Object:  StoredProcedure [dbo].[spGetCategoryById]    Script Date: 15/06/2020 13:34:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetCategoryById]
	@Id int
AS
	SELECT * FROM dbo.Categories
	WHERE Categories.Id = @Id
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[spGetMediaById]    Script Date: 15/06/2020 13:34:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetMediaById]
	@Id int
AS
	SET NOCOUNT ON;
    SELECT Media.*, Categories.Id AS [Category.Id], Categories.Name AS [Category.Name]
	FROM Media
	LEFT OUTER JOIN MediaCategories
	  ON Media.Id = MediaCategories.Media_Id
	LEFT OUTER JOIN Categories
	  ON MediaCategories.Category_Id = Categories.Id
	WHERE Media.Id = @Id
GO
/****** Object:  StoredProcedure [dbo].[spUpdateMedia]    Script Date: 15/06/2020 13:34:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spUpdateMedia]
	@Id int,
	@Name nvarchar(MAX),
	@Url nvarchar(MAX),
	@Path nvarchar(MAX),
	@Type int,
	@Done bit
AS
	UPDATE dbo.Media
	SET Name = @Name, Url = @Url, Path = @Path, Type = @Type, Done = @Done
	WHERE Media.Id = @Id
RETURN 0
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 15/06/2020 13:34:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 15/06/2020 13:34:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.Categories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Media]    Script Date: 15/06/2020 13:34:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Media](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Url] [nvarchar](max) NULL,
	[Path] [nvarchar](max) NULL,
	[Type] [int] NOT NULL,
	[Done] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Media] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MediaCategories]    Script Date: 15/06/2020 13:34:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MediaCategories](
	[Media_Id] [int] NOT NULL,
	[Category_Id] [int] NOT NULL,
 CONSTRAINT [PK_dbo.MediaCategories] PRIMARY KEY CLUSTERED 
(
	[Media_Id] ASC,
	[Category_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'202006120905442_v1_Initial', N'Library.DAL.Migrations.Configuration', 0x1F8B0800000000000400ED5ACD6EE33610BE17E83B083AB545D6B2B39736B0779175922268FE10278BDE025A1A3BC452944A52818DA24FD6431FA9AFD0D13F454AB29CECA6455B04086292F3CD3F6738CE9FBFFF317DBF0999F30442D288CFDCC968EC3AC0FD28A07C3D7313B57AF3BDFBFEDDD75F4D4F8370E37C2CCFBD4DCF21259733F751A9F8C8F3A4FF082191A390FA2292D14A8DFC28F448107987E3F10FDE64E20142B888E538D3DB842B1A42F6013FCE23EE43AC12C22EA300982CD6716791A13A57240419131F66EE2504948C4E8E2F4648A560A35CE7985182822C80AD5C87701E29A250CCA37B090B2522BE5EC4B840D8DD36063CB7224C4221FE517D7CA826E3C35413AF262CA1FC44AA28DC1370F2B6308D67923FCBC06E653A34DE291A596D53AD3303CEDC3951B08EC4D6754C66477326D283857D2FE85210B1CDCC9CA15090A392FAC0D1B60FAAA0C0D8497F0E9C79C2542260C6215182B003E7265932EAFF04DBBBE813F0194F18D3E5444971AFB1804B37228A41A8ED2DAC0AE9CF03D7F19A749E4958916934B95EE75CBD3D749D2B644E960CAA30D06CB05091801F8183404D831BA214089E624066488BBBC12BFD5D72C3B8C30C729D4BB2B900BE568F6858B2719D33BA81A05C2924B8E714130E899448C06272459EE83A93CF6097394ABACE2DB06C5B3ED2384F8251B6F550F80B5D877C4514DE46AC24D3F61EEE88580366D15DD471601125C237049B7A7570F5865C86F6BC78CB76FE0FB6D70C3683C9BD605F9C076AFEF8C599A4F015932A43F255CB49FD502711AFA03E44983184EFC6E84C623D475F9AC8659E76267299E9C3123909CD34CEED752ECF1859D77574AFD44EC234DE53256B177C9614C7780840B02DC68F9E824D375C42B80451A8744659E83A1F094BF0C3D87259E32C3AFA537576625B30B795BE782C65E4D34C55DD84BA2F9BFC4E79E0EC72AC11BF9828681A1AA331D08333F73B4B891ED0EADAAF41EBF6A01777EA69CAD9977FDA9611CA2BDB9D9E558D9A152AD8A115D1228B4436E54F1117A05AD2A58E5B4B7CCB0A4D94B2725A0885550D724D5B03A39199DAB1AEEC35CBCE009F57B2D7627B7BC0945ED6607499CD0AD754B5E59AA89C5BB7E85EDEA397BDBCD7D1CC4F2F491C63766ACD7DB1E22CF2CE7EFE66B17FCF1BE6189E2F5B5ADF4ADA8A13165DB206631759A3A46754487542145992F45A9B07A175AC0EE58E002BF958D16ABBAC0CBD9224FD5B0B2DFD855347B60153DBF00CD50AB173C83404DBDB2DA4D9EB8A30225ABA9879C492907775427DD4795FA2D3E72B36C2D43364376DE4594632A2D534FB20A71459F43287E417C5FEDEE8A0FBBB5DD18590F57F3A40B6309C3EEFED74807C653842DE72E808F9CA7084BC5FD311F295D70FC8E6E5DA12958D72B233FC1AA75B03AD2BF7D382D1F6986CA93FB69106056A0ED716AEA9912AE6CF90AB2868CF94ABB4C89EA29985D176AF551FCD2355705575D2A887D3A236ED9E8059C52A3FE23A28FB130DD242B5D84A05E1283D305AFCC2E68C6238D7072E09A72B902AEF9FDDC3F1E4D098A2FD73265A9E94011B38D67AF5773E4DADBAF325BFE70B537FDAF32722FC4722BE09C9E65B1DC97EF5EE3992F94FDBAA77D4F1221C7D9CF122207D649199EE05738A25DD45BF5FF0BC24E17A4A837DB8E7BEDE1D7A3527CD8AD613F49C07B099B9BF664447CEF9CF0F25DD81732DF0B23C72C6CE6F7B9BBF21F97EFC35D23D44E8F2E0EE41446BAD371F95BBA70F13ABCDB8E627C0408173ECE7D5634EA44F02DB7669E1EDE55E3FED4D2906CE2CD2EF9C600522BD6608C32A2D95C03A6DB5783782729FC6843574B7BB8D219763AA588567EE9C400C3CBDF55AD51CC2B0AFC7AAD00D3BEFB241E768674014B575669A1F5B5DD8E5BD7F652CEDE5DD570FA71DADF1678FA8F661A13D88193410DCF68E03F3FE78E606CB089D9EDFA03D53B0D67161F7B4B00DBD7D90D80ADCA381B1DFC9A8479741B3CB6AD8B87B84D9F12EB4AB8535F4D839B6340DD1F28E1D3EAF1CAC7A39201DA07AFBD3B3F58A6B1BC0BDAE01F618D8DA0F4F4C6BED1F34F07291745D43A4FFAEC1C16F247475E69CAFA2F27231242A8F586D9A220166FBB15074457C85DB3E48997D11587CE3721A2E2138E7D7898A13852A43B8640D63A4F7531FFF6C2ADD94797A1D67DF437D0E15504C8A2AC035FF90501654729FB5B4691D10E9C557BC8B525FAAF47DB4DE564857D6CCAA0BA8305F755FDF4118330493D77C419EE039B2DD4BB88035F1B7E5FCA01B64B7239A669F9E50B216249405464D8F1F31868370F3EE2F8DD55458A7240000, N'6.4.4')
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([Id], [Name]) VALUES (1, N'Programming')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (2, N'Data scientist')
SET IDENTITY_INSERT [dbo].[Categories] OFF
SET IDENTITY_INSERT [dbo].[Media] ON 

INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (28, N'New name', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (29, N'New name', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (30, N'New name', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (31, N'New name', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (32, N'New name', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (82, N'New name', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (83, N'New name', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (84, N'New name', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (86, N'Programming in C#', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 1, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (87, N'Programming in C#', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 1, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (88, N'New name', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (90, N'Programming in C#', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 1, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (91, N'New name', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (93, N'Programming in C#', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 1, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (94, N'New name', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (96, N'Programming in C#', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 1, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (97, N'New name', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (99, N'Programming in C#', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 1, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (100, N'New name', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (102, N'Programming in C#', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 1, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (103, N'New name', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (105, N'Programming in C#', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 1, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (106, N'New name', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (108, N'Programming in C#', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 1, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (109, N'New name', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (111, N'Programming in C#', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 1, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (112, N'New name', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (114, N'Programming in C#', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 1, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (115, N'New name', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (117, N'Programming in C#', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 1, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (118, N'New name', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (120, N'Programming in C#', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 1, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (121, N'New name', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (123, N'Programming in C#', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 1, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (124, N'New name', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (126, N'Programming in C#', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 1, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (127, N'New name', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (129, N'Programming in C#', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 1, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (130, N'New name', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (132, N'Programming in C#', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 1, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (133, N'New name', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (135, N'Programming in C#', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 1, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (136, N'New name', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (138, N'Programming in C#', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 1, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (139, N'New name', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (141, N'Programming in C#', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 1, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (142, N'New name', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (144, N'Programming in C#', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 1, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (145, N'New name', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (147, N'Programming in C#', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 1, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (148, N'New name', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (151, N'New name', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (152, N'Use of Flexbox', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (154, N'Use of Flexbox', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done]) VALUES (155, N'Use of Flexbox', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 1)
SET IDENTITY_INSERT [dbo].[Media] OFF
INSERT [dbo].[MediaCategories] ([Media_Id], [Category_Id]) VALUES (28, 1)
INSERT [dbo].[MediaCategories] ([Media_Id], [Category_Id]) VALUES (29, 1)
INSERT [dbo].[MediaCategories] ([Media_Id], [Category_Id]) VALUES (86, 1)
INSERT [dbo].[MediaCategories] ([Media_Id], [Category_Id]) VALUES (28, 2)
INSERT [dbo].[MediaCategories] ([Media_Id], [Category_Id]) VALUES (30, 2)
/****** Object:  Index [IX_Category_Id]    Script Date: 15/06/2020 13:34:51 ******/
CREATE NONCLUSTERED INDEX [IX_Category_Id] ON [dbo].[MediaCategories]
(
	[Category_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Media_Id]    Script Date: 15/06/2020 13:34:51 ******/
CREATE NONCLUSTERED INDEX [IX_Media_Id] ON [dbo].[MediaCategories]
(
	[Media_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MediaCategories]  WITH CHECK ADD  CONSTRAINT [FK_dbo.MediaCategories_dbo.Categories_Category_Id] FOREIGN KEY([Category_Id])
REFERENCES [dbo].[Categories] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MediaCategories] CHECK CONSTRAINT [FK_dbo.MediaCategories_dbo.Categories_Category_Id]
GO
ALTER TABLE [dbo].[MediaCategories]  WITH CHECK ADD  CONSTRAINT [FK_dbo.MediaCategories_dbo.Media_Media_Id] FOREIGN KEY([Media_Id])
REFERENCES [dbo].[Media] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MediaCategories] CHECK CONSTRAINT [FK_dbo.MediaCategories_dbo.Media_Media_Id]
GO
USE [master]
GO
ALTER DATABASE [MediaLibrary] SET  READ_WRITE 
GO
