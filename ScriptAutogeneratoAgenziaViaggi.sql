USE [master]
GO
/****** Object:  Database [AgenziaViaggi]    Script Date: 17/03/2022 14:40:13 ******/
CREATE DATABASE [AgenziaViaggi]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AgenziaViaggi', FILENAME = N'C:\Users\RenataCarriero\AgenziaViaggi.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'AgenziaViaggi_log', FILENAME = N'C:\Users\RenataCarriero\AgenziaViaggi_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [AgenziaViaggi] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AgenziaViaggi].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AgenziaViaggi] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AgenziaViaggi] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AgenziaViaggi] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AgenziaViaggi] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AgenziaViaggi] SET ARITHABORT OFF 
GO
ALTER DATABASE [AgenziaViaggi] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [AgenziaViaggi] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AgenziaViaggi] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AgenziaViaggi] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AgenziaViaggi] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AgenziaViaggi] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AgenziaViaggi] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AgenziaViaggi] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AgenziaViaggi] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AgenziaViaggi] SET  ENABLE_BROKER 
GO
ALTER DATABASE [AgenziaViaggi] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AgenziaViaggi] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AgenziaViaggi] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AgenziaViaggi] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AgenziaViaggi] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AgenziaViaggi] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AgenziaViaggi] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AgenziaViaggi] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [AgenziaViaggi] SET  MULTI_USER 
GO
ALTER DATABASE [AgenziaViaggi] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AgenziaViaggi] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AgenziaViaggi] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AgenziaViaggi] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [AgenziaViaggi] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [AgenziaViaggi] SET QUERY_STORE = OFF
GO
USE [AgenziaViaggi]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [AgenziaViaggi]
GO
/****** Object:  Table [dbo].[Gita]    Script Date: 17/03/2022 14:40:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gita](
	[GitaID] [int] IDENTITY(1,1) NOT NULL,
	[DataPartenza] [date] NOT NULL,
	[ResponsabileID] [int] NOT NULL,
	[ItinerarioID] [int] NOT NULL,
 CONSTRAINT [PK_Gita] PRIMARY KEY CLUSTERED 
(
	[GitaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Itinerario]    Script Date: 17/03/2022 14:40:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Itinerario](
	[ItinerarioID] [int] IDENTITY(1,1) NOT NULL,
	[Descrizione] [nvarchar](50) NOT NULL,
	[Durata] [int] NOT NULL,
	[Prezzo] [decimal](10, 2) NOT NULL,
 CONSTRAINT [PK_Itinerario] PRIMARY KEY CLUSTERED 
(
	[ItinerarioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ItinerarioTappa]    Script Date: 17/03/2022 14:40:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItinerarioTappa](
	[ItinerarioID] [int] NOT NULL,
	[TappaID] [int] NOT NULL,
	[GiorniPermanenza] [int] NOT NULL,
 CONSTRAINT [PK_ItinerarioTappa] PRIMARY KEY CLUSTERED 
(
	[TappaID] ASC,
	[ItinerarioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Partecipante]    Script Date: 17/03/2022 14:40:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Partecipante](
	[PartecipanteID] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [nvarchar](30) NOT NULL,
	[Cognome] [nvarchar](30) NOT NULL,
	[DataNascita] [date] NOT NULL,
	[Città] [nvarchar](30) NOT NULL,
	[Indirizzo] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_Partecipante] PRIMARY KEY CLUSTERED 
(
	[PartecipanteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PartecipanteGita]    Script Date: 17/03/2022 14:40:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PartecipanteGita](
	[PartecipanteID] [int] NOT NULL,
	[GitaID] [int] NOT NULL,
 CONSTRAINT [PK_PartecipanteGita] PRIMARY KEY CLUSTERED 
(
	[GitaID] ASC,
	[PartecipanteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Responsabile]    Script Date: 17/03/2022 14:40:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Responsabile](
	[ResponsabileID] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [nvarchar](30) NOT NULL,
	[Cognome] [nvarchar](30) NOT NULL,
	[NumeroTelefono] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_Responsabile] PRIMARY KEY CLUSTERED 
(
	[ResponsabileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tappa]    Script Date: 17/03/2022 14:40:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tappa](
	[TappaID] [int] IDENTITY(1,1) NOT NULL,
	[Città] [nvarchar](20) NOT NULL,
 CONSTRAINT [Pk_Tappa] PRIMARY KEY CLUSTERED 
(
	[TappaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Gita] ON 

INSERT [dbo].[Gita] ([GitaID], [DataPartenza], [ResponsabileID], [ItinerarioID]) VALUES (1, CAST(N'2021-04-03' AS Date), 1, 2)
INSERT [dbo].[Gita] ([GitaID], [DataPartenza], [ResponsabileID], [ItinerarioID]) VALUES (2, CAST(N'2021-07-21' AS Date), 2, 1)
INSERT [dbo].[Gita] ([GitaID], [DataPartenza], [ResponsabileID], [ItinerarioID]) VALUES (3, CAST(N'2021-08-03' AS Date), 3, 5)
INSERT [dbo].[Gita] ([GitaID], [DataPartenza], [ResponsabileID], [ItinerarioID]) VALUES (4, CAST(N'2022-10-12' AS Date), 4, 3)
INSERT [dbo].[Gita] ([GitaID], [DataPartenza], [ResponsabileID], [ItinerarioID]) VALUES (5, CAST(N'2021-04-03' AS Date), 5, 4)
INSERT [dbo].[Gita] ([GitaID], [DataPartenza], [ResponsabileID], [ItinerarioID]) VALUES (6, CAST(N'2022-04-03' AS Date), 2, 1)
INSERT [dbo].[Gita] ([GitaID], [DataPartenza], [ResponsabileID], [ItinerarioID]) VALUES (7, CAST(N'2021-12-30' AS Date), 1, 4)
SET IDENTITY_INSERT [dbo].[Gita] OFF
GO
SET IDENTITY_INSERT [dbo].[Itinerario] ON 

INSERT [dbo].[Itinerario] ([ItinerarioID], [Descrizione], [Durata], [Prezzo]) VALUES (1, N'Spiagge', 4, CAST(800.00 AS Decimal(10, 2)))
INSERT [dbo].[Itinerario] ([ItinerarioID], [Descrizione], [Durata], [Prezzo]) VALUES (2, N'Città di arte', 5, CAST(2500.00 AS Decimal(10, 2)))
INSERT [dbo].[Itinerario] ([ItinerarioID], [Descrizione], [Durata], [Prezzo]) VALUES (3, N'Musei', 5, CAST(900.00 AS Decimal(10, 2)))
INSERT [dbo].[Itinerario] ([ItinerarioID], [Descrizione], [Durata], [Prezzo]) VALUES (4, N'Capitali', 12, CAST(4800.00 AS Decimal(10, 2)))
INSERT [dbo].[Itinerario] ([ItinerarioID], [Descrizione], [Durata], [Prezzo]) VALUES (5, N'Spiagge', 6, CAST(1000.00 AS Decimal(10, 2)))
INSERT [dbo].[Itinerario] ([ItinerarioID], [Descrizione], [Durata], [Prezzo]) VALUES (6, N'Montagne', 7, CAST(400.00 AS Decimal(10, 2)))
INSERT [dbo].[Itinerario] ([ItinerarioID], [Descrizione], [Durata], [Prezzo]) VALUES (7, N'Mari e Monti', 8, CAST(400.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[Itinerario] OFF
GO
INSERT [dbo].[ItinerarioTappa] ([ItinerarioID], [TappaID], [GiorniPermanenza]) VALUES (2, 1, 9)
INSERT [dbo].[ItinerarioTappa] ([ItinerarioID], [TappaID], [GiorniPermanenza]) VALUES (4, 3, 12)
INSERT [dbo].[ItinerarioTappa] ([ItinerarioID], [TappaID], [GiorniPermanenza]) VALUES (3, 4, 5)
INSERT [dbo].[ItinerarioTappa] ([ItinerarioID], [TappaID], [GiorniPermanenza]) VALUES (4, 6, 12)
INSERT [dbo].[ItinerarioTappa] ([ItinerarioID], [TappaID], [GiorniPermanenza]) VALUES (2, 7, 9)
INSERT [dbo].[ItinerarioTappa] ([ItinerarioID], [TappaID], [GiorniPermanenza]) VALUES (1, 8, 4)
INSERT [dbo].[ItinerarioTappa] ([ItinerarioID], [TappaID], [GiorniPermanenza]) VALUES (5, 9, 6)
INSERT [dbo].[ItinerarioTappa] ([ItinerarioID], [TappaID], [GiorniPermanenza]) VALUES (5, 10, 6)
GO
SET IDENTITY_INSERT [dbo].[Partecipante] ON 

INSERT [dbo].[Partecipante] ([PartecipanteID], [Nome], [Cognome], [DataNascita], [Città], [Indirizzo]) VALUES (1, N'Luca', N'Verdi', CAST(N'1978-02-04' AS Date), N'Roma', N'Via Casa 1')
INSERT [dbo].[Partecipante] ([PartecipanteID], [Nome], [Cognome], [DataNascita], [Città], [Indirizzo]) VALUES (2, N'Mario', N'Rossi', CAST(N'1986-03-10' AS Date), N'Milano', N'Via Palazzo 10')
INSERT [dbo].[Partecipante] ([PartecipanteID], [Nome], [Cognome], [DataNascita], [Città], [Indirizzo]) VALUES (3, N'Maria', N'Bianchi', CAST(N'1998-10-04' AS Date), N'Napoli', N'Via Condominio 3')
INSERT [dbo].[Partecipante] ([PartecipanteID], [Nome], [Cognome], [DataNascita], [Città], [Indirizzo]) VALUES (4, N'Giovanni', N'Neri', CAST(N'1994-02-04' AS Date), N'Roma', N'Via Roma 5')
INSERT [dbo].[Partecipante] ([PartecipanteID], [Nome], [Cognome], [DataNascita], [Città], [Indirizzo]) VALUES (5, N'Sara', N'Ceri', CAST(N'1993-02-04' AS Date), N'Caserta', N'Via CasaMia 8')
INSERT [dbo].[Partecipante] ([PartecipanteID], [Nome], [Cognome], [DataNascita], [Città], [Indirizzo]) VALUES (6, N'Michela', N'Micheli', CAST(N'1972-06-12' AS Date), N'Caserta', N'Via CasaMia 12')
INSERT [dbo].[Partecipante] ([PartecipanteID], [Nome], [Cognome], [DataNascita], [Città], [Indirizzo]) VALUES (7, N'Lucia', N'Gialli', CAST(N'1998-03-09' AS Date), N'Bari', N'Via CasaMia 6')
INSERT [dbo].[Partecipante] ([PartecipanteID], [Nome], [Cognome], [DataNascita], [Città], [Indirizzo]) VALUES (8, N'Marco', N'Verdi', CAST(N'1969-10-04' AS Date), N'Firenze', N'Via Palazzo 4')
SET IDENTITY_INSERT [dbo].[Partecipante] OFF
GO
INSERT [dbo].[PartecipanteGita] ([PartecipanteID], [GitaID]) VALUES (6, 1)
INSERT [dbo].[PartecipanteGita] ([PartecipanteID], [GitaID]) VALUES (1, 2)
INSERT [dbo].[PartecipanteGita] ([PartecipanteID], [GitaID]) VALUES (2, 2)
INSERT [dbo].[PartecipanteGita] ([PartecipanteID], [GitaID]) VALUES (7, 2)
INSERT [dbo].[PartecipanteGita] ([PartecipanteID], [GitaID]) VALUES (5, 3)
INSERT [dbo].[PartecipanteGita] ([PartecipanteID], [GitaID]) VALUES (3, 4)
INSERT [dbo].[PartecipanteGita] ([PartecipanteID], [GitaID]) VALUES (4, 5)
INSERT [dbo].[PartecipanteGita] ([PartecipanteID], [GitaID]) VALUES (8, 5)
GO
SET IDENTITY_INSERT [dbo].[Responsabile] ON 

INSERT [dbo].[Responsabile] ([ResponsabileID], [Nome], [Cognome], [NumeroTelefono]) VALUES (1, N'Franco', N'Franchi', N'3465890238')
INSERT [dbo].[Responsabile] ([ResponsabileID], [Nome], [Cognome], [NumeroTelefono]) VALUES (2, N'Luisa', N'Luisi', N'3289507943')
INSERT [dbo].[Responsabile] ([ResponsabileID], [Nome], [Cognome], [NumeroTelefono]) VALUES (3, N'Matteo', N'Mattei', N'3289041759')
INSERT [dbo].[Responsabile] ([ResponsabileID], [Nome], [Cognome], [NumeroTelefono]) VALUES (4, N'Simona', N'Simoni', N'3349012678')
INSERT [dbo].[Responsabile] ([ResponsabileID], [Nome], [Cognome], [NumeroTelefono]) VALUES (5, N'Marcello', N'Marcelli', N'3214567901')
SET IDENTITY_INSERT [dbo].[Responsabile] OFF
GO
SET IDENTITY_INSERT [dbo].[Tappa] ON 

INSERT [dbo].[Tappa] ([TappaID], [Città]) VALUES (1, N'Roma')
INSERT [dbo].[Tappa] ([TappaID], [Città]) VALUES (2, N'Madrid')
INSERT [dbo].[Tappa] ([TappaID], [Città]) VALUES (3, N'Berlino')
INSERT [dbo].[Tappa] ([TappaID], [Città]) VALUES (4, N'Barcellona')
INSERT [dbo].[Tappa] ([TappaID], [Città]) VALUES (5, N'Vienna')
INSERT [dbo].[Tappa] ([TappaID], [Città]) VALUES (6, N'Praga')
INSERT [dbo].[Tappa] ([TappaID], [Città]) VALUES (7, N'Parigi')
INSERT [dbo].[Tappa] ([TappaID], [Città]) VALUES (8, N'Palma de Mallorca')
INSERT [dbo].[Tappa] ([TappaID], [Città]) VALUES (9, N'Zante')
INSERT [dbo].[Tappa] ([TappaID], [Città]) VALUES (10, N'Creta')
SET IDENTITY_INSERT [dbo].[Tappa] OFF
GO
ALTER TABLE [dbo].[Gita]  WITH CHECK ADD  CONSTRAINT [FK_Itinerario] FOREIGN KEY([ItinerarioID])
REFERENCES [dbo].[Itinerario] ([ItinerarioID])
GO
ALTER TABLE [dbo].[Gita] CHECK CONSTRAINT [FK_Itinerario]
GO
ALTER TABLE [dbo].[Gita]  WITH CHECK ADD  CONSTRAINT [FK_Responsabile] FOREIGN KEY([ResponsabileID])
REFERENCES [dbo].[Responsabile] ([ResponsabileID])
GO
ALTER TABLE [dbo].[Gita] CHECK CONSTRAINT [FK_Responsabile]
GO
ALTER TABLE [dbo].[ItinerarioTappa]  WITH CHECK ADD  CONSTRAINT [FK_Tappa] FOREIGN KEY([TappaID])
REFERENCES [dbo].[Tappa] ([TappaID])
GO
ALTER TABLE [dbo].[ItinerarioTappa] CHECK CONSTRAINT [FK_Tappa]
GO
ALTER TABLE [dbo].[ItinerarioTappa]  WITH CHECK ADD  CONSTRAINT [FK_TappaItinerario] FOREIGN KEY([ItinerarioID])
REFERENCES [dbo].[Itinerario] ([ItinerarioID])
GO
ALTER TABLE [dbo].[ItinerarioTappa] CHECK CONSTRAINT [FK_TappaItinerario]
GO
ALTER TABLE [dbo].[PartecipanteGita]  WITH CHECK ADD  CONSTRAINT [FK_PartecGita] FOREIGN KEY([PartecipanteID])
REFERENCES [dbo].[Partecipante] ([PartecipanteID])
GO
ALTER TABLE [dbo].[PartecipanteGita] CHECK CONSTRAINT [FK_PartecGita]
GO
ALTER TABLE [dbo].[PartecipanteGita]  WITH CHECK ADD  CONSTRAINT [FK_PartecGita2] FOREIGN KEY([GitaID])
REFERENCES [dbo].[Gita] ([GitaID])
GO
ALTER TABLE [dbo].[PartecipanteGita] CHECK CONSTRAINT [FK_PartecGita2]
GO
USE [master]
GO
ALTER DATABASE [AgenziaViaggi] SET  READ_WRITE 
GO
