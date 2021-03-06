USE [master]
GO
/****** Object:  Database [MediaLibrary]    Script Date: 18/06/2020 08:39:01 ******/
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
/****** Object:  StoredProcedure [dbo].[spAddCategory]    Script Date: 18/06/2020 08:39:01 ******/
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
/****** Object:  StoredProcedure [dbo].[spAddMedia]    Script Date: 18/06/2020 08:39:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAddMedia]
	@Name nvarchar(MAX),
	@Url nvarchar(MAX),
	@Path nvarchar(MAX),
	@Type int,
	@Done bit,
	@CategoryId int,
	@Date datetime
AS  
    INSERT INTO [dbo].[Media](Name, Url, Path, Type, Done, Category_Id, DateOfAddition)    
    VALUES(@Name,@Url,@Path,@Type, @Done, @CategoryId, @Date)    
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[spDeleteCategory]    Script Date: 18/06/2020 08:39:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spDeleteCategory]
	@Id int
AS
	DELETE FROM Categories
	WHERE Categories.Id = @Id
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[spDeleteMedia]    Script Date: 18/06/2020 08:39:01 ******/
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
/****** Object:  StoredProcedure [dbo].[spGetAllCategories]    Script Date: 18/06/2020 08:39:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetAllCategories]
	
AS
	SELECT * FROM dbo.Categories
GO
/****** Object:  StoredProcedure [dbo].[spGetAllMedias]    Script Date: 18/06/2020 08:39:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetAllMedias]	
AS
	SELECT Media.*, Categories.Id AS [Category.Id], Categories.Name AS [Category.Name]
	FROM Media
	LEFT OUTER JOIN Categories
	  ON Media.Category_Id = Categories.Id
	ORDER BY Media.DateOfAddition DESC
GO
/****** Object:  StoredProcedure [dbo].[spGetCategoryById]    Script Date: 18/06/2020 08:39:01 ******/
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
/****** Object:  StoredProcedure [dbo].[spGetMediaById]    Script Date: 18/06/2020 08:39:01 ******/
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
	LEFT OUTER JOIN Categories
	  ON Media.Category_Id = Categories.Id	
	WHERE Media.Id = @Id
GO
/****** Object:  StoredProcedure [dbo].[spUpdateCategory]    Script Date: 18/06/2020 08:39:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spUpdateCategory]
	@Id int,
	@Name nvarchar(MAX)
AS
	UPDATE dbo.Categories
	SET Name = @Name
	WHERE Categories.Id = @Id
RETURN 0
GO
/****** Object:  StoredProcedure [dbo].[spUpdateMedia]    Script Date: 18/06/2020 08:39:01 ******/
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
	@Done bit,
	@CategoryId int,
	@Date datetime
AS
	UPDATE dbo.Media
	SET Name = @Name, Url = @Url, Path = @Path, Type = @Type, Done = @Done, DateOfAddition = @Date, Category_Id = @CategoryId
	WHERE Media.Id = @Id
RETURN 0
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 18/06/2020 08:39:01 ******/
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
/****** Object:  Table [dbo].[Categories]    Script Date: 18/06/2020 08:39:01 ******/
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
/****** Object:  Table [dbo].[Media]    Script Date: 18/06/2020 08:39:01 ******/
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
	[DateOfAddition] [datetime] NOT NULL,
	[Category_Id] [int] NULL,
 CONSTRAINT [PK_dbo.Media] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'202006120905442_v1_Initial', N'Library.DAL.Migrations.Configuration', 0x1F8B0800000000000400ED5ACD6EE33610BE17E83B083AB545D6B2B39736B0779175922268FE10278BDE025A1A3BC452944A52818DA24FD6431FA9AFD0D13F454AB29CECA6455B04086292F3CD3F6738CE9FBFFF317DBF0999F30442D288CFDCC968EC3AC0FD28A07C3D7313B57AF3BDFBFEDDD75F4D4F8370E37C2CCFBD4DCF21259733F751A9F8C8F3A4FF082191A390FA2292D14A8DFC28F448107987E3F10FDE64E20142B888E538D3DB842B1A42F6013FCE23EE43AC12C22EA300982CD6716791A13A57240419131F66EE2504948C4E8E2F4648A560A35CE7985182822C80AD5C87701E29A250CCA37B090B2522BE5EC4B840D8DD36063CB7224C4221FE517D7CA826E3C35413AF262CA1FC44AA28DC1370F2B6308D67923FCBC06E653A34DE291A596D53AD3303CEDC3951B08EC4D6754C66477326D283857D2FE85210B1CDCC9CA15090A392FAC0D1B60FAAA0C0D8497F0E9C79C2542260C6215182B003E7265932EAFF04DBBBE813F0194F18D3E5444971AFB1804B37228A41A8ED2DAC0AE9CF03D7F19A749E4958916934B95EE75CBD3D749D2B644E960CAA30D06CB05091801F8183404D831BA214089E624066488BBBC12BFD5D72C3B8C30C729D4BB2B900BE568F6858B2719D33BA81A05C2924B8E714130E899448C06272459EE83A93CF6097394ABACE2DB06C5B3ED2384F8251B6F550F80B5D877C4514DE46AC24D3F61EEE88580366D15DD471601125C237049B7A7570F5865C86F6BC78CB76FE0FB6D70C3683C9BD605F9C076AFEF8C599A4F015932A43F255CB49FD502711AFA03E44983184EFC6E84C623D475F9AC8659E76267299E9C3123909CD34CEED752ECF1859D77574AFD44EC234DE53256B177C9614C7780840B02DC68F9E824D375C42B80451A8744659E83A1F094BF0C3D87259E32C3AFA537576625B30B795BE782C65E4D34C55DD84BA2F9BFC4E79E0EC72AC11BF9828681A1AA331D08333F73B4B891ED0EADAAF41EBF6A01777EA69CAD9977FDA9611CA2BDB9D9E558D9A152AD8A115D1228B4436E54F1117A05AD2A58E5B4B7CCB0A4D94B2725A0885550D724D5B03A39199DAB1AEEC35CBCE009F57B2D7627B7BC0945ED6607499CD0AD754B5E59AA89C5BB7E85EDEA397BDBCD7D1CC4F2F491C63766ACD7DB1E22CF2CE7EFE66B17FCF1BE6189E2F5B5ADF4ADA8A13165DB206631759A3A46754487542145992F45A9B07A175AC0EE58E002BF958D16ABBAC0CBD9224FD5B0B2DFD855347B60153DBF00CD50AB173C83404DBDB2DA4D9EB8A30225ABA9879C492907775427DD4795FA2D3E72B36C2D43364376DE4594632A2D534FB20A71459F43287E417C5FEDEE8A0FBBB5DD18590F57F3A40B6309C3EEFED74807C653842DE72E808F9CA7084BC5FD311F295D70FC8E6E5DA12958D72B233FC1AA75B03AD2BF7D382D1F6986CA93FB69106056A0ED716AEA9912AE6CF90AB2868CF94ABB4C89EA29985D176AF551FCD2355705575D2A887D3A236ED9E8059C52A3FE23A28FB130DD242B5D84A05E1283D305AFCC2E68C6238D7072E09A72B902AEF9FDDC3F1E4D098A2FD73265A9E94011B38D67AF5773E4DADBAF325BFE70B537FDAF32722FC4722BE09C9E65B1DC97EF5EE3992F94FDBAA77D4F1221C7D9CF122207D649199EE05738A25DD45BF5FF0BC24E17A4A837DB8E7BEDE1D7A3527CD8AD613F49C07B099B9BF664447CEF9CF0F25DD81732DF0B23C72C6CE6F7B9BBF21F97EFC35D23D44E8F2E0EE41446BAD371F95BBA70F13ABCDB8E627C0408173ECE7D5634EA44F02DB7669E1EDE55E3FED4D2906CE2CD2EF9C600522BD6608C32A2D95C03A6DB5783782729FC6843574B7BB8D219763AA588567EE9C400C3CBDF55AD51CC2B0AFC7AAD00D3BEFB241E768674014B575669A1F5B5DD8E5BD7F652CEDE5DD570FA71DADF1678FA8F661A13D88193410DCF68E03F3FE78E606CB089D9EDFA03D53B0D67161F7B4B00DBD7D90D80ADCA381B1DFC9A8479741B3CB6AD8B87B84D9F12EB4AB8535F4D839B6340DD1F28E1D3EAF1CAC7A39201DA07AFBD3B3F58A6B1BC0BDAE01F618D8DA0F4F4C6BED1F34F07291745D43A4FFAEC1C16F247475E69CAFA2F27231242A8F586D9A220166FBB15074457C85DB3E48997D11587CE3721A2E2138E7D7898A13852A43B8640D63A4F7531FFF6C2ADD94797A1D67DF437D0E15504C8A2AC035FF90501654729FB5B4691D10E9C557BC8B525FAAF47DB4DE564857D6CCAA0BA8305F755FDF4118330493D77C419EE039B2DD4BB88035F1B7E5FCA01B64B7239A669F9E50B216249405464D8F1F31868370F3EE2F8DD55458A7240000, N'6.4.4')
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'202006161522188_v2_AddDateToMediaEntity', N'Library.DAL.Migrations.Configuration', 0x1F8B0800000000000400ED5ACD6EE33610BE17E83B083AB545D6B2B39736B0779175E22268120771B2E82DA025DA2196A254920A6C147DB21EFA487D850EF54B91922C25BB69D116018298E47CF3CB99E1387FFEFEC7F4FD2EA4CE13E682446CE64E4663D7C1CC8F02C2B63337919B37DFBBEFDF7DFDD5F43C0877CEC7E2DC5B750E289998B98F52C6279E27FC471C22310A89CF23116DE4C88F420F0591773C1EFFE04D261E060817B01C677A9B3049429C7E808FF388F9389609A2575180A9C8D7616795A23AD728C422463E9EB95738206874767A39022A8977D2754E294120C80AD38DEB20C62289248879722FF04AF2886D57312C207AB78F319CDB202A702EFE4975BCAF26E363A589571116507E2264140E049CBCCD4DE399E4CF32B05B9A0E8C770E46967BA5756AC0993B47126F23BE771D93D9C99C727530B7EF255973C4F7A999531482C5A8A03E72B4EDA332282076D4CF91334FA84C389E319C488EE8917393AC29F17FC2FBBBE81366339650AACB0992C25E6D01966E7814632EF7B778934B7F11B88E57A7F34CC2924CA3C9F4BA60F2EDB1EB5C0373B4A6B80C03CD062B1971FC23669883A6C10D921273A630706A488BBBC14BFD2EB841DCC10D729D2BB4BBC46C2B1FC1B068E73A0BB2C341B1924B70CF085C3820923CC116936BF444B6A97C06BBD451C2756E314DB7C52389B34B304AB71E727F81EB802F8FC2DB881664DADEC31DE25B0CB7E82E6A39B08A12EE1B824DBD2AB83A432E457B5EBCA53BFF07DB6B069BC1E49ED32FCE03347FFCE24C147CC9A4BC21D9AAE5A46EA8B38895501F22B831880DC700972F37A74140B2449FA1A9D53B12F610A93527E857FEA579A1B8F6AD79A1481CFDF242129A592133FF855850B4ADCAF2A04C9184EAFA28252B8F7E968C01E115604EF7108EFA8DAEBBE10A876BCC7395168486AEF311D1043E8C2D97D5CE42DC7C2ACF4E6C0B66B6D2174F85887C92AAAA9B50F7659DDF390B9C438E35AE03DC3B300D89C118E0C199FB9DA544076859452AD0AADBE8C49D7A9A72762D515D1E22ACB4DDF9A2ECFBAC5081862F8F1691E705537E85B8C2B2E1BA54716B896F59A18E5214620B21B7AA41AE696B60D46EA676ACEDF69A55AC87CF4BD92BB1BD0130859735185D66B360D6556D4813A573AB8EDFCB5AFEE269E0B5BC0DA657288EE1766A6F857CC559650F85F99BD5F0163ACC303C5F3474D2A5B42527A8E1688B8D5D600D922E081712523A5A2395D6E641681DAB42B925C00A3E56B4DA2E2B42AF20517F6BA1A53F98AAC836602A1B2E40AD101A9154436C7BBB81347DAC218A784353348F6812B2B6C6AA8B3A6B7374FA6CC546987A86ECA68D3CCB4846B49A66EFE594FC16BDCC2159A218EE8D16BABFDB156D08693BA903A40BFDE9B3565107C856FA23642D878E90ADF447C8DA3F1D215B198060347F352C63EFF5C3BC9EB21B62BD56A40E0675ED7463F8B6651455869A5EBC0D55CD3652AFF0CFE09A2E813252C9FC1972E565F29972151619289A596E6DF75A55D73C520657597D8D2A3BCD2BDEE1319D5502B323AE03B23F914095BFD55E481C8ED481D1EA173AA704C2B93A708518D96021B3AEDC3D1E4F8E8D51DF3F67ECE60911D09EB3B7571F461065D583E386814F587DFEC09E10F71F11FF2644BB6F7524FB693E706EF49FB655E73CE64538FACCE54540FA5C2535DD0B86296BF20CFAC6414A00ABF2F02065582CBEE4FE76541AFB7047FA3F1CC91527CD29D63BF982057837737F4D894E9C8B9F1F0ABA2367C921F79E3863E7B7C1DEA8493E8CBF463A4084360F1E9E9634B60EE6CBF7F0886462752D4B76862996D839F5B3623447C247816D3B55C73BB957F307538A9E8315F53D1BDE60AEB216A250F485E450F6AD8EF18613E69318D19AEE76F3D227D72AC54A3C73E70CC798A924DAA8661F865D2D5B896ED8F9900D5AE74F3DA2A8A9D1D3FCD8E8C236EFFD2B636990775F3D9C0E74DA9F3DA29A279AF6B4A8D7D472DF39B3CCDA6DA885EB089C9E65D08E515DE34CB37DA4D984DE3CED6C04EED0C0D86F65D4A14BAF016B39113D3C676D7966DAD5C29ACC1C9CAD9A86687816F71FAAF656BD98E2F650BDF925DB98E29AA684AF6B80015365FB1D0BD75AFBA714482E826C2B08F52F2A0CFBB50B5D9EB9609BA8482E8644C511AB4D9308BA5474CA25D9205FC2B68F8548BFFCCCBF163A0FD738B860CB44C689049571B8A63563A8FCD4C53F1D9DD7659E2EE3F4CBB2CFA102884954A3BD641F12428352EE45439BD602A1125FFECC52BE94EAB9B5DD9748D7D660AD0D28375F99AFEF70185300134BB6424FF839B2DD0B7C89B7C8DF17E3887690C38EA89B7D7A46D096A350E418153D7C84180EC2DDBBBF004DF68D0F9B250000, N'6.4.4')
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'202006170720210_v3_RemoveManyToManyRelationship', N'Library.DAL.Migrations.Configuration', 0x1F8B0800000000000400ED59DB6EE336107D2FD07F10F4D41659CBC9BEB481BD8BAC13174673439C2CFA16D0D2D82196A254920A6C14FDB23EF493FA0B1DEA4A91BEC8CE66B7408B004144720EE73EC3C9DF7FFE3578BF8C99F70C42D2840FFDE35EDFF780874944F962E8676AFEE647FFFDBB6FBF195C44F1D2FB589D7BABCF21259743FF49A9F4340864F8043191BD98862291C95CF5C2240E48940427FDFE4FC1F1710008E12396E70DEE32AE680CF9077E8E121E42AA32C2AE9208982CD771679AA37AD7240699921086FE154494F4CECF2E7B48A560A97CEF8C51828C4C81CD7D8F709E28A290CDD30709532512BE98A6B840D8FD2A053C37274C42C9FE6973BCAB24FD132D49D010565061265512EF0978FCB6544D60931FA460BF561D2AEF0295AC565AEA5C81437F44142C12B1F23DFBB2D31113FA60A9DF4B3A1344AC7235E7281464AFA23EF28CEDA3DA29D077F4CF9137CA98CA040C39644A1076E4DD663346C35F60759F7C023EE41963269FC829EEB51670E956242908B5BA8379C9FD24F2BDA04D17D88435994153C835E1EAED89EF5DE3E564C6A076034307539508F81938089434BA254A81E01A0372453AB75B77E9DFD56DE8771841BE77459697C017EA09154B96BE37A64B88AA959283074E31E09048890C9C4BAEC9335DE4FC59D7E58692BE77072CDF964F342D82A0976F3D36D61E8B24BE4B584554EF3CDE13B1008CA0FB64EDF634C94468B134081AB7DAEA6C39D6619E96EFFCEF665FD2CDAC4B1E047BF53B50F2A757BF44C3D797D4B151AC3A46DA0E759EF01AEA4382F142F8FE1868F29BF95914D122C517687AF59EC61D58DA980D9A607F493EA8027E433EA8D245B77C90C5763628D43E916346164D21DE2B4364B10E1B2D5E63C9CF9229D0AD22106C856E6846725BFD5710CF4094228D298B7DEF2361197EF41D53B5CEA2BF7CAACF1EBB1A2C74652E9E4999843417D5546163C5F66D173CF2B69BD40A018C35540B4D511168BDA1FF8323C046C8BA6A34908D6FB551FBBD9E23AD21995B4074534728AF157731AEDB3CC74FB0BF2B5D4596C9C01640234E41B563042B8CEF354EEB48E0A8A18D52D55D07A154AB456E486B611801691C5A1FB276D9DA69EE9AEB86E1A03348656003C4D49D5D1DDB22AEC90DB5519BC63E283AFBEA05106C78020CAE489A62481A4F8272C59B16EF81D19BE9FE9D725C6004A15CD330D7DCD63761C1260BB076F16AE4744C855498BFC98CE85C368A62E758E3C21B1CABBAC7F152D76095CB5524FA6FC3A5CC77516F93F3343A1CA35831761DB984E05A7B0D69FE26238C88351DD0286159CC377551DBA88B9EC6A42F565C844160F16EEB2870946479ABADF64E462963E865062912C4FED6D840F7B54DB10921EF1D4D807CA13B7DD1179A00C54A7784A2CF30118A95EE0845AF6722142B7B20589D5E0BCBDAFBF26EDE4ED96B7CDD284E3B5DDA38DBC97575E159F798750A90AB964E0E5FC3ACF37CAD99FAF6BD192BCBEB818CEDCD0FAAB9F0116C9AF5D3A0EE993B8A6BD766D7179C126D1FA93DB12ED556491E94E571F7E8CEA997C511DF43F19F69A46BE5742515C43D7DA037FD8D8D1845DF6F0E5C114EE72055D1B7FB27FDE3136BFCF7EF19C5055246ACE33CEE8B8F29A8D6EACE41C49E8F5B7332C19F89089F88F82E26CBEF4D24F7D1BEE744E93FADABAD939A17E198D39817019913975C752F18B3CCE801F46B472C11AEAA4E23960D839547CB219CD7E88447B01CFABFE774A7DEE4D74783F4C8BB1198BF4EBDBEF7C761D170F03CA05DC8F77EAFBBEFC4436609188B2074A8108695462A81B5C6E9696E05E5214D09B33977CB6D9718D7BAAC21ED9D734881EBE06D49D6E5A21DDD450D6CE59B5D1AD8732EE2BE3D3BCD3E565B271F453DC660992568E4C243B73CFCD74E46360F46D6A17F9D9989AD8CF69B77E7A0C49DAEBCCE4CC46DACD08D8CFF9CA2134BBA682074BBC8216C39507D66C2E749E5CC1647D511A7F55504D32639138ACE49A8703B0429F3397D39C9BC8867104DF84DA6D24CA1C810CF584B813A1EB6DD9F0F7EDA3C0F6ED27CBEFB39444036A9CEFC37FC43465954F33D7633FF26081D6865DDD7B654BAFE2F5635D2B5F32CDC0454AAAFCE0FF710A70CC1E40D9F92673884B7070997B020E1AAEA8F3783EC36445BED83734A1682C4B2C468E8F1137D388A97EFFE01AE4F1AB940200000, N'6.4.4')
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([Id], [Name]) VALUES (1, N'Programming')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (2, N'Data scientist')
INSERT [dbo].[Categories] ([Id], [Name]) VALUES (3, N'Discovery')
SET IDENTITY_INSERT [dbo].[Categories] OFF
SET IDENTITY_INSERT [dbo].[Media] ON 

INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done], [DateOfAddition], [Category_Id]) VALUES (203, N'Use of Flexbox', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 1, CAST(0x0000ABDD0097F6E0 AS DateTime), 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done], [DateOfAddition], [Category_Id]) VALUES (204, N'Programming in C#', N'C:\Users\Ambroise\Desktop\UNamur', N'C:\Users\Ambroise\Desktop\UNamur', 0, 0, CAST(0x0000ABDD00D2200E AS DateTime), 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done], [DateOfAddition], [Category_Id]) VALUES (206, N'Programme MIC', N'C:\Users\Ambroise\source\repos\MediaLibrarySolution\MediaLibrary.MVC5\images\MIC - Introduction à Unity.pdf', N'MIC - Introduction à Unity.pdf', 1, 0, CAST(0x0000ABDD00A266AE AS DateTime), 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done], [DateOfAddition], [Category_Id]) VALUES (207, N'PHP pour débutants', N'C:\Users\Ambroise\source\repos\MediaLibrarySolution\MediaLibrary.MVC5\images\acte_de_naissance.pdf', N'acte_de_naissance.pdf', 1, 0, CAST(0x0000ABDD00A31577 AS DateTime), 1)
INSERT [dbo].[Media] ([Id], [Name], [Url], [Path], [Type], [Done], [DateOfAddition], [Category_Id]) VALUES (211, N'Salutations', N'C:\Users\Ambroise\source\repos\MediaLibrarySolution\MediaLibrary.MVC5\images\MIC - Introduction à Unity.pdf', N'MIC - Introduction à Unity.pdf', 0, 0, CAST(0x0000ABDD00E50086 AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Media] OFF
/****** Object:  Index [IX_Category_Id]    Script Date: 18/06/2020 08:39:02 ******/
CREATE NONCLUSTERED INDEX [IX_Category_Id] ON [dbo].[Media]
(
	[Category_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Media] ADD  DEFAULT ('1900-01-01T00:00:00.000') FOR [DateOfAddition]
GO
ALTER TABLE [dbo].[Media]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Media_dbo.Categories_Category_Id] FOREIGN KEY([Category_Id])
REFERENCES [dbo].[Categories] ([Id])
GO
ALTER TABLE [dbo].[Media] CHECK CONSTRAINT [FK_dbo.Media_dbo.Categories_Category_Id]
GO
USE [master]
GO
ALTER DATABASE [MediaLibrary] SET  READ_WRITE 
GO
