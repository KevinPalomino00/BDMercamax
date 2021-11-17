CREATE TABLE [dbo].[Proveedor]
(
	[nit] INT NOT NULL PRIMARY KEY, 
    [nombre_proveedor] VARCHAR(MAX) NOT NULL, 
    [telefono_proveedor] VARCHAR(MAX) NOT NULL, 
    [email_proveedor] VARCHAR(MAX) NOT NULL, 
    [direccion_proveedor] VARCHAR(MAX) NOT NULL, 
    [agente_ventas] VARCHAR(MAX) NOT NULL
)
