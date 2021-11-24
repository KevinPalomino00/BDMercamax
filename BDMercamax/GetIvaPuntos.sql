CREATE PROCEDURE [dbo].[GetIvaPuntos]
	@id int 
	
AS
	SELECT  iva, puntos   FROM Tipo_Producto WHERE	Id_tipo = (SELECT id_tipo FROM Producto WHERE Id_producto = @id)
RETURN 0


/*De la tabla Tipo_Producto, obtenga los campos iva y puntos tal que
Tipo_Producto.id_tipo corresponda con Producto.id_tipo en la tabla
Producto donde id_producto=@id
*/ 