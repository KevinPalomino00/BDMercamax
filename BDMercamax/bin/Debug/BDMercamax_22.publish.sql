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
PRINT N'La operación de refactorización Cambiar nombre con la clave b9140c34-c5cf-4586-bc84-619fbb3e0f2a se ha omitido; no se cambiará el nombre del elemento [dbo].[Cliente].[fecha_nacimiento_cliente] (SqlSimpleColumn) a fecha_nacimiento';


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
PRINT N'Creando Procedimiento [dbo].[ActualizarPuntos]...';


GO
CREATE PROCEDURE [dbo].[ActualizarPuntos]
	@id int ,
	@n int
AS
	UPDATE Cliente SET puntos_acumulados = puntos_acumulados +@n WHERE cc_cliente = @id

RETURN 0
GO
PRINT N'Creando Procedimiento [dbo].[CrearCliente]...';


GO
CREATE PROCEDURE [dbo].[CrearCliente]
	@cc int ,
	@nombre nvarchar(MAX),
	@telefono nvarchar(MAX),
	@email nvarchar(MAX),
	@direccion nvarchar(MAX),
	@fecha date
AS
	INSERT INTO Cliente (cc_cliente, nombre_apellido_cliente,telefono_cliente,email_cliente,direccion_cliente,fecha_nacimiento,puntos_acumulados) VALUES (@cc, @nombre, @telefono, @email, @direccion, @fecha, 0)
RETURN 0
GO
PRINT N'Creando Procedimiento [dbo].[CrearFactura]...';


GO
CREATE PROCEDURE [dbo].[CrearFactura]
	@id	int,
	@monto decimal,
	@date date,
	@montolva decimal,
	@cliente int,
	@personal int

AS

	INSERT INTO Facturacion (Id_factura, monto_total, fecha, monto_iva, cc_cliente, cc_personal) VALUES (@id, @monto, @date, @montolva, @cliente, @personal)

RETURN 0
GO
PRINT N'Creando Procedimiento [dbo].[GetIvaPuntos]...';


GO
CREATE PROCEDURE [dbo].[GetIvaPuntos]
	@id int 
	
AS
	SELECT  iva, puntos   FROM Tipo_Producto WHERE	Id_tipo = (SELECT id_tipo FROM Producto WHERE Id_producto = @id)
RETURN 0


/*De la tabla Tipo_Producto, obtenga los campos iva y puntos tal que
Tipo_Producto.id_tipo corresponda con Producto.id_tipo en la tabla
Producto donde id_producto=@id
*/
GO
-- Paso de refactorización para actualizar el servidor de destino con los registros de transacciones implementadas
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'b9140c34-c5cf-4586-bc84-619fbb3e0f2a')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('b9140c34-c5cf-4586-bc84-619fbb3e0f2a')

GO

GO
PRINT N'Actualización completada.';


GO
