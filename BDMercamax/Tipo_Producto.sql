﻿CREATE TABLE [dbo].[Tipo_Producto]
(
	[Id_tipo] INT NOT NULL PRIMARY KEY, 
    [categoria] VARCHAR(MAX) NOT NULL, 
    [perecedero] BIT NOT NULL, 
    [iva] INT NOT NULL, 
    [puntos] INT NOT NULL
)
