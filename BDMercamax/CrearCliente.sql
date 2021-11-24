CREATE PROCEDURE [dbo].[CrearCliente]
	@cc int ,
	@nombre nvarchar(MAX),
	@telefono nvarchar(MAX),
	@email nvarchar(MAX),
	@direccion nvarchar(MAX),
	@fecha date
AS
	INSERT INTO Cliente (cc_cliente,nombre_apellido_cliente,telefono_cliente,email_cliente,direccion_cliente,fecha_nacimiento_cliente,puntos_acumulados) VALUES (@cc, @nombre, @telefono, @email, @direccion, @fecha, 0)
RETURN 0
