USE [master]
GO

IF EXISTS(SELECT [name] FROM sys.databases WHERE [name] = 'Restaurant')
BEGIN
	ALTER DATABASE Restaurant SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE Restaurant
END
GO

CREATE DATABASE [Restaurant]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Restaurant', FILENAME = N'D:\_sql_data\Restaurant.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Restaurant_log', FILENAME = N'D:\_sql_data\Restaurant_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Restaurant] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Restaurant].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Restaurant] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Restaurant] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Restaurant] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Restaurant] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Restaurant] SET ARITHABORT OFF 
GO
ALTER DATABASE [Restaurant] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Restaurant] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Restaurant] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Restaurant] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Restaurant] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Restaurant] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Restaurant] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Restaurant] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Restaurant] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Restaurant] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Restaurant] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Restaurant] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Restaurant] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Restaurant] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Restaurant] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Restaurant] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Restaurant] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Restaurant] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Restaurant] SET  MULTI_USER 
GO
ALTER DATABASE [Restaurant] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Restaurant] SET DB_CHAINING OFF 
GO
USE [Restaurant]
GO


/****** Object:  Table [dbo].[Addon]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Addon](
	[AddonId] [uniqueidentifier] NOT NULL,
	[RestaurantId] [int] NULL,
	[PriceId] [varchar](50) NULL,
	[CategoryId] [uniqueidentifier] NULL,
	[CategoryCode] [varchar](50) NULL,
	[Code] [varchar](20) NULL,
	[NameEn] [nvarchar](100) NULL,
	[NameVi] [nvarchar](100) NULL,
	[NameKo] [nvarchar](100) NULL,
	[NameEs] [nvarchar](100) NULL,
	[NameZh] [nvarchar](100) NULL,
	[Price] [decimal](5, 2) NULL,
	[PrepareMinutes] [int] NULL,
	[IsModifer] [bit] NULL,
	[IsPriceChangeable] [bit] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Addon] PRIMARY KEY CLUSTERED 
(
	[AddonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Category]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryId] [uniqueidentifier] NOT NULL,
	[RestaurantId] [int] NULL,
	[Sequence] [int] NULL,
	[Code] [varchar](50) NULL,
	[NameEn] [nvarchar](100) NULL,
	[NameVi] [nvarchar](100) NULL,
	[NameKo] [nvarchar](100) NULL,
	[NameEs] [nvarchar](100) NULL,
	[NameZh] [nvarchar](100) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Category_1] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Contact]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contact](
	[ContactId] [uniqueidentifier] NOT NULL,
	[NickName] [nvarchar](50) NULL,
	[First] [varchar](50) NULL,
	[Last] [varchar](50) NULL,
	[Middle] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Phone1] [varchar](50) NULL,
	[Phone2] [varchar](50) NULL,
	[Facebook] [varchar](50) NULL,
	[Type] [varchar](50) NULL,
	[Notes] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Contact] PRIMARY KEY CLUSTERED 
(
	[ContactId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customization]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customization](
	[CustomizationId] [uniqueidentifier] NOT NULL,
	[Description] [varchar](100) NULL,
	[Key] [varchar](50) NULL,
	[Value] [varchar](1000) NULL,
	[DataType] [varchar](50) NULL,
 CONSTRAINT [PK_Customization] PRIMARY KEY CLUSTERED 
(
	[CustomizationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Language]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Language](
	[LanguageId] [char](2) NOT NULL,
	[Name] [varchar](50) NULL,
	[NameNative] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Language] PRIMARY KEY CLUSTERED 
(
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Module]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Module](
	[ModuleId] [int] NOT NULL,
	[Name] [varchar](50) NULL,
	[Description] [varchar](500) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Module] PRIMARY KEY CLUSTERED 
(
	[ModuleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Order]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[OrderId] [uniqueidentifier] NOT NULL,
	[RestaurantId] [int] NULL,
	[TableId] [uniqueidentifier] NULL,
	[OrderTypeId] [uniqueidentifier] NULL,
	[OrderNumber] [varchar](50) NULL,
	[CustomerName] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Phone] [varchar](50) NULL,
	[PartySize] [int] NULL,
	[SplitBillEvenFlag] [bit] NULL,
	[EmailReceiptFlag] [bit] NULL,
	[TextReceiptFlag] [bit] NULL,
	[OrderTime] [datetime] NULL,
	[DeliverTime] [datetime] NULL,
	[PaidTime] [datetime] NULL,
	[TaxRatePercent] [decimal](4, 2) NULL,
	[OrderAmount] [decimal](8, 2) NULL,
	[TipAmount] [decimal](5, 2) NULL,
	[TotalAmount] [decimal](8, 0) NULL,
	[PaymentMethod] [varchar](50) NULL,
	[OrderStaffId] [uniqueidentifier] NULL,
	[ServiceStaffId] [uniqueidentifier] NULL,
	[CashierStaffId] [uniqueidentifier] NULL,
	[StatusId] [int] NULL,
	[IsToGo] [bit] NULL,
	[IsCompleted] [bit] NULL,
	[IsLocked] [bit] NULL,
	[Note] [nvarchar](500) NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[CreatedTime] [datetime] NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderEvent]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderEvent](
	[OrderEventId] [uniqueidentifier] NOT NULL,
	[OrderId] [uniqueidentifier] NULL,
	[TimeStamp] [datetime] NULL,
	[DescriptionEn] [nvarchar](200) NULL,
	[DescriptionVi] [nvarchar](200) NULL,
	[DescriptionKo] [nvarchar](200) NULL,
	[DescriptionEs] [nvarchar](200) NULL,
	[DescriptionZh] [nvarchar](200) NULL,
	[CreatedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_OrderEvent] PRIMARY KEY CLUSTERED 
(
	[OrderEventId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderProduct]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderProduct](
	[OrderProductId] [uniqueidentifier] NOT NULL,
	[OrderId] [uniqueidentifier] NULL,
	[ProductId] [uniqueidentifier] NULL,
	[StatusId] [int] NULL,
	[Sequence] [uniqueidentifier] NULL,
	[Quantity] [int] NULL,
	[SeatNumber] [int] NULL,
	[OrderTime] [datetime] NULL,
	[FinishTime] [datetime] NULL,
	[DeliverTime] [datetime] NULL,
	[Price] [decimal](5, 2) NULL,
	[IsComplementary] [bit] NULL,
	[IsToGo] [bit] NULL,
	[Notes] [nvarchar](100) NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[OrderProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderProductAddon]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderProductAddon](
	[OrderProductAddonId] [uniqueidentifier] NOT NULL,
	[OrderProductId] [uniqueidentifier] NULL,
	[AddonId] [uniqueidentifier] NULL,
	[OrderTime] [datetime] NULL,
	[FinishTime] [datetime] NULL,
	[DeliverTime] [datetime] NULL,
	[Price] [decimal](5, 2) NULL,
	[IsComplimentary] [bit] NULL,
	[IsToGo] [bit] NULL,
	[StatusId] [int] NULL,
 CONSTRAINT [PK_ProductAddon] PRIMARY KEY CLUSTERED 
(
	[OrderProductAddonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderPromotion]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderPromotion](
	[OrderPromotionId] [uniqueidentifier] NOT NULL,
	[OrderId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_OrderPromotion] PRIMARY KEY CLUSTERED 
(
	[OrderPromotionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderType]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderType](
	[OrderTypeId] [uniqueidentifier] NOT NULL,
	[NameEn] [nvarchar](100) NULL,
	[NameVi] [nvarchar](100) NULL,
	[NameKo] [nvarchar](100) NULL,
	[NameEs] [nvarchar](100) NULL,
	[NameZh] [nvarchar](100) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_OrderType] PRIMARY KEY CLUSTERED 
(
	[OrderTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Page]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Page](
	[PageId] [uniqueidentifier] NOT NULL,
	[Code] [varchar](50) NULL,
	[DescriptionEn] [varchar](100) NULL,
	[DescriptionVi] [nvarchar](100) NULL,
	[DescriptionKo] [nvarchar](100) NULL,
	[DescriptionEs] [nvarchar](100) NULL,
	[DescriptionZh] [nvarchar](100) NULL,
	[IsActive] [bit] NULL,
	[LastUpdate] [datetime] NULL,
 CONSTRAINT [PK_Page] PRIMARY KEY CLUSTERED 
(
	[PageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductId] [uniqueidentifier] NOT NULL,
	[RestaurantId] [int] NULL,
	[PriceId] [varchar](50) NULL,
	[Code] [varchar](20) NULL,
	[Sequence] [int] NULL,
	[NameEn] [nvarchar](100) NULL,
	[NameVi] [nvarchar](100) NULL,
	[NameKo] [nvarchar](100) NULL,
	[NameEs] [nvarchar](100) NULL,
	[NameZh] [nvarchar](100) NULL,
	[DescriptionEn] [nvarchar](200) NULL,
	[DescriptionVi] [nvarchar](200) NULL,
	[DescriptionKo] [nvarchar](200) NULL,
	[DescriptionEs] [nvarchar](200) NULL,
	[DescriptionZh] [nvarchar](200) NULL,
	[Price] [decimal](5, 2) NULL,
	[CategoryId] [uniqueidentifier] NULL,
	[CategoryCode] [varchar](50) NULL,
	[IsAddonRequired] [bit] NULL,
	[PrepareMinutes] [int] NULL,
	[PicturePath] [varchar](100) NULL,
	[IsPriceChangeable] [bit] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Promotion]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Promotion](
	[PromotionId] [uniqueidentifier] NOT NULL,
	[RestaurantId] [int] NULL,
	[NameEn] [nvarchar](100) NULL,
	[NameVi] [nvarchar](100) NULL,
	[NameKo] [nvarchar](100) NULL,
	[NameEs] [nvarchar](100) NULL,
	[NameZh] [nvarchar](100) NULL,
	[ApplicableCategoryId] [uniqueidentifier] NULL,
	[AmountPercent] [decimal](4, 2) NULL,
	[IsPercent] [bit] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Promotion] PRIMARY KEY CLUSTERED 
(
	[PromotionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Restaurant]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Restaurant](
	[RestaurantId] [int] NOT NULL,
	[NameEn] [nvarchar](100) NULL,
	[NameVi] [nvarchar](100) NULL,
	[NameKo] [nvarchar](100) NULL,
	[NameEs] [nvarchar](100) NULL,
	[NameZh] [nvarchar](100) NULL,
	[Location] [varchar](50) NULL,
	[Code] [varchar](50) NULL,
	[ResourceFolder] [varchar](200) NULL,
	[Address1] [varchar](100) NULL,
	[Address2] [varchar](100) NULL,
	[City] [varchar](100) NULL,
	[State] [varchar](10) NULL,
	[Zip] [varchar](15) NULL,
	[Phone] [varchar](15) NULL,
	[Contact1] [uniqueidentifier] NULL,
	[Contact2] [uniqueidentifier] NULL,
	[Contact3] [uniqueidentifier] NULL,
	[TaxPercent] [decimal](6, 3) NULL,
	[GroupPeople] [int] NULL,
	[GroupChargePercent] [decimal](6, 3) NULL,
	[RecommendedTipPercent] [decimal](6, 3) NULL,
	[CreditCardSurcharge] [decimal](6, 3) NULL,
	[SlowOrderWarningMinutes] [int] NULL,
	[RefreshIntervalSeconds] [int] NULL,
	[Status] [varchar](50) NULL,
	[Language] [char](2) NULL,
	[Notes] [nvarchar](500) NULL,
	[IsFoodTruck] [bit] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_SystemInfo] PRIMARY KEY CLUSTERED 
(
	[RestaurantId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RestaurantCustomization]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RestaurantCustomization](
	[RestaurantCustomizationId] [uniqueidentifier] NOT NULL,
	[RestaurantId] [int] NULL,
	[CustomizationId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_RestaurantCustomization] PRIMARY KEY CLUSTERED 
(
	[RestaurantCustomizationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RestaurantLanguage]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RestaurantLanguage](
	[RestaurantLanguageId] [uniqueidentifier] NOT NULL,
	[RestaurantId] [int] NULL,
	[LanguageId] [int] NULL,
 CONSTRAINT [PK_RestaurantLanguage] PRIMARY KEY CLUSTERED 
(
	[RestaurantLanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RestaurantModule]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RestaurantModule](
	[RestaurantModule] [uniqueidentifier] NOT NULL,
	[RestaurantId] [int] NULL,
	[ModuleId] [int] NULL,
	[LastUpdate] [datetime] NULL,
 CONSTRAINT [PK_RestaurantModule] PRIMARY KEY CLUSTERED 
(
	[RestaurantModule] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Status]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Status](
	[StatusId] [int] NOT NULL,
	[ApplyTo] [varchar](50) NULL,
	[Sequence] [int] NULL,
	[NameEn] [varchar](100) NULL,
	[NameVi] [nvarchar](100) NULL,
	[NameKo] [nvarchar](100) NULL,
	[NameEs] [nvarchar](100) NULL,
	[NameZh] [nvarchar](100) NULL,
	[DescriptionEn] [varchar](100) NULL,
	[DescriptionVi] [nvarchar](100) NULL,
	[DescriptionKo] [nvarchar](190) NULL,
	[DescriptionEs] [nvarchar](100) NULL,
	[DescriptionZh] [nvarchar](100) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
	[StatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Table]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table](
	[TableId] [uniqueidentifier] NOT NULL,
	[RestaurantId] [int] NULL,
	[PriceId] [varchar](50) NULL,
	[SequenceNo] [int] NULL,
	[NameEn] [nvarchar](100) NULL,
	[NameVi] [nvarchar](100) NULL,
	[NameKo] [nvarchar](100) NULL,
	[NameEs] [nvarchar](100) NULL,
	[NameZh] [nvarchar](100) NULL,
	[DescriptionEn] [nvarchar](200) NULL,
	[DescriptionVi] [nvarchar](200) NULL,
	[DescriptionKo] [nvarchar](200) NULL,
	[DescriptionEs] [nvarchar](200) NULL,
	[DescriptionZh] [nvarchar](200) NULL,
	[TableShapeId] [int] NULL,
	[Seats] [int] NULL,
	[LocationY] [int] NULL,
	[LocationX] [int] NULL,
	[IsForCustomer] [bit] NULL,
	[LastActivity] [datetime] NULL,
	[StatusId] [int] NULL,
	[LastUpdatedBy] [varchar](50) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Table] PRIMARY KEY CLUSTERED 
(
	[TableId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TableShape]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TableShape](
	[TableShapeId] [int] NOT NULL,
	[Code] [varchar](50) NULL,
	[NameEn] [varchar](50) NULL,
	[NameVi] [varchar](50) NULL,
	[NameKo] [varchar](50) NULL,
	[NameEs] [varchar](50) NULL,
	[NameZh] [varchar](50) NULL,
	[Class] [varchar](50) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_TableShape] PRIMARY KEY CLUSTERED 
(
	[TableShapeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserId] [uniqueidentifier] NOT NULL,
	[AuthenticationId] [uniqueidentifier] NULL,
	[RestaurantId] [int] NULL,
	[Login] [varchar](50) NULL,
	[Password] [varchar](50) NULL,
	[NameEn] [nvarchar](50) NULL,
	[Phone1] [varchar](20) NULL,
	[Phone2] [varchar](20) NULL,
	[UserType] [uniqueidentifier] NULL,
	[DefaultLanguage] [char](2) NULL,
	[Note] [nvarchar](200) NULL,
	[IsActive] [bit] NULL,
	[LastLogin] [datetime] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserHistory]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserHistory](
	[UserHistoryId] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NULL,
	[DateStamp] [datetime] NULL,
	[Description] [varchar](50) NULL,
 CONSTRAINT [PK_UserHistory] PRIMARY KEY CLUSTERED 
(
	[UserHistoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[vwOrder]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[vwOrder] as

select 
	o.RestaurantId, o.orderId, TableName = t.NameEn, p.[Sequence], 
	ProductName = p.NameVi, ProductPrice = op.Price, 
	AddonName = a.NameVi, AddonPrice = opa.Price,
	o.OrderAmount, o.TotalAmount, o.TipAmount
from [Order] o
left join [OrderProduct] op on op.OrderId = o.OrderId
left join [OrderProductAddon] opa on opa.OrderProductId = op.OrderProductId
left join [Product] p on p.ProductId = op.ProductId
left join [Addon] a on a.AddonId = opa.AddonId
left join [Table] t on t.TableId = o.TableId



/*
select * from [Order]
select * from [OrderProduct]
select * from [OrderProductAddon]


delete [OrderProductAddon]
delete [OrderProduct]
delete [Order]
*/




GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [RoleNameIndex]    Script Date: 2/7/2017 4:46:52 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 2/7/2017 4:46:52 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 2/7/2017 4:46:52 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_RoleId]    Script Date: 2/7/2017 4:46:52 PM ******/
CREATE NONCLUSTERED INDEX [IX_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 2/7/2017 4:46:52 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserRoles]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UserNameIndex]    Script Date: 2/7/2017 4:46:52 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Addon]  WITH CHECK ADD  CONSTRAINT [FK_Addon_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([CategoryId])
GO
ALTER TABLE [dbo].[Addon] CHECK CONSTRAINT [FK_Addon_Category]
GO
ALTER TABLE [dbo].[Addon]  WITH CHECK ADD  CONSTRAINT [FK_Addon_Restaurant] FOREIGN KEY([RestaurantId])
REFERENCES [dbo].[Restaurant] ([RestaurantId])
GO
ALTER TABLE [dbo].[Addon] CHECK CONSTRAINT [FK_Addon_Restaurant]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[Category]  WITH CHECK ADD  CONSTRAINT [FK_Category_Restaurant] FOREIGN KEY([RestaurantId])
REFERENCES [dbo].[Restaurant] ([RestaurantId])
GO
ALTER TABLE [dbo].[Category] CHECK CONSTRAINT [FK_Category_Restaurant]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_CashierStaff] FOREIGN KEY([CashierStaffId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_CashierStaff]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Order] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Order] ([OrderId])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Order]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_OrderStaff] FOREIGN KEY([OrderStaffId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_OrderStaff]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_OrderType] FOREIGN KEY([OrderTypeId])
REFERENCES [dbo].[OrderType] ([OrderTypeId])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_OrderType]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Restaurant] FOREIGN KEY([RestaurantId])
REFERENCES [dbo].[Restaurant] ([RestaurantId])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Restaurant]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_ServiceStaff] FOREIGN KEY([ServiceStaffId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_ServiceStaff]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Status] ([StatusId])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Status]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Table] FOREIGN KEY([TableId])
REFERENCES [dbo].[Table] ([TableId])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Table]
GO
ALTER TABLE [dbo].[OrderEvent]  WITH CHECK ADD  CONSTRAINT [FK_OrderEvent_Order] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Order] ([OrderId])
GO
ALTER TABLE [dbo].[OrderEvent] CHECK CONSTRAINT [FK_OrderEvent_Order]
GO
ALTER TABLE [dbo].[OrderProduct]  WITH CHECK ADD  CONSTRAINT [FK_OrderProduct_Order] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Order] ([OrderId])
GO
ALTER TABLE [dbo].[OrderProduct] CHECK CONSTRAINT [FK_OrderProduct_Order]
GO
ALTER TABLE [dbo].[OrderProduct]  WITH CHECK ADD  CONSTRAINT [FK_OrderProduct_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
GO
ALTER TABLE [dbo].[OrderProduct] CHECK CONSTRAINT [FK_OrderProduct_Product]
GO
ALTER TABLE [dbo].[OrderProduct]  WITH CHECK ADD  CONSTRAINT [FK_OrderProduct_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Status] ([StatusId])
GO
ALTER TABLE [dbo].[OrderProduct] CHECK CONSTRAINT [FK_OrderProduct_Status]
GO
ALTER TABLE [dbo].[OrderProductAddon]  WITH CHECK ADD  CONSTRAINT [FK_OrderProductAddon_OrderProduct] FOREIGN KEY([OrderProductId])
REFERENCES [dbo].[OrderProduct] ([OrderProductId])
GO
ALTER TABLE [dbo].[OrderProductAddon] CHECK CONSTRAINT [FK_OrderProductAddon_OrderProduct]
GO
ALTER TABLE [dbo].[OrderProductAddon]  WITH CHECK ADD  CONSTRAINT [FK_OrderProductAddon_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Status] ([StatusId])
GO
ALTER TABLE [dbo].[OrderProductAddon] CHECK CONSTRAINT [FK_OrderProductAddon_Status]
GO
ALTER TABLE [dbo].[OrderProductAddon]  WITH CHECK ADD  CONSTRAINT [FK_ProductAddon_Addon] FOREIGN KEY([AddonId])
REFERENCES [dbo].[Addon] ([AddonId])
GO
ALTER TABLE [dbo].[OrderProductAddon] CHECK CONSTRAINT [FK_ProductAddon_Addon]
GO
ALTER TABLE [dbo].[OrderPromotion]  WITH CHECK ADD  CONSTRAINT [FK_OrderPromotion_OrderPromotion] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Order] ([OrderId])
GO
ALTER TABLE [dbo].[OrderPromotion] CHECK CONSTRAINT [FK_OrderPromotion_OrderPromotion]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([CategoryId])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Restaurant] FOREIGN KEY([RestaurantId])
REFERENCES [dbo].[Restaurant] ([RestaurantId])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Restaurant]
GO
ALTER TABLE [dbo].[Promotion]  WITH CHECK ADD  CONSTRAINT [FK_Promotion_Category] FOREIGN KEY([ApplicableCategoryId])
REFERENCES [dbo].[Category] ([CategoryId])
GO
ALTER TABLE [dbo].[Promotion] CHECK CONSTRAINT [FK_Promotion_Category]
GO
ALTER TABLE [dbo].[Promotion]  WITH CHECK ADD  CONSTRAINT [FK_Promotion_Restaurant] FOREIGN KEY([RestaurantId])
REFERENCES [dbo].[Restaurant] ([RestaurantId])
GO
ALTER TABLE [dbo].[Promotion] CHECK CONSTRAINT [FK_Promotion_Restaurant]
GO
ALTER TABLE [dbo].[Restaurant]  WITH CHECK ADD  CONSTRAINT [FK_Restaurant_Contact] FOREIGN KEY([Contact3])
REFERENCES [dbo].[Contact] ([ContactId])
GO
ALTER TABLE [dbo].[Restaurant] CHECK CONSTRAINT [FK_Restaurant_Contact]
GO
ALTER TABLE [dbo].[Restaurant]  WITH CHECK ADD  CONSTRAINT [FK_Restaurant_Contact1] FOREIGN KEY([Contact1])
REFERENCES [dbo].[Contact] ([ContactId])
GO
ALTER TABLE [dbo].[Restaurant] CHECK CONSTRAINT [FK_Restaurant_Contact1]
GO
ALTER TABLE [dbo].[Restaurant]  WITH CHECK ADD  CONSTRAINT [FK_Restaurant_Contact2] FOREIGN KEY([Contact2])
REFERENCES [dbo].[Contact] ([ContactId])
GO
ALTER TABLE [dbo].[Restaurant] CHECK CONSTRAINT [FK_Restaurant_Contact2]
GO
ALTER TABLE [dbo].[Restaurant]  WITH CHECK ADD  CONSTRAINT [FK_Restaurant_Language] FOREIGN KEY([Language])
REFERENCES [dbo].[Language] ([LanguageId])
GO
ALTER TABLE [dbo].[Restaurant] CHECK CONSTRAINT [FK_Restaurant_Language]
GO
ALTER TABLE [dbo].[RestaurantCustomization]  WITH CHECK ADD  CONSTRAINT [FK_RestaurantCustomization_Customization] FOREIGN KEY([CustomizationId])
REFERENCES [dbo].[Customization] ([CustomizationId])
GO
ALTER TABLE [dbo].[RestaurantCustomization] CHECK CONSTRAINT [FK_RestaurantCustomization_Customization]
GO
ALTER TABLE [dbo].[RestaurantCustomization]  WITH CHECK ADD  CONSTRAINT [FK_RestaurantCustomization_Restaurant] FOREIGN KEY([RestaurantId])
REFERENCES [dbo].[Restaurant] ([RestaurantId])
GO
ALTER TABLE [dbo].[RestaurantCustomization] CHECK CONSTRAINT [FK_RestaurantCustomization_Restaurant]
GO
ALTER TABLE [dbo].[RestaurantModule]  WITH CHECK ADD  CONSTRAINT [FK_RestaurantModule_Module] FOREIGN KEY([ModuleId])
REFERENCES [dbo].[Module] ([ModuleId])
GO
ALTER TABLE [dbo].[RestaurantModule] CHECK CONSTRAINT [FK_RestaurantModule_Module]
GO
ALTER TABLE [dbo].[RestaurantModule]  WITH CHECK ADD  CONSTRAINT [FK_RestaurantModule_Restaurant] FOREIGN KEY([RestaurantId])
REFERENCES [dbo].[Restaurant] ([RestaurantId])
GO
ALTER TABLE [dbo].[RestaurantModule] CHECK CONSTRAINT [FK_RestaurantModule_Restaurant]
GO
ALTER TABLE [dbo].[Table]  WITH CHECK ADD  CONSTRAINT [FK_Table_Restaurant] FOREIGN KEY([RestaurantId])
REFERENCES [dbo].[Restaurant] ([RestaurantId])
GO
ALTER TABLE [dbo].[Table] CHECK CONSTRAINT [FK_Table_Restaurant]
GO
ALTER TABLE [dbo].[Table]  WITH CHECK ADD  CONSTRAINT [FK_Table_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Status] ([StatusId])
GO
ALTER TABLE [dbo].[Table] CHECK CONSTRAINT [FK_Table_Status]
GO
ALTER TABLE [dbo].[Table]  WITH CHECK ADD  CONSTRAINT [FK_Table_TableShape] FOREIGN KEY([TableShapeId])
REFERENCES [dbo].[TableShape] ([TableShapeId])
GO
ALTER TABLE [dbo].[Table] CHECK CONSTRAINT [FK_Table_TableShape]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Restaurant] FOREIGN KEY([RestaurantId])
REFERENCES [dbo].[Restaurant] ([RestaurantId])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Restaurant]
GO
ALTER TABLE [dbo].[UserHistory]  WITH CHECK ADD  CONSTRAINT [FK_UserHistory_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[UserHistory] CHECK CONSTRAINT [FK_UserHistory_User]
GO
/****** Object:  StoredProcedure [dbo].[CreateNewPrice]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CreateNewPrice] 
	@priceId VARCHAR(10) = 'New-price-Id',
	@restaurantId int = 101,
	@productIncrement decimal = 1,
	@addonIncrement decimal = 0.5
AS
BEGIN
	SET NOCOUNT ON;

INSERT INTO [dbo].[Product]
(
	   [ProductId]
      ,[RestaurantId]
      ,[PriceId]
      ,[Code]
      ,[Sequence]
      ,[NameEn]
      ,[NameVi]
      ,[NameKo]
      ,[NameEs]
      ,[NameZh]
      ,[DescriptionEn]
      ,[DescriptionVi]
      ,[DescriptionKo]
      ,[DescriptionEs]
      ,[DescriptionZh]
      ,[Price]
      ,[CategoryId]
      ,[CategoryCode]
      ,[IsAddonRequired]
      ,[PrepareMinutes]
      ,[PicturePath]
      ,[IsActive]
)
SELECT 
	   Newid()
      ,[RestaurantId]
      ,@priceId
      ,[Code]
      ,[Sequence]
      ,[NameEn]
      ,[NameVi]
      ,[NameKo]
      ,[NameEs]
      ,[NameZh]
      ,[DescriptionEn]
      ,[DescriptionVi]
      ,[DescriptionKo]
      ,[DescriptionEs]
      ,[DescriptionZh]
      ,[Price] 
      ,[CategoryId]
      ,[CategoryCode]
      ,[IsAddonRequired]
      ,[PrepareMinutes]
      ,[PicturePath]
      ,[IsActive]
  FROM [dbo].[Product]
  WHERE RestaurantId = @restaurantId and PriceId is null

UPDATE [dbo].[Product] SET price = price + @productIncrement 
	WHERE RestaurantId = @restaurantId and PriceId = @priceId




	INSERT INTO [dbo].[Addon]
(
	   [AddonId]
      ,[RestaurantId]
      ,[PriceId]
      ,[CategoryId]
      ,[CategoryCode]
      ,[Code]
      ,[NameEn]
      ,[NameVi]
      ,[NameKo]
      ,[NameEs]
      ,[NameZh]
      ,[Price]
      ,[PrepareMinutes]
      ,[IsActive]
)
SELECT 
	   Newid()
      ,[RestaurantId]
      ,[PriceId]
      ,[CategoryId]
      ,[CategoryCode]
      ,[Code]
      ,[NameEn]
      ,[NameVi]
      ,[NameKo]
      ,[NameEs]
      ,[NameZh]
      ,[Price]
      ,[PrepareMinutes]
      ,[IsActive]
  FROM [dbo].[Addon]	
  WHERE RestaurantId = @restaurantId and PriceId is null

  UPDATE [dbo].[Product] SET price = price + @addonIncrement 
	WHERE RestaurantId = @restaurantId and PriceId = @priceId

END





GO
/****** Object:  StoredProcedure [dbo].[DeleteAllData]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Refresh All data 
-- =============================================
CREATE PROCEDURE [dbo].[DeleteAllData]
AS
BEGIN
	--	declare @restaurantId int 
	SET NOCOUNT ON;

	DELETE [OrderProductAddon]
	DELETE [OrderEvent] 
	DELETE [OrderProduct]
	DELETE [OrderPromotion] 
	DELETE [Order]				
	
	DELETE [Promotion]			
	DELETE [Product]			
	DELETE [Addon]				
	DELETE [Category]			
	DELETE [User]				
	--DELETE [UserType]			

	DELETE [Page]

	DELETE [RestaurantModule]	

	DELETE [Table]	
	DELETE [TableShape]
	
	DELETE [Status]
				
	DELETE [Customization]
	DELETE [RestaurantCustomization]
	DELETE [Restaurant]

	DELETE [Module]			
	DELETE [Language]			

	-- Identity tables
	DELETE AspNetUserRoles
	DELETE AspNetRoles
	DELETE AspNetUsers
END






GO
/****** Object:  StoredProcedure [dbo].[DeleteRestaurantData]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Refresh restauran data 
-- *** all existing data will be wiped out
-- =============================================
CREATE PROCEDURE [dbo].[DeleteRestaurantData]
	@restaurantId int = 0 
AS
BEGIN
	--	declare @restaurantId int 
	SET NOCOUNT ON;
	DELETE [OrderProductAddon]
	FROM [OrderProductAddon] t
	JOIN [OrderProduct] p ON p.OrderProductId = t.OrderProductId
	JOIN [Order] o ON o.OrderId = p.OrderId
	WHERE o.RestaurantId = @restaurantId

	DELETE [OrderEvent] 
	FROM [OrderEvent] t
	JOIN [Order] o ON o.OrderId = t.OrderId
	WHERE o.RestaurantId = @restaurantId

	DELETE [OrderProduct]
	FROM [OrderProduct] t
	JOIN [Order] o ON o.OrderId = t.OrderId
	WHERE o.RestaurantId = @restaurantId

	DELETE [OrderPromotion] 
	FROM [OrderPromotion] t
	JOIN [Order] o ON o.OrderId = t.OrderId
	WHERE o.RestaurantId = @restaurantId

	DELETE [Order]				WHERE RestaurantId = @restaurantId
	DELETE [Table]				WHERE RestaurantId = @restaurantId
	DELETE [Promotion]			WHERE RestaurantId = @restaurantId
	DELETE [Product]			WHERE RestaurantId = @restaurantId
	DELETE [Addon]				WHERE RestaurantId = @restaurantId
	DELETE [Category]			WHERE RestaurantId = @restaurantId
	DELETE [User]				WHERE RestaurantId = @restaurantId
END





GO
/****** Object:  StoredProcedure [dbo].[DeleteRestaurantOrders]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Refresh restauran data 
-- *** all existing data will be wiped out
-- =============================================
CREATE PROCEDURE [dbo].[DeleteRestaurantOrders]
	@restaurantId int = 0 
AS
BEGIN
	--	declare @restaurantId int 
	SET NOCOUNT ON;
	DELETE [OrderProductAddon]
	FROM [OrderProductAddon] t
	JOIN [OrderProduct] p ON p.OrderProductId = t.OrderProductId
	JOIN [Order] o ON o.OrderId = p.OrderId
	WHERE o.RestaurantId = @restaurantId

	DELETE [OrderEvent] 
	FROM [OrderEvent] t
	JOIN [Order] o ON o.OrderId = t.OrderId
	WHERE o.RestaurantId = @restaurantId

	DELETE [OrderProduct]
	FROM [OrderProduct] t
	JOIN [Order] o ON o.OrderId = t.OrderId
	WHERE o.RestaurantId = @restaurantId

	DELETE [OrderPromotion] 
	FROM [OrderPromotion] t
	JOIN [Order] o ON o.OrderId = t.OrderId
	WHERE o.RestaurantId = @restaurantId

	DELETE [Order]				WHERE RestaurantId = @restaurantId
	--DELETE [Table]				WHERE RestaurantId = @restaurantId
	--DELETE [Promotion]			WHERE RestaurantId = @restaurantId
	--DELETE [Product]			WHERE RestaurantId = @restaurantId
	--DELETE [Addon]				WHERE RestaurantId = @restaurantId
	--DELETE [Category]			WHERE RestaurantId = @restaurantId
	--DELETE [User]				WHERE RestaurantId = @restaurantId
END





GO
/****** Object:  StoredProcedure [dbo].[RefreshDatabase]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Refresh database
-- =============================================
CREATE PROCEDURE [dbo].[RefreshDatabase]

AS
BEGIN
	SET NOCOUNT ON;
	EXEC DeleteAllData
	EXEC SetupSystemTables
	EXEC SetupRestaurantDataForTesting
END

GO
/****** Object:  StoredProcedure [dbo].[SetupRestaurantDataForTesting]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SetupRestaurantDataForTesting]
AS
BEGIN
	SET NOCOUNT ON;

/*

Refresh all existing data for Pho So 1 Gardena (RestaurantId = 102)

*/



SET NOCOUNT ON;

DECLARE @restaurantId INT = 102	
DECLARE @restaurantCode VARCHAR(50) = 'PhoSo1'

EXEC DeleteRestaurantData @restaurantId
	
IF NOT EXISTS (SELECT 1 FROM [dbo].[Restaurant] WHERE RestaurantId=@restaurantId)
BEGIN
	INSERT INTO [dbo].[Restaurant] (RestaurantId) VALUES (@restaurantId)
END
UPDATE [dbo].[Restaurant] SET
	 NameEn						= 'Pho So 1'						
	,[Location]					= 'Gardena'					
	,[Code]						= @restaurantCode
    ,[Address1]					= '1749 W. Redondo Beach Blvd'				
    ,[Address2]					= ''					
    ,[City]						= 'Gardena'						
    ,[State]					= 'CA'							
    ,[Zip]						= '90247'							
    ,[Phone]					= '310-329-7365'
	-- [Hours]					= '9:00am - 9:45pm, Monday - Sunday'
    ,[TaxPercent]				= 8.35						
    ,[GroupPeople]				= 100						
    ,[GroupChargePercent]		= 15					
    ,[RecommendedTipPercent]	= 15				
    ,[CreditCardSurcharge]		= 10				
    ,[SlowOrderWarningMinutes]  = 10	
	,[RefreshIntervalSeconds]	= 20
	,[Language] = 'vi'		
WHERE RestaurantId = @restaurantId				

-- User
INSERT INTO [User]
	 (UserId, RestaurantId, DefaultLanguage, [Login], NameEn) 
	 VALUES
	 (NEWID(), @restaurantId, 'en',	'Demo'				,  'Demo Account, all roles')
	,(NEWID(), @restaurantId, 'vi',	'DemoV'				,  'Demo Account (Vietnamese)')
	,(NEWID(), @restaurantId, 'vi',	'Waiter'			,  'Can take order')
	,(NEWID(), @restaurantId, 'vi',	'Preparer'			,  'Prepare Food and Beverage')
	,(NEWID(), @restaurantId, 'vi',	'Deliverer'			,  'Servicer, carry food/beverage to customer')
	,(NEWID(), @restaurantId, 'vi',	'Cashier'			,  'Cashier')
	,(NEWID(), @restaurantId, 'vi',	'Manager'			,  'Restaurant Manager')
	,(NEWID(), @restaurantId, 'vi',	'Owner'				,  'Restaurant Owner')
	,(NEWID(), @restaurantId, 'vi',	'Admin'				,  'Restaurant Admin')
	
update [User] set [Password]  = lower([Login]) + 'temp' where RestaurantId = @restaurantId
update [User] set [Login]  = [Login] + '@' + @restaurantCode where RestaurantId = @restaurantId
DELETE AspNetUsers where UserName in (select Login from dbo.[User] where RestaurantId=@restaurantId)

-- Table 
-- location X (grid of 12)
INSERT INTO [Table] 
	 (TableId, RestaurantId, IsForCustomer, Seats, LocationY, LocationX, NameEn, NameVi) VALUES
	 (newid(), @restaurantId, 1, 4,  2, 1, 'T.01',	N'B.01')
	,(newid(), @restaurantId, 1, 4,  2, 2, 'T.02',	N'B.02')
	,(newid(), @restaurantId, 1, 8,  2, 3, 'T.03',	N'B.03')
	,(newid(), @restaurantId, 1, 8,  3, 1, 'T.04',	N'B.04')
	,(newid(), @restaurantId, 1, 4,  3, 2, 'T.05',	N'B.05')
	,(newid(), @restaurantId, 1, 4,  3, 3, 'T.06',	N'B.06')
	,(newid(), @restaurantId, 1, 6,  3, 1, 'T.07',	N'B.07')
	,(newid(), @restaurantId, 1, 6,  4, 2, 'T.08',	N'B.08')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.09',	N'B.09')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.10',	N'B.10')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.11',	N'B.11')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.12',	N'B.12')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.13',	N'B.13')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.14',	N'B.14')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.15',	N'B.15')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.16',	N'B.16')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.17',	N'B.17')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.18',	N'B.18')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.19',	N'B.19')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.20',	N'B.20')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.21',	N'B.21')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.22',	N'B.22')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.23',	N'B.23')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.24',	N'B.24')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.25',	N'B.25')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.26',	N'B.26')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.27',	N'B.27')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.28',	N'B.28')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.29',	N'B.29')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'Takeout',	N'Mang Đi')
	,(newid(), @restaurantId, 0, 0,  1, 1, 'Entrance',	N'Cửa ra vào')
	,(newid(), @restaurantId, 0, 0,  4, 1, 'Cashier',	N'Quầy tính tiền')
	,(newid(), @restaurantId, 0, 0,  4, 3, 'Kitchen',	N'Nhà bếp')


-- Category  (as in menu)
INSERT INTO Category
	 (CategoryId, RestaurantId, [Sequence], Code, NameEn, NameVi) 
	 VALUES
	 (newid(), @restaurantId, 1,  'BEV'			, 'Beverages',									N'Thức Uống')			-- 1
	,(newid(), @restaurantId, 2,  'APPETIZER'	, 'Appetizer',									N'Khai Vị')				-- 2
	,(newid(), @restaurantId, 3,  'DESSERT'		, 'Desserts',									N'Tráng Miệng')			-- 3
	,(newid(), @restaurantId, 4,  'SPECIAL'		, 'Specialties',								N'Món Ăn Đặc Biệt')		-- 4
	,(newid(), @restaurantId, 5,  'SPBS'		, 'Specialty Beef & Shrimp',					N'Đặc Biệt Bò Tôm')		-- 5
	,(newid(), @restaurantId, 6,  'PHO'			, 'Noodle Soup of Beef',						N'Phở')					-- 6
	,(newid(), @restaurantId, 7,  'SPRN'		, 'Special Rice Soup & Pork Noodle Soup',		N'Cháo & Bánh Canh')	-- 7
	,(newid(), @restaurantId, 8,  'NOODLE'		, 'Egg Noodle',									N'Mì')					-- 8
	,(newid(), @restaurantId, 9,  'VERMICELLI'	, 'Vermicelli',									N'Bún')					-- 9
	,(newid(), @restaurantId, 10, 'RICE'		, 'Rice',										N'Cơm')					-- 10
	,(newid(), @restaurantId, 11, 'SIDE'		, 'Side Order',									N'Side Order')			-- 11
	
INSERT INTO Product 
	 (ProductId, RestaurantId, IsAddonRequired, CategoryCode, PrepareMinutes, Price, Code, NameEn, NameVi) 
	 VALUES
	 (newid(), @restaurantId, 0, 'BEV', 5, 2.95,	'122',		'Hot filtered coffee, French style',						N'Cà phê phin')
	,(newid(), @restaurantId, 0, 'BEV', 5, 2.95,	'123',		'Hot filtered coffee with condensed milk, French style',	N'Cà phe sữa')
	,(newid(), @restaurantId, 0, 'BEV', 5, 2.95,	'124',		'Iced filtered coffee, French style',						N'Cà phê phin đá')
	,(newid(), @restaurantId, 0, 'BEV', 5, 2.95,	'125',		'Iced filtered coffee with condensed milk, French style',	N'Cà phe sữa đá')
	,(newid(), @restaurantId, 0, 'BEV', 5, 2.15,	'126',		'Fresh lemonade',											N'Nước đá chanh')
	,(newid(), @restaurantId, 0, 'BEV', 5, 2.15,	'127',		'Soybean milk',												N'Sữa đậu nành')
	,(newid(), @restaurantId, 0, 'BEV', 5, 2.85,	'128',		'Beated egg sweeten milk with soda',						N'Soda sữa hột gà')
	,(newid(), @restaurantId, 0, 'BEV', 5, 2.85,	'129',		'Squeezed orange juice',									N'Cam vắt')
	,(newid(), @restaurantId, 0, 'BEV', 5, 2.85,	'130',		'Young coconut juice',										N'Nước dừa tươi')
	,(newid(), @restaurantId, 0, 'BEV', 5, 1.95,	'131-C',	'Soft drink, Coca Cola (per glass)',						N'Soda, Coca Cola (per glass)')
	,(newid(), @restaurantId, 0, 'BEV', 5, 1.95,	'131-U',	'Soft drink, 7-up (per glass)',								N'Soda, 7-Up (per glass)')
	,(newid(), @restaurantId, 0, 'BEV', 5, 1.95,	'131-O',	'Soft drink, Orange (per glass)',							N'Soda, Orange (per glass)')
	,(newid(), @restaurantId, 0, 'BEV', 5, 2.15,	'132-C',	'Soda lemon',												N'Soda chanh')
	,(newid(), @restaurantId, 0, 'BEV', 5, 2.15,	'132-CX',	'Soda salted plum',											N'Soda chanh xí mụi')
	,(newid(), @restaurantId, 0, 'BEV', 5, 2.15,	'132-XM',	'Soda salted lemon',										N'Soda chanh muối')
	,(newid(), @restaurantId, 0, 'BEV', 5, 2.15,	'133',		'Iced tea lemonade',										N'Trà đá chanh đường')
	,(newid(), @restaurantId, 0, 'BEV', 5, 2.85,	'134',		'Thai Iced tea',											N'Trà Thái')
	,(newid(), @restaurantId, 0, 'BEV', 5, 0.50,	'135',		'Iced tea',													N'Trà đá')
	,(newid(), @restaurantId, 0, 'DESSERT', 5, 2.85,	'107',	'Cold rambaruttan fruit??',									N'Chôm chôm ướp lạnh')
	,(newid(), @restaurantId, 0, 'DESSERT', 5, 2.85,	'108',	'Cold longan fruit',										N'Nhãn ướp lạnh')
	,(newid(), @restaurantId, 0, 'DESSERT', 5, 2.85,	'109',	'Jelly and tropical coconut milk',							N'Sương sa hạt lựu')
	,(newid(), @restaurantId, 0, 'DESSERT', 5, 2.85,	'110',	'Green bean drink',											N'Chè đậu xanh')
	,(newid(), @restaurantId, 0, 'DESSERT', 5, 2.85,	'111',	'Red bean drink',											N'Chè đậu đỏ')
	,(newid(), @restaurantId, 0, 'DESSERT', 5, 2.85,	'112',	'Special three-color drink',								N'Chè ba màu')
	,(newid(), @restaurantId, 0, 'DESSERT', 5, 2.85,	'113',	'Jelly dry plum lotus seed & drink in glass',				N'Sâm bổ lượng')
	,(newid(), @restaurantId, 0, 'DESSERT', 5, 2.85,	'114',	'Dry sugar longan',											N'Nhãn nhục')
	,(newid(), @restaurantId, 0, 'DESSERT', 5, 2.85,	'115',	'Natural shake of custard apple',							N'Sinh tố mãng cầu')
	,(newid(), @restaurantId, 0, 'DESSERT', 5, 2.85,	'116',	'Natural shake of durian',									N'Sinh tố sầu riêng')
	,(newid(), @restaurantId, 0, 'DESSERT', 5, 2.85,	'117',	'Natural shake of jack fruit',								N'Sinh tố mít')
	,(newid(), @restaurantId, 0, 'DESSERT', 5, 2.85,	'118',	'Natural shake of pineapple',								N'Sinh tố thơm')
	,(newid(), @restaurantId, 0, 'DESSERT', 5, 2.85,	'119',	'Vitamin of natural tomato shake',							N'Sinh tố cà chua')
	,(newid(), @restaurantId, 0, 'DESSERT', 5, 2.85,	'120',	'Vitamin of natural vegetable drink',						N'Rau má')
	,(newid(), @restaurantId, 0, 'DESSERT', 5, 2.85,	'121',	'Natural shake of avocado',									N'Sinh tố bơ')
	,(newid(), @restaurantId, 0, 'SPECIAL', 10, 9.45,	'95-H',	'Grilled pork with rice vermicelli (?) with vegetable',								N'Bánh hỏi thịt heo')
	,(newid(), @restaurantId, 0, 'SPECIAL', 10, 9.45,	'95-B',	'Grilled beef with rice vermicelli (?) with vegetable',								N'Bánh hỏi thịt bò')
	,(newid(), @restaurantId, 0, 'SPECIAL', 10, 9.45,	'96',	'Rice vermicelli (?) with barbecue shrimp sugar cane',								N'Bánh hỏi chạo tôm')
	,(newid(), @restaurantId, 0, 'SPECIAL', 10, 9.45,	'97',	'Grilled pork meat ball with  rice vermicelli (?) with vegetable (?)',				N'Bánh hỏi nem nướng')
	,(newid(), @restaurantId, 0, 'SPECIAL', 10, 9.45,	'98',	'Egg roll with rice vermicelli (?) with vegetable',									N'Bánh hỏi chả giò')
	,(newid(), @restaurantId, 0, 'SPECIAL', 10, 9.45,	'99',	'Grilled shrip with rice vermicelli (?) with vegetable',							N'Bánh hỏi tôm nướng')
	,(newid(), @restaurantId, 1, 'SPBS', 10, 17.55, '100',	'Beef',									N'Bò nhúng dấm')
	,(newid(), @restaurantId, 1, 'SPBS', 10, 20.55, '101',	'Beef',									N'Tôm nhúng dấm')
	,(newid(), @restaurantId, 1, 'SPBS', 10, 20.55, '102',	'Beef',									N'Bò tôm nhúng dấm')
	,(newid(), @restaurantId, 1, 'SPBS', 10, 17.55, '103',	'Beef',									N'Bò nướng vỉ')
	,(newid(), @restaurantId, 1, 'SPBS', 10, 20.55, '104',	'Beef',									N'Bò tôm nướng vỉ')
	,(newid(), @restaurantId, 1, 'SPBS', 10, 20.55, '105',	'Beef',									N'Tôm nướng vỉ')
	,(newid(), @restaurantId, 1, 'SPBS', 10, 10.15, '106',	'Beef',									N'Bò tái chanh')
	,(newid(), @restaurantId, 1, 'SPRN', 10, 7.85,	'26',	'Special beef rice soup',									N'Cháo bò')		 		 
	,(newid(), @restaurantId, 0, 'SPRN', 10, 7.85,	'27',	'Special combination of pig and organs(?) rice soup',		N'Cháo lòng heo')		 		 
	,(newid(), @restaurantId, 0, 'SPRN', 10, 7.85,	'28',	'Rice soup poridge with pig blood (?)',						N'Cháo huyết heo')		 		 
	,(newid(), @restaurantId, 0, 'SPRN', 10, 7.85,	'29',	'Rice (?) soup with pork legs',								N'Bánh canh giò heo')		 		 
	,(newid(), @restaurantId, 0, 'SPRN', 10, 7.85,	'20',	'Chicken rice soup',										N'Cháo gà')		 		 
	,(newid(), @restaurantId, 0, 'SPRN', 10, 7.85,	'31',	'Shrimp rice soup',											N'Cháo tôm')		 		 
	,(newid(), @restaurantId, 0, 'SPRN', 10, 7.85,	'32',	'Duck rice soup',											N'Cháo vịt')		 		 
	,(newid(), @restaurantId, 0, 'SPRN', 10, 7.85,	'33',	'Rice stick noodle soup with meat (?)',						N'Bánh canh thịt')		 		 
	,(newid(), @restaurantId, 0, 'SPRN', 10, 7.85,	'34',	'Rice stick noodle (?) with shhrimp, crab meat, pork leg, port meatrice soup',	N'Bánh canh giò heo tôm cua')		 		 
	,(newid(), @restaurantId, 0, 'SPRN', 10, 7.85,	'35',	'Rice stick (?) noodle with shrimp',						N'Bánh canh tôm')		 		 
	,(newid(), @restaurantId, 0, 'NOODLE', 10, 7.85,	'35',	'Egg noodle',						N'Mì tôm cua thịt soup')		 		 
	,(newid(), @restaurantId, 0, 'NOODLE', 10, 7.85,	'35',	'Egg noodle',						N'Mì đồ biển soup')		 		 
	,(newid(), @restaurantId, 0, 'NOODLE', 10, 7.85,	'35',	'Egg noodle',						N'Mì bò kho soup')		 		 
	,(newid(), @restaurantId, 0, 'NOODLE', 10, 7.85,	'35',	'Egg noodle',						N'Mì xào giòn đồ biển')		 		 
	,(newid(), @restaurantId, 0, 'NOODLE', 10, 7.85,	'35',	'Egg noodle',						N'Mì xào mềm đò biển')		 		 
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'41',	'Duck soup with clear noodle',		N'Miến vịt')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'42',	'Chicken soup with clear noodle',	N'Miến gà')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'43',	'vermicelli',						N'Bún măng vịt')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'44',	'vermicelli',						N'Bún bò Huế')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'45',	'vermicelli',						N'Bún bì chả giò')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'46',	'vermicelli',						N'Bún chả giò')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'47-H',	'vermicelli',						N'Bún bì thịt heo nướng')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'47-B',	'vermicelli',						N'Bún bì thịt bò nướng')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'48-H',	'vermicelli',						N'Bún chạo tôm thịt heo nướng')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'48-B',	'vermicelli',						N'Bún chạo tôm thịt bò nướng')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'49',	'vermicelli',						N'Bún chạo tôm chả giò')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'50-H',	'vermicelli',						N'Bún nem nướng thịt heo nướng')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'50-B',	'vermicelli',						N'Bún nem nướng thịt bò nướng')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'51',	'vermicelli',						N'Bún nem nướng chả giò')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'52-H',	'vermicelli',						N'Bún chả giò thịt heo nướng')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'52-B',	'vermicelli',						N'Bún chả giò thịt bò nướng')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'53-H',	'vermicelli',						N'Bún chả giò thịt heo nướng')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'53-B',	'vermicelli',						N'Bún chả giò thịt bò nướng')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'54-H',	'vermicelli',						N'Bún thịt heo nướng')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'54-B',	'vermicelli',						N'Bún thịt bò nướng')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'55',	'vermicelli',						N'Bún tôm nướng')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'56',	'vermicelli',						N'Bún tôm chả giò')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'57',	'vermicelli',						N'Bún bò xào')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'58',	'vermicelli',						N'Bún bò kho')
	,(newid(), @restaurantId, 0, 'VERMICELLI', 10, 7.85,	'59',	'vermicelli',						N'Bún bì tôm nướng')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'60',	'rice',								N'Cơm gà xào củ hành')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'61',	'rice',								N'Cơm gà xào xả ớt')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'62',	'rice',								N'Cơm tôm xào xả ớt')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'63',	'rice',								N'Cơm tôm gà xào xả ớt')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'64',	'rice',								N'Cơm tôm bò xào xả ớt')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'65',	'rice',								N'Cơm bò xào xả ớt')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'66',	'rice',								N'Cơm gà rôti')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'67',	'rice',								N'Cơm xào chay')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'68',	'rice',								N'Cơm bò kho')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'69',	'rice',								N'Cơm chiên Dương châu')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'70',	'rice',								N'Cơm bì chả nem nướng')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'71',	'rice',								N'Cơm nem nướng thịt nướng')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'72',	'rice',								N'Cơm bì chả chạo tôm')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'73',	'rice',								N'Cơm chạo tôm thịt nướng')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'74',	'rice',								N'Cơm sườn tôm ram')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'75',	'rice',								N'Cơm sườn ram')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'76',	'rice',								N'Cơm sườn xào chua ngọt')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'77',	'rice',								N'Cơm tôm xào chua ngọt')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'78',	'rice',								N'Cơm tấm sườn nướng')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'79',	'rice',								N'Cơm tấm chả sườn nướng')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'80',	'rice',								N'Cơm tấm bì chả sườn nướng')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'81',	'rice',								N'Cơm tấm bì chả thịt heo nướng')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'82',	'rice',								N'Cơm tấm bì chả thịt bò nướng')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'83',	'rice',								N'Cơm tấm thịt bò nướng')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'84',	'rice',								N'Cơm tấm thịt heo nướng')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'85',	'rice',								N'Cơm tấm bì chả')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'86',	'rice',								N'Cơm tôm xào bông cải')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'87',	'rice',								N'Cơm bò xào bông cải')		
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'88',	'rice',								N'Cơm tôm bò xào bông cải')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'89',	'rice',								N'Cơm bò xào củ hành')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'90',	'rice',								N'Cơm gà xào bông cải')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'91',	'rice',								N'Bánh mì bò kho')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.85,	'92',	'rice',								N'Cơm tôm bò nướng')
	,(newid(), @restaurantId, 0, 'RICE', 10, 7.75,	'93',	'rice',								N'Chả giò')
	,(newid(), @restaurantId, 0, 'RICE', 10, 6.55,	'94',	'rice',								N'Gỏi cuốn')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.75,	'01',	'beef noodle',						N'Đặc biệt xe lửa (tô lớn)')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'02',	'beef noodle',						N'Tái nạm gầu gân sách (tô nhỏ)')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'03',	'beef noodle',						N'Chín nạm gầu gân sách')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'04',	'beef noodle',						N'Tái chín gầu gân sách')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'05',	'beef noodle',						N'Tái chín nạm gân sách')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'06',	'beef noodle',						N'Tái nạm gân sách')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'07',	'beef noodle',						N'Tái nạm gân')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'08',	'beef noodle',						N'Tái nạm sách')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'09',	'beef noodle',						N'Tái chín nạm')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'10',	'beef noodle',						N'Nạm vè dòn')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'11',	'beef noodle',						N'Chín nạm vè dòn')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'12',	'beef noodle',						N'Tái nạm gầu')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'13',	'beef noodle',						N'Tái gầu')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'14',	'beef noodle',						N'Tái chín')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'15',	'beef noodle',						N'Tái nạm')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'16',	'beef noodle',						N'Tái gân')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'17',	'beef noodle',						N'Tái sách')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'18',	'beef noodle',						N'Tái tái')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'19',	'beef noodle',						N'Phở bò viên')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.55,	'20',	'beef noodle',						N'Bò viên')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'21',	'beef noodle',						N'Phở gà')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.75,	'22',	'beef noodle',						N'Phở tôm')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.85,	'23',	'beef noodle',						N'Phở bò kho')
	,(newid(), @restaurantId, 0, 'PHO', 5, 9.55,	'24',	'beef noodle',						N'Phở áp chảo')
	,(newid(), @restaurantId, 0, 'PHO', 5, 7.15,	'25',	'beef noodle',						N'Phở bông cải xanh đậu hũ')
	,(newid(), @restaurantId, 0, 'SIDE', 5, 5.00,	'X01',	'Shrimp Sauce',						N'Mắm nêm')
	,(newid(), @restaurantId, 0, 'SIDE', 5, 5.00,	'X01',	'Fish Sauce',						N'Nước mắm')
	,(newid(), @restaurantId, 0, 'SIDE', 5, 5.00,	'X02',	'Vermicelli only',					N'Bún không')
	,(newid(), @restaurantId, 0, 'SIDE', 5, 5.00,	'X03',	'Noodle only',						N'Mì không')
	,(newid(), @restaurantId, 0, 'SIDE', 5, 3.00,	'X04',	'Pho broth',						N'Nước phở')
	,(newid(), @restaurantId, 0, 'SIDE', 5, 3.00,	'X05',	'Pho noodle only',					N'Bánh phở')
	,(newid(), @restaurantId, 0, 'SIDE', 5, 2.00,	'X06',	'Extra beef ball soup',				N'Thêm chén bò viên')
	,(newid(), @restaurantId, 0, 'SIDE', 5, 2.00,	'X07',	'Extra rare steak',					N'Thêm dĩa tái')
	,(newid(), @restaurantId, 0, 'SIDE', 5, 2.00,	'X08',	'Large bowl of noodle and soup',	N'Bánh nước (nhỏ)')
	,(newid(), @restaurantId, 0, 'SIDE', 5, 2.00,	'X09',	'Large bowl of noodle and soup',	N'Bánh nước (lớn)')
	,(newid(), @restaurantId, 0, 'SIDE', 5, 2.00,	'X10',	'Onion in broth', 					N'Hành chần nước béo')
	,(newid(), @restaurantId, 0, 'SIDE', 5, 2.00,	'X11',	'Sliced Onion with vinegar', 		N'Hành dấm')
	,(newid(), @restaurantId, 0, 'SIDE', 5, 2.00,	'X12',	'Extra vegetable for Pho', 			N'Thêm rau Phở')
	,(newid(), @restaurantId, 0, 'SIDE', 5, 2.00,	'X13',	'Extra vegetable for Special', 		N'Thêm rau Đặc biệt')
	,(newid(), @restaurantId, 0, 'SIDE', 5, 1.00,	'X90',	'Special 1'							, N'ĐB 1')
	,(newid(), @restaurantId, 0, 'SIDE', 5, 2.00,	'X91',	'Special 2'							, N'ĐB 2')
	,(newid(), @restaurantId, 0, 'SIDE', 5, 3.00,	'X92',	'Special 3'							, N'ĐB 3')
	,(newid(), @restaurantId, 0, 'SIDE', 5, 4.00,	'X93',	'Special 4'							, N'ĐB 4')
	,(newid(), @restaurantId, 0, 'SIDE', 5, 5.00,	'X94',	'Special 5'							, N'ĐB 5')
	,(newid(), @restaurantId, 0, 'SIDE', 5, 10.00,	'X95',	'Special 6'							, N'ĐB 6')

update t set t.CategoryId = c.CategoryId
from Product t
join Category c on c.Code = t.CategoryCode and t.RestaurantId = @restaurantId
where t.RestaurantId = @restaurantId and c.RestaurantId = @restaurantId



-- Addon Table
INSERT INTO Addon
	 (AddonId, RestaurantId, CategoryCode,  Price, NameEn, NameVi) 
	 VALUES
 	 
	 (newid(), @restaurantId, 'PHO'		, 0		,'Clear broth', 				N'Nước trong')			-- added
	,(newid(), @restaurantId, 'PHO'		, 0		,'Less noodle', 				N'Ít phở')
	,(newid(), @restaurantId, 'PHO'		, 0		,'No green onion', 				N'Không hành lá')
	,(newid(), @restaurantId, 'PHO'		, 0		,'No onion', 					N'Không hành tây')
	,(newid(), @restaurantId, 'PHO'		, 1		,'Add rare steak', 				N'Thêm tái')
	,(newid(), @restaurantId, 'PHO'		, 1		,'Add tripe', 					N'Thêm sách')
	,(newid(), @restaurantId, 'PHO'		, 1		,'Add CHIN', 					N'Thêm chín')
	,(newid(), @restaurantId, 'PHO'		, 1		,'Add NAM', 					N'Thêm nạm')
	,(newid(), @restaurantId, 'PHO'		, 1		,'Add meatball', 				N'Thêm bò viên')
	,(newid(), @restaurantId, 'PHO'		, 1		,'Add egg', 					N'Thêm trứng')
	,(newid(), @restaurantId, 'BEV'		, 1		,'No ice', 						N'Không đá')
	,(newid(), @restaurantId, 'BEV'		, 1		,'Little ice', 					N'Ít đá')
	,(newid(), @restaurantId, 'BEV'		, 1		,'No sugar', 					N'Không đường')
	,(newid(), @restaurantId, 'BEV'		, 1		,'Less sugar', 					N'Ít đường')
	,(newid(), @restaurantId, 'BEV'		, 1		,'Extra sugar', 				N'Thêm đường')
	,(newid(), @restaurantId, 'RICE'	, 1		,'Extra rice', 					N'Thêm cơm trắng')
	,(newid(), @restaurantId, 'RICE'	, 1		,'No onion', 					N'Không mỡ hành')
	,(newid(), @restaurantId, 'RICE'	, 0		,'Extra fish sauce', 			N'Thêm nước mắm')
	,(newid(), @restaurantId, 'RICE'	, 0		,'Extra egg', 					N'Thêm trứng')
	,(newid(), @restaurantId, 'RICE'	, 0		,'Extra bbq beef', 				N'Thêm bò nướng')
	,(newid(), @restaurantId, 'RICE'	, 0		,'Extra bbq pork', 				N'Thêm heo nướng')
	,(newid(), @restaurantId, 'RICE'	, 0		,'Extra pork rib', 				N'Thêm sường nướng')
	,(newid(), @restaurantId, 'RICE'	, 0		,'Extra egg paste', 			N'Thêm chả')
	,(newid(), @restaurantId, 'SPECIAL'	, 1		,'Fish sauce', 					N'Nước mắm')
	,(newid(), @restaurantId, 'SPECIAL'	, 1		,'Shrimp sauce', 				N'Mắm nêm')
	,(newid(), @restaurantId, 'SPECIAL'	, 0		,'Extra vegetable', 			N'Thêm rau')
	,(newid(), @restaurantId, 'SPECIAL'	, 0		,'Extra vermicelli', 			N'Thêm bún')
	,(newid(), @restaurantId, 'SPRN'	, 1		,'No onion', 					N'Không hành lá')
	,(newid(), @restaurantId, 'SPRN'	, 1		,'Extra broth', 				N'Thêm nước soup')
	,(newid(), @restaurantId, 'SPRN'	, 1		,'More noodle', 				N'Thêm bánh')
	,(newid(), @restaurantId, 'SPRN'	, 1		,'Less noodle', 				N'Ít bánh')
	
update t set t.CategoryId = c.CategoryId
from Addon t
join Category c on c.Code = t.CategoryCode and t.RestaurantId = @restaurantId
where t.RestaurantId = @restaurantId and c.RestaurantId = @restaurantId

UPDATE [User]		SET IsActive = 1 WHERE IsActive IS NULL	
UPDATE [Table]		SET IsActive = 1 WHERE IsActive IS NULL		
UPDATE [Product]	SET IsActive = 1 WHERE IsActive IS NULL	
UPDATE [Addon]		SET IsActive = 1 WHERE IsActive IS NULL	
UPDATE [Category]	SET IsActive = 1 WHERE IsActive IS NULL

------ food truck script ---------------------

/*

Refresh all existing data for Brian's Food Truck (RestaurantId = 101)

*/

set @restaurantId = 101	
set @restaurantCode = 'FoodTruck'

EXEC DeleteRestaurantData @restaurantId
	
IF NOT EXISTS (SELECT 1 FROM [dbo].[Restaurant] WHERE RestaurantId=@restaurantId)
BEGIN
	INSERT INTO [dbo].[Restaurant] (RestaurantId) VALUES (@restaurantId)
END

UPDATE [dbo].[Restaurant] SET
	 NameEn						= 'Brian''s Food Truck'						
	,[Location]					= 'Winnetka'					
	,[Code]						=  @restaurantCode
    ,[Address1]					= '19725 Stagg St'				
    ,[Address2]					= ''					
    ,[City]						= 'Winnetka'						
    ,[State]					= 'CA'							
    ,[Zip]						= '91335'							
    ,[Phone]					= '818-701-1234'
	-- [Hours]					= '9:00am - 9:45pm, Monday - Sunday'
    ,[TaxPercent]				= 8.35						
    ,[GroupPeople]				= 100						
    ,[GroupChargePercent]		= 15					
    ,[RecommendedTipPercent]	= 15				
    ,[CreditCardSurcharge]		= 10				
    ,[SlowOrderWarningMinutes]  = 10		
	,[RefreshIntervalSeconds]	= 20
	,[Language] = 'en'		
WHERE RestaurantId = @restaurantId				

-- User
INSERT INTO [User]
	(UserId, RestaurantId, DefaultLanguage, [Login], NameEn) 
	VALUES
	 (NEWID(), @restaurantId, 'en',	'Demo'				,  'Demo Account, all roles')
	,(NEWID(), @restaurantId, 'en',	'Waiter'			,  'Can take order')
	,(NEWID(), @restaurantId, 'en',	'Preparer'			,  'Prepare Food and Beverage')
	,(NEWID(), @restaurantId, 'en',	'Deliverer'			,  'Servicer, carry food/beverage to customer')
	,(NEWID(), @restaurantId, 'en',	'Cashier'			,  'Cashier')
	,(NEWID(), @restaurantId, 'en',	'Manager'			,  'Restaurant Manager')
	,(NEWID(), @restaurantId, 'en',	'Owner'				,  'Restaurant Owner')
	,(NEWID(), @restaurantId, 'en',	'Admin'				,  'Restaurant Admin')	
update [User] set [Password]  = lower([Login]) + 'temp' where RestaurantId = @restaurantId
update [User] set [Login]  = [Login] + '@' + @restaurantCode where RestaurantId = @restaurantId
DELETE [AspNetUsers] where UserName in (select Login from dbo.[User] where RestaurantId=@restaurantId)
	
-- Table 
-- use as food truck location/hours
INSERT INTO [Table] 
	(TableId, RestaurantId, IsForCustomer, PriceId, NameEn, DescriptionEn) 
	VALUES
	 (NEWID(), @restaurantId, 1, ''				, 'Brickyard Pub', 'North Hollywood')	
	,(NEWID(), @restaurantId, 1, ''				, 'Angel City Brewery', '')	
	,(NEWID(), @restaurantId, 1, 'Delux'			, 'October Event', 'Sample Delux Event Hollowood')	
	,(NEWID(), @restaurantId, 1, 'Business-Class'	, 'November Event', 'Sample Bussiness-class Event City Walk')	
	,(NEWID(), @restaurantId, 1, 'First-Class'		, 'Other Event', 'Sample First-class Event Moholland Drive')	

	

-- Category  (as in menu)
INSERT INTO Category
	(CategoryId, RestaurantId, [Sequence], Code, NameEn, NameVi) 
	VALUES
	 (newid(), @restaurantId, 1,	'BEV',		'Beverages',		N'Beverages')			
	,(newid(), @restaurantId, 2,	'TACO',		'Taco',				N'Taco')				
	,(newid(), @restaurantId, 3,	'QUESA',	'Quesadilla',		N'Quesadilla')			
	,(newid(), @restaurantId, 4,	'BURRITO',	'Burritos',			N'Burritos')			
	,(newid(), @restaurantId, 5,	'RBOWL',	'Rice Bowl',		N'Rice Bowl')			
	,(newid(), @restaurantId, 6,	'BURGER',	'Burger',			N'Burger')				
	,(newid(), @restaurantId, 7,	'DUMPLING',	'Dumplings',		N'Dumplings')			
	,(newid(), @restaurantId, 8,	'GCHEESE',	'Grilled Cheese',	N'Grilled Cheese')		
	,(newid(), @restaurantId, 9,	'SALAD',	'Salad',			N'Salad')				
	,(newid(), @restaurantId, 10,	'SIDE',		'SideOrder',		N'SideOrder')			

INSERT INTO Product 
	(ProductId, RestaurantId, IsAddonRequired, CategoryCode, Code, PrepareMinutes, Price, NameEn, NameVi) 
	VALUES
	 (newid(), @restaurantId, 0, 'BEV',			'11',	5,  2.00, 'Coke',					'')
	,(newid(), @restaurantId, 0, 'BEV',			'12',	5,  2.00, 'Diet Coke',				'')
	,(newid(), @restaurantId, 0, 'BEV',			'13',	5,  2.00, 'Ginger Ale',				'')
	,(newid(), @restaurantId, 0, 'BEV',			'14',	5,  2.00, 'Cactus Cooler',				'')
	,(newid(), @restaurantId, 0, 'BEV',			'15',	5,  2.00, 'Gatorade',				'')
	,(newid(), @restaurantId, 0, 'BEV',			'16',	5,  2.95, 'Bottled Water',			'')
	,(newid(), @restaurantId, 1, 'TACO',		'31',	5,  2.00, 'Taco, Beef "Kalbi"',			'')
	,(newid(), @restaurantId, 1, 'TACO',		'32',	5,  2.00, 'Taco, Pork "Pork Belly"',		'')
	,(newid(), @restaurantId, 1, 'TACO',		'33',	5,  2.00, 'Taco, Chicken "Braise Thigh"','')
	,(newid(), @restaurantId, 1, 'TACO',		'34',	5,  2.00, 'Taco, Tofu "Soy Protein"',	'')
	,(newid(), @restaurantId, 1, 'QUESA',		'41',	5,  6.00, 'Quesadia, Plain',			'')
	,(newid(), @restaurantId, 1, 'QUESA',		'43',	5,  9.00, 'Quesadia, Kimchi',			'')
	,(newid(), @restaurantId, 1, 'QUESA',		'44',	5, 11.00, 'Quesadia, Beef "Kalbi"',			'')
	,(newid(), @restaurantId, 1, 'QUESA',		'45',	5, 11.00, 'Quesadia, Pork "Pork Belly"',		'')
	,(newid(), @restaurantId, 1, 'QUESA',		'46',	5, 11.00, 'Quesadia, Chicken "Braise Thigh"','')
	,(newid(), @restaurantId, 1, 'QUESA',		'47',	5, 11.00, 'Quesadia, Tofu "Soy Protein"',	'')
	,(newid(), @restaurantId, 1, 'BURRITO',		'51',	5,  9.00, 'Burrito, Beef "Kalbi"',			'')
	,(newid(), @restaurantId, 1, 'BURRITO',		'52',	5,  9.00, 'Burrito, Pork "Pork Belly"',		'')
	,(newid(), @restaurantId, 1, 'BURRITO',		'53',	5,  9.00, 'Burrito, Chicken "Braise Thigh"','')
	,(newid(), @restaurantId, 1, 'BURRITO',		'54',	5,  9.00, 'Burrito, Tofu "Soy Protein"',	'')
	,(newid(), @restaurantId, 1, 'RBOWL',		'51',	5, 11.00, 'Beef "Kalbi"',			'')
	,(newid(), @restaurantId, 1, 'RBOWL',		'52',	5, 11.00, 'Rice Bowl, Pork "Pork Belly"',		'')
	,(newid(), @restaurantId, 1, 'RBOWL',		'53',	5, 11.00, 'Rice Bowl, Chicken "Braise Thigh"','')
	,(newid(), @restaurantId, 1, 'RBOWL',		'54',	5, 11.00, 'Rice Bowl, Tofu "Soy Protein"',	'')
	,(newid(), @restaurantId, 1, 'BURGER',		'61',	5,  8.95, 'Beef "Kalbi"',			'')
	,(newid(), @restaurantId, 1, 'BURGER',		'62',	5,  8.95, 'Burger, Pork "Pork Belly"',		'')
	,(newid(), @restaurantId, 1, 'BURGER',		'63',	5,  8.95, 'Burger, Chicken "Braise Thigh"','')
	,(newid(), @restaurantId, 1, 'BURGER',		'64',	5,  8.95, 'Burger, Tofu "Soy Protein"',	'')
	,(newid(), @restaurantId, 1, 'BURGER',		'65',	5,  8.95, 'Burger, Kimchi"',	'')
	,(newid(), @restaurantId, 1, 'DUMPLING',	'71',	5, 12.00, 'Dumpling, No meat',			'')
	,(newid(), @restaurantId, 1, 'DUMPLING',	'72',	5, 12.00, 'Dumpling, Beef "Kalbi"',			'')
	,(newid(), @restaurantId, 1, 'DUMPLING',	'73',	5, 12.00, 'Dumpling, Pork "Pork Belly"',		'')
	,(newid(), @restaurantId, 1, 'DUMPLING',	'74',	5, 12.00, 'Dumpling, Chicken "Braise Thigh"','')
	,(newid(), @restaurantId, 1, 'DUMPLING',	'75',	5, 12.00, 'Dumpling, Tofu "Soy Protein"',	'')
	,(newid(), @restaurantId, 1, 'GCHEESE',		'81',	5,  8.95, 'Grilled Cheese, Beef "Kalbi"',			'')
	,(newid(), @restaurantId, 1, 'GCHEESE',		'82',	5,  8.95, 'Grilled Cheese, Pork "Pork Belly"',		'')
	,(newid(), @restaurantId, 1, 'GCHEESE',		'83',	5,  8.95, 'Grilled Cheese, Chicken "Braise Thigh"','')
	,(newid(), @restaurantId, 1, 'GCHEESE',		'84',	5,  8.95, 'Grilled Cheese, Tofu "Soy Protein"',	'')
	,(newid(), @restaurantId, 1, 'SALAD',		'91',	5,  8.00, 'Salad, Beef "Kalbi"',			'')
	,(newid(), @restaurantId, 1, 'SALAD',		'92',	5,  8.00, 'Salad, Pork "Pork Belly"',		'')
	,(newid(), @restaurantId, 1, 'SALAD',		'93',	5,  8.00, 'Salad, Chicken "Braise Thigh"','')
	,(newid(), @restaurantId, 1, 'SALAD',		'94',	5,  8.00, 'Salad, Tofu "Soy Protein"',	'')
	,(newid(), @restaurantId, 1, 'SIDE',		'X1',	5,  3.00, 'Side Order, Rice',	'')
	,(newid(), @restaurantId, 1, 'SIDE',		'X2',	5,  3.00, 'Side Order, Kimchi',	'')
	,(newid(), @restaurantId, 1, 'SIDE',		'X3',	5,  3.00, 'Side Order, Beans',	'')
	,(newid(), @restaurantId, 1, 'SIDE',		'X4',	5,  3.00, 'Side Order, Potato Salad',	'')
												 
update t set t.CategoryId = c.CategoryId		 
from Product t									 
join Category c on c.Code = t.CategoryCode and t.RestaurantId = @restaurantId
where t.RestaurantId = @restaurantId and c.RestaurantId = @restaurantId

-- Addon
INSERT INTO Addon 
	(AddonId, RestaurantId, CategoryCode, PrepareMinutes, IsModifer, Price, NameEn, NameVi) 
	VALUES
	 (newid(), @restaurantId, 'BEV'		, 5, 1, 0, 'Cup of ice',	'')
	,(newid(), @restaurantId, 'BEV'		, 5, 1, 0, 'Extra cup',	'')
	,(newid(), @restaurantId, 'TACO'	, 5, 1, 0, 'No cilantro',				'')
	,(newid(), @restaurantId, 'TACO'	, 5, 1, 0, 'No cheese',				'')
	,(newid(), @restaurantId, 'TACO'	, 5, 1, 0, 'No onion',			'')
	,(newid(), @restaurantId, 'TACO'	, 5, 1, 0, 'No rice',		'')
	,(newid(), @restaurantId, 'TACO'	, 5, 1, 0, 'No vegies',		'')
	,(newid(), @restaurantId, 'TACO'	, 5, 1, 0, 'Light cilantro',				'')
	,(newid(), @restaurantId, 'TACO'	, 5, 1, 0, 'Light cheese',				'')
	,(newid(), @restaurantId, 'TACO'	, 5, 1, 0, 'Light onion',			'')
	,(newid(), @restaurantId, 'TACO'	, 5, 1, 0, 'Light rice',		'')
	,(newid(), @restaurantId, 'TACO'	, 5, 1, 0, 'Light vegies',		'')
	,(newid(), @restaurantId, 'QUESA'	, 5, 1, 0, 'No cilantro',				'')
	,(newid(), @restaurantId, 'QUESA'	, 5, 1, 0, 'No cheese',				'')
	,(newid(), @restaurantId, 'QUESA'	, 5, 1, 0, 'No onion',			'')
	,(newid(), @restaurantId, 'QUESA'	, 5, 1, 0, 'No rice',		'')
	,(newid(), @restaurantId, 'QUESA'	, 5, 1, 0, 'No vegies',		'')
	,(newid(), @restaurantId, 'QUESA'	, 5, 1, 0, 'Light cilantro',				'')
	,(newid(), @restaurantId, 'QUESA'	, 5, 1, 0, 'Light cheese',				'')
	,(newid(), @restaurantId, 'QUESA'	, 5, 1, 0, 'Light onion',			'')
	,(newid(), @restaurantId, 'QUESA'	, 5, 1, 0, 'Light rice',		'')
	,(newid(), @restaurantId, 'QUESA'	, 5, 1, 0, 'Light vegies',		'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'No cilantro',				'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'No cheese',				'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'No onion',			'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'No rice',		'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'No vegies',		'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'Light cilantro',				'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'Light cheese',				'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'Light onion',			'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'Light rice',		'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'Light vegies',		'')
	,(newid(), @restaurantId, 'RBOW'	, 5, 1, 0, 'No cilantro',				'')
	,(newid(), @restaurantId, 'RBOW'	, 5, 1, 0, 'No cheese',				'')
	,(newid(), @restaurantId, 'RBOW'	, 5, 1, 0, 'No onion',			'')
	,(newid(), @restaurantId, 'RBOW'	, 5, 1, 0, 'No rice',		'')
	,(newid(), @restaurantId, 'RBOW'	, 5, 1, 0, 'No vegies',		'')
	,(newid(), @restaurantId, 'RBOW'	, 5, 1, 0, 'Light cilantro',				'')
	,(newid(), @restaurantId, 'RBOW'	, 5, 1, 0, 'Light cheese',				'')
	,(newid(), @restaurantId, 'RBOW'	, 5, 1, 0, 'Light onion',			'')
	,(newid(), @restaurantId, 'RBOW'	, 5, 1, 0, 'Light rice',		'')
	,(newid(), @restaurantId, 'RBOW'	, 5, 1, 0, 'Light vegies',		'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'No cilantro',				'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'No cheese',				'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'No onion',			'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'No rice',		'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'No vegies',		'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'Light cilantro',				'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'Light cheese',				'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'Light onion',			'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'Light rice',		'')
	,(newid(), @restaurantId, 'BURRITO'	, 5, 1, 0, 'Light vegies',		'')
	,(newid(), @restaurantId, 'DUMPLING', 5, 1, 0, 'Mild',				'')
	,(newid(), @restaurantId, 'DUMPLING', 5, 1, 0, 'Spicy',				'')
	,(newid(), @restaurantId, 'DUMPLING', 5, 1, 0, 'No onion',			'')
	,(newid(), @restaurantId, 'DUMPLING', 5, 1, 0, 'No avacado',		'')
	,(newid(), @restaurantId, 'DUMPLING', 5, 1, 0, 'Extra onion',		'')
	,(newid(), @restaurantId, 'DUMPLING', 5, 1, 0, 'Extra avacado',		'')
	,(newid(), @restaurantId, 'GCHEESE'	, 5, 1, 0, 'Mild',				'')
	,(newid(), @restaurantId, 'GCHEESE'	, 5, 1, 0, 'Spicy',				'')
	,(newid(), @restaurantId, 'GCHEESE'	, 5, 1, 0, 'No onion',			'')
	,(newid(), @restaurantId, 'GCHEESE'	, 5, 1, 0, 'No avacado',		'')
	,(newid(), @restaurantId, 'GCHEESE'	, 5, 1, 0, 'Extra onion',		'')
	,(newid(), @restaurantId, 'GCHEESE'	, 5, 1, 0, 'Extra avacado',		'')
	,(newid(), @restaurantId, 'SALAD'	, 5, 1, 0, 'Mild',				'')
	,(newid(), @restaurantId, 'SALAD'	, 5, 1, 0, 'Spicy',				'')
	,(newid(), @restaurantId, 'SALAD'	, 5, 1, 0, 'No onion',			'')
	,(newid(), @restaurantId, 'SALAD'	, 5, 1, 0, 'No avacado',		'')
	,(newid(), @restaurantId, 'SALAD'	, 5, 1, 0, 'Extra onion',		'')
	,(newid(), @restaurantId, 'SALAD'	, 5, 1, 0, 'Extra avacado',		'')

update t set t.CategoryId = c.CategoryId
from Addon t
join Category c on c.Code = t.CategoryCode and t.RestaurantId = @restaurantId
where t.RestaurantId = @restaurantId and c.RestaurantId = @restaurantId

-- create 2 more new price lists
EXEC	[dbo].[CreateNewPrice]
		@priceId = N'Delux',
		@restaurantId = @restaurantId,
		@productIncrement = 1,
		@addonIncrement = 0.5
EXEC	[dbo].[CreateNewPrice]
		@priceId = N'Business-Class',
		@restaurantId = @restaurantId,
		@productIncrement = 2,
		@addonIncrement = 1
EXEC	[dbo].[CreateNewPrice]
		@priceId = N'First-Class',
		@restaurantId = @restaurantId,
		@productIncrement = 3,
		@addonIncrement = 1.5
		
UPDATE [User]		SET IsActive = 1 WHERE IsActive IS NULL	
UPDATE [Table]		SET IsActive = 1 WHERE IsActive IS NULL		
UPDATE [Product]	SET IsActive = 1 WHERE IsActive IS NULL	
UPDATE [Addon]		SET IsActive = 1 WHERE IsActive IS NULL	
UPDATE [Category]	SET IsActive = 1 WHERE IsActive IS NULL

----------------------------------------
-- The Streets by Bistro Orient
----------------------------------------

SET @restaurantId = 103	
SET @restaurantCode = 'Streets'

EXEC DeleteRestaurantData @restaurantId
	
IF NOT EXISTS (SELECT 1 FROM [dbo].[Restaurant] WHERE RestaurantId=@restaurantId)
BEGIN
	INSERT INTO [dbo].[Restaurant] (RestaurantId) VALUES (@restaurantId)
END
UPDATE [dbo].[Restaurant] SET
	 NameEn						= 'The Streets by Bistro Orient'						
	,[Location]					= 'Thousand Oaks'					
	,[Code]						= @restaurantCode
    ,[Address1]					= '74 North Skyline Dr'				
    ,[Address2]					= ''					
    ,[City]						= 'Thousand Oaks'						
    ,[State]					= 'CA'							
    ,[Zip]						= '91362'							
    ,[Phone]					= '805 946-0800'
	-- [Hours]					= 'Lunch: 11:00-2:45 Monday-Friday, Dinner: 4:00-9:00 Monday-Thursday, 4:-00:930 Friday&Saturday, Closed Sundays'
    ,[TaxPercent]				= 8.35						
    ,[GroupPeople]				= 6						
    ,[GroupChargePercent]		= 18					
    ,[RecommendedTipPercent]	= 15				
    ,[CreditCardSurcharge]		= 0				
    ,[SlowOrderWarningMinutes]  = 15				
	,[RefreshIntervalSeconds]	= 20
	,[Language] = 'en'		
WHERE RestaurantId = @restaurantId				


-- User
INSERT INTO [User]
	 (UserId, RestaurantId, DefaultLanguage, [Login], NameEn) 
	 VALUES
	 (NEWID(), @restaurantId, 'en',	'Demo'				,  'Demo Account, all roles')
	,(NEWID(), @restaurantId, 'en',	'Waiter'			,  'Can take order')
	,(NEWID(), @restaurantId, 'en',	'Preparer'			,  'Prepare Food and Beverage')
	,(NEWID(), @restaurantId, 'en',	'Deliverer'			,  'Servicer, carry food/beverage to customer')
	,(NEWID(), @restaurantId, 'en',	'Cashier'			,  'Cashier')
	,(NEWID(), @restaurantId, 'en',	'Manager'			,  'Restaurant Manager')
	,(NEWID(), @restaurantId, 'en',	'Owner'				,  'Restaurant Owner')
	,(NEWID(), @restaurantId, 'en',	'Admin'				,  'Restaurant Admin')
	
update [User] set [Password]  = lower([Login]) + 'temp' where RestaurantId = @restaurantId
update [User] set [Login]  = [Login] + '@' + @restaurantCode where RestaurantId = @restaurantId
DELETE AspNetUsers where UserName in (select Login from dbo.[User] where RestaurantId=@restaurantId)

-- Table 
-- location X (grid of 12)
INSERT INTO [Table] 
	 (TableId, RestaurantId, IsForCustomer, Seats, LocationY, LocationX, NameEn, NameVi) VALUES
	 (newid(), @restaurantId, 1, 4,  2, 1, 'T.01',	N'B.01')
	,(newid(), @restaurantId, 1, 4,  2, 2, 'T.02',	N'B.02')
	,(newid(), @restaurantId, 1, 8,  2, 3, 'T.03',	N'B.03')
	,(newid(), @restaurantId, 1, 8,  3, 1, 'T.04',	N'B.04')
	,(newid(), @restaurantId, 1, 4,  3, 2, 'T.05',	N'B.05')
	,(newid(), @restaurantId, 1, 4,  3, 3, 'T.06',	N'B.06')
	,(newid(), @restaurantId, 1, 6,  3, 1, 'T.07',	N'B.07')
	,(newid(), @restaurantId, 1, 6,  4, 2, 'T.08',	N'B.08')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.09',	N'B.09')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.10',	N'B.10')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.11',	N'B.11')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.12',	N'B.12')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.13',	N'B.13')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.14',	N'B.14')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.15',	N'B.15')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.16',	N'B.16')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.17',	N'B.17')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.18',	N'B.18')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.19',	N'B.19')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.20',	N'B.20')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.21',	N'B.21')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.22',	N'B.22')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.23',	N'B.23')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.24',	N'B.24')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.25',	N'B.25')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.26',	N'B.26')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.27',	N'B.27')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.28',	N'B.28')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'T.29',	N'B.29')
	,(newid(), @restaurantId, 1, 2,  4, 3, 'Takeout',	N'Mang Đi')
	,(newid(), @restaurantId, 0, 0,  1, 1, 'Entrance',	N'Cửa ra vào')
	,(newid(), @restaurantId, 0, 0,  4, 1, 'Cashier',	N'Quầy tính tiền')
	,(newid(), @restaurantId, 0, 0,  4, 3, 'Kitchen',	N'Nhà bếp')


-- Category  (as in menu)
INSERT INTO Category
	 (CategoryId, RestaurantId, [Sequence], Code, NameEn, NameVi) 
	 VALUES																		
	 (newid(), @restaurantId, 1,  'BEV'			, 'Beverages',						N'')
	,(newid(), @restaurantId, 2,  'STARTER'		, 'Starters',						N'')
	,(newid(), @restaurantId, 3,  'SOUP'		, 'Soups',							N'')
	,(newid(), @restaurantId, 4,  'SALAD'		, 'Salad',							N'')
	,(newid(), @restaurantId, 5,  'FDICE'		, 'Fried Rice',						N'')
	,(newid(), @restaurantId, 6,  'ENTREE'		, 'Entrees',						N'')
	,(newid(), @restaurantId, 7,  'LUNCHSP'		, 'Lunch Specials',					N'')
	,(newid(), @restaurantId, 8,  'SPPADTHAI'	, 'Streets Specials Pad Thai',		N'')
	,(newid(), @restaurantId, 9,  'SPTHAIYAKI'	, 'Streets Specials Thai Yakisoba',	N'')
	,(newid(), @restaurantId, 10, 'SPYCURRY'	, 'Streets Specials Yellow Curry',	N'')
	,(newid(), @restaurantId, 11, 'SPRCURRY'	, 'Streets Specials Red Curry',		N'')
	,(newid(), @restaurantId, 12, 'SIDE'		, 'Sides',							N'')
	
INSERT INTO Product 
	 (ProductId, RestaurantId, IsPriceChangeable, IsAddonRequired, CategoryCode, [Sequence], PrepareMinutes, Price, Code, NameEn) 
	 VALUES
	 (newid(), @restaurantId, 0, 0, 'BEV'			, 10		, 5	,   0	, 'B01'	,'Ice Water')
	,(newid(), @restaurantId, 0, 1, 'BEV'			, 11		, 5	, 	2	, 'B02'	,'Coke')
	,(newid(), @restaurantId, 0, 1, 'BEV'			, 12		, 5	, 	2	, 'B03'	,'Diet Coke')
	,(newid(), @restaurantId, 0, 1, 'BEV'			, 13		, 5	, 	2	, 'B04'	,'Sprite')
	,(newid(), @restaurantId, 0, 1, 'BEV'			, 14		, 5	, 	2	, 'B05'	,'Hot Tea')
	,(newid(), @restaurantId, 0, 1, 'BEV'			, 15		, 5	, 	2	, 'B06'	,'Ice Tea')
	,(newid(), @restaurantId, 0, 1, 'BEV'			, 16		, 5	, 	2	, 'B07'	,'Hot Coffee')
	,(newid(), @restaurantId, 0, 1, 'STARTER'		, 30, 10	, 	4.5 , 'A00'	,'Fresh Spring Rolls (cut 4pc) - Pork Belly')
	,(newid(), @restaurantId, 0, 1, 'STARTER'		, 31, 10	, 	4.5 , 'A01'	,'Fresh Spring Rolls (cut 4pc) - Steamed Shrimp')
	,(newid(), @restaurantId, 0, 1, 'STARTER'		, 32, 10	, 	4.5 , 'A02'	,'Fresh Spring Rolls (cut 4pc) - Sugarcane Shrimp')
	,(newid(), @restaurantId, 0, 1, 'STARTER'		, 33, 10	, 	4.0 , 'A03'	,'Fresh Spring Rolls (cut 4pc) - Tofu')
	,(newid(), @restaurantId, 0, 0, 'STARTER'		, 34, 10	,	8.0	, 'A04'	,'Vegetarian Fried Imperial Egg Rolls (4 rolls)')
	,(newid(), @restaurantId, 0, 0, 'STARTER'		, 35, 10	,	8.0	, 'A05'	,'Chichen & Schrimp Fried Imperial Egg Rolls (4 rolls)')
	,(newid(), @restaurantId, 0, 0, 'STARTER'		, 36, 10	,	7.0	, 'A06'	,'Sriracha Hoeny Hosin Pork Belly w/ Steam Buns (2)')
	,(newid(), @restaurantId, 0, 0, 'STARTER'		, 37, 10	,	6.5	, 'A07'	,'Pan Fried Shrimp & Spinach Dumplings (4 pc)')
	,(newid(), @restaurantId, 0, 0, 'STARTER'		, 38, 10	,	5.5	, 'A08'	,'Pan Fried Chicken & Shiitake Dumplings (4 pc)')
	,(newid(), @restaurantId, 0, 0, 'STARTER'		, 39, 10	,	5.5	, 'A09'	,'Pan Fried Vegetarian Dumplings (4 pc)')
	,(newid(), @restaurantId, 0, 0, 'STARTER'		, 40, 10	,	4.5	, 'A10'	,'Steam Siu Mai Dumplings (4 pc)')
	,(newid(), @restaurantId, 0, 0, 'STARTER'		, 41, 10	,	8.0	, 'A11'	,'Sriracha Honey Hoisin Sea Bass w/ Steam Buns (2)')
	,(newid(), @restaurantId, 0, 0, 'STARTER'		, 42, 10	,	8.0	, 'A12'	,'Baked Green Mussels (6 pc)')
	,(newid(), @restaurantId, 0, 0, 'STARTER'		, 43, 10	,	10	, 'A13'	,'Casian (Cajun + Asian) Crispy Calamari')
	,(newid(), @restaurantId, 0, 0, 'STARTER'		, 44, 10	,	6.5 , 'A14'	,'Casian (Cajun + Asian) Hot Wings (5 pc)')
	,(newid(), @restaurantId, 0, 0, 'STARTER'		, 45, 10	,	6.5	, 'A15'	,'Siracha Honey Hoisin Hot Wings (5 pc)')
	,(newid(), @restaurantId, 0, 0, 'SOUP'			, 60, 10	,	8.5	, 'SOP-T'	,'Pho - Tofu')
	,(newid(), @restaurantId, 0, 0, 'SOUP'			, 61, 10	,	8.5	, 'SOP-RS'	,'Pho - Rare Steak')
	,(newid(), @restaurantId, 0, 0, 'SOUP'			, 62, 10	,	8.5	, 'SOP-BR'	,'Pho - Brisket')
	,(newid(), @restaurantId, 0, 0, 'SOUP'			, 63, 10	,	8.5	, 'SOP-TD'	,'Pho - Tendon')
	,(newid(), @restaurantId, 0, 0, 'SOUP'			, 64, 10	,	8.5	, 'SOP-TP'	,'Pho - Tripe')
	,(newid(), @restaurantId, 0, 0, 'SOUP'			, 65, 10	,	8.5	, 'SOP-MB'	,'Pho - Meatball')
	,(newid(), @restaurantId, 0, 0, 'SOUP'			, 66, 10	,	8.5	, 'SOP-CH'	,'Pho - Chicken')
	,(newid(), @restaurantId, 0, 1, 'SOUP'			, 67, 10	,	11	, 'SON-P'	,'Soba Noodle Soup - Pork Belly & Pickled Veggies')
	,(newid(), @restaurantId, 0, 1, 'SOUP'			, 68, 10	,	10	, 'SON-T'	,'Soba Noodle Soup - Tofu, Shiitake, Bok Choy & Asparagus')
	,(newid(), @restaurantId, 0, 1, 'SOUP'			, 69, 10	,	11	, 'SON-F'	,'Soba Noodle Soup - Garlic Sea Bass')
	,(newid(), @restaurantId, 0, 1, 'SOUP'			, 70, 10	,	11	, 'SON-S'	,'Soba Noodle Soup - Shrimp & Snowpeas')
	,(newid(), @restaurantId, 0, 0, 'SOUP'			, 71, 10	,	5	, 'SOW-C'	,'Streets Wonton Soup - Cup')
	,(newid(), @restaurantId, 0, 0, 'SOUP'			, 72, 10	,	9	, 'SOW-B'	,'Streets Wonton Soup - Bowl')
	,(newid(), @restaurantId, 0, 0, 'SOUP'			, 73, 10	,	13	, 'SOB-F'	,'Streets Bouilabaisse - Sea Bass')
	,(newid(), @restaurantId, 0, 0, 'SOUP'			, 74, 10	,	14	, 'SOB-S'	,'Streets Bouilabaisse - Jumbo Shrimp (6)')
	,(newid(), @restaurantId, 0, 0, 'SOUP'			, 75, 10	,	20	, 'SOB-KS'	,'Streets Bouilabaisse - Kitchen Sink')
	,(newid(), @restaurantId, 0, 0, 'SALAD'		, 80, 10	,	8.5	, 'SLB-GP'	,'Bun - Grilled Pork')
	,(newid(), @restaurantId, 0, 0, 'SALAD'		, 81, 10	,	8.5	, 'SLB-CH'	,'Bun - Grilled Chicken')
	,(newid(), @restaurantId, 0, 0, 'SALAD'		, 82, 10	,	8.5	, 'SLB-TF'	,'Bun - Grilled Tofu')
	,(newid(), @restaurantId, 0, 0, 'SALAD'		, 83, 10	,	11	, 'SLB-FM'	,'Bun - Filet Mignon')
	,(newid(), @restaurantId, 0, 0, 'SALAD'		, 84, 10	,	11	, 'SLB-SH'	,'Bun - Jumbo Shrimp (7)')
	,(newid(), @restaurantId, 0, 0, 'SALAD'		, 85, 10	,	11	, 'SLB-SB'	,'Bun - Sea Bass')
	,(newid(), @restaurantId, 0, 0, 'SALAD'		, 86, 10	,	5	, 'SLS-PS'	,'Papaya Salad, Plain, Small')
	,(newid(), @restaurantId, 0, 0, 'SALAD'		, 87, 10	,	9	, 'SLS-PL'	,'Papaya Salad, Plain, Large')
	,(newid(), @restaurantId, 0, 0, 'SALAD'		, 88, 10	,	6	, 'SLS-TS'	,'Papaya Salad, Sliced Tofu, Small')
	,(newid(), @restaurantId, 0, 0, 'SALAD'		, 89, 10	,	11	, 'SLS-TL'	,'Papaya Salad, Sliced Tofu, Large')
	,(newid(), @restaurantId, 0, 0, 'SALAD'		, 90, 10	,	6	, 'SLS-CS'	,'Papaya Salad, Shredded Chicken, Small')
	,(newid(), @restaurantId, 0, 0, 'SALAD'		, 91, 10	,	11	, 'SLS-CL'	,'Papaya Salad, Shredded Chicken, Large')
	,(newid(), @restaurantId, 0, 0, 'SALAD'		, 92, 10	,	7	, 'SLS-SS'	,'Papaya Salad, Steamed Shrimp, Small')
	,(newid(), @restaurantId, 0, 0, 'SALAD'		, 93, 10	,	13	, 'SLS-SL'	,'Papaya Salad, Steamed Shrimp, Large')
	,(newid(), @restaurantId, 0, 0, 'SALAD'		, 94, 10	,	15	, 'SLS-JS'	,'Papaya Salad, Grilled Jumbo Shrimp, Large')
	,(newid(), @restaurantId, 0, 0, 'SALAD'		, 95, 10	,	12	, 'SLS-C'	,'Streets Salad - Chicken')
	,(newid(), @restaurantId, 0, 0, 'SALAD'		, 96, 10	,	12	, 'SLS-T'	,'Streets Salad - Tofu')
	,(newid(), @restaurantId, 0, 0, 'SALAD'		, 97, 10	,	14	, 'SLS-F'	,'Streets Salad - Sea Bass')
	,(newid(), @restaurantId, 0, 0, 'SALAD'		, 98, 10	,	14	, 'SLS-B'	,'Streets Salad - Filet Mignon')
	,(newid(), @restaurantId, 0, 0, 'SALAD'		, 99, 10	,	14	, 'SLS-S'	,'Streets Salad - Jumbo Shrimp (7)')
	,(newid(), @restaurantId, 0, 0, 'FDICE'		, 100, 10	,	9	, 'FR-C'	,'Traditional Fried Rice - Chicken')
	,(newid(), @restaurantId, 0, 0, 'FDICE'		, 101, 10	,	9	, 'FR-T'	,'Traditional Fried Rice - Tofu')
	,(newid(), @restaurantId, 0, 0, 'FDICE'		, 102, 10	,	9	, 'FR-V'	,'Traditional Fried Rice - Vegies')
	,(newid(), @restaurantId, 0, 0, 'FDICE'		, 103, 10	,	12	, 'FR-F'	,'Traditional Fried Rice - Sea Bass')
	,(newid(), @restaurantId, 0, 0, 'FDICE'		, 104, 10	,	12	, 'FR-S'	,'Traditional Fried Rice - Shrimp')
	,(newid(), @restaurantId, 0, 0, 'FDICE'		, 105, 10	,	12	, 'FR-CS'	,'Hawaiian Fried Rice - Chicken & Shrimp')
	,(newid(), @restaurantId, 0, 0, 'FDICE'		, 106, 10	,	13	, 'FR-CM'	,'Crab Meat Fried Rice')
	,(newid(), @restaurantId, 0, 0, 'FDICE'		, 107, 10	,	14	, 'FR-SF'	,'Seafood Fried Rice')
	,(newid(), @restaurantId, 0, 0, 'ENTREE'		, 110	, 10	,	17	, 'E01-L'	, 'Grilled Lemongrass Lamb Chops - Large ( pc)')
	,(newid(), @restaurantId, 0, 0, 'ENTREE'		, 111	, 10	,	10	, 'E01-S'	, 'Grilled Lemongrass Lamb Chops - Small (2 pc)')
	,(newid(), @restaurantId, 0, 0, 'ENTREE'		, 112	, 10	,	9	, 'E02-S'	, 'Casian Baby Back Ribs - Small (4 pc)')
	,(newid(), @restaurantId, 0, 0, 'ENTREE'		, 113	, 10	,	15	, 'E02-L'	, 'Casian Baby Back Ribs - Large (7 pc)')
	,(newid(), @restaurantId, 0, 0, 'ENTREE'		, 114	, 10	,	9	, 'E03-S'	, 'Sriracha Honey Hoisin Baby Back Ribs - Small (4 pc)')
	,(newid(), @restaurantId, 0, 0, 'ENTREE'		, 115	, 10	,   15	, 'E03-L'	, 'Sriracha Honey Hoisin Baby Back Ribs - Large (7 pc)')
	,(newid(), @restaurantId, 0, 0, 'ENTREE'		, 116	, 10	,	9	, 'E04-S'	, 'Satay Peanut Baby Back Ribs - Small (4 pc)')
	,(newid(), @restaurantId, 0, 0, 'ENTREE'		, 117	, 10	,	15	, 'E04-L'	, 'Satay Peanut Baby Back Ribs - Large (7 pc)')
	,(newid(), @restaurantId, 0, 0, 'ENTREE'		, 118	, 10	,	11	, 'E05-L'	, 'Crispy Roasted Cornish Hen & Steamed Bok Choy')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 119	, 10	,	13	, 'E06-CH'	, 'Wok Shaken House Garlic - Chicken')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 120	, 10	,	13	, 'E06-TF'	, 'Wok Shaken House Garlic - Tofu')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 121	, 10	,	16	, 'E06-SB'	, 'Wok Shaken House Garlic - Sea Bass')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 122	, 10	,	16	, 'E06-FM'	, 'Wok Shaken House Garlic - Filet Mignon')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 123	, 10	,	19	, 'E06-SS'	, 'Wok Shaken House Garlic - Sea Scallops (4)')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 124	, 10	,	17	, 'E06-JS'	, 'Wok Shaken House Garlic - Jumbo Shrimp (8)')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 125	, 10	,	13	, 'E07-CH'	, 'Wok Seared Garlic Green Beans & Onion - Chicken')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 126	, 10	,	13	, 'E07-TF'	, 'Wok Seared Garlic Green Beans & Onion - Tofu')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 127	, 10	,	16	, 'E07-SB'	, 'Wok Seared Garlic Green Beans & Onion - Sea Bass')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 128	, 10	,	16	, 'E07-FM'	, 'Wok Seared Garlic Green Beans & Onion - Filet Mignon')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 129	, 10	,	17	, 'E07-JS'	, 'Wok Seared Garlic Green Beans & Onion - Jumbo Shrimp (8)')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 130	, 10	,	14	, 'E07-PB'	, 'Wok Seared Garlic Green Beans & Onion - Pork Belly')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 131	, 10	,	13	, 'E08-CH'	, 'Tumeric Lemongrass Glazed - Chicken')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 132	, 10	,	13	, 'E08-TF'	, 'Tumeric Lemongrass Glazed - Tofu')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 133	, 10	,	16	, 'E08-SB'	, 'Tumeric Lemongrass Glazed - Sea Bass')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 134	, 10	,	16	, 'E08-FM'	, 'Tumeric Lemongrass Glazed - Filet Mignon')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 135	, 10	,	17	, 'E08-JS'	, 'Tumeric Lemongrass Glazed - Jumbo Shrimp (8)')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 136	, 10	,	14	, 'E08-PB'	, 'Tumeric Lemongrass Glazed - Pork Belly')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 137	, 10	,	13	, 'E09-CH'	, 'Tamarind Basil - Chicken')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 138	, 10	,	13	, 'E09-TF'	, 'Tamarind Basil - Tofu')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 139	, 10	,	16	, 'E09-SB'	, 'Tamarind Basil - Sea Bass')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 140	, 10	,	19	, 'E09-SS'	, 'Tamarind Basil - Sea Scallops (4)')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 141	, 10	,	17	, 'E09-JS'	, 'Tamarind Basil - Jumbo Shrimp (8)')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 142	, 10	,	13	, 'E10-CH'	, 'Ginger Garlic Glazed - Chicken')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 143	, 10	,	13	, 'E10-TF'	, 'Ginger Garlic Glazed - Tofu')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 144	, 10	,	16	, 'E10-SB'	, 'Ginger Garlic Glazed - Sea Bass')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 145	, 10	,	19	, 'E10-SS'	, 'Ginger Garlic Glazed - Sea Scallops (4)')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 146	, 10	,	17	, 'E10-JS'	, 'Ginger Garlic Glazed - Jumbo Shrimp (8)')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 147	, 10	,	13	, 'E11-CH'	, 'Compound Butter - Chicken')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 148	, 10	,	13	, 'E11-TF'	, 'Compound Butter - Tofu')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 149	, 10	,	16	, 'E11-SB'	, 'Compound Butter - Sea Bass')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 150	, 10	,	19	, 'E11-SS'	, 'Compound Butter - Sea Scallops (4)')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 151	, 10	,	17	, 'E11-JS'	, 'Compound Butter - Jumbo Shrimp (8)')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 152	, 10	,	13	, 'E12-CH'	, 'Spicy Lemongrass - Chicken')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 153	, 10	,	13	, 'E12-TF'	, 'Spicy Lemongrass - Tofu')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 154	, 10	,	16	, 'E12-SB'	, 'Spicy Lemongrass - Sea Bass')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 155	, 10	,	16	, 'E12-FM'	, 'Spicy Lemongrass - Filet Mignon')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 156	, 10	,	19	, 'E12-SS'	, 'Spicy Lemongrass - Sea Scallops (4)')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 157	, 10	,	17	, 'E12-JS'	, 'Spicy Lemongrass - Jumbo Shrimp (8)')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 158	, 10	,	14	, 'E12-PB'	, 'Spicy Lemongrass - Pork Belly')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 159	, 10	,	13	, 'ES-CH'	, 'Garlic Soba - Chicken')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 160	, 10	,	13	, 'ES-TF'	, 'Garlic Soba - Tofu')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 161	, 10	,	16	, 'ES-SB'	, 'Garlic Soba - Sea Bass')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 162	, 10	,	19	, 'ES-SS'	, 'Garlic Soba - Sea Scallops (4)')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 163	, 10	,	17	, 'ES-JS'	, 'Garlic Soba - Jumbo Shrimp (8)')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 164	, 10	,	13	, 'ECS-CH'	, 'Cream Garlic Soba - Chicken')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 165	, 10	,	13	, 'ECS-TF'	, 'Cream Garlic Soba - Tofu')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 166	, 10	,	16	, 'ECS-SB'	, 'Cream Garlic Soba - Sea Bass')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 167	, 10	,	19	, 'ECS-SS'	, 'Cream Garlic Soba - Sea Scallops (4)')
	,(newid(), @restaurantId, 0, 1, 'ENTREE'		, 168	, 10	,	17	, 'ECS-JS'	, 'Cream Garlic Soba - Jumbo Shrimp (8)')
	,(newid(), @restaurantId, 0, 0, 'LUNCHSP'		, 170, 10	,	9	, 'L01'	, 'Grilled Lemongrass Chicken Breast Slices')
	,(newid(), @restaurantId, 0, 0, 'LUNCHSP'		, 171, 10	,	9	, 'L02'	, 'Grilled Lemongrass Port Loin Slices')
	,(newid(), @restaurantId, 0, 0, 'LUNCHSP'		, 172, 10	,	9	, 'L03'	, 'Half Crispy 5-spice Cornish Hen')
	,(newid(), @restaurantId, 0, 0, 'LUNCHSP'		, 173, 10	,	9	, 'L04'	, 'Sriracha Honey Hoisin Wings (6 pc)')
	,(newid(), @restaurantId, 0, 0, 'LUNCHSP'		, 174, 10	,	9	, 'L05'	, 'Casian Wings (6 pc)')
	,(newid(), @restaurantId, 0, 0, 'LUNCHSP'		, 175, 10	,	10	, 'L06'	, 'Shaken Chicken Breast')
	,(newid(), @restaurantId, 0, 0, 'LUNCHSP'		, 176, 10	,	9	, 'L07'	, 'Garlic & Ginger Mixed Vegetables')
	,(newid(), @restaurantId, 0, 0, 'LUNCHSP'		, 177, 10	,	10	, 'L08'	, 'Sriracha Honey Hoisin Baby Back Ribs (4 pc)')
	,(newid(), @restaurantId, 0, 0, 'LUNCHSP'		, 178, 10	,	10	, 'L09'	, 'Casian Baby Back Ribs (4 pc)')
	,(newid(), @restaurantId, 0, 0, 'LUNCHSP'		, 179, 10	,	12	, 'L10'	, 'Shaken Sea Bass')
	,(newid(), @restaurantId, 0, 0, 'LUNCHSP'		, 170, 10	,	12	, 'L11'	, 'Shaken Filet')
	,(newid(), @restaurantId, 0, 0, 'SPPADTHAI'	, 180, 10	,	10	, 'SPP-T'	, 'Pad Thai - Tofu')
	,(newid(), @restaurantId, 0, 0, 'SPPADTHAI'	, 181, 10	,	10	, 'SPP-C'	, 'Pad Thai - Chicken')
	,(newid(), @restaurantId, 0, 0, 'SPPADTHAI'	, 182, 10	,	11	, 'SPP-P'	, 'Pad Thai - Pork Belly')
	,(newid(), @restaurantId, 0, 0, 'SPPADTHAI'	, 183, 10	,	13	, 'SPP-F'	, 'Pad Thai - Sea Bass')
	,(newid(), @restaurantId, 0, 0, 'SPPADTHAI'	, 184, 10	,	14	, 'SPP-S'	, 'Pad Thai - Jumbo Shrimp')
	,(newid(), @restaurantId, 0, 0, 'SPTHAIYAKI'	, 190, 10	,	10	, 'SPT-T'	, 'Thai Yakisoba - Tofu')
	,(newid(), @restaurantId, 0, 0, 'SPTHAIYAKI'	, 191, 10	,	10	, 'SPT-C'	, 'Thai Yakisoba - Chicken')
	,(newid(), @restaurantId, 0, 0, 'SPTHAIYAKI'	, 192, 10	,	11	, 'SPT-P'	, 'Thai Yakisoba - Pork Belly')
	,(newid(), @restaurantId, 0, 0, 'SPTHAIYAKI'	, 193, 10	,	13	, 'SPT-F'	, 'Thai Yakisoba - Sea Bass')
	,(newid(), @restaurantId, 0, 0, 'SPTHAIYAKI'	, 194, 10	,	14	, 'SPT-S'	, 'Thai Yakisoba - Jumbo Shrimp')
	,(newid(), @restaurantId, 0, 0, 'SPYCURRY'		, 200, 10	,	10	, 'SPY-T'	, 'Yellow Curry - Tofu')
	,(newid(), @restaurantId, 0, 0, 'SPYCURRY'		, 201, 10	,	10	, 'SPY-C'	, 'Yellow Curry - Chicken')
	,(newid(), @restaurantId, 0, 0, 'SPYCURRY'		, 202, 10	,	11	, 'SPY-P'	, 'Yellow Curry - Pork Belly')
	,(newid(), @restaurantId, 0, 0, 'SPYCURRY'		, 203, 10	,	13	, 'SPY-F'	, 'Yellow Curry - Sea Bass')
	,(newid(), @restaurantId, 0, 0, 'SPYCURRY'		, 204, 10	,	14	, 'SPY-S'	, 'Yellow Curry - Jumbo Shrimp')
	,(newid(), @restaurantId, 0, 0, 'SPYCURRY'		, 205, 10	,	18	, 'SPY-SC'	, 'Yellow Curry - Sea Scallop')
	,(newid(), @restaurantId, 0, 0, 'SPRCURRY'		, 210, 10	,	10	, 'SBR-T'	, 'Red Curry - Tofu')
	,(newid(), @restaurantId, 0, 0, 'SPRCURRY'		, 211, 10	,	10	, 'SBR-C'	, 'Red Curry - Chicken')
	,(newid(), @restaurantId, 0, 0, 'SPRCURRY'		, 212, 10	,	11	, 'SBR-P'	, 'Red Curry - Pork Belly')
	,(newid(), @restaurantId, 0, 0, 'SPRCURRY'		, 213, 10	,	13	, 'SBR-F'	, 'Red Curry - Sea Bass')
	,(newid(), @restaurantId, 0, 0, 'SPRCURRY'		, 214, 10	,	14	, 'SBR-S'	, 'Red Curry - Jumbo Shrimp')
	,(newid(), @restaurantId, 0, 0, 'SPRCURRY'		, 215, 10	,	18	, 'SBR-SC'	, 'Red Curry - Sea Scallop')
	,(newid(), @restaurantId, 0, 0, 'SIDE'			, 220, 10	,	2	, 'S01'	, 'Jasmine Rice')
	,(newid(), @restaurantId, 0, 0, 'SIDE'			, 221, 10	,	2	, 'S02'	, 'Brown Rice')
	,(newid(), @restaurantId, 0, 0, 'SIDE'			, 222, 10	,	5	, 'S03'	, 'Garlic Green Beans')
	,(newid(), @restaurantId, 0, 0, 'SIDE'			, 223, 10	,	3	, 'S04'	, 'Side Salad')
	,(newid(), @restaurantId, 0, 0, 'SIDE'			, 224, 10	,	5	, 'S05'	, 'Steamed Assorted Vegetables')
	,(newid(), @restaurantId, 1, 0, 'SIDE'			, 224, 10	,	1	, 'S10'	, 'Special Order #1')
	,(newid(), @restaurantId, 1, 0, 'SIDE'			, 224, 10	,	5	, 'S11'	, 'Special Order #2')
	,(newid(), @restaurantId, 1, 0, 'SIDE'			, 224, 10	,	10	, 'S12'	, 'Special Order #3')

update t set t.CategoryId = c.CategoryId
from Product t
join Category c on c.Code = t.CategoryCode and t.RestaurantId = @restaurantId
where t.RestaurantId = @restaurantId and c.RestaurantId = @restaurantId


-- Addon Table
INSERT INTO Addon
	 (AddonId, RestaurantId, CategoryCode, PrepareMinutes, IsModifer, IsPriceChangeable, Price, NameEn) 
	 VALUES
	 (newid(), @restaurantId, 'BEV', 5	, 1, 0, 0		, 'No ice' 						)
	,(newid(), @restaurantId, 'BEV', 5	, 1, 0, 0		, 'Little ice' 					)
	,(newid(), @restaurantId, 'BEV', 5	, 1, 0, 0		, 'No sugar' 					)
	,(newid(), @restaurantId, 'BEV', 5	, 1, 0, 0		, 'Less sugar' 					)
	,(newid(), @restaurantId, 'BEV', 5	, 1, 0, 0		, 'Extra sugar' 				)
	
	,(newid(), @restaurantId, 'SOUP', 5	, 1, 0, 1		,'Add Extra Meat (2 oz) for Pho')
	,(newid(), @restaurantId, 'SOUP', 5	, 1, 0, 1		,'Add Extra Noodle for Pho'		)
	,(newid(), @restaurantId, 'SOUP', 5	, 1, 0, 1.5	,	'Add Assorted Veggies for Pho'	)
	,(newid(), @restaurantId, 'SOUP', 5	, 1, 0, 3		,'Add Shrimp (3) for Pho'		)
	,(newid(), @restaurantId, 'SOUP', 5	, 1, 0, 3		,'No green onion'				)
	,(newid(), @restaurantId, 'SOUP', 5	, 1, 0, 3		,'No sliced onion'				)
	,(newid(), @restaurantId, 'SOUP', 5	, 1, 1, 3		,'Special Order'				)

update t set t.CategoryId = c.CategoryId
from Addon t
join Category c on c.Code = t.CategoryCode and t.RestaurantId = @restaurantId
where t.RestaurantId = @restaurantId and c.RestaurantId = @restaurantId

UPDATE [User]		SET IsActive = 1 WHERE IsActive IS NULL	
UPDATE [Table]		SET IsActive = 1 WHERE IsActive IS NULL		
UPDATE [Product]	SET IsActive = 1 WHERE IsActive IS NULL	
UPDATE [Addon]		SET IsActive = 1 WHERE IsActive IS NULL	
UPDATE [Category]	SET IsActive = 1 WHERE IsActive IS NULL


END





GO
/****** Object:  StoredProcedure [dbo].[SetupSystemTables]    Script Date: 2/7/2017 4:46:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SetupSystemTables]
AS
BEGIN

EXEC DeleteAllData

-- define "Roles" in AspNetRoles
-- [Name] will be used as constant in the system
INSERT INTO [dbo].[AspNetRoles]
([Id],[Name]) 
VALUES
	 (NEWID(), 'OrderTaker')				
	,(NEWID(), 'Preparer')					
	,(NEWID(), 'Deliverer')					
	,(NEWID(), 'Cashier')					
	,(NEWID(), 'Manager')					
	,(NEWID(), 'Owner')						
	,(NEWID(), 'ClientAdmin')				
	,(NEWID(), 'SystemSalesPerson')			
	,(NEWID(), 'SystemTechnician')
	,(NEWID(), 'SystemAdmin')

-- system tables

INSERT INTO [Language]
	(LanguageId, [Name], NameNative)
	VALUES
	 ('en', 'English',		N'English')
	,('vi', 'Vietnamese',	N'Tiếng Việt')
	,('ko', 'Korean',		N'Korean')
	,('es', 'Spanish',		N'Espanõl')
	,('zh', 'Chinese',		N'Chinese')

-- module restaurant can purchase
INSERT INTO [Module]
	(ModuleId, [Name], Description) 
	VALUES
	 ( 1, 'Vietnamese', 'Support Vietnamese Language')
	,( 2, 'Korean', 'Support Korean Language')
	,( 3, 'Spanish', 'Support Spanish Language')
	,( 4, 'Chinese', 'Support Chinese Language')
	,( 11, 'Self Order', 'Customer can self-order at table')
	,( 12, 'Internet Order', 'Customer can order from internet')
	,( 13, 'Business Intelligent', 'Reports, charts and analysises')
	,( 21, 'Credit Card Processing, Cashier', 'Process credit card at cashier')
	,( 22, 'Credit Card Processing, Customer and Cashier', 'Process credit card at table or cashier')
	,( 23, 'Credit Card Processing Online', 'Customer can pay from internet')
	,( 24, 'Cash Register Connection', 'Connect "system to cash register')


INSERT INTO [TableShape]
	(TableShapeId, [Code], [NameEn], [NameVi], [Class]) 
	VALUES
	 (1, 'round'	,'Round',			'Tròn'		,'tbl-shape-round')
	,(2, 'square'	,'Square',			'Vuông'		,'tbl-shape-square')
	,(3, 'tall'		,'Tall',			'Cao'		,'tbl-shape-tall')
	,(4, 'wide'		,'Wide',			'Dài'		,'tbl-shape-wide')
	,(5, 'xtall'	,'Extra Tall',		'Thật cao'	,'tbl-shape-xtall')
	,(6, 'xwide'	,'Extra Wide',		'Thật dài'	,'tbl-shape-xwide')


	
---- Status
-- shared status used by various table
-- consecutive numbers are not used so we can insert in between later if required
INSERT INTO [Status]
	 (StatusId, [Sequence], ApplyTo, NameEn, NameVi, DescriptionEn, DescriptionVi) 
	 VALUES
	 (110, 10,	'TABLE'	,'Available',			N'Bàn Trống'	,'Available'				,N'Bàn trống'	)
	,(120, 20,	'TABLE'	,'Occupied',			N'Có Khách'		,'Occupied'					,N'Có khách'	)
						
    ,(210, 10,	'ORDER'	,'Pre-order',			N'Order Trước'  ,'Not yet send to kitchen'	,N'Order chưa gởi cho bếp'  )
	,(220, 20,	'ORDER'	,'Send to Kitchen',		N'Gởi Bếp'		,'Waiting to process'		,N'Đợi làm' )
	,(230, 30,	'ORDER'	,'Start Processing',	N'Bắt Đầu Làm'	,'In process'				,N'Đang làm'		)
	,(240, 40,	'ORDER'	,'Finish Processing',	N'Làm Xong'		,'Ready to deliver'			,N'Đợi mang ra bàn'		)
	,(250, 50,	'ORDER'	,'Deliver',				N'Mang Ra Bàn '	,'Delivered'				,N'Đã mang ra bàn'	)
	,(253, 53,	'ORDER'	,'Request Check',		N'Xin Bill'		,'Check Requested'			,N'Đợi thanh toán'	)	
    --,(256, 56,	'ORDER'	,'Check Out',		    N'Check out'	,'Checked Out'				,N'Checked out'		)		-- not used
    --,(260, 60,	'ORDER'	,'Request to Cancel',	N'Xin Bỏ'		,'Cancel requested'			,N'Xin bỏ'		)			-- not used
	,(270, 70,	'ORDER'	,'Cancel',				N'Hủy Bỏ'		,'Cancelled'				,N'Đã Hủy bỏ'	)
    ,(280, 80,	'ORDER'	,'Pay',					N'Trả tiền'		,'Paid'						,N'Đã thanh toán' )
						
	,(410, 10,	'ITEM'	,'Pre-order',			N'Order Trước'  ,'Not yet send to kitchen'	,N'Order chưa gởi cho bếp'  )
	,(420, 20,	'ITEM'	,'Send to Kitchen',		N'Gởi Bếp'		,'Waiting to process'		,N'Đã gởi bếp' )
	,(430, 30,	'ITEM'	,'Start Processing',	N'Bắt Đầu Làm'	,'In process'				,N'Đang làm'		)
	,(440, 40,	'ITEM'	,'Finish Processing',	N'Làm Xong'		,'Ready to deliver'			,N'Đợi mang ra bàn'		)
	,(450, 50,	'ITEM'	,'Deliver',				N'Mang Ra Bàn'	,'Delivered'				,N'Đã mang ra bàn'	)
	--,(460, 60,	'ITEM'	,'Check Out',		    N'Check out'	,'Checked Out'				,N'Checked out'		)
	--,(470, 70,	'ITEM'	,'Request to Cancel',	N'Xin Bỏ'		,'Cancel requested'			,N'Xin bỏ'		)			
	,(470, 90,	'ITEM'	,'Cancel',				N'Hủy Bỏ'		,'Cancelled'				,N'Đã Hủy bỏ'	)	
	,(490, 90,	'ITEM'	,'Dispose',				N'Đổ Bỏ'		,'Disposed'					,N'Đã đổ bỏ'	)	


-- ***************************************************************************************************
-- page access control, not used for now
-- related tables:
--		Page:		all pages in the system
--		Role:		user rol, use to quickly assign user access to pages
--		RolePage:	what pages a certain role can access
--		UserPage:	actual table use for access control, contain which pages a user can access
-- ***************************************************************************************************
/*
-- all pages in the system
INSERT INTO [Page]
	-- code will be correspondent to ui-route's state
	(PageId, Code, DescriptionEn, DescriptionVi) 
	VALUES
	 (newid(), 'sys_exec_script'			,'Execute SQL Scripts'			,'')		
	,(newid(), 'sys_client_management'		,'Client Management'			,'')
	,(newid(), 'admin_category'				,'Category Management'			,'')
	,(newid(), 'admin_product'				,'Product Management'			,'')
	,(newid(), 'admin_adon'					,'Addon Management'				,'')
	,(newid(), 'admin_table'				,'Table Management'				,'')
	,(newid(), 'admin_restaurant'			,'Restaurant Management'		,'')
	,(newid(), 'admin_account'				,'User Account Management'		,'')
	,(newid(), 'emp_report_1'				,'Report 1'						,'')
	,(newid(), 'emp_report_2'				,'Report 2'						,'')
	,(newid(), 'emp_order_create'			,'Create Order'			,'')
	,(newid(), 'emp_order_update'			,'Update Order'			,'')
	,(newid(), 'emp_order_view'				,'View Order'			,'')
	,(newid(), 'customer_order_create'		,'Create Order'			,'')
	,(newid(), 'customer_order_view'		,'Create Order'			,'')
UPDATE Page SET DescriptionVi = DescriptionEn

INSERT INTO [Role]
	(RoleId, Code, NameEn, NameVi, DescriptionEn, DescriptionVi) 
	VALUES
	-- system
	 (newid(), 'SAMIN'	,  'System Admin',		N'God User',		'Can do anything',									N'Làm gì cũng được'								)
	,(newid(), 'STECH'	,  'System Technician',	N'Chuyên viên KT',	'Can delete, set up client info',					N'Xóa, chỉnh dữ kiện khách hàng'				)
	,(newid(), 'SACM'	,  'System Account Manager',	N'QL Khách hàng',	'Can setup new client info',						N'Tạo khách hàng mới'							)
						
	-- client					
	,(newid(), 'COWN'	, 'Owner',				N'Chủ',				'All non-tech features',							N'Làm gì cũng được, không kỹ thuật'				)
	,(newid(), 'CSMAN'	, 'Senior Manager',		N'Quản lý cao cấp',	'Sensitive reports, manage account',				N'Coi báo cáo nhạy cảm quản lý account'			)
	,(newid(), 'CMAN'	, 'Manager',			N'Quản lý',			'Non sensitive reports, manage account, discount',	N'Coi báo cáo không nhạy cảm, quản lý account'	)
	,(newid(), 'CTECH'	, 'Technician',			N'Chuyên viên KT',	'Can delete, set up client info',					N'Xóa, chỉnh dữ kiện khách hàng'				)
	,(newid(), 'CEMP'	, 'Employee',			N'Nhân viên',		'Change, reate, sumbit order',						N'Sửa, hủy bỏ order'							)
	,(newid(), 'CTEMP'	, 'Trainee',			N'NV tập sự',		'Create, sumbit order',								N'Tạo và gởi order'								)
	
	--customer					
	,(newid(), 'GSEAT'	, 'Seated Customer',	N'Khách tiệm',		 'In store, seated customer',						N'Gởi, sửa thêm order tới bếp'					)
	,(newid(), 'GREG'	, 'Registered User',	N'Khách có account', 'Registered internet guess',						N'Gởi order thẳng tới bếp'						)
	,(newid(), 'GGUEST'	, 'Guess User',			N'Khách vãng lai',	 'Un-registered internet guess',					N'Gởi order tới tiệm để xác nhận'				)

INSERT INTO RolePage
	(RolePageId, RoleId, PageId) 
	VALUES
	 (newid(), (SELECT RoleId FROM [Role] WHERE Code='SAMIN'	), (SELECT PageId FROM [Page] WHERE Code='sys_exec_script'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='SAMIN'	), (SELECT PageId FROM [Page] WHERE Code='sys_client_management'	)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='SAMIN'	), (SELECT PageId FROM [Page] WHERE Code='admin_category'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='SAMIN'	), (SELECT PageId FROM [Page] WHERE Code='admin_product'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='SAMIN'	), (SELECT PageId FROM [Page] WHERE Code='admin_adon'				)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='SAMIN'	), (SELECT PageId FROM [Page] WHERE Code='admin_table'				)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='SAMIN'	), (SELECT PageId FROM [Page] WHERE Code='admin_restaurant'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='SAMIN'	), (SELECT PageId FROM [Page] WHERE Code='admin_account'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='SAMIN'	), (SELECT PageId FROM [Page] WHERE Code='emp_report_1'				)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='SAMIN'	), (SELECT PageId FROM [Page] WHERE Code='emp_report_2'				)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='SAMIN'	), (SELECT PageId FROM [Page] WHERE Code='emp_order_create'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='SAMIN'	), (SELECT PageId FROM [Page] WHERE Code='emp_order_update'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='SAMIN'	), (SELECT PageId FROM [Page] WHERE Code='emp_order_view'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='SAMIN'	), (SELECT PageId FROM [Page] WHERE Code='customer_order_create'	)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='SAMIN'	), (SELECT PageId FROM [Page] WHERE Code='customer_order_view'		)) 
	  
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='STECH'	), (SELECT PageId FROM [Page] WHERE Code='admin_category'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='STECH'	), (SELECT PageId FROM [Page] WHERE Code='admin_product'				)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='STECH'	), (SELECT PageId FROM [Page] WHERE Code='admin_adon'				)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='STECH'	), (SELECT PageId FROM [Page] WHERE Code='admin_table'				)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='STECH'	), (SELECT PageId FROM [Page] WHERE Code='admin_restaurant'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='STECH'	), (SELECT PageId FROM [Page] WHERE Code='admin_account'				)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='STECH'	), (SELECT PageId FROM [Page] WHERE Code='emp_report_1'				)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='STECH'	), (SELECT PageId FROM [Page] WHERE Code='emp_report_2'				)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='STECH'	), (SELECT PageId FROM [Page] WHERE Code='emp_order_create'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='STECH'	), (SELECT PageId FROM [Page] WHERE Code='emp_order_update'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='STECH'	), (SELECT PageId FROM [Page] WHERE Code='emp_order_view'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='STECH'	), (SELECT PageId FROM [Page] WHERE Code='customer_order_create'		)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='STECH'	), (SELECT PageId FROM [Page] WHERE Code='customer_order_view'		)) 
	  
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='SACM'	), (SELECT PageId FROM [Page] WHERE Code='admin_category'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='SACM'	), (SELECT PageId FROM [Page] WHERE Code='admin_product'				)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='SACM'	), (SELECT PageId FROM [Page] WHERE Code='admin_adon'				)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='SACM'	), (SELECT PageId FROM [Page] WHERE Code='admin_table'				)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='SACM'	), (SELECT PageId FROM [Page] WHERE Code='admin_restaurant'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='SACM'	), (SELECT PageId FROM [Page] WHERE Code='admin_account'				)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='SACM'	), (SELECT PageId FROM [Page] WHERE Code='emp_report_1'				)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='SACM'	), (SELECT PageId FROM [Page] WHERE Code='emp_report_2'				)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='SACM'	), (SELECT PageId FROM [Page] WHERE Code='emp_order_create'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='SACM'	), (SELECT PageId FROM [Page] WHERE Code='emp_order_update'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='SACM'	), (SELECT PageId FROM [Page] WHERE Code='emp_order_view'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='SACM'	), (SELECT PageId FROM [Page] WHERE Code='customer_order_create'		)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='SACM'	), (SELECT PageId FROM [Page] WHERE Code='customer_order_view'		)) 
	  
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='COWN'	), (SELECT PageId FROM [Page] WHERE Code='admin_category'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='COWN'	), (SELECT PageId FROM [Page] WHERE Code='admin_product'				)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='COWN'	), (SELECT PageId FROM [Page] WHERE Code='admin_adon'				)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='COWN'	), (SELECT PageId FROM [Page] WHERE Code='admin_table'				)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='COWN'	), (SELECT PageId FROM [Page] WHERE Code='admin_restaurant'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='COWN'	), (SELECT PageId FROM [Page] WHERE Code='admin_account'				)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='COWN'	), (SELECT PageId FROM [Page] WHERE Code='emp_report_1'				)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='COWN'	), (SELECT PageId FROM [Page] WHERE Code='emp_report_2'				)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='COWN'	), (SELECT PageId FROM [Page] WHERE Code='emp_order_create'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='COWN'	), (SELECT PageId FROM [Page] WHERE Code='emp_order_update'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='COWN'	), (SELECT PageId FROM [Page] WHERE Code='emp_order_view'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='COWN'	), (SELECT PageId FROM [Page] WHERE Code='emp_order_update'		)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='COWN'	), (SELECT PageId FROM [Page] WHERE Code='customer_order_view'			)) 
	  
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CSMAN'	), (SELECT PageId FROM [Page] WHERE Code='admin_category'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CSMAN'	), (SELECT PageId FROM [Page] WHERE Code='admin_product'				)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CSMAN'	), (SELECT PageId FROM [Page] WHERE Code='admin_adon'				)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CSMAN'	), (SELECT PageId FROM [Page] WHERE Code='admin_table'				)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CSMAN'	), (SELECT PageId FROM [Page] WHERE Code='admin_restaurant'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CSMAN'	), (SELECT PageId FROM [Page] WHERE Code='admin_account'				)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CSMAN'	), (SELECT PageId FROM [Page] WHERE Code='emp_report_1'				)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CSMAN'	), (SELECT PageId FROM [Page] WHERE Code='emp_report_2'				)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CSMAN'	), (SELECT PageId FROM [Page] WHERE Code='emp_order_create'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CSMAN'	), (SELECT PageId FROM [Page] WHERE Code='emp_order_update'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CSMAN'	), (SELECT PageId FROM [Page] WHERE Code='emp_order_view'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CSMAN'	), (SELECT PageId FROM [Page] WHERE Code='customer_order_create'		)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CSMAN'	), (SELECT PageId FROM [Page] WHERE Code='customer_order_view'		)) 
	  
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CMAN'	), (SELECT PageId FROM [Page] WHERE Code='admin_account'				)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CMAN'	), (SELECT PageId FROM [Page] WHERE Code='emp_report_1'				)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CMAN'	), (SELECT PageId FROM [Page] WHERE Code='emp_report_2'				)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CMAN'	), (SELECT PageId FROM [Page] WHERE Code='emp_order_create'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CMAN'	), (SELECT PageId FROM [Page] WHERE Code='emp_order_update'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CMAN'	), (SELECT PageId FROM [Page] WHERE Code='emp_order_view'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CMAN'	), (SELECT PageId FROM [Page] WHERE Code='customer_order_create'		)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CMAN'	), (SELECT PageId FROM [Page] WHERE Code='customer_order_view'		)) 
	  
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CTECH'	), (SELECT PageId FROM [Page] WHERE Code='admin_category'		)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CTECH'	), (SELECT PageId FROM [Page] WHERE Code='admin_product'		)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CTECH'	), (SELECT PageId FROM [Page] WHERE Code='admin_adon'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CTECH'	), (SELECT PageId FROM [Page] WHERE Code='admin_table'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CTECH'	), (SELECT PageId FROM [Page] WHERE Code='admin_restaurant'		)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CTECH'	), (SELECT PageId FROM [Page] WHERE Code='admin_account'		)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CTECH'	), (SELECT PageId FROM [Page] WHERE Code='emp_order_create'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CTECH'	), (SELECT PageId FROM [Page] WHERE Code='emp_order_update'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CTECH'	), (SELECT PageId FROM [Page] WHERE Code='emp_order_view'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CTECH'	), (SELECT PageId FROM [Page] WHERE Code='customer_order_create'	)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CTECH'	), (SELECT PageId FROM [Page] WHERE Code='customer_order_view'		)) 
	  
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CEMP'	), (SELECT PageId FROM [Page] WHERE Code='emp_order_create'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CEMP'	), (SELECT PageId FROM [Page] WHERE Code='emp_order_update'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CEMP'	), (SELECT PageId FROM [Page] WHERE Code='emp_order_view'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CEMP'	), (SELECT PageId FROM [Page] WHERE Code='customer_order_create'		)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CEMP'	), (SELECT PageId FROM [Page] WHERE Code='customer_order_view'		)) 
	  
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CTEMP'	), (SELECT PageId FROM [Page] WHERE Code='emp_order_create'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CTEMP'	), (SELECT PageId FROM [Page] WHERE Code='emp_order_view'			)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CTEMP'	), (SELECT PageId FROM [Page] WHERE Code='customer_order_create'		)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='CTEMP'	), (SELECT PageId FROM [Page] WHERE Code='customer_order_view'		)) 
	  
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='GSEAT'	), (SELECT PageId FROM [Page] WHERE Code='customer_order_create'		)) 
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='GSEAT'	), (SELECT PageId FROM [Page] WHERE Code='customer_order_view'		)) 
	  
	,(newid(), (SELECT RoleId FROM [Role] WHERE Code='GGUEST'), (SELECT PageId FROM [Page] WHERE Code='customer_order_view'		)) 
*/


END
	






GO
USE [master]
GO
ALTER DATABASE [Restaurant] SET  READ_WRITE 
GO
