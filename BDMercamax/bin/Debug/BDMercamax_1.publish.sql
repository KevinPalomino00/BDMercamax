/*
Script de implementación para BDMercamax

Una herramienta generó este código.
Los cambios realizados en este archivo podrían generar un comportamiento incorrecto y se perderán si
se vuelve a generar el código.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "BDMercamax"
:setvar DefaultFilePrefix "BDMercamax"
:setvar DefaultDataPath "C:\Users\STX\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"
:setvar DefaultLogPath "C:\Users\STX\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"

GO
:on error exit
GO
/*
Detectar el modo SQLCMD y deshabilitar la ejecución del script si no se admite el modo SQLCMD.
Para volver a habilitar el script después de habilitar el modo SQLCMD, ejecute lo siguiente:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'El modo SQLCMD debe estar habilitado para ejecutar correctamente este script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creando la base de datos $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'No se puede modificar la configuración de la base de datos. Debe ser un administrador del sistema para poder aplicar esta configuración.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'No se puede modificar la configuración de la base de datos. Debe ser un administrador del sistema para poder aplicar esta configuración.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Creando Tabla [dbo].[Cliente]...';


GO
CREATE TABLE [dbo].[Cliente] (
    [cc_cliente]               INT            NOT NULL,
    [nombre_apellido_cliente]  NVARCHAR (MAX) NOT NULL,
    [telefono_cliente]         NVARCHAR (MAX) NOT NULL,
    [email_cliente]            NVARCHAR (MAX) NOT NULL,
    [direccion_cliente]        NVARCHAR (MAX) NOT NULL,
    [fecha_nacimiento_cliente] DATE           NOT NULL,
    [puntos_acumulados]        INT            NOT NULL,
    PRIMARY KEY CLUSTERED ([cc_cliente] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[Facturacion]...';


GO
CREATE TABLE [dbo].[Facturacion] (
    [Id_factura]  INT             NOT NULL,
    [monto_total] DECIMAL (18, 2) NOT NULL,
    [fecha]       DATE            NOT NULL,
    [monto_iva]   DECIMAL (18, 2) NOT NULL,
    [cc_cliente]  INT             NOT NULL,
    [cc_personal] INT             NOT NULL,
    [id_venta]    INT             NOT NULL,
    PRIMARY KEY CLUSTERED ([Id_factura] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[LugarStock]...';


GO
CREATE TABLE [dbo].[LugarStock] (
    [Id_lugar]         INT            NOT NULL,
    [barcode_producto] INT            NOT NULL,
    [cantidad_bodega]  INT            NOT NULL,
    [cantidad_gondola] INT            NOT NULL,
    [seccion_bodega]   NVARCHAR (MAX) NOT NULL,
    [seccion_gondola]  NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id_lugar] ASC),
    UNIQUE NONCLUSTERED ([barcode_producto] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[Personal]...';


GO
CREATE TABLE [dbo].[Personal] (
    [cc_personal]               INT            NOT NULL,
    [nombre_apellido_personal]  NVARCHAR (MAX) NOT NULL,
    [cargo]                     BIT            NOT NULL,
    [telefono_personal]         NVARCHAR (MAX) NOT NULL,
    [email_personal]            NVARCHAR (MAX) NOT NULL,
    [direccion_personal]        NVARCHAR (MAX) NOT NULL,
    [fecha_nacimiento_personal] NVARCHAR (MAX) NOT NULL,
    [password]                  NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([cc_personal] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[Producto]...';


GO
CREATE TABLE [dbo].[Producto] (
    [Id_producto]       INT             NOT NULL,
    [nombre_producto]   VARCHAR (MAX)   NOT NULL,
    [fecha_llegada]     DATE            NOT NULL,
    [fecha_vencimiento] DATE            NOT NULL,
    [barcode]           INT             NOT NULL,
    [precio]            DECIMAL (18, 2) NOT NULL,
    [nit]               INT             NOT NULL,
    [id_tipo]           INT             NOT NULL,
    PRIMARY KEY CLUSTERED ([Id_producto] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[Proveedor]...';


GO
CREATE TABLE [dbo].[Proveedor] (
    [nit]                 INT           NOT NULL,
    [nombre_proveedor]    VARCHAR (MAX) NOT NULL,
    [telefono_proveedor]  VARCHAR (MAX) NOT NULL,
    [email_proveedor]     VARCHAR (MAX) NOT NULL,
    [direccion_proveedor] VARCHAR (MAX) NOT NULL,
    [agente_ventas]       VARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([nit] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[Tipo_Producto]...';


GO
CREATE TABLE [dbo].[Tipo_Producto] (
    [Id_tipo]    INT           NOT NULL,
    [categoria]  VARCHAR (MAX) NOT NULL,
    [perecedero] BIT           NOT NULL,
    [iva]        INT           NOT NULL,
    [puntos]     INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([Id_tipo] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[Venta]...';


GO
CREATE TABLE [dbo].[Venta] (
    [Id_venta]         INT NOT NULL,
    [barcode_producto] INT NOT NULL,
    [cantidad]         INT NOT NULL,
    [id_factura]       INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id_venta] ASC),
    UNIQUE NONCLUSTERED ([barcode_producto] ASC)
);


GO
PRINT N'Creando Clave externa [dbo].[FK_Facturacion_ToTable]...';


GO
ALTER TABLE [dbo].[Facturacion]
    ADD CONSTRAINT [FK_Facturacion_ToTable] FOREIGN KEY ([cc_cliente]) REFERENCES [dbo].[Cliente] ([cc_cliente]);


GO
PRINT N'Creando Clave externa [dbo].[FK_Facturacion_ToTable_1]...';


GO
ALTER TABLE [dbo].[Facturacion]
    ADD CONSTRAINT [FK_Facturacion_ToTable_1] FOREIGN KEY ([cc_personal]) REFERENCES [dbo].[Personal] ([cc_personal]);


GO
PRINT N'Creando Clave externa [dbo].[FK_Facturacion_ToTable_2]...';


GO
ALTER TABLE [dbo].[Facturacion]
    ADD CONSTRAINT [FK_Facturacion_ToTable_2] FOREIGN KEY ([id_venta]) REFERENCES [dbo].[Venta] ([Id_venta]);


GO
PRINT N'Creando Clave externa [dbo].[FK_Producto_ToTable]...';


GO
ALTER TABLE [dbo].[Producto]
    ADD CONSTRAINT [FK_Producto_ToTable] FOREIGN KEY ([nit]) REFERENCES [dbo].[Proveedor] ([nit]);


GO
PRINT N'Creando Clave externa [dbo].[FK_Producto_ToTable_1]...';


GO
ALTER TABLE [dbo].[Producto]
    ADD CONSTRAINT [FK_Producto_ToTable_1] FOREIGN KEY ([id_tipo]) REFERENCES [dbo].[Tipo_Producto] ([Id_tipo]);


GO
PRINT N'Creando Clave externa [dbo].[FK_Venta_ToTable]...';


GO
ALTER TABLE [dbo].[Venta]
    ADD CONSTRAINT [FK_Venta_ToTable] FOREIGN KEY ([id_factura]) REFERENCES [dbo].[Facturacion] ([Id_factura]);


GO
-- Paso de refactorización para actualizar el servidor de destino con los registros de transacciones implementadas

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '386040f4-672b-4fca-96b9-0609630e2538')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('386040f4-672b-4fca-96b9-0609630e2538')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '68ed7fe7-3fb5-4afd-b5e4-45abbfd2b140')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('68ed7fe7-3fb5-4afd-b5e4-45abbfd2b140')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '90fd8179-2dca-4d15-b705-3ebadd9d66c8')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('90fd8179-2dca-4d15-b705-3ebadd9d66c8')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'd29a785d-88b6-4a40-b876-01834ecab69b')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('d29a785d-88b6-4a40-b876-01834ecab69b')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '0fdfb3b5-331a-42f3-acb2-5a211fc04830')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('0fdfb3b5-331a-42f3-acb2-5a211fc04830')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'f98b2142-5719-4ec1-b66f-f83719f97f3b')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('f98b2142-5719-4ec1-b66f-f83719f97f3b')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '0c284771-5987-4f73-bae9-24ef28a4025a')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('0c284771-5987-4f73-bae9-24ef28a4025a')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'c24fbbb7-ca7b-4b0e-b292-3f06b2cfb985')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('c24fbbb7-ca7b-4b0e-b292-3f06b2cfb985')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '2368c316-24a6-4f42-a477-0ffa9dd01154')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('2368c316-24a6-4f42-a477-0ffa9dd01154')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '2e7fcc4a-2d7e-41d0-85dd-0e5f8273f286')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('2e7fcc4a-2d7e-41d0-85dd-0e5f8273f286')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'c4e8ac14-5145-410e-b66c-e1512dc67c2f')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('c4e8ac14-5145-410e-b66c-e1512dc67c2f')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '9d8b4ac9-e327-4b4d-8272-e9508e7c3d2f')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('9d8b4ac9-e327-4b4d-8272-e9508e7c3d2f')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '226dd846-ec0a-4437-8eec-f0c6cba64766')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('226dd846-ec0a-4437-8eec-f0c6cba64766')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '4e630dc7-d890-4a77-b01e-f77529c189b8')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('4e630dc7-d890-4a77-b01e-f77529c189b8')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '81e945d3-c8a0-45c7-9868-15846710918a')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('81e945d3-c8a0-45c7-9868-15846710918a')

GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Actualización completada.';


GO
