USE [master]
GO
/****** Object:  Database [transport_logistique]    Script Date: 07/04/2023 14:34:59 ******/
CREATE DATABASE [transport_logistique]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'transport_logistique', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\transport_logistique.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'transport_logistique_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\transport_logistique_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [transport_logistique] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [transport_logistique].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [transport_logistique] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [transport_logistique] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [transport_logistique] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [transport_logistique] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [transport_logistique] SET ARITHABORT OFF 
GO
ALTER DATABASE [transport_logistique] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [transport_logistique] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [transport_logistique] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [transport_logistique] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [transport_logistique] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [transport_logistique] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [transport_logistique] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [transport_logistique] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [transport_logistique] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [transport_logistique] SET  DISABLE_BROKER 
GO
ALTER DATABASE [transport_logistique] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [transport_logistique] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [transport_logistique] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [transport_logistique] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [transport_logistique] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [transport_logistique] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [transport_logistique] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [transport_logistique] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [transport_logistique] SET  MULTI_USER 
GO
ALTER DATABASE [transport_logistique] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [transport_logistique] SET DB_CHAINING OFF 
GO
ALTER DATABASE [transport_logistique] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [transport_logistique] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [transport_logistique] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [transport_logistique] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [transport_logistique] SET QUERY_STORE = ON
GO
ALTER DATABASE [transport_logistique] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [transport_logistique]
GO


/****** Object:  Table [dbo].[entrepots]    Script Date: 07/04/2023 14:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[entrepots](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nom_entrepot] [varchar](25) NULL,
	[adresse] [varchar](250) NULL,
	[ville] [varchar](30) NULL,
	[pays] [varchar](20) NULL,
	[continent] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[entrepot_view]    Script Date: 07/04/2023 14:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[entrepot_view] AS
SELECT nom_entrepot,
		(adresse+ville+pays)as adresse, 
		count(id_entrepot_source) as nombres_expeditions
FROM entrepots e
INNER JOIN
	 expeditions expd
	 ON
	 e.id=expd.id_entrepot_source
WHERE
	DATEDIFF(day,date_expedition,getdate())<=30
GROUP BY 
		nom_entrepot,
		(adresse+ville+pays) 
GO
/****** Object:  Table [dbo].[clients]    Script Date: 07/04/2023 14:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[clients](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nom] [varchar](20) NULL,
	[adresse] [varchar](50) NULL,
	[ville] [varchar](50) NULL,
	[pays] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[expeditions_clients]    Script Date: 07/04/2023 14:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[expeditions_clients](
	[id_expeditions] [int] NOT NULL,
	[id_client_expediteur] [int] NOT NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[clients] ON 

INSERT [dbo].[clients] ([id], [nom], [adresse], [ville], [pays]) VALUES (1, N'rasolo', N'Michelle de montaigne', N' eybens', N'France')
INSERT [dbo].[clients] ([id], [nom], [adresse], [ville], [pays]) VALUES (2, N'michel', N'rue de la republique', N'Vaulx-en-velin', N'LOS ANGELES')
INSERT [dbo].[clients] ([id], [nom], [adresse], [ville], [pays]) VALUES (3, N'ferry', N'felix fort', N'lyon', N'THAILANDE')
INSERT [dbo].[clients] ([id], [nom], [adresse], [ville], [pays]) VALUES (4, N'sotos', N'les granges', N'la tours', N'BRESIL')
SET IDENTITY_INSERT [dbo].[clients] OFF
GO
SET IDENTITY_INSERT [dbo].[entrepots] ON 

INSERT [dbo].[entrepots] ([id], [nom_entrepot], [adresse], [ville], [pays], [continent]) VALUES (1, N'Lyon', N'145, rue de la poudrette', N'Villeurbanne', N'France', N'europe')
INSERT [dbo].[entrepots] ([id], [nom_entrepot], [adresse], [ville], [pays], [continent]) VALUES (2, N'Casablanca', N'154, rue Meddy Le grand', N'Casablanca', N'Maroc', N'AFRIQUE')
INSERT [dbo].[entrepots] ([id], [nom_entrepot], [adresse], [ville], [pays], [continent]) VALUES (3, N'Vienne', N'157, rue du Ballet', N'Vienne', N'Autriche', N'europe')
INSERT [dbo].[entrepots] ([id], [nom_entrepot], [adresse], [ville], [pays], [continent]) VALUES (4, N'Londres', N'157, Street Queen Elisabeth', N'Londres', N'Angleterre', N'europe')
INSERT [dbo].[entrepots] ([id], [nom_entrepot], [adresse], [ville], [pays], [continent]) VALUES (5, N'New-york', N'15, 5 Avenue', N'New-York', N'Etats-Unis', N'Amerique')
INSERT [dbo].[entrepots] ([id], [nom_entrepot], [adresse], [ville], [pays], [continent]) VALUES (6, N'SingapourInc.', N'123 rue singapour', N'Singapour', N'Singapour', N'Asie')
INSERT [dbo].[entrepots] ([id], [nom_entrepot], [adresse], [ville], [pays], [continent]) VALUES (7, N'Bangkok', N'123 rue bangkok', N'Bangkok', N'Thaïlande', N'Asie')
INSERT [dbo].[entrepots] ([id], [nom_entrepot], [adresse], [ville], [pays], [continent]) VALUES (8, N'los Angels', N'20 8 Avenue', N'Los Angeles', N'Etats-Unis', N'Amerique')
SET IDENTITY_INSERT [dbo].[entrepots] OFF
GO
SET IDENTITY_INSERT [dbo].[expeditions] ON 

INSERT [dbo].[expeditions] ([id], [date_expedition], [id_entrepot_source], [id_entrepot_destination], [poids], [statut], [date_livraison_prévu], [date_livraison], [id_client_receveur]) VALUES (1, CAST(N'2023-03-15' AS Date), 1, 3, CAST(570.00 AS Decimal(10, 2)), N'en transit', CAST(N'2023-03-22' AS Date), CAST(N'2023-03-22' AS Date), 1)
INSERT [dbo].[expeditions] ([id], [date_expedition], [id_entrepot_source], [id_entrepot_destination], [poids], [statut], [date_livraison_prévu], [date_livraison], [id_client_receveur]) VALUES (2, CAST(N'2023-03-16' AS Date), 2, 4, CAST(220.70 AS Decimal(10, 2)), N'en transit', CAST(N'2023-03-23' AS Date), CAST(N'2023-03-27' AS Date), 2)
INSERT [dbo].[expeditions] ([id], [date_expedition], [id_entrepot_source], [id_entrepot_destination], [poids], [statut], [date_livraison_prévu], [date_livraison], [id_client_receveur]) VALUES (3, CAST(N'2023-03-17' AS Date), 3, 2, CAST(350.20 AS Decimal(10, 2)), N'en transit', CAST(N'2023-03-24' AS Date), CAST(N'2023-03-24' AS Date), 2)
INSERT [dbo].[expeditions] ([id], [date_expedition], [id_entrepot_source], [id_entrepot_destination], [poids], [statut], [date_livraison_prévu], [date_livraison], [id_client_receveur]) VALUES (4, CAST(N'2023-03-18' AS Date), 4, 1, CAST(140.00 AS Decimal(10, 2)), N'non pris en charge', CAST(N'2023-03-25' AS Date), CAST(N'2023-03-29' AS Date), 2)
INSERT [dbo].[expeditions] ([id], [date_expedition], [id_entrepot_source], [id_entrepot_destination], [poids], [statut], [date_livraison_prévu], [date_livraison], [id_client_receveur]) VALUES (5, CAST(N'2023-03-19' AS Date), 5, 2, CAST(410.90 AS Decimal(10, 2)), N'en transit', CAST(N'2023-03-26' AS Date), CAST(N'2023-03-26' AS Date), 2)
INSERT [dbo].[expeditions] ([id], [date_expedition], [id_entrepot_source], [id_entrepot_destination], [poids], [statut], [date_livraison_prévu], [date_livraison], [id_client_receveur]) VALUES (6, CAST(N'2023-03-20' AS Date), 1, 4, CAST(280.30 AS Decimal(10, 2)), N'en transit', CAST(N'2023-03-27' AS Date), CAST(N'2023-03-31' AS Date), 1)
INSERT [dbo].[expeditions] ([id], [date_expedition], [id_entrepot_source], [id_entrepot_destination], [poids], [statut], [date_livraison_prévu], [date_livraison], [id_client_receveur]) VALUES (7, CAST(N'2023-03-21' AS Date), 2, 5, CAST(180.60 AS Decimal(10, 2)), N'en transit', CAST(N'2023-03-28' AS Date), CAST(N'2023-03-28' AS Date), 1)
INSERT [dbo].[expeditions] ([id], [date_expedition], [id_entrepot_source], [id_entrepot_destination], [poids], [statut], [date_livraison_prévu], [date_livraison], [id_client_receveur]) VALUES (8, CAST(N'2023-03-22' AS Date), 3, 1, CAST(80.10 AS Decimal(10, 2)), N'perdu', CAST(N'2023-03-29' AS Date), CAST(N'2023-03-29' AS Date), 3)
INSERT [dbo].[expeditions] ([id], [date_expedition], [id_entrepot_source], [id_entrepot_destination], [poids], [statut], [date_livraison_prévu], [date_livraison], [id_client_receveur]) VALUES (9, CAST(N'2023-03-23' AS Date), 4, 2, CAST(430.00 AS Decimal(10, 2)), N'en transit', CAST(N'2023-03-30' AS Date), CAST(N'2023-03-30' AS Date), 1)
INSERT [dbo].[expeditions] ([id], [date_expedition], [id_entrepot_source], [id_entrepot_destination], [poids], [statut], [date_livraison_prévu], [date_livraison], [id_client_receveur]) VALUES (10, CAST(N'2023-03-24' AS Date), 5, 3, CAST(90.40 AS Decimal(10, 2)), N'arriver', CAST(N'2023-03-31' AS Date), CAST(N'2023-03-31' AS Date), 1)
INSERT [dbo].[expeditions] ([id], [date_expedition], [id_entrepot_source], [id_entrepot_destination], [poids], [statut], [date_livraison_prévu], [date_livraison], [id_client_receveur]) VALUES (11, CAST(N'2023-04-01' AS Date), 2, 5, CAST(50.00 AS Decimal(10, 2)), N'arriver', CAST(N'2023-04-08' AS Date), CAST(N'2023-04-12' AS Date), 3)
INSERT [dbo].[expeditions] ([id], [date_expedition], [id_entrepot_source], [id_entrepot_destination], [poids], [statut], [date_livraison_prévu], [date_livraison], [id_client_receveur]) VALUES (12, CAST(N'2023-03-29' AS Date), 5, 2, CAST(50.00 AS Decimal(10, 2)), N'arriver', CAST(N'2023-04-05' AS Date), CAST(N'2023-04-02' AS Date), 2)
INSERT [dbo].[expeditions] ([id], [date_expedition], [id_entrepot_source], [id_entrepot_destination], [poids], [statut], [date_livraison_prévu], [date_livraison], [id_client_receveur]) VALUES (13, CAST(N'2023-04-02' AS Date), 3, 2, CAST(150.00 AS Decimal(10, 2)), N'arriver', CAST(N'2023-04-09' AS Date), NULL, 3)
INSERT [dbo].[expeditions] ([id], [date_expedition], [id_entrepot_source], [id_entrepot_destination], [poids], [statut], [date_livraison_prévu], [date_livraison], [id_client_receveur]) VALUES (14, CAST(N'2023-04-03' AS Date), 4, 1, CAST(250.00 AS Decimal(10, 2)), N'arriver', CAST(N'2023-04-10' AS Date), CAST(N'2023-04-07' AS Date), 4)
INSERT [dbo].[expeditions] ([id], [date_expedition], [id_entrepot_source], [id_entrepot_destination], [poids], [statut], [date_livraison_prévu], [date_livraison], [id_client_receveur]) VALUES (15, CAST(N'2023-03-30' AS Date), 1, 2, CAST(60.00 AS Decimal(10, 2)), N'arriver', CAST(N'2023-04-06' AS Date), CAST(N'2023-04-03' AS Date), 1)
INSERT [dbo].[expeditions] ([id], [date_expedition], [id_entrepot_source], [id_entrepot_destination], [poids], [statut], [date_livraison_prévu], [date_livraison], [id_client_receveur]) VALUES (16, CAST(N'2023-03-31' AS Date), 3, 1, CAST(40.00 AS Decimal(10, 2)), N'arriver', CAST(N'2023-04-07' AS Date), CAST(N'2023-04-04' AS Date), 4)
INSERT [dbo].[expeditions] ([id], [date_expedition], [id_entrepot_source], [id_entrepot_destination], [poids], [statut], [date_livraison_prévu], [date_livraison], [id_client_receveur]) VALUES (17, CAST(N'2023-03-28' AS Date), 2, 1, CAST(40.00 AS Decimal(10, 2)), N'arriver', CAST(N'2023-04-04' AS Date), NULL, NULL)
INSERT [dbo].[expeditions] ([id], [date_expedition], [id_entrepot_source], [id_entrepot_destination], [poids], [statut], [date_livraison_prévu], [date_livraison], [id_client_receveur]) VALUES (18, CAST(N'2023-03-20' AS Date), 8, 4, CAST(1200.00 AS Decimal(10, 2)), N'en transit', CAST(N'2023-03-27' AS Date), CAST(N'2023-03-24' AS Date), NULL)
INSERT [dbo].[expeditions] ([id], [date_expedition], [id_entrepot_source], [id_entrepot_destination], [poids], [statut], [date_livraison_prévu], [date_livraison], [id_client_receveur]) VALUES (19, CAST(N'2023-03-21' AS Date), 3, 7, CAST(180.60 AS Decimal(10, 2)), N'en transit', CAST(N'2023-03-28' AS Date), NULL, NULL)
INSERT [dbo].[expeditions] ([id], [date_expedition], [id_entrepot_source], [id_entrepot_destination], [poids], [statut], [date_livraison_prévu], [date_livraison], [id_client_receveur]) VALUES (20, CAST(N'2023-03-28' AS Date), 4, 6, CAST(40.00 AS Decimal(10, 2)), N'arriver', CAST(N'2023-04-04' AS Date), NULL, NULL)
INSERT [dbo].[expeditions] ([id], [date_expedition], [id_entrepot_source], [id_entrepot_destination], [poids], [statut], [date_livraison_prévu], [date_livraison], [id_client_receveur]) VALUES (21, CAST(N'2023-03-28' AS Date), 5, 8, CAST(540.00 AS Decimal(10, 2)), N'arriver', CAST(N'2023-04-04' AS Date), NULL, NULL)
INSERT [dbo].[expeditions] ([id], [date_expedition], [id_entrepot_source], [id_entrepot_destination], [poids], [statut], [date_livraison_prévu], [date_livraison], [id_client_receveur]) VALUES (22, CAST(N'2023-04-01' AS Date), 8, 5, CAST(896.00 AS Decimal(10, 2)), N'en transit', CAST(N'2023-04-08' AS Date), NULL, NULL)
INSERT [dbo].[expeditions] ([id], [date_expedition], [id_entrepot_source], [id_entrepot_destination], [poids], [statut], [date_livraison_prévu], [date_livraison], [id_client_receveur]) VALUES (23, CAST(N'2023-04-04' AS Date), 3, 5, CAST(89.00 AS Decimal(10, 2)), N'en transit', CAST(N'2023-04-11' AS Date), NULL, NULL)
INSERT [dbo].[expeditions] ([id], [date_expedition], [id_entrepot_source], [id_entrepot_destination], [poids], [statut], [date_livraison_prévu], [date_livraison], [id_client_receveur]) VALUES (24, CAST(N'2023-04-04' AS Date), 1, 3, CAST(120.50 AS Decimal(10, 2)), N'arriver', NULL, NULL, NULL)
INSERT [dbo].[expeditions] ([id], [date_expedition], [id_entrepot_source], [id_entrepot_destination], [poids], [statut], [date_livraison_prévu], [date_livraison], [id_client_receveur]) VALUES (25, CAST(N'2023-04-05' AS Date), 2, 4, CAST(220.70 AS Decimal(10, 2)), N'arriver', NULL, NULL, NULL)
INSERT [dbo].[expeditions] ([id], [date_expedition], [id_entrepot_source], [id_entrepot_destination], [poids], [statut], [date_livraison_prévu], [date_livraison], [id_client_receveur]) VALUES (26, CAST(N'2023-04-06' AS Date), 3, 2, CAST(350.20 AS Decimal(10, 2)), N'arriver', NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[expeditions] OFF
GO
INSERT [dbo].[expeditions_clients] ([id_expeditions], [id_client_expediteur]) VALUES (2, 1)
INSERT [dbo].[expeditions_clients] ([id_expeditions], [id_client_expediteur]) VALUES (9, 1)
INSERT [dbo].[expeditions_clients] ([id_expeditions], [id_client_expediteur]) VALUES (10, 1)
INSERT [dbo].[expeditions_clients] ([id_expeditions], [id_client_expediteur]) VALUES (5, 1)
INSERT [dbo].[expeditions_clients] ([id_expeditions], [id_client_expediteur]) VALUES (1, 2)
INSERT [dbo].[expeditions_clients] ([id_expeditions], [id_client_expediteur]) VALUES (11, 2)
INSERT [dbo].[expeditions_clients] ([id_expeditions], [id_client_expediteur]) VALUES (15, 3)
INSERT [dbo].[expeditions_clients] ([id_expeditions], [id_client_expediteur]) VALUES (3, 3)
INSERT [dbo].[expeditions_clients] ([id_expeditions], [id_client_expediteur]) VALUES (4, 3)
INSERT [dbo].[expeditions_clients] ([id_expeditions], [id_client_expediteur]) VALUES (16, 4)
INSERT [dbo].[expeditions_clients] ([id_expeditions], [id_client_expediteur]) VALUES (13, 4)
INSERT [dbo].[expeditions_clients] ([id_expeditions], [id_client_expediteur]) VALUES (12, 4)
GO
ALTER TABLE [dbo].[expeditions]  WITH CHECK ADD FOREIGN KEY([id_client_receveur])
REFERENCES [dbo].[clients] ([id])
GO
ALTER TABLE [dbo].[expeditions]  WITH CHECK ADD FOREIGN KEY([id_entrepot_source])
REFERENCES [dbo].[entrepots] ([id])
GO
ALTER TABLE [dbo].[expeditions]  WITH CHECK ADD FOREIGN KEY([id_entrepot_destination])
REFERENCES [dbo].[entrepots] ([id])
GO
ALTER TABLE [dbo].[expeditions_clients]  WITH CHECK ADD FOREIGN KEY([id_client_expediteur])
REFERENCES [dbo].[clients] ([id])
GO
ALTER TABLE [dbo].[expeditions_clients]  WITH CHECK ADD FOREIGN KEY([id_expeditions])
REFERENCES [dbo].[expeditions] ([id])
GO
/****** Object:  StoredProcedure [dbo].[nb_expeditions_envoyees_dernier_mois]    Script Date: 07/04/2023 14:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[nb_expeditions_envoyees_dernier_mois]
    @id_entrepot INT
AS
BEGIN
    SELECT COUNT(*) AS nombre_expeditions_envoyees
    FROM expeditions
    WHERE id_entrepot_source = @id_entrepot
    AND date_expedition >= DATEADD(month, -1, GETDATE());
END
GO
USE [master]
GO
ALTER DATABASE [transport_logistique] SET  READ_WRITE 
GO
