CREATE TABLE [dbo].[LugarStock]
(
	[Id_lugar] INT NOT NULL PRIMARY KEY, 
    [barcode_producto] INT NOT NULL UNIQUE,
    [cantidad_bodega] INT NOT NULL, 
    [cantidad_gondola] INT NOT NULL, 
    [seccion_bodega] NVARCHAR(MAX) NOT NULL, 
    [seccion_gondola] NVARCHAR(MAX) NOT NULL
)
