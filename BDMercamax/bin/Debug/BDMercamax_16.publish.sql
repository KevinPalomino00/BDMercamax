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
USE [$(DatabaseName)];


GO
/*
Se está quitando la columna [dbo].[Cliente].[fecha_nacimiento]; puede que se pierdan datos.

Debe agregarse la columna [dbo].[Cliente].[fecha_nacimiento_cliente] de la tabla [dbo].[Cliente], pero esta columna no tiene un valor predeterminado y no admite valores NULL. Si la tabla contiene datos, el script ALTER no funcionará. Para evitar esta incidencia, agregue un valor predeterminado a la columna, márquela de modo que permita valores NULL o habilite la generación de valores predeterminados inteligentes como opción de implementación.
*/

IF EXISTS (select top 1 1 from [dbo].[Cliente])
    RAISERROR (N'Se detectaron filas. La actualización del esquema va a terminar debido a una posible pérdida de datos.', 16, 127) WITH NOWAIT

GO
/*
Debe agregarse la columna [dbo].[Facturacion].[id_venta] de la tabla [dbo].[Facturacion], pero esta columna no tiene un valor predeterminado y no admite valores NULL. Si la tabla contiene datos, el script ALTER no funcionará. Para evitar esta incidencia, agregue un valor predeterminado a la columna, márquela de modo que permita valores NULL o habilite la generación de valores predeterminados inteligentes como opción de implementación.
*/

IF EXISTS (select top 1 1 from [dbo].[Facturacion])
    RAISERROR (N'Se detectaron filas. La actualización del esquema va a terminar debido a una posible pérdida de datos.', 16, 127) WITH NOWAIT

GO
/*
Debe agregarse la columna [dbo].[LugarStock].[Id_lugar] de la tabla [dbo].[LugarStock], pero esta columna no tiene un valor predeterminado y no admite valores NULL. Si la tabla contiene datos, el script ALTER no funcionará. Para evitar esta incidencia, agregue un valor predeterminado a la columna, márquela de modo que permita valores NULL o habilite la generación de valores predeterminados inteligentes como opción de implementación.
*/

IF EXISTS (select top 1 1 from [dbo].[LugarStock])
    RAISERROR (N'Se detectaron filas. La actualización del esquema va a terminar debido a una posible pérdida de datos.', 16, 127) WITH NOWAIT

GO
/*
Debe agregarse la columna [dbo].[Venta].[Id_venta] de la tabla [dbo].[Venta], pero esta columna no tiene un valor predeterminado y no admite valores NULL. Si la tabla contiene datos, el script ALTER no funcionará. Para evitar esta incidencia, agregue un valor predeterminado a la columna, márquela de modo que permita valores NULL o habilite la generación de valores predeterminados inteligentes como opción de implementación.
*/

IF EXISTS (select top 1 1 from [dbo].[Venta])
    RAISERROR (N'Se detectaron filas. La actualización del esquema va a terminar debido a una posible pérdida de datos.', 16, 127) WITH NOWAIT

GO
PRINT N'Quitando Clave externa [dbo].[FK_Facturacion_ToTable]...';


GO
ALTER TABLE [dbo].[Facturacion] DROP CONSTRAINT [FK_Facturacion_ToTable];


GO
PRINT N'Quitando Clave externa [dbo].[FK_Facturacion_ToTable_1]...';


GO
ALTER TABLE [dbo].[Facturacion] DROP CONSTRAINT [FK_Facturacion_ToTable_1];


GO
PRINT N'Quitando Clave externa [dbo].[FK_Venta_ToTable]...';


GO
ALTER TABLE [dbo].[Venta] DROP CONSTRAINT [FK_Venta_ToTable];


GO
PRINT N'Iniciando recompilación de la tabla [dbo].[Cliente]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Cliente] (
    [cc_cliente]               INT            NOT NULL,
    [nombre_apellido_cliente]  NVARCHAR (MAX) NOT NULL,
    [telefono_cliente]         NVARCHAR (MAX) NOT NULL,
    [email_cliente]            NVARCHAR (MAX) NOT NULL,
    [direccion_cliente]        NVARCHAR (MAX) NOT NULL,
    [fecha_nacimiento_cliente] DATE           NOT NULL,
    [puntos_acumulados]        INT            NOT NULL,
    PRIMARY KEY CLUSTERED ([cc_cliente] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Cliente])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_Cliente] ([cc_cliente], [nombre_apellido_cliente], [telefono_cliente], [email_cliente], [direccion_cliente], [puntos_acumulados])
        SELECT   [cc_cliente],
                 [nombre_apellido_cliente],
                 [telefono_cliente],
                 [email_cliente],
                 [direccion_cliente],
                 [puntos_acumulados]
        FROM     [dbo].[Cliente]
        ORDER BY [cc_cliente] ASC;
    END

DROP TABLE [dbo].[Cliente];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Cliente]', N'Cliente';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Modificando Tabla [dbo].[Facturacion]...';


GO
ALTER TABLE [dbo].[Facturacion]
    ADD [id_venta] INT NOT NULL;


GO
PRINT N'Iniciando recompilación de la tabla [dbo].[LugarStock]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_LugarStock] (
    [Id_lugar]         INT            NOT NULL,
    [barcode_producto] INT            NOT NULL,
    [cantidad_bodega]  INT            NOT NULL,
    [cantidad_gondola] INT            NOT NULL,
    [seccion_bodega]   NVARCHAR (MAX) NOT NULL,
    [seccion_gondola]  NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id_lugar] ASC),
    UNIQUE NONCLUSTERED ([barcode_producto] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[LugarStock])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_LugarStock] ([barcode_producto], [cantidad_bodega], [cantidad_gondola], [seccion_bodega], [seccion_gondola])
        SELECT [barcode_producto],
               [cantidad_bodega],
               [cantidad_gondola],
               [seccion_bodega],
               [seccion_gondola]
        FROM   [dbo].[LugarStock];
    END

DROP TABLE [dbo].[LugarStock];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_LugarStock]', N'LugarStock';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Iniciando recompilación de la tabla [dbo].[Personal]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Personal] (
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

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Personal])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_Personal] ([cc_personal], [nombre_apellido_personal], [cargo], [telefono_personal], [email_personal], [direccion_personal], [fecha_nacimiento_personal], [password])
        SELECT   [cc_personal],
                 [nombre_apellido_personal],
                 [cargo],
                 [telefono_personal],
                 [email_personal],
                 [direccion_personal],
                 [fecha_nacimiento_personal],
                 [password]
        FROM     [dbo].[Personal]
        ORDER BY [cc_personal] ASC;
    END

DROP TABLE [dbo].[Personal];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Personal]', N'Personal';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Iniciando recompilación de la tabla [dbo].[Venta]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Venta] (
    [Id_venta]         INT NOT NULL,
    [barcode_producto] INT NOT NULL,
    [cantidad]         INT NOT NULL,
    [id_factura]       INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id_venta] ASC),
    UNIQUE NONCLUSTERED ([barcode_producto] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Venta])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_Venta] ([barcode_producto], [cantidad], [id_factura])
        SELECT [barcode_producto],
               [cantidad],
               [id_factura]
        FROM   [dbo].[Venta];
    END

DROP TABLE [dbo].[Venta];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Venta]', N'Venta';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Creando Clave externa [dbo].[FK_Facturacion_ToTable]...';


GO
ALTER TABLE [dbo].[Facturacion] WITH NOCHECK
    ADD CONSTRAINT [FK_Facturacion_ToTable] FOREIGN KEY ([cc_cliente]) REFERENCES [dbo].[Cliente] ([cc_cliente]);


GO
PRINT N'Creando Clave externa [dbo].[FK_Facturacion_ToTable_1]...';


GO
ALTER TABLE [dbo].[Facturacion] WITH NOCHECK
    ADD CONSTRAINT [FK_Facturacion_ToTable_1] FOREIGN KEY ([cc_personal]) REFERENCES [dbo].[Personal] ([cc_personal]);


GO
PRINT N'Creando Clave externa [dbo].[FK_Venta_ToTable]...';


GO
ALTER TABLE [dbo].[Venta] WITH NOCHECK
    ADD CONSTRAINT [FK_Venta_ToTable] FOREIGN KEY ([id_factura]) REFERENCES [dbo].[Facturacion] ([Id_factura]);


GO
PRINT N'Creando Clave externa [dbo].[FK_Facturacion_ToTable_2]...';


GO
ALTER TABLE [dbo].[Facturacion] WITH NOCHECK
    ADD CONSTRAINT [FK_Facturacion_ToTable_2] FOREIGN KEY ([id_venta]) REFERENCES [dbo].[Venta] ([Id_venta]);


GO
PRINT N'Creando Vista [dbo].[GetCountFacturas]...';


GO
CREATE VIEW [dbo].[GetCountFacturas]
	AS SELECT Id_factura FROM Facturacion
GO
PRINT N'Creando Vista [dbo].[VerClientes]...';


GO
CREATE VIEW [dbo].[VerClientes]

	AS SELECT cc_cliente, nombre_apellido_cliente, puntos_acumulados FROM Cliente
GO
PRINT N'Creando Vista [dbo].[VerProductoPrecio]...';


GO
CREATE VIEW [dbo].[VerProductoPrecio]


	AS SELECT Id_producto , nombre_producto FROM Producto
GO
PRINT N'Creando Procedimiento [dbo].[ActualizarGondola]...';


GO
CREATE PROCEDURE [dbo].[ActualizarGondola]
	@id int ,
	@n int
AS
	UPDATE LugarStock SET cantidad_gondola = cantidad_gondola -@n WHERE barcode_producto = (SELECT barcode FROM Producto WHERE Id_producto = -@id)

RETURN 0
GO
PRINT N'Actualizando Procedimiento [dbo].[LoginCliente]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[LoginCliente]';


GO
PRINT N'Actualizando Procedimiento [dbo].[VerPuntos]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[VerPuntos]';


GO
PRINT N'Actualizando Procedimiento [dbo].[VerProductoBodega]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[VerProductoBodega]';


GO
PRINT N'Actualizando Procedimiento [dbo].[VerProductoGondola]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[VerProductoGondola]';


GO
PRINT N'Actualizando Procedimiento [dbo].[Login]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[Login]';


GO
PRINT N'Comprobando los datos existentes con las restricciones recién creadas';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Facturacion] WITH CHECK CHECK CONSTRAINT [FK_Facturacion_ToTable];

ALTER TABLE [dbo].[Facturacion] WITH CHECK CHECK CONSTRAINT [FK_Facturacion_ToTable_1];

ALTER TABLE [dbo].[Venta] WITH CHECK CHECK CONSTRAINT [FK_Venta_ToTable];

ALTER TABLE [dbo].[Facturacion] WITH CHECK CHECK CONSTRAINT [FK_Facturacion_ToTable_2];


GO
PRINT N'Actualización completada.';


GO
