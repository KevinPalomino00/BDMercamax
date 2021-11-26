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
