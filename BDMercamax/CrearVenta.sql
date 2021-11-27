CREATE PROCEDURE [dbo].[CrearVenta]
	@id int ,
	@n int,
	@factura int 
AS
	INSERT INTO Venta (barcode_producto, cantidad, id_factura) VALUES ((SELECT barcode FROM Producto WHERE Id_producto = @id), @n, @factura ) 

	/*
	Seleccionar, de la tabla Producto, el barcode que corresponda al
	id_producto @id, y agréguelo a la tabla Venta, además de la cantidad @n
	y la cantidad @n. 


	*/ 

RETURN 0
