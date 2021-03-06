USE [Book]
GO
/****** Object:  Table [dbo].[borrow_table]    Script Date: 2019/12/20 12:36:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[borrow_table](
	[booksid] [char](7) NOT NULL,
	[usersid] [nchar](7) NOT NULL,
	[borrowtime] [datetime] NOT NULL,
	[returntime] [datetime] NULL,
	[shouldtime] [datetime] NOT NULL,
	[fine] [numeric](5, 2) NOT NULL,
 CONSTRAINT [PK_borrow_table] PRIMARY KEY CLUSTERED 
(
	[booksid] ASC,
	[usersid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[book_table]    Script Date: 2019/12/20 12:36:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[book_table](
	[bookid] [char](7) NOT NULL,
	[bookname] [varchar](100) NOT NULL,
	[author] [varchar](100) NULL,
	[publichouse] [varchar](50) NOT NULL,
	[introduction] [nvarchar](max) NULL,
	[isin] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[bookid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[recordsview]    Script Date: 2019/12/20 12:36:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
create table user_table(
     userId nchar(7) not null primary key,
	 username varchar(20) not null,
	 upassword varchar(14) not null,
	 phone nchar(11) unique,
	 ID char(1) not null
     );

create table book_table(
     bookId char(7) not null primary key,
	 bookname varchar(30),
	 author varchar(20),
	 public_house varchar(40),
	 introduction text,
	 isIn bit not null,
	 );

create table borrow_table(
     bookId char(7) not null,
	 userId nchar(7) not null,
	 borrowtime datetime,
	 returntime datetime,
	 shouldtime datetime,
	 fine numeric(5,2),
	 primary key(bookId,userId),
	 foreign key(bookId) references book_table(bookId),
	 foreign key(userId) references user_table(userId),
     );

create table classific(
     classId char(1) primary key,
	 classname varchar(20)not null unique,
     );
	
	insert into user_table values('0000001','张三','123456','11011011011','0'); 
	insert into user_table values('1000001','李四','1234567','11011011000','1');
	alter table user_table add isCan bit;
	update user_table set isCan=0 where userId='0000001';
	update user_table set isCan=1 where userId='1000001';
	create view record_view as 
	select userId,borrow_table.bookId,book_table.bookname,borrowtime,returntime,shouldtime
	from borrow_table,book_table
	where borrow_table.bookId=book_table.bookId
	with check option;
	create unique index Boosno on book_table(bookId);
	create unique index Userno on user_table(userId);
	create unique index Borsno on borrow_table(bookId,userId);
	create unique index Clasno on classific(classId);
	alter table user_table alter column isCan bit not null;
	alter table book_table alter column introduction nvarchar(MAX);
	alter table book_table alter column bookname varchar(50);
	alter table book_table alter column bookname varchar(50) not null;
	alter table book_table alter column publichouse varchar(50) not null;
	alter table user_table add borrownum int;
	alter table user_table alter column borrownum int not null;*/
CREATE VIEW [dbo].[recordsview]
WITH  VIEW_METADATA
AS
SELECT   dbo.borrow_table.usersid, dbo.borrow_table.booksid, dbo.book_table.bookname, dbo.borrow_table.borrowtime, 
                dbo.borrow_table.returntime, dbo.borrow_table.shouldtime
FROM      dbo.borrow_table INNER JOIN
                dbo.book_table ON dbo.borrow_table.booksid = dbo.book_table.bookid
WITH CHECK OPTION
GO
/****** Object:  Table [dbo].[classific]    Script Date: 2019/12/20 12:36:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[classific](
	[classid] [char](1) NOT NULL,
	[classname] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[classid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_table]    Script Date: 2019/12/20 12:36:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_table](
	[userid] [nchar](7) NOT NULL,
	[username] [varchar](20) NOT NULL,
	[upassword] [varchar](14) NOT NULL,
	[phone] [nchar](11) NULL,
	[id] [char](1) NOT NULL,
	[iscan] [bit] NOT NULL,
	[borrownum] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[userid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'A000001', N'IBM-PC汇编语言程序设计', N'沈美明、温东婵', N'清华大学出版社', N'在教材中注意体现了“机器”与“程序”相互结合这一思想，使学生对“计算机”的认识更加深入', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'A000002', N'第一行代码Android（第2版）', N'郭霖', N'人民邮电出版社', N'本书内容通俗易懂，由浅入深，既适合初学者阅读，也同样适合专业人员。学习本书内容之前，你并不需要有任何的Android基础，但是你需要有一定的Java基础，因为Android开发都是使用Java语言的，而本书并不会去专门介绍Java方面的知识。', 0)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'A000003', N'数据库系统概论', N'王珊、撒师煊', N'高等教育出版社', N'我国第一部系统阐述数据库原理、技术和方法的教材，实时反映数据库领域新成果和应用新方向，内容丰富，概念准确，结构完整，语言精练，具有较强的可读性与教学适用性。', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'A000004', N'软件工程导论', N'张海藩、牟永敏', N'清华大学出版社', N'本书全面系统地讲述了软件工程的概念、原理和典型的方法学，并介绍了软件项目的管理技术。本书正文共13章，第1章是概述，第2章至第8章顺序讲述软件生命周期各阶段的任务、过程、结构化方法和工具。', 0)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'A000005', N'PPT设计思维（实战版', N'邵云蛟', N'电子工业出版社', N'在知乎获得300多万收藏、88万赞的PPT设计经验分享，数十万粉丝共同点赞的PPT“美容计划”，《PPT之光》等畅销书作者、@simon_阿文、iSlide社区创始人刘浩力荐，随书赠送PPT知识地图.', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'A000006', N'深入核心的敏捷开发：ThoughtWorks五大关键实践', N'肖然 张凯峰', N'清华大学出版社', N'ThoughtWorks十多年敏捷导入与实施经验回放，行之有效的敏捷开发核心原则、实践、管理体系及案例，灵巧结合工程实践与敏捷管理，推动敏捷转型顺利落地。', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'A000007', N'算法导论（原书第3版）', N'(美)科尔曼', N'机械工业出版社', N'影响全球千万程序员的“算法圣经”！国内外千余所高校采用！MIT四大名师联手铸就。', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'A000008', N'C Primer Plus 第6版 中文版', N'[美]史蒂芬·普拉达', N'人民邮电出版社', N'畅销30余年的C语言编程入门教程 近百万程序员的C语言编程启蒙教程 技术大牛案头常备的工具书 针对C11标准库更新 蔡学镛 孟岩 高博倾力推荐', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'A000009', N'深入浅出MySQL 数据库开发 优化与管理维护 第3版', N'翟振兴、张恒岩、崔春华、黄荣、董骐铭', N'人民邮电出版社', N'MySQL技术内幕从入门到精通书籍，高性能MySQL数据库必知必会教程，畅销图书全新升级版本，涵盖MySQL 8.0的重要功能，附带大量一线工程案例', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'A000010', N'Python金融大数据挖掘与分析全流程详解', N'王宇涛 房宇亮 肖金鑫', N'机械工业出版社', N'利用python高效解决量化金融问题、揭秘人工智能在金融行业中的实战应用、全流程详解量化金融与数据化决策技术、网络爬虫从入门到精通、附赠超值讲解视频', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'A000011', N'千金良方——MySQL性能优化金字塔法则', N'李春', N'电子工业出版社', N'沃趣团队凭借着多年的运维经验，为行业客户提供专业数据库、系统相关的服务和产品。《千金良方——MySQL性能优化金字塔法则》是其核心团队的呕心力作，全书细致地介绍MySQL的基本原理，以及性能优化的实际案例。
无论你是MySQL初学者，还是专门从事MySQL工作的开发人员和运维人员，或者是资深的MySQL DBA，都值得一读！', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'A000012', N'R语言实战 第2版', N'[美]卡巴科弗（Robert I. Kabacoff）', N'人民邮电出版社', N'【图灵程序设计丛书】R语言入门到精通 大数据挖掘 用R轻松实现数据挖掘 数据可视化 从实际数据分析出发 全面掌握R编程 新增预测性分析 简化多变量数据等近200页内容', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'A000013', N'Android Studio开发实战：从零基础到App上线(第2版)', N'欧阳燊', N'清华大学出版社', N'深度揭秘流行App背后的手机开发技术，展示移动信息科技的1新工程实践', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'A000014', N'用户体验要素：以用户为中心的产品设计（原书第2版）', N'[美]杰西·詹姆斯·加勒特（Jesse James Garrett）', N'机械工业出版社', N'《用户体验要素：以用户为中心的产品设计（原书第2版）》是ajax之父jesse james garrett的经典之作。本书用简洁的语言系统化地诠释了设计、技术和商业融合是重要的发展趋势。全书共8章，包括关于用户体验以及为什么它如此重要、认识这些要素、战略层、范围层、结构层、框架层、表现层以及要素的应用。　　《用户体验要素：以用户为中心的产品设计（原书第2版）》用清晰的说明和生动的图形分析了以用户为中心的设计方法（ucd）来进行网站设计的复杂内涵，并关注于思路而不是工具或技术，从而使你的网站具备高质量体验的流程。', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'A072659', N'计算机操作系统教程', N'张尧学、宋虹、张高', N'清华大学出版社', N'本套教材体系完整，结构严谨。', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'B000001', N'毛泽东思想和中国特色社会主义理论体系概论', N'本书编写组', N'高等教育出版社', N'“毛泽东思想和中国特色社会主义理论体系概论”是根据2005年《中共中央宣传部、教育部关于进一步加强和改进高等学校思想政治理论课的意见》及“实施方案”设立的，是我国高校本专科学生都必修的一门思想政治理论课程。', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'B000002', N'新中国：砥砺奋进的七十年', N'张士义', N'东方出版社', N'2019年主题出版重点出版物 一条时间线勾勒新中国七十年历史 人人都应该认真接受的国史教育 公务员应该人手一册的国史读本', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'B000003', N'大趋势：中国下一步', N'郑永年', N'东方出版社', N'中国问题研究专家郑永年用国际视野，世界眼光系统解读中国的改革逻辑，分析新常态下中国面临的新风险和挑战，探寻中国前进道路的正确方向', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'B000004', N'注定一战：中美能避免修昔底德陷阱吗？', N'[美] 格雷厄姆·艾利森', N'上海人民出版社', N'贸易战必读。亚马逊年度*历史类图书，《纽约时报》、《金融时报》、《伦敦时报》年度畅销书。哈佛大学历史学家、美国前助理国防部长格雷厄姆·艾利森，横跨500年历史、剖析21世纪zui重要的大国关系', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'B000005', N'毛泽东论核武器与核战争 初析', N'崔茂东 李华', N'北京联合出版公司', N'国内较为全面系统地收集和研究*关于核武器与核战争论述的专门著作，再现一代伟人的缜密思维、卓远见识与运筹帷幄。', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'C000001', N'思无邪', N'安意如', N'人民文学出版社', N'一棵树上不可能只结甜而大的果子，也有干瘪酸涩的，因此无论喜悦悲哀都要学会顺然承受。《诗经》传达的本就该是这样发自内心田的喜悦或是忧伤。', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'C000002', N'人生若只如初见', N'安意如', N'人民文学出版社', N'太多人喜欢这一句，“人生若只如初见”。可知我们都遗憾深重。命运像最名贵的丝绢，再怎样巧夺天工，拿到手上看，总透出丝丝缕缕的光，那些错落，是与生具行的原罪。', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'C000003', N'当时只道是寻常', N'安意如', N'人民文学出版社', N'细读纳兰词会发现，豪放是外在的风骨，忧伤才是内敛的精魂。', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'C000004', N'皮囊', N'蔡崇达，果麦文化', N'天津人民出版社', N'刘德华、韩寒、白岩松感动推荐。2019全新升级，书封采用具有肌肤质感的SKINS纸。命运是一条闪闪发光的金色河流，我们彼此相遇，卸下皮囊，以心相交。', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'C000005', N'一只特立独行的猪', N'王小波', N'北京十月文艺出版社', N'王小波杂文精选集，逝世二十周年精装纪念版！幽默中充满智性，扛起一面自由、独立、理性的精神旗帜！——“我觉得黑色幽默是我的气质，是天生的。”', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'C000006', N'万般滋味，都是生活', N'丰子恺', N'华中科技大学出版社', N'丰子恺先生诞辰120周年纪念！全彩插图珍藏本，丰子恺*温暖的散文作品。献给曾是孩子的你！愿你永葆童真，并乐此不疲，去生活！', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'C000007', N'沉默的大多数', N'王小波', N'北京十月文艺出版社', N'王小波杂文精选集，逝世二十周年精装纪念版！特别收入珍贵手稿！集结精粹杂文，全面呈现一位自由思想者的精神世界！——“从话语中，你很少能学到人性，从沉默中却能。”', 0)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'D000001', N'明天也是小春日和', N'津端英子，津端修一', N'新星出版社', N'（一个男人对妻子的承诺：那并不耀眼的初冬暖阳，恰似你日复一日的长情陪伴）', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'D000002', N'你想活出怎样的人生', N'日）吉野源三郎 著，（日）胁田和 绘', N'南海出版公司', N'影响宫崎骏一生的经典小说，入选日本学校教材，荣获日本中学教师票选“送你一本书大奖”，中日知名院士、学者一致推荐。生而为人真正重要的事，都在这本书里了！', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'D000003', N'瓦尔登湖', N'（美）梭罗', N'中国三峡出版社', N'美国自然文学的典范，与《圣经》一同被评为“塑造读者的25本书”。瓦尔登湖旅游节指定中文版本，管理者Machael J. Frederick 盛赞推荐。清华大学校长送给新生的见面礼，朗读者推荐阅读。', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'D000004', N'查令十字街84号', N'海莲·汉芙 著，陈建铭 译', N'译林出版社', N'爱书人的圣经，当当网友真实好评破24万！唐诺、恺蒂、张立宪、汤唯、吴秀波、潘虹、李现都是这本书的书迷！', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'D000005', N'痛苦的中国人', N'[奥地利]彼得·汉德克 著，刘学慧、张帆 译', N'上海人民出版社', N'余华推荐！德语文学“活着的经典”，一个充满隐喻的“杀人故事”，三段追索历史与现状的东欧之旅，在作者眼里，没有浮光掠影）', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'D000006', N'月亮和六便士', N'（英）威廉·萨默塞特·毛姆 著，王然 译', N'花山文艺出版社', N'眼前的苟且or诗意的远方，让毛姆告诉你该作何选择,以法国后印象派画家高更为原型，白岩松、余华、村上春树、杨澜、蔡崇达、高晓松、范冰冰感动推荐！', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'D000007', N'聂鲁达情诗全集：二十首情诗和一首绝望的歌', N'巴勃罗·聂鲁达', N'南海出版公司', N'聂鲁达20岁时的《二十首情诗和一首绝望的歌》，为他赢得了全世界的赞誉。《船长的诗》《一百首爱的十四行诗》是聂鲁达写给爱人玛蒂尔德的情诗，充满了突发的和炽烈的激情，字里行间都是对玛蒂尔德的爱。“爱是这么短，遗忘是这么长”“我喜欢你沉默的时候，因为你仿佛不在”等经典的聂鲁达诗句，打动着每一个恋人。', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'E000001', N'知更鸟女孩', N'查克·温迪格', N'百花洲文艺出版社', N'她心里有一座关于死亡的大剧院，舞台上的幕布永远是拉开的，生存与死亡在这里交错轮回，充斥其间的是人性与爱的一次次交锋。到底是人性拯救爱，还是爱拯救人性？或者说爱情在我们的生命里到底占据多大的比重？我想每个人都想知道答案。', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'E000002', N'活着', N'余华', N'作家出版社', N'余华是我国当代著名作家，也是享誉世界的小说家，曾荣获众多国内外奖项。《活着》是其代表作，在全球广泛传播，销量逾千万册，获得了普遍好评，已成为中国乃至世界当代文学的经典。', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'E000003', N'偷影子的人', N'马克·李维（Marc Levy）', N'湖南文艺出版社', N'一部唤醒童年回忆与内心梦想的温情疗愈小说，2013年度“大众ZUI喜爱的50本书”之一。数百万中文读者口口相传，外国文学畅销经典。', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'E000004', N'时间的答案', N'卢思浩', N'北京联合出版有限公司', N'青年作家卢思浩2019年全新长篇小说。献给一边成长一边失去，面临人生选择的我们。我们都是往事的幸存者。向前走，时间会给你答案。', 1)
INSERT [dbo].[book_table] ([bookid], [bookname], [author], [publichouse], [introduction], [isin]) VALUES (N'E000005', N'荒潮', N'陈楸帆', N'上海文艺出版社', N'　一座被卷入全球化浪潮的电子垃圾之岛，污染肆虐，罪恶横行。

　　一台用途不明的危险义体，牵扯出一位女孩大脑的疯狂异变。

　　贪心的大家族、饱受歧视的劳工、暗藏其间的经济杀手……小小的孤岛之上暗流涌动。

　　而这一切，都指向一场尘封六十年的禁忌实验——“荒潮”计划……', 1)
INSERT [dbo].[borrow_table] ([booksid], [usersid], [borrowtime], [returntime], [shouldtime], [fine]) VALUES (N'A000001', N'1000002', CAST(N'2019-12-06T16:50:36.027' AS DateTime), CAST(N'2019-12-13T14:14:01.357' AS DateTime), CAST(N'2020-01-05T16:50:36.027' AS DateTime), CAST(0.00 AS Numeric(5, 2)))
INSERT [dbo].[borrow_table] ([booksid], [usersid], [borrowtime], [returntime], [shouldtime], [fine]) VALUES (N'A000002', N'1000001', CAST(N'2019-12-17T12:58:21.360' AS DateTime), CAST(N'2019-12-17T13:19:35.613' AS DateTime), CAST(N'2020-01-16T12:58:21.360' AS DateTime), CAST(0.00 AS Numeric(5, 2)))
INSERT [dbo].[borrow_table] ([booksid], [usersid], [borrowtime], [returntime], [shouldtime], [fine]) VALUES (N'A000002', N'1000002', CAST(N'2019-11-13T14:17:05.037' AS DateTime), NULL, CAST(N'2019-12-12T14:17:05.037' AS DateTime), CAST(3.00 AS Numeric(5, 2)))
INSERT [dbo].[borrow_table] ([booksid], [usersid], [borrowtime], [returntime], [shouldtime], [fine]) VALUES (N'A000013', N'1656381', CAST(N'2019-12-17T18:03:48.487' AS DateTime), CAST(N'2019-12-17T18:08:02.397' AS DateTime), CAST(N'2020-01-16T18:03:48.487' AS DateTime), CAST(0.00 AS Numeric(5, 2)))
INSERT [dbo].[borrow_table] ([booksid], [usersid], [borrowtime], [returntime], [shouldtime], [fine]) VALUES (N'A072659', N'1000002', CAST(N'2019-12-13T14:18:56.890' AS DateTime), CAST(N'2019-12-13T14:19:33.463' AS DateTime), CAST(N'2020-01-12T14:18:56.890' AS DateTime), CAST(0.00 AS Numeric(5, 2)))
INSERT [dbo].[borrow_table] ([booksid], [usersid], [borrowtime], [returntime], [shouldtime], [fine]) VALUES (N'A072659', N'1000003', CAST(N'2019-12-13T14:17:50.490' AS DateTime), CAST(N'2019-12-13T14:18:49.620' AS DateTime), CAST(N'2020-01-12T14:17:50.490' AS DateTime), CAST(0.00 AS Numeric(5, 2)))
INSERT [dbo].[borrow_table] ([booksid], [usersid], [borrowtime], [returntime], [shouldtime], [fine]) VALUES (N'C000001', N'1000003', CAST(N'2019-12-13T14:19:52.543' AS DateTime), CAST(N'2019-12-13T14:25:20.927' AS DateTime), CAST(N'2020-01-12T14:19:52.543' AS DateTime), CAST(0.00 AS Numeric(5, 2)))
INSERT [dbo].[borrow_table] ([booksid], [usersid], [borrowtime], [returntime], [shouldtime], [fine]) VALUES (N'C000007', N'1656381', CAST(N'2019-12-17T18:07:51.343' AS DateTime), NULL, CAST(N'2020-01-16T18:07:51.343' AS DateTime), CAST(0.00 AS Numeric(5, 2)))
INSERT [dbo].[classific] ([classid], [classname]) VALUES (N'A', N'计算机')
INSERT [dbo].[classific] ([classid], [classname]) VALUES (N'B', N'思想政治')
INSERT [dbo].[classific] ([classid], [classname]) VALUES (N'D', N'外国文学')
INSERT [dbo].[classific] ([classid], [classname]) VALUES (N'E', N'小说')
INSERT [dbo].[classific] ([classid], [classname]) VALUES (N'C', N'中国文学')
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'0000001', N'张三', N'1234567', N'15936842345', N'0', 0, 0)
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'0000002', N'张五', N'1234567', N'15515515511', N'0', 0, 0)
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'0000003', N'张七七', N'1234567', N'12212212211', N'0', 0, 0)
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'0000004', N'张八八', N'1234567', N'13314312212', N'0', 0, 0)
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'0000005', N'张九九', N'123456', N'16616616616', N'0', 0, 0)
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'0000006', N'张十十', N'123456', N'17717717717', N'0', 0, 0)
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'1000001', N'李八', N'1234567', N'13457678364', N'1', 1, 1)
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'1000002', N'王六', N'123456', N'22233333333', N'1', 1, 1)
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'1000003', N'张一一', N'123456', N'12345678901', N'1', 1, 0)
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'1222221', N'周三三', N'123456', N'13422325634', N'1', 1, 0)
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'1246792', N'王四四', N'1234322', N'14930720937', N'1', 1, 0)
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'1263893', N'王二二', N'1234323', N'15394673289', N'1', 1, 0)
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'1274637', N'王八八', N'adjfhaes', N'17348274836', N'1', 1, 0)
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'1333331', N'周四四', N'123456', N'15937263827', N'1', 1, 0)
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'1345826', N'李五', N'dashu322', N'13746793234', N'1', 1, 0)
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'1347298', N'王十十', N'causi23', N'17342793246', N'1', 1, 0)
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'1371199', N'李狗蛋', N'123456', N'17398393787', N'1', 1, 0)
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'1374672', N'李三三', N'bjs4328', N'13473692833', N'1', 1, 0)
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'1374673', N'李一一', N'casy231', N'17627493834', N'1', 1, 0)
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'1426594', N'李二二', N'3246922', N'13477924326', N'1', 1, 0)
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'1444441', N'周五五', N'1234567', N'15937265327', N'1', 1, 0)
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'1463234', N'王七七', N'abcdefg', N'13746927239', N'1', 1, 0)
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'1467392', N'王五五', N'1234322', N'18463023748', N'1', 1, 0)
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'1473589', N'李六', N'dfah453', N'13467294728', N'1', 1, 0)
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'1555551', N'周二二', N'123456', N'13243246734', N'1', 1, 0)
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'1634583', N'王九九', N'dgfiubau', N'17529338723', N'1', 1, 0)
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'1656381', N'张咕咕', N'123456', N'15823225646', N'1', 1, 1)
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'1666661', N'周六六', N'1234567', N'15937567328', N'1', 1, 0)
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'1736430', N'王六六', N'1265382', N'18365380244', N'1', 1, 0)
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'1763494', N'王三三', N'1234567', N'13864792638', N'1', 1, 0)
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'1769320', N'王一一', N'1234567', N'15370934873', N'1', 1, 0)
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'1777771', N'周七七', N'12345678', N'13437629643', N'1', 1, 0)
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'1789128', N'张二四', N'123456', N'12312312312', N'1', 1, 0)
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'1888881', N'周八八', N'12345678', N'15793075390', N'1', 1, 0)
INSERT [dbo].[user_table] ([userid], [username], [upassword], [phone], [id], [iscan], [borrownum]) VALUES (N'1999991', N'周九九', N'12345678', N'15829837407', N'1', 1, 0)
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__classifi__279D481438098B26]    Script Date: 2019/12/20 12:36:57 ******/
ALTER TABLE [dbo].[classific] ADD UNIQUE NONCLUSTERED 
(
	[classname] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__user_tab__B43B145FCF290939]    Script Date: 2019/12/20 12:36:57 ******/
ALTER TABLE [dbo].[user_table] ADD UNIQUE NONCLUSTERED 
(
	[phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[borrow_table] ADD  CONSTRAINT [DF_borrow_table_returntime]  DEFAULT (NULL) FOR [returntime]
GO
ALTER TABLE [dbo].[borrow_table] ADD  CONSTRAINT [DF_borrow_table_fine]  DEFAULT ((0.0)) FOR [fine]
GO
ALTER TABLE [dbo].[borrow_table]  WITH CHECK ADD  CONSTRAINT [FK__borrow_ta__bookI__440B1D61] FOREIGN KEY([booksid])
REFERENCES [dbo].[book_table] ([bookid])
GO
ALTER TABLE [dbo].[borrow_table] CHECK CONSTRAINT [FK__borrow_ta__bookI__440B1D61]
GO
ALTER TABLE [dbo].[borrow_table]  WITH CHECK ADD  CONSTRAINT [FK__borrow_ta__userI__44FF419A] FOREIGN KEY([usersid])
REFERENCES [dbo].[user_table] ([userid])
GO
ALTER TABLE [dbo].[borrow_table] CHECK CONSTRAINT [FK__borrow_ta__userI__44FF419A]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "book_table"
            Begin Extent = 
               Top = 6
               Left = 233
               Bottom = 146
               Right = 392
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "borrow_table"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 146
               Right = 195
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'recordsview'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'recordsview'
GO
