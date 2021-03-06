USE [master]
GO
/****** Object:  Database [Museam]    Script Date: 2019/12/6 8:22:17 ******/
CREATE DATABASE [Museam] ON  PRIMARY 
( NAME = N'Museam', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.SQLEXPRESS\MSSQL\DATA\Museam.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Museam_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.SQLEXPRESS\MSSQL\DATA\Museam_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Museam] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Museam].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Museam] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Museam] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Museam] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Museam] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Museam] SET ARITHABORT OFF 
GO
ALTER DATABASE [Museam] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Museam] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Museam] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Museam] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Museam] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Museam] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Museam] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Museam] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Museam] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Museam] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Museam] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Museam] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Museam] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Museam] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Museam] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Museam] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Museam] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Museam] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Museam] SET  MULTI_USER 
GO
ALTER DATABASE [Museam] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Museam] SET DB_CHAINING OFF 
GO
USE [Museam]
GO
/****** Object:  User [root]    Script Date: 2019/12/6 8:22:17 ******/
CREATE USER [root] FOR LOGIN [root] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[banner]    Script Date: 2019/12/6 8:22:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[banner](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NULL,
	[img] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[collection]    Script Date: 2019/12/6 8:22:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[collection](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](50) NULL,
	[img] [varchar](max) NULL,
	[succinct_id] [int] NOT NULL,
	[_new ] [int] NULL,
	[hot] [int] NULL,
	[introduce] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[config]    Script Date: 2019/12/6 8:22:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[config](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[A1] [varchar](max) NULL,
	[A2] [varchar](max) NULL,
	[A3] [varchar](max) NULL,
	[A4] [varchar](max) NULL,
	[A5] [varchar](max) NULL,
	[A6] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[exhibit]    Script Date: 2019/12/6 8:22:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[exhibit](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](max) NULL,
	[img] [varchar](max) NULL,
	[introduce] [text] NULL,
	[address] [varchar](50) NULL,
	[start_time] [date] NULL,
	[end_time] [date] NULL,
	[_new] [smallint] NULL,
	[hot] [smallint] NULL,
	[content] [text] NULL,
	[type] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[exhibit_reservation]    Script Date: 2019/12/6 8:22:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[exhibit_reservation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[exhibit_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[addTime] [datetime2](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[home_banner]    Script Date: 2019/12/6 8:22:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[home_banner](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[banner] [varchar](max) NULL,
	[note] [varchar](50) NULL,
	[url] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[questions]    Script Date: 2019/12/6 8:22:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[questions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[question] [varchar](max) NULL,
	[answer] [varchar](max) NULL,
	[addtime] [date] NULL,
	[user_id] [int] NULL,
	[img] [varchar](max) NULL,
	[type] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[succincts]    Script Date: 2019/12/6 8:22:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[succincts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[classname] [varchar](20) NOT NULL,
	[img] [varchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 2019/12/6 8:22:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[card] [varchar](50) NOT NULL,
	[password] [varchar](max) NOT NULL,
	[phone] [varchar](13) NOT NULL,
	[addTime] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[banner] ON 

INSERT [dbo].[banner] ([Id], [name], [img]) VALUES (1, N'藏品细节', N'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1572362194857&di=8744ba89ba09e1aa6942c1151d4e4440&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01ea875b911302a80121a0f76a1c0a.jpg%403000w_1l_2o_100sh.jpg')
INSERT [dbo].[banner] ([Id], [name], [img]) VALUES (2, N'藏品首页', N'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1572030984680&di=a28de48bde413cba37f9601d8357d17e&imgtype=0&src=http%3A%2F%2Fbig.justeasy.cn%2Feffect%2F201708%2F20170814220529_5991ae29a7197.jpg')
INSERT [dbo].[banner] ([Id], [name], [img]) VALUES (3, N'展览首页', N'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1572626131&di=4f8cf80996a1cfa15b64d86a8382f8ff&imgtype=jpg&er=1&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F014c5f5dac3ff8a801209e1fbf94c8.jpg%402o.jpg')
INSERT [dbo].[banner] ([Id], [name], [img]) VALUES (4, N'参观攻略', N'http://pic.rmb.bdstatic.com/e70f6fe7244f25b4b47b254e95567ca9.jpeg')
INSERT [dbo].[banner] ([Id], [name], [img]) VALUES (5, N'门票预约', N'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1573208905&di=6c84129abcc2bfb315815db40aaecbcb&imgtype=jpg&er=1&src=http%3A%2F%2Fimg1.dili360.com%2Fga%2FM00%2F26%2F28%2FwKgBzFR01aaAJx_gAAmJhKBMiUE938.jpg')
INSERT [dbo].[banner] ([Id], [name], [img]) VALUES (6, N'咨询问答', N'http://www.cpazz.com/uploads/file/news/2019/10/13/43417a8eedc06e64baf6a1560ee0efcb.jpg?x-oss-process=image/format,jpg')
SET IDENTITY_INSERT [dbo].[banner] OFF
SET IDENTITY_INSERT [dbo].[collection] ON 

INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (10, N'太和殿', N'https://img.dpm.org.cn/Uploads/Picture/2016/12/22/s585b38f00e48c.jpg', 20, 0, 0, N'太和殿，俗称“金銮殿”，位于紫禁城南北主轴线的显要位置，明永乐十八年（1420年）建成，称奉天殿。嘉靖四十一年（1562年）改称皇极殿。清顺治二年（1645年）改今名。自建成后屡遭焚毁，又多次重建，今天所见为清代康熙三十四年(1695年)重建后的形制。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (11, N'中和殿', N'https://img.dpm.org.cn/Uploads/Picture/2016/12/22/s585b38b930168.jpg', 20, 0, 0, N'中和殿，故宫外朝三大殿之一，位于紫禁城太和殿、保和殿之间。始建于明永乐十八年（1420年），明初称华盖殿，嘉靖时遭遇火灾，重修后改称中极殿，现天花内构件上仍遗留有明代“中极殿”墨迹。清顺治元年（1644年），清皇室入主紫禁城，第二年改中极殿为中和殿。殿名取自《礼记·中庸》：“中也者，天下之本也；和也者，天下之道也”之意。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (12, N'保和殿', N'https://img.dpm.org.cn/Uploads/Picture/2016/12/22/s585b3889f3e66.jpg', 20, 0, 0, N'　保和殿，故宫外朝三大殿之一。位于中和殿后，建成于明永乐十八年（1420年），初名谨身殿，嘉靖时遭火灾，重修后改称建极殿。清顺治二年改为保和殿。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (13, N'乾清宫', N'https://www.dpm.org.cn/Uploads/Picture/2016/12/22/s585b3852595a2.jpg', 20, 0, 0, N'乾清宫，内廷后三宫之一。始建于明代永乐十八年（1420年），明清两代曾因数次被焚毁而重建，现有建筑为清代嘉庆三年（1798年）所建。
　　乾清宫为黄琉璃瓦重檐庑殿顶，座落在单层汉白玉石台基之上，连廊面阔９间，进深５间，建筑面积1400㎡，自台面至正脊高20余米 ，檐角置脊兽９个，檐下上层单翘双昂七踩斗栱，下层单翘单昂五踩斗栱，饰金龙和玺彩画，三交六椀菱花隔扇门窗。殿内明间、东西次间相通，明间前檐减去金柱，梁架结构为减柱造形式，以扩大室内空间。后檐两金柱间设屏，屏前设宝座，宝座上方悬“正大光明”匾。东西两梢间为暖阁，后檐设仙楼，两尽间为穿堂，可通交泰殿、坤宁宫。殿内铺墁金砖。殿前宽敞的月台上，左右分别有铜龟、铜鹤，日晷、嘉量，前设鎏金香炉4座，正中出丹陛，接高台甬路与乾清门相连。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (14, N'交泰殿', N'https://www.dpm.org.cn/Uploads/Picture/2016/12/22/s585b381e7251b.jpg', 20, 0, 0, N'内廷后三宫之一，位于乾清宫和坤宁宫之间，约为明嘉靖年间建，顺治十二年（1655年）、康熙八年（1669年）重修，嘉庆二年（1797年）乾清宫失火，殃及此殿，是年重建。
　　交泰殿平面为方形，深、广各3间，单檐四角攒尖顶，铜镀金宝顶，黄琉璃瓦，双昂五踩斗栱，梁枋饰龙凤和玺彩画。四面明间开门，三交六椀菱花，龙凤裙板隔扇门各4扇，南面次间为槛窗，其余三面次间均为墙。殿内顶部为盘龙衔珠藻井，地面铺墁金砖。明间设宝座，上悬康熙帝御书“无为”匾，宝座后有板屏一面，上书乾隆帝御制《交泰殿铭》。东次间设铜壶滴漏，乾隆年后不再使用。西次间设大自鸣钟，宫内时间以此为准。
　　交泰殿为皇后千秋节受庆贺礼的地方。清代，于此殿贮清二十五宝玺。每年正月，由钦天监选择吉日吉时，设案开封陈宝，皇帝来此拈香行礼。清世祖所立“内宫不许干预政事”的铁牌曾立于此殿。皇帝大婚时，皇后的册、宝安设殿内左右案上。每年春季祀先蚕，皇后先一日在此查阅采桑的用具。
　　现为宫廷生活原状陈列。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (15, N'乾宁宫', N'https://www.dpm.org.cn/Uploads/Picture/2016/12/22/s585b37f03ce66.jpg', 20, 0, 0, N'坤宁宫是内廷后三宫之一，始建于明永乐十八年(1420年)，正德九年(1514年)、万历二十四年(1596年)两次毁于火，万历三十三年(1605年)重建。清沿明制于顺治二年(1645年)重修，十二年(1655年)仿沈阳盛京清宁宫再次重修。嘉庆二年(1797年)乾清宫失火，延烧此殿前檐，三年(1798年)重修。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (17, N'贤若宫', N'https://www.dpm.org.cn/Uploads/Picture/2016/12/22/s585b37bf60105.jpg', 20, 0, 0, N'咸若馆位于慈宁宫花园北部中央，是园中主体建筑，为清代太后、太妃礼佛之所。明代初建时称咸若亭，万历十一年（1583年）更名曰咸若馆。清乾隆年间先后大修、改建，即今所见形制。
　　馆坐北朝南，正殿5间，前出抱厦3间，四周出围廊。正殿为黄琉璃瓦歇山式顶，抱厦为黄琉璃瓦卷棚式顶。馆内装饰考究别致：梁檩上的龙凤和玺彩画灿然生辉，顶部的海墁花卉天花清丽淡雅。室内明间柱子的装饰颇具藏式佛殿之意味；贯通东、北、西三面墙壁的通连式金漆毗庐帽梯级大佛龛，给人以庄严神秘、佛法无边之感。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (18, N'寿康宫', N'https://img.dpm.org.cn/Uploads/Picture/2018/09/04/s5b8de36418992.jpg', 20, 0, 0, N'寿康宫，位于内廷外西路，慈宁宫西侧。清雍正十三年（1735年）始建，至乾隆元年（1736年）建成，嘉庆二十五年（1820年）、光绪十六年（1890年）重修。
　　寿康宫南北三进院，院墙外东、西、北三面均有夹道，西夹道外有房数间。院落南端寿康门为琉璃门，门前为一个封闭的小广场，广场东侧是徽音右门，可通慈宁宫。
　　寿康门内正殿即寿康宫。殿坐北朝南，面阔5间，进深3间，黄琉璃瓦歇山顶，前出廊，明间、次间各安三交六椀菱花槅扇门4扇，梢间为三交六椀菱花槅扇槛窗各4扇，后檐明间与前檐明间相同，其余开窗。殿内悬乾隆皇帝御书“慈寿凝禧”匾额，东西梢间辟为暖阁，东暖阁是皇太后日常礼佛之佛堂。殿前出月台，台前出三阶，中设御路石，月台左右亦各出一阶。
　　寿康宫东西配殿面阔各3间，黄琉璃瓦硬山顶，前出廊。东配殿明间安槅扇门，西配殿明间槅扇、风门为后来改装。次间均为槛窗，每间用间柱分为两组，窗棂均为一抹三件式。两配殿南设耳房，北为连檐通脊庑房，与后罩房相接。
　　寿康宫以北是第二进院，后殿为寿康宫的寝殿，额曰：“长乐敷华”，有甬道与寿康宫相连。殿面阔5间，进深3间，黄琉璃瓦歇山顶。前檐出廊，明间安步步锦槅扇、玻璃风门，次、稍间安窗，上为步步锦窗格，下为玻璃方窗。室内以槅扇分为5间。后檐明间开槅扇门，接叠落式穿堂，直达后罩房。
　　寿康宫为清代太皇太后、皇太后居所，太妃、太嫔随居于此，皇帝每隔两三日即至此行问安礼。乾隆朝孝圣宪皇太后、嘉庆朝颖贵太妃、咸丰朝康慈皇太后都曾在此颐养天年。孝圣宪皇太后去世后，乾隆皇帝仍于每年圣诞令节及上元节前一日至寿康宫拈香礼拜，瞻仰宝座，以申哀慕之情。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (19, N'养心殿', N'https://www.dpm.org.cn/Uploads/Picture/2016/12/22/s585b370b35c25.jpg', 20, 0, 0, N'　　养心殿，明代嘉靖年建，位于内廷乾清宫西侧。清初顺治皇帝病逝于此地。康熙年间，这里曾经作为宫中造办处的作坊，专门制作宫廷御用物品。自雍正皇帝居住养心殿后，造办处的各作坊遂逐渐迁出内廷，这里就一直作为清代皇帝的寝宫，至乾隆年加以改造、添建，成为一组集召见群臣、处理政务、皇帝读书、学习及居住为一体的多功能建筑群。一直到溥仪出宫，清代有八位皇帝先后居住在养心殿。 
　　养心殿为工字形殿，前殿面阔三间，通面阔36m,进深3间，通进深12m。黄琉璃瓦歇山式顶，明间、西次间接卷棚抱厦。前檐檐柱位，每间各加方柱两根，外观似9间。皇帝的宝座设在明间正中，上悬雍正御笔“中正仁和”匾。明间东侧的“东暖阁”内设宝座，向西，这里曾经是慈禧、慈安两太后垂帘听政处。明间西侧的西暖阁则分隔为数室，有皇帝看阅奏折、与大臣秘谈的小室，曰“勤政亲贤”殿，有乾隆皇帝的读书处三希堂，还有小佛堂、梅坞，是专为皇帝供佛、休息的地方。养心殿的后殿是皇帝的寝宫，共有五间，东西稍间为寝室，各设有床，皇帝可随意居住。后殿两侧各有耳房五间，东五间为皇后随居之处，西五间为贵妃等人居住。同治年间两宫皇太后垂帘听政时，慈安住在东侧的“体顺堂”，慈禧住在西侧的“燕禧堂”，随时登临前堂，处理政务，确是十分方便。寝宫两侧各设有围房十余间，房间矮小，陈设简单，是供妃嫔等人随侍时临时居住的地方。
　　养心殿前有琉璃门，曰“养心门”，门外有一东西狭长的院落，乾隆十五年（1750年）在此添建连房三座，房高不过墙，进深不足4m，为宫中太监、侍卫及值班官员的值宿之所。
　　现为宫廷原状陈列。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (20, N'储秀宫', N'https://www.dpm.org.cn/Uploads/Picture/2016/12/22/s585b36db6eec1.jpg', 20, 0, 0, N'　　储秀宫，内廷西六宫之一，明清时为妃嫔所居。始建于明永乐十八年（1420年），原名寿昌宫，嘉靖十四年（1535年）改曰储秀宫。清代曾多次修葺，光绪十年（1884年）为庆祝慈禧五十寿辰，耗费白银63万两进行大规模整修，现存建筑为光绪十年重修后的形制。
　　储秀宫原为二进院，清晚期拆除了储秀门及围墙，并将翊坤宫后殿改为穿堂殿，称体和殿，连通储秀宫与翊坤宫，形成相通的四进院落。储秀宫前廊与东西配殿前廊及体和殿后檐廊转角相连，构成迴廊。迴廊墙壁上镶贴的琉璃烧制的万寿无疆赋是众臣为祝慈禧寿辰所撰。 
　　储秀宫为单檐歇山顶，面阔5间，前出廊。檐下施斗栱，梁枋饰以淡雅的苏式彩画。门为楠木雕万字锦底、五蝠捧寿、万福万寿裙板隔扇门；窗饰万字团寿纹步步锦支摘窗。内檐装修精巧华丽。明间正中设地屏宝座，后置5扇紫檀嵌寿字镜心屏风，上悬“大圆宝镜”匾。东侧有花梨木雕竹纹裙板玻璃隔扇，西侧有花梨木雕玉兰纹裙板玻璃隔扇，分别将东西次间与明间隔开。东次、梢间以花梨木透雕缠枝葡萄纹落地罩相隔；西次、梢间以一道花梨木雕万福万寿纹为边框内镶大玻璃的隔扇相隔，内设避风隔，西梢间作为暖阁，是居住的寝室。
　　储秀宫的庭院宽敞幽静，两棵苍劲的古柏耸立其中，殿台基下东西两侧安置一对戏珠铜龙和一对铜梅花鹿，为光绪十年慈禧五十大寿时所铸。东西配殿为养和殿、绥福殿，均为面阔3间的硬山顶建筑。
　　后殿为丽景轩，面阔5间，单檐硬山顶，有东西配殿曰凤光室、猗兰馆。慈禧入宫后曾居住储秀宫后殿，并在此生下同治皇帝。光绪十年慈禧五十大寿时又移居储秀宫，并将后殿定名为丽景轩。
　　现为宫廷生活原状陈列。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (22, N'皇极殿', N'https://www.dpm.org.cn/Uploads/Picture/2016/12/22/s585b363502ae9.jpg', 20, 0, 0, N'　　皇极殿为宁寿宫区的主体建筑，始建于清康熙二十八年(1689年)，初名宁寿宫。乾隆三十七年(1772年)至四十一年(1776年)改建宁寿宫一区建筑时，将宁寿宫改称为皇极殿，作为乾隆皇帝归政后临朝受贺之所。
　　皇极殿位于宁寿宫区中轴线前部，与后殿宁寿宫前后排列于单层石台基之上。殿座北朝南，面阔9间，进深5间，取帝尊九五之制。黄琉璃瓦重檐庑殿顶，前檐出廊，枋下浑金雕龙雀替。明间，左、右次间设殿门，余各次间下砌槛墙。后檐明、次间辟为殿后门，可达宁寿宫，余各间砌墙。殿中四根沥粉贴金蟠龙柱，顶置八角浑金蟠龙藻井，下设宝座，品级仅次于太和殿。殿内左置铜壶滴漏，右置大自鸣钟，制作考究。
　　殿建于青白石须弥座上，前出月台。御路与甬道相接，直贯宁寿门，四周通饰汉白玉石栏板。月台左右及甬道两侧各设台阶。殿两侧为垂花门、看墙，分别与东、西庑房相接，将院落隔为前后两进。庑中开门，东为凝祺门，西为昌泽门。
　　皇极殿丹陛左右分置日晷、嘉量，是体现皇权的重要陈设。御道两侧各有六方须弥座一个，座上置重檐六角亭，亭身每面镌篆体寿字各三。石座中心有铸铁胆，每年腊月二十三至正月十五日，则改立灯杆于其中，是古代多用途基座实例，今仅存其座。另外，乾隆三十八年(1773年)曾成造并安设铜龟、铜鹤各一对，鼎炉两对，今皆不存。
　　皇极殿为仿乾清宫制度改造。嘉庆元年（1796年）新正，传位授宝典后，太上皇乾隆帝于此举行“千叟宴”，宴请90岁以上老人，时入宴群臣、耆老及并未入座者达五千余人。嘉庆七年（1805年）、光绪十年（1884年）先后修葺。光绪二十年（1894年）在皇极殿行慈禧六十寿辰贺礼。光绪三十年（1904年）西太后七十岁生日前后，在此分别接见奥、美等9国使臣。慈禧死后，曾在此停灵、治丧。
　　皇极殿彩画原为金龙和玺彩画，慈禧太后六十寿辰在此祝寿，将外檐改为枋心苏式彩画。1979年重新修缮后，恢复了乾隆时期的风貌。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (23, N' 新石器时代的陶器', N'https://img.dpm.org.cn/Uploads/Picture/2017/01/06/s586f1357189db.jpg', 16, 0, 0, N'陶器是随着原始农业的出现和人类定居生活的需要而产生的。考古发现所获得的资料证明，我国的陶器生产距今已有10000多年的历史，陶器是原始先民主要的日常生产和生活用具。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (24, N'瓷国寻踪', N'https://img.dpm.org.cn/Uploads/Picture/2017/01/06/s586f1342984f0.jpg', 16, 0, 0, N' 商周时期，人们主要的日常生活用具仍然是陶器。商代除了大量烧造灰陶以外，还烧造出精美的刻纹白陶和印纹硬陶。约在商代中期出现了原始瓷，为后来瓷器的发明奠定了基础。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (25, N'青瓷独秀', N'https://img.dpm.org.cn/Uploads/Picture/2017/01/06/s586f1312636f8.jpg', 16, 0, 0, N'  三国、两晋、南北朝历经360余年，陶瓷生产发展迅速。南方制瓷技术明显提高，瓷器产区和规模不断扩大，江苏、浙江、福建、江西、湖南、湖北、四川省等境内均有窑址分布。所产瓷器以青瓷为主，器物造型以日常生活所用盘、碗、壶、罐、槅、洗、谷仓、烛台、虎子、唾壶、薰炉等较为多见。产品各具地方特色。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (26, N'名窑迭出', N'https://img.dpm.org.cn/Uploads/Picture/2017/01/06/s586f137f56f0f.jpg', 16, 0, 0, N'宋代陶瓷业蓬勃发展，名窑遍布全国各地，出现了陶瓷史上前所未有的兴盛局面。在民窑发展的基础上，朝廷也在南北各地设窑专门烧造宫廷用瓷，名曰“官窑”。汝、官、哥、定、钧窑等“五大名窑”瓷器备受后人推崇。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (27, N'瓷都奠基', N'https://img.dpm.org.cn/Uploads/Picture/2017/01/06/s586f1393af13e.jpg', 16, 0, 0, N'　　公元1279年，元王朝统一了中国。海外贸易的蓬勃发展，进一步刺激了陶瓷业的兴盛。钧窑、磁州窑、龙泉窑等继续生产传统陶瓷品种，其产品不但畅销国内，而且远销国外。景德镇则得天时、地利、人和，异军突起，青花、釉里红、卵白釉、蓝釉、红釉瓷等新品种层出不穷，遂使景德镇一举成为全国最重要的瓷器产地')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (28, N'繁荣昌盛', N'https://img.dpm.org.cn/Uploads/Picture/2017/01/06/s586f13aa59b9e.jpg', 16, 0, 0, N'  明代自洪武二年（1369年）起，朝廷即在景德镇设御器厂专门烧造宫廷用瓷，这就是俗称的“官窑瓷器”。此后，历朝沿袭此种制度。明代的窑业分为官窑和民窑两种。前者专烧宫廷御用瓷，不计成本，质量精美；后者则属商品生产，产量大，艺术风格古朴潇洒。官窑的发展带动了民窑的兴盛，当时景德镇从事陶瓷生产的工人达十余万人，天下至精至美之瓷器莫不出于景德镇，景德镇遂成为全国的制瓷中心。青花瓷、彩瓷和颜色釉瓷是其主要品种，历朝均有精品传世。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (29, N'明末清初的景德镇窑瓷器', N'https://img.dpm.org.cn/Uploads/Picture/2017/01/06/s586f12cec0117.jpg', 16, 0, 0, N'在从明代万历三十五年（1607年）到清代康熙中期（约1676—1700年）将近一百年的时间里，随着农民起义的蓬勃发展，直至摧毁明王朝的统治和清朝入主中原，中国社会曾发生剧烈变革。作为全国制瓷中心的景德镇，其瓷器制造业也经历了一次重大转变。主要表现在万历三十五年以前，景德镇的制瓷业是由官窑占统治地位，此后，官窑急剧衰落，民营瓷业则因国内和亚欧市场需求的刺激而渐趋兴盛，跃居主导地位。以往人们曾将17世纪这一时期景德镇的制瓷业称为“转变期”或“转型期”。 ')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (30, N'清代康熙、雍正、乾隆景德镇官窑及清代其他地方窑陶瓷', N'https://img.dpm.org.cn/Uploads/Picture/2017/01/06/s586f132b191cd.jpg', 16, 0, 0, N'清代景德镇窑沿袭明制，亦分为官窑和民窑。清朝统治者革除了明朝在手工业方面的一些弊病，废除了官窑的编役制，将明末出现的“官搭民烧”作为定制，从而出现官民竞争的局面，刺激了民窑的进一步发展。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (31, N'清代晚期瓷器', N'https://img.dpm.org.cn/Uploads/Picture/2017/01/06/s586f13fd39976.jpg', 16, 0, 0, N'　清道光二十年（1840年）鸦片战争以后，随着内忧外患接踵而至和清王朝的日趋衰败，景德镇的制瓷业亦总体上呈现逐渐衰退的局面。但清代晚期官窑瓷器仍然有光辉的亮点，如皇帝大婚和皇太后庆寿用成套餐具的批量生产等，有如晚霞余辉，令人称羡。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (32, N'中国瓷器的外销', N'https://img.dpm.org.cn/Uploads/Picture/2017/01/06/s586f1422b1f88.jpg', 16, 0, 0, N'　　中国陶瓷生产有着大约10000多年绵延不断的历史，堪称世界工艺史上的一大奇迹，为人类文明的发展做出过杰出贡献。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (35, N'清宫造办', N'https://img.dpm.org.cn/Uploads/Picture/2017/01/05/s586e392f225a1.jpg', 17, 0, 0, N'清代在内务府造办处下设做钟处，以制造、修缮钟表为专职。乾隆时期是做钟处制造钟表的鼎盛时期，它以承造更钟、自鸣钟、时乐钟为主。尤其更钟，把我国传统夜间计时的“更”与西方计时的“时”、“分”有机地结合起来，并能根据节气的变化而调整“更”的长短，极为符合传统计时习惯。宫中承做的这些钟表，多以优良木材为外壳，上嵌珐琅或描以金漆等，色调庄严凝重。造型以中国传统的建筑形式为主。玩艺系统多选祝颂福寿的题材，机械结构用发条或坠砣带动齿轮转动。这些钟表既继承了我国的工艺传统，又融汇了东西计时之法，形成别具一格的皇家风范。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (36, N'苏州之韵', N'https://img.dpm.org.cn/Uploads/Picture/2017/01/05/s586e391397539.jpg', 17, 0, 0, N'苏州是我国资本主义萌芽最早的城市之一。在清代苏州的各种手工业都获得了长足发展。18世纪开始兴起钟表制造业，19世纪后技术日臻完善。所造钟表有摆钟、更钟、三套钟、插屏钟等形式。这些钟表不仅具计时功能，还能反映日月星辰变化与四时节气更替，并装饰有趣的玩艺系统。造型简洁、色调清雅，尤其钟盘体大突出，实用性强，成为苏州钟表的显著特点。在制作工艺上，钟盘面板錾花细腻精美，钟碗报时声音清脆洪亮，呈现其技术优势。苏州钟表代表江南钟表的风格，以其独特的艺术魅力与精湛的制作技术，在昔日帝后奢华的生活中占有一席之地。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (37, N'广州精华', N'https://img.dpm.org.cn/Uploads/Picture/2017/01/05/s586e3906d455e.jpg', 17, 0, 0, N'       清代康熙二十三年（1684年）诏开海禁后，广州成为对西洋贸易开放的唯一口岸。在欧洲舶来钟表的影响下，广州开始仿照欧洲钟表的机械装置，结合中国的传统工艺，制造出具有浓郁民族风格的钟表。所造钟表的造型大多是亭、台、楼、阁、塔、葫芦、花盆等形式；顶部及四角皆饰以花束；外壳为色彩鲜艳的铜胎珐琅，并嵌以各色料石；通体装饰得富丽堂皇。表现题材以我国传统中富有吉祥寓意、祝颂太平、庆寿祈福等为主，同时也反映了社会生活的内容。机械结构以发条、链条、塔轮组成动力源，既能走时报点，又有转花、跑人、卷帘、水法、奏乐等玩艺系统。18世纪后期，广州所制钟表已堪与英国钟表相媲美，反映了我国自制钟表技术的水平。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (38, N'英伦遗珍', N'https://img.dpm.org.cn/Uploads/Picture/2017/01/05/s586e38f8497d7.jpg', 17, 0, 0, N'   中国市场的需要促进了英国钟表制作的发展，于18世纪通过广州粤海关大量销入我国。它们以铜质镀金为外壳，上嵌色彩缤纷的料石花，富于华丽高贵之感。造型多彩多姿，善用各种动物作底托，置表盘于其上部，下部饰以彩漆风景画和珐琅人物画，或雕刻山石动物等。表现题材广泛，或为古希腊神话，或为大自然美景，或为欧洲社会风情，或为我国传统的祥瑞题材以迎合中国人的心态。这些钟表除计时的主要功能外，普遍装有奏乐、水法、转花、跑人、禽嬉、鸟鸣等玩艺系统。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (39, N'世家杰作', N'https://img.dpm.org.cn/Uploads/Picture/2017/01/05/s586e38e93ce66.jpg', 17, 0, 0, N'       詹姆斯·考克斯（James·Cox），在1760-1765年间曾创造了一座以气压升降调节钟弦松紧的水银瓶气压钟，被誉为永衡运行钟。1783—1792年，考克斯父子还在广州设立公司，制作销售英式钟表。这些精美钟表的盘上都署有James·Cox的名字，还在钟盘体或钥匙上镌刻有制作年代。

　　约瑟夫·威廉森（Joseph·Williamson）是安妮女王时期（1702—1714年）杰出的钟表师，出身于英国著名钟表世家。他发明了当时走时最准确的天文时钟，以及标明日期、星期的日历钟。18世纪末，蒂莫西·威廉森（Timothy·Williamson）继承其祖先的钟表事业。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (40, N'多国荟萃', N'https://img.dpm.org.cn/Uploads/Picture/2017/01/05/s586e38d9e7876.jpg', 17, 0, 0, N'
　　这里展出的是瑞士、美国、日本、英国的小型钟表。瑞士钟表业是由法国传入的。之后瑞士钟表制造业的工业化进程颇快，其产品于19世纪末20世纪初进入我国。瑞士钟表造型别致，装饰精美，材料贵重，受到中国市场的欢迎。20世纪美国、日本从欧洲传入了制作钟表的技术，钟表造型小巧玲珑，外壳金碧辉煌，有很高的艺术造诣。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (41, N'法国撷英', N'https://img.dpm.org.cn/Uploads/Picture/2017/01/05/s586e38cc0ce38.jpg', 17, 0, 0, N'       法国是制造钟表比较早的国家之一。故宫收藏的法国钟表属于晚期作品。法国钟表的进入，打破了英国钟表长期独占中国市场的格局。清代宫廷内使用的法国钟表，造型凝练，有奖杯、亭、围屏等形式，尤其注重把近代科技发明融入造型之中，制作出火车、汽车、轮船、热气球等各种新款式钟表。法国钟表的动力结构也独具特色，除以发条为动力源外，还发明了以钢球、钟体压力及机芯坠砣等为动力源的钟表。某些钟表除计时表盘外，还装置寒暑表与风雨表，集多种功能于一体。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (42, N'名匠精品', N'https://img.dpm.org.cn/Uploads/Picture/2017/01/05/s586e3947da469.jpg', 17, 0, 0, N'
       英国18世纪的钟表师榜上有名的有巴伯特（Barbot）、乔治·希金森（George·Higginson）、约翰·贝内特（John·Bennett）、约翰·泰勒（John·Taylor）、罗伯特·菲利普（Robert·Philip）等。他们在其制造的钟表上均有署名。

　　其中约翰·贝内特出身于钟表制造商之家。1836年，他在伦敦切珀赛德（Cheapside）65号开设工厂和商店，制造并出售钟表。1858年，他创立英国钟表制造协会。1872年，约翰·贝内特因卓越的技艺被维多利亚女王授予爵士称号。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (43, N'陈设景观', N'https://img.dpm.org.cn/Uploads/Picture/2017/01/05/s586e38ab0559d.jpg', 17, 0, 0, N'       钟表具有使用、陈设和娱乐等功能。这里展示的是以各式钟表组合的景观，不仅是宫中的计时器，也是取悦于帝后的娱乐用具。如迎手钟，皇帝可以随时扶靠，用手轻按即发出悦耳的音乐；紫檀插屏钟不仅能报时，还能奏乐；冠架钟是放置皇帝帽子的用具；铜镀金镜表箱内有化妆用品等，后妃既可看时间，又可在镜前梳妆打扮；还有香水瓶表，外壳嵌有小表；鸟音笼钟和鹦鹉钟，能给人带来悦耳的鸟音声。作为消遣的一种方式，同时也反映了西方工业革命对清代宫廷生活的渗透。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (44, N'西方袖珍', N'https://img.dpm.org.cn/Uploads/Picture/2017/01/05/s586e38bf3873b.jpg', 17, 0, 0, N'       19世纪西方国家开始制造形体小巧的各式袖珍表。其中以便于随身携带、实用性强的挂表为主，亦有胸针、带扣、规矩箱、望远镜等多功能小表。袖珍表造型丰富，有圆形、椭圆形、瓶形、多角形、扇形、锁形、昆虫形、果实形、如意形等。袖珍表装饰考究、材质珍贵，多以珍珠、钻石、宝石、料石等镶嵌外缘，表壳则嵌以色彩鲜艳的西洋珐琅画或以珠宝联缀成各式图案。早期的袖珍表尚需独立的钥匙上弦。为此，表上均配以玲珑剔透的链条，使表与钥匙相连，同时也作为表身以外华美的装饰。袖珍表因其体小实用、品质尊贵，颇受帝后及显贵们的青睐。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (45, N'钟表演示', N'https://img.dpm.org.cn/Uploads/Picture/2017/01/05/s586e393b79577.jpg', 17, 0, 0, N'       这里展示的是老式机械钟表。钟表多由动力、传动、调速和跟踪部分等组成，走时、打点、打乐和表演功能等都是靠复杂的机械传动来完成。最初以水和重锤为原动力，后逐渐以发条取代，通过齿轮啮合及凸轮与连杆的传递，带动跟踪部件按照预设的机械程序完成指示时间、打刻打点、奏乐表演等相应动作。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (46, N'珠光宝气——珠宝饰品与珠宝镶嵌类器物', N'https://img.dpm.org.cn/Uploads/Picture/2019/07/10/s5d258c058254d.jpg', 18, 0, 0, N'　　珠宝镶嵌是清代工艺中一个重要的装饰手段。就取材范围而言，比以往有所拓宽，在传统的玉石之外，还十分重视满族发祥之地的特产——东珠，此外还常用翡翠、碧玺、青金石、绿松石等彩色矿石和受西方文化影响而引入的钻石、红宝石、蓝宝石、祖母绿、猫睛石等，种类繁多，异彩纷呈。在设计上，往往采取多种材质和装饰手段复合叠加，使璀璨的珠宝、艳丽的点翠与精巧的金银累丝巧妙搭配，相得益彰，将民族特点、文化交融与时代风尚凝聚一身，淋漓尽致地展现出当时人们对富贵吉祥的渴望和追求。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (47, N'金昭银辉——清宫收藏金银器', N'https://img.dpm.org.cn/Uploads/Picture/2019/08/01/s5d42a90325bf0.jpg', 18, 0, 0, N'　自古以来，金、银即因其稀有的属性而成为财富与地位的象征。以金、银制作而成的精美器皿，则不仅彰显经济的丰足，也代表着一个时代工艺发展的水平。 

　　清代金银器制作十分兴盛，特别是皇室御用，其材料之靡费、品类之丰富、技艺之精湛，都达到前所未有的高度。用途则涉及礼制、宗教、陈设、日用等各方面，体现出鲜明的宫廷特色与恢弘的国家气象，为我们研究那个时代的历史文化提供了宝贵的资料。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (48, N'球琳集萃——玉及彩石', N'https://img.dpm.org.cn/Uploads/Picture/2019/07/19/s5d318be94b7ea.jpg', 18, 0, 0, N'　　清代是中国古代玉石工艺发展的一个高峰，而乾隆时期的宫廷玉雕，更是取得了极高的成就。当时的制作者非常重视对原材料的选择，新疆和田玉依然占据着产品的主流。除了常见的白玉、青玉外，黄玉、碧玉等颜色的玉料也获得了充分的开发与利用。而翡翠在清代中晚期成为皇室新宠，地位不断提高，谱写出玉雕工艺的新篇章。此外，还有为数可观的玛瑙、水晶、青金石、绿松石、孔雀石、芙蓉石、寿山石等材质的器物传世，其丰富多彩的面貌与新意迭出的意匠令人赞叹，其精雕细琢的工艺则代表了清代玉石雕刻的水平。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (49, N'金枝玉叶——宝石盆景', N'https://img.dpm.org.cn/Uploads/Picture/2019/07/19/s5d318bc9b7b28.jpg', 18, 0, 0, N'　　清代宫廷遗留下来一类人工制造的宝石盆景，主要使用各种金银贵金属与稀有宝石，以惟妙惟肖地模仿天然盆景形态为旨归，表面上看来是仿生，实则是“吉祥”符号的累加，妙在二者和谐统一。宝石盆景在宫廷陈设中不可或缺，还是年节庆典中重要的贡品类型，它们反映出清代皇室独特的审美趣味和文化心理，也代表了当时的工艺水平。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (50, N'演戏机构与演员', N'https://img.dpm.org.cn/Uploads/Picture/2017/01/05/s586e30633f9e7.jpg', 19, 0, 0, N'清宫设立专门机构管理戏曲排练与演出等事务。清初承袭明宫教坊司旧制，康熙朝设“南府” 与“景山”，道光七年(1827年)南府改组为升平署，并一直沿袭至清末。清宫承应演戏的艺人，南府时代主要有“内学”与“外学”，内学指太监伶人，外学由来自江南等地的优秀民间艺人及从内务府三旗子弟中挑选的旗籍伶人组成；升平署时代则主要由太监艺人承差。光绪初年，慈禧太后为欣赏时兴的西皮、二黄诸腔戏，又以其寝居长春宫的近侍太监为主成立“普天同庆”本宫班。晚清时期，升平署还挑选大量的民间戏班与著名演员入宫承应。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (51, N'戏画', N'https://img.dpm.org.cn/Uploads/Picture/2017/01/05/s586e30420a8f8.jpg', 19, 0, 0, N'　　宫廷戏曲画是描绘晚清宫廷戏曲演出场景的画作，绢本，工笔，设色。咸丰年间，徽班入宫演出，令人耳目一新。因而，内务府如意馆画士秉承皇帝的旨意作画，撷取精彩的戏剧场面定格下来，以备观赏。这些戏画均为工笔细描之作，将人物的脸谱服饰、言情神态及桌椅砌末等均细致真切地绘出，据此可对照出现藏的某些戏衣实物和具体的剧情片段。宫廷戏画真实地再现了当年演员绝佳的扮相，是宫廷戏曲活动丰富、具体的形象资料。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (52, N'宫苑戏台', N'https://img.dpm.org.cn/Uploads/Picture/2017/01/05/s586e304d0182e.jpg', 19, 0, 0, N'　戏曲活动的日渐兴盛使得戏台的营造也达到登峰造极的地步。宫中戏台形式多样，结构精巧，装饰奢华，已成为宫殿建筑的重要组成部分。戏台的功能划分更便于帝后赏戏，有建于室内以演宴戏、岔曲为主的小戏台；有与寝宫为邻，以承朔望、年节频繁演戏的中型戏台；还有结构特殊、非宫廷不备、专演群仙神道祝寿和连台本戏的三层大戏台。戏台已不仅限于禁宫，皇帝驻跸的苑囿行宫中所建戏台堪与宫中媲美。戏台的建造以乾隆时期最盛。')
INSERT [dbo].[collection] ([Id], [title], [img], [succinct_id], [_new ], [hot], [introduce]) VALUES (53, N'行头、砌末和乐器', N'https://img.dpm.org.cn/Uploads/Picture/2017/01/05/s586e30717c1f9.jpg', 19, 0, 0, N'　由于帝后的爱好与提倡，宫廷演戏空前兴盛，其排场规模也反映在戏剧的行头、砌末、乐器上。砌末为剧中各种道具的总称，种类繁多，用途广泛。伴奏乐器有管弦乐器、打击乐器等。清宫演戏以乾隆、光绪两朝最盛，所存文物也以这两个时期为多')
SET IDENTITY_INSERT [dbo].[collection] OFF
SET IDENTITY_INSERT [dbo].[config] ON 

INSERT [dbo].[config] ([Id], [A1], [A2], [A3], [A4], [A5], [A6]) VALUES (1, N'08:00', N'18:00', N'今日藏馆上新请敬请期待', N'156487', NULL, NULL)
SET IDENTITY_INSERT [dbo].[config] OFF
SET IDENTITY_INSERT [dbo].[exhibit] ON 

INSERT [dbo].[exhibit] ([Id], [title], [img], [introduce], [address], [start_time], [end_time], [_new], [hot], [content], [type]) VALUES (7, N'世界之美，美美与共——2019一带一路人文历史摄影展圆满结束', N'http://pic.people.com.cn/NMediaFile/2019/1101/MAIN201911011659000148385120630.jpg', N'自5月29日起，一带一路人文历史摄影展正式启动，面向全国广大摄影人及摄影爱好者征集以“一带一路”合作国家及国内相关省、市、区的人文历史、文化遗产等为主题的摄影作品。', N'慈宁宫花园东院', CAST(N'2019-10-10' AS Date), CAST(N'2019-10-26' AS Date), 0, 0, N'展览于10月11日至27日在故宫博物院的慈宁宫花园东院展出。这是第一次在故宫举办关于“一带一路”的摄影展。正如故宫博物院院长王旭东在摄影展的开幕仪式上所说：“在故宫这座历经600年历史的文化殿堂举办“一带一路”人文历史摄影展，会带给公众更丰富的人文积淀和美的享受。”
本次摄影展获得了非常大的反响，众多摄影人踊跃投稿，到9月1日截稿时，共收到投稿作品两万多幅。此外，展览也得到华为新影像大赛、五粮液、中国银联等品牌的大力支持。经过组委会和知名摄影家、文化专家的认真遴选，最终，共有253幅优秀作品参与展览。', 3)
INSERT [dbo].[exhibit] ([Id], [title], [img], [introduce], [address], [start_time], [end_time], [_new], [hot], [content], [type]) VALUES (8, N'纪念 ｜ 于倬云诞辰百年，故宫讲述古建工程师一甲子', N'https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=1570024917,1988130266&fm=173&app=49&f=JPEG?w=600&h=400&s=C6C2F90D72EA2B0F3630B09B030060C3', N'“故事集：古建工程师的一甲子——于倬云诞辰百年纪念展”将持续至2020年5月，凭故宫博物院大门票免费参观。', N'东华门展厅', CAST(N'2018-12-14' AS Date), CAST(N'2020-03-04' AS Date), 0, 0, N'今年是于倬云先生诞辰百年纪念，东华门古建馆特意为此进行改陈，以“于倬云的文物建筑保护实践之路”为主题，展示从民国到二十世纪末的不同历史时期，一个坚定的故宫守护者对时代的回应。在国家政治、经济状况不断变化的60多年间，他从一名文整会的试用技士成长为故宫文物建筑保护的技术带头人和实践者的历程。展览选取于倬云先生职业生涯中若干重要事件，置于大时代背景之中，讲述故宫古建筑保护事业的发展，以及于倬云先生与同仁们在这一过程中的思考、付出与成就。', 0)
INSERT [dbo].[exhibit] ([Id], [title], [img], [introduce], [address], [start_time], [end_time], [_new], [hot], [content], [type]) VALUES (9, N'营造之道 — 紫禁城建筑艺术展', N'https://www.artlib.cn/ueditor1/jsp/upload/image/20170324/1490342701396037504.jpg', N'故宫博物院是一座建立在明清两朝皇宫——紫禁城基础上的特殊博物馆，它的建筑成就分布在72万m2的宫院之中，「营造之道 — 紫禁城建筑艺术展」力求通过「立足本体」、「揭示内涵」、「深层联系」三部分帮助观众深入理解紫禁城的建筑艺术。', N'故宫博物院', CAST(N'2020-01-09' AS Date), CAST(N'2021-07-07' AS Date), 0, 0, N'展览选址——故宫东南部的东华门区域本身就是故宫重要的文物建筑，这里不仅是展览场地，更是主要的展品，主要的参观体验对象。经过保护修缮的东华门和做法古老稀见的东南角楼内存有许多珍贵的、值得展示的历史遗迹和信息，如东华门内檐彩画和斗拱、东南角楼瓦兽件和木结构做法等，这部分展览旨在让观众解读建筑中特殊而丰富的历史信息。展览通过呈现故宫、国家图书馆等处收藏的图样、烫样等古建筑设计文物资料，展示古建筑设计意匠。', 0)
INSERT [dbo].[exhibit] ([Id], [title], [img], [introduce], [address], [start_time], [end_time], [_new], [hot], [content], [type]) VALUES (10, N'“釉彩国度——葡萄牙瓷板画500年”', N'http://5b0988e595225.cdn.sohucs.com/images/20190703/7771f9dc8e5d4317b5213cc80c7d7327.jpeg', N'“釉彩国度——葡萄牙瓷板画500年”展在故宫博物院永寿宫拉开帷幕。中国文化和旅游部部长雒树刚、葡萄牙文化部部长格拉萨·丰塞卡、故宫博物院院长王旭东、葡萄牙驻华大使杜傲杰等出席展览开幕式。', N'永寿宫展厅', CAST(N'2019-06-11' AS Date), CAST(N'2019-10-06' AS Date), 0, 0, N'这是故宫博物院首次与葡萄牙国立瓷板画博物馆合作举办的展览，共展出16世纪至21世纪50余幅葡萄牙瓷板画精品。由于每幅瓷板画都是由数块瓷板拼接而成，因此用于本次展览的瓷板多达5000块。这些展品颇具代表性，贯穿葡萄牙瓷板画500余年历史，观众可以从中感受到葡萄牙瓷板画风格的变迁：16世纪早期瓷板画构图严谨、装饰性强，属于基督教艺术与伊斯兰艺术的混合体；17世纪瓷板画上的狩猎图，色彩搭配协调、画面干净明快，人物栩栩如生、活泼有趣，有一种小清新的田园情调；18世纪的一幅作品勾画出葡萄牙人想象中的中国人生活场景，把孩子抱在膝头的妇女、勤勉做着家务的夫妻、吹着笛子与女孩玩耍的妈妈等，和谐安宁。从这些作品可以发现，19世纪工业革命极大改变了葡萄牙瓷板画的艺术风格；20世纪之后，葡萄牙瓷板画接受新艺术潮流，用抽象、夸张、变形的风格表达创作者的内心思想。', 3)
INSERT [dbo].[exhibit] ([Id], [title], [img], [introduce], [address], [start_time], [end_time], [_new], [hot], [content], [type]) VALUES (11, N'“国色天香——紫禁城里赏牡丹”故宫菏泽牡丹展', N'http://heze.dzwww.com/news/201904/W020190430578147722131.jpg', N'2019年4月30日，由故宫博物院、菏泽市人民政府主办的“国色天香——紫禁城里赏牡丹”故宫菏泽牡丹展开幕式在故宫博物院慈宁宫花园举行。展览精选了菏泽具有代表性的优质牡丹70种，在故宫博物院慈宁宫区域、长信门广场、慈宁宫花园再现京城春季牡丹盛开的美景。', N'慈宁宫', CAST(N'2019-04-29' AS Date), CAST(N'2019-05-11' AS Date), 0, 0, N'唯有牡丹真国色，花开时节动京城。牡丹，又名木芍药、百两金、富贵花等，枝繁叶茂，富丽端妍，是中国传统名花之一，其雍容华贵的气质、富贵吉祥的美好寓意寄托了对国家繁荣昌盛的期盼。自古我国就有观赏牡丹的爱好，康熙六十一年（1722年），十二岁的弘历在父亲的安排下第一次见到祖父康熙帝，三代帝王共赏人间第一富贵花的场景为后世史家津津乐道。雍正帝更是以“叠云层石秀，曲水绕台斜。天下无双品，人间第一花”盛赞牡丹。


　　菏泽古称曹州，是我国最重要的牡丹产地之一，自古便有“曹州牡丹甲天下”的美誉。清代时期，山东曹州已成为全国牡丹栽培中心，直至乾隆二十九年（1764年）山东巡抚一直为清廷进贡牡丹。


　　2013年11月26日，习近平总书记视察菏泽，专门考察了菏泽牡丹产业，并对牡丹产业寄予厚望。此次菏泽牡丹在故宫盛放，是现代牡丹花卉、牡丹文化和牡丹产业在菏泽发展的集中展示，也是贯彻落实习近平总书记发展牡丹产业的指示。


　　本次展览分为引、颂、造、品四个部分。“引”：通过10根牡丹诗词花柱展示唐宋明清时期牡丹诗词文化，发掘深厚的牡丹文化内涵，让观众在享受视觉美好的同时，浸润中华传统文化的熏陶。“颂”：通过“慈”“宁”“寿”“康”花坛装点慈宁宫，咏颂这座因孝心而建的宫殿及植根于中华民族五千多年文明历史所孕育的中华优秀传统文化“孝”。“造”：通过牡丹花海、牡丹非遗、牡丹文化衍生品展示，让观众了解菏泽的牡丹文化及牡丹产业发展；“品”部分为牡丹知识科普，70种精品牡丹错落分布，与慈宁宫花园临溪亭南北花台的牡丹相互辉映，在这里不仅能观赏到难得一见的黄牡丹、黑牡丹、绿牡丹、白牡丹，还能了解各种牡丹知识。


　　展览中观众还可以通过多媒体交互技术近距离走进花的海洋。在“花开盛世”数字体验厅里，上千朵花艺作品悬挂于空中，观众进入时，花束在空中缓缓升降，在空中自由表演。


　　本次展览于2019年4月30日正式向公众开放，展期至2019年5月12日，观众凭故宫博物院门票免费参观。', 3)
SET IDENTITY_INSERT [dbo].[exhibit] OFF
SET IDENTITY_INSERT [dbo].[exhibit_reservation] ON 

INSERT [dbo].[exhibit_reservation] ([Id], [exhibit_id], [user_id], [addTime]) VALUES (37, 9, 3, CAST(N'2019-12-05T11:34:26.5470000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[exhibit_reservation] OFF
SET IDENTITY_INSERT [dbo].[home_banner] ON 

INSERT [dbo].[home_banner] ([Id], [banner], [note], [url]) VALUES (20, N'https://img.dpm.org.cn/Uploads/Picture/2018/12/14/s5c135ca6d77c2.jpg', N'于云诞辰百年纪念展', N'http://localhost:8082/#/patch/patch-detail?id=8')
INSERT [dbo].[home_banner] ([Id], [banner], [note], [url]) VALUES (21, N'https://img.dpm.org.cn/Uploads/Picture/2019/07/16/s5d2d812c115f1.jpg', N'数字博物馆', N'http://localhost:8082/#/exhibit/succinct')
SET IDENTITY_INSERT [dbo].[home_banner] OFF
SET IDENTITY_INSERT [dbo].[questions] ON 

INSERT [dbo].[questions] ([Id], [question], [answer], [addtime], [user_id], [img], [type]) VALUES (19, N'您好，我想问一下清明节故宫开吗', N'啊清明节开放的哟！平时周一闭馆，法定假日及暑假7～8月除外。
故宫采取游客限流，平时6万人一天，节假日8万人一天。
由于游客众多，最好提前预订，否则很可能买不到票', CAST(N'2019-10-26' AS Date), 3, NULL, N'咨询')
INSERT [dbo].[questions] ([Id], [question], [answer], [addtime], [user_id], [img], [type]) VALUES (21, N'想来故宫工作怎么办？', N'故宫博物院招聘应届大学毕业生来院参加工作。一般在每年年初的时候在故宫网站公布招聘信息，敬请关注！', CAST(N'2019-10-26' AS Date), 3, NULL, N'咨询')
INSERT [dbo].[questions] ([Id], [question], [answer], [addtime], [user_id], [img], [type]) VALUES (28, N'故宫网站提供鉴定服务吗？', N'很抱歉故宫博物院网站不能为您的家藏器物作评估鉴定！ 为保持故宫博物院学术研究的严肃性、科学性和工作严谨的态度，我院规定，故宫博物院研究人员不对外为私人进行文物鉴定。对此，请您予以理解！ 故宫博物院网站内容中包含有相当丰富的文物知识，为了更方便地查找特定内容，您还可以利用网站设置的全文检索功能。我们还在不断发布更新更多有关文物知识的内容，希望能够满足广大文物爱好者的求知欲。', CAST(N'2019-10-26' AS Date), 3, NULL, N'咨询')
INSERT [dbo].[questions] ([Id], [question], [answer], [addtime], [user_id], [img], [type]) VALUES (29, N'怎样成为故宫志愿者？', N'您可以等故宫博物院下次招收志愿者的时候报名即可。至于何时招收，欢迎您随时关注故宫网站相关信息。在等待的时间里，您可以先预习起来有关故宫的历史和知识，因为志愿者是要接受面试的。', CAST(N'2019-10-26' AS Date), 3, NULL, N'咨询')
INSERT [dbo].[questions] ([Id], [question], [answer], [addtime], [user_id], [img], [type]) VALUES (30, N'我想捐献文物怎么办？', N'如您欲联系文物收购或捐献事宜，请直接与故宫博物院文物管理处联系 地址：北京 景山前街4号 故宫博物院 文物管理处 邮政编码：100009', CAST(N'2019-10-26' AS Date), 3, NULL, N'咨询')
SET IDENTITY_INSERT [dbo].[questions] OFF
SET IDENTITY_INSERT [dbo].[succincts] ON 

INSERT [dbo].[succincts] ([Id], [classname], [img]) VALUES (16, N'陶瓷馆', N'http://a.cphotos.bdimg.com/timg?image&quality=100&size=b4000_4000&sec=1574771772&di=44d5b3e59bab81975881c379bf13adb6&src=http://www.zjscdb.com/UploadFiledb/20190311151314_67431.jpg')
INSERT [dbo].[succincts] ([Id], [classname], [img]) VALUES (17, N'钟表馆', N'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1575377004&di=3e7e61b3dc942c1b314e913afe828425&imgtype=jpg&er=1&src=http%3A%2F%2Fyouimg1.c-ctrip.com%2Ftarget%2Ffd%2Ftg%2Fg1%2FM0B%2FE2%2F02%2FCghzfFUwh26AVwVsAC9GSE-kpYM244.jpg')
INSERT [dbo].[succincts] ([Id], [classname], [img]) VALUES (18, N'珍宝馆', N'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=195778799,604544795&fm=11&gp=0.jpg')
INSERT [dbo].[succincts] ([Id], [classname], [img]) VALUES (19, N'戏曲馆', N'https://img.dpm.org.cn/Uploads/Picture/2017/01/20/s588182e7578fe.png')
INSERT [dbo].[succincts] ([Id], [classname], [img]) VALUES (20, N'原装陈列', N'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1574782440702&di=c480a526a6d6d67472acddd811e77132&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn%2Fw1600h992%2F20180201%2F79a9-fyrcsrw5349142.jpg')
SET IDENTITY_INSERT [dbo].[succincts] OFF
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([Id], [name], [card], [password], [phone], [addTime]) VALUES (3, N'陈慧涛', N'123123124124124124', N'chenhuitao', N'13058144073', CAST(N'2019-12-05T11:15:25.0000000' AS DateTime2))
INSERT [dbo].[users] ([Id], [name], [card], [password], [phone], [addTime]) VALUES (7, N'admin', N'1', N'root', N'admin', CAST(N'2019-11-05T12:52:32.0000000' AS DateTime2))
INSERT [dbo].[users] ([Id], [name], [card], [password], [phone], [addTime]) VALUES (12, N'小明', N'165161651651656511', N'asdasd', N'11335468978', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[users] ([Id], [name], [card], [password], [phone], [addTime]) VALUES (13, N'aaaa', N'123123123123123332', N'asdasd', N'12312313124', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[users] OFF
ALTER TABLE [dbo].[collection] ADD  DEFAULT ((0)) FOR [_new ]
GO
ALTER TABLE [dbo].[collection] ADD  DEFAULT ((0)) FOR [hot]
GO
ALTER TABLE [dbo].[exhibit] ADD  DEFAULT ((0)) FOR [_new]
GO
ALTER TABLE [dbo].[exhibit] ADD  DEFAULT ((0)) FOR [hot]
GO
ALTER TABLE [dbo].[exhibit] ADD  DEFAULT ((1)) FOR [type]
GO
ALTER TABLE [dbo].[exhibit_reservation] ADD  DEFAULT (getdate()) FOR [addTime]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (getdate()) FOR [addTime]
GO
ALTER TABLE [dbo].[collection]  WITH CHECK ADD  CONSTRAINT [succinct_id] FOREIGN KEY([succinct_id])
REFERENCES [dbo].[succincts] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[collection] CHECK CONSTRAINT [succinct_id]
GO
ALTER TABLE [dbo].[exhibit_reservation]  WITH CHECK ADD  CONSTRAINT [exhibit_id] FOREIGN KEY([exhibit_id])
REFERENCES [dbo].[exhibit] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[exhibit_reservation] CHECK CONSTRAINT [exhibit_id]
GO
ALTER TABLE [dbo].[exhibit_reservation]  WITH CHECK ADD  CONSTRAINT [exhibit_user_id] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[exhibit_reservation] CHECK CONSTRAINT [exhibit_user_id]
GO
ALTER TABLE [dbo].[questions]  WITH CHECK ADD  CONSTRAINT [user_id] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[questions] CHECK CONSTRAINT [user_id]
GO
USE [master]
GO
ALTER DATABASE [Museam] SET  READ_WRITE 
GO
