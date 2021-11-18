CREATE PROCEDURE [dbo].[VerProductoGondola]
	@codProd int 
AS
	SELECT cantidad_gondola, seccion_gondola FROM LugarStock Where barcode_producto = @codProd
RETURN 0