CREATE PROCEDURE [dbo].[GetFacturas]
	@id int
AS
	SELECT Id_factura, monto_total, monto_iva, fecha FROM Facturacion WHERE cc_cliente = @id
RETURN 0


/*
Seleccionar, de la tabla Facturacion, los campos id_factura, monto_total,
monto_iva y fecha tal que cc_cliente=@id
*/

