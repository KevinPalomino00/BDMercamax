CREATE PROCEDURE [dbo].[MoverAgondola]
	@codigo int ,
	@n int
AS
	UPDATE LugarStock SET cantidad_bodega = cantidad_bodega -@n ,  cantidad_gondola = cantidad_gondola +@n  WHERE barcode_producto = @codigo 
RETURN 0


/*
Aumente en @n y disminuya en @n los campos cantidad_gondola y
cantidad_bodega, respectivamente, en la tabla LugarStock donde
barcode_producto=@codigo
*/