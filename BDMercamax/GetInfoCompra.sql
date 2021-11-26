CREATE PROCEDURE [dbo].[GetInfoCompra]
	@codigo int
AS
	SELECT nombre_proveedor,agente_ventas,telefono_proveedor  FROM Proveedor WHERE nit = (SELECT nit  FROM Producto WHERE barcode = @codigo)
RETURN 0

/*
Obtenga, de la tabla Proveedor, el nombre_proveedor, agente_ventas y
teléfono_proveedor donde nit sea igual al nit recuperado de la tabla
Producto donde Producto.barcode=@codigo
*/