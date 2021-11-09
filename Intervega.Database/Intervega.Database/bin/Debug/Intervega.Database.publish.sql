/*
Script de implementación para CentralPeru2021

Una herramienta generó este código.
Los cambios realizados en este archivo podrían generar un comportamiento incorrecto y se perderán si
se vuelve a generar el código.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "CentralPeru2021"
:setvar DefaultFilePrefix "CentralPeru2021"
:setvar DefaultDataPath "D:\Data\"
:setvar DefaultLogPath "D:\Data\"

GO
:on error exit
GO
/*
Detectar el modo SQLCMD y deshabilitar la ejecución del script si no se admite el modo SQLCMD.
Para volver a habilitar el script después de habilitar el modo SQLCMD, ejecute lo siguiente:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'El modo SQLCMD debe estar habilitado para ejecutar correctamente este script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
PRINT N'La operación de refactorización Cambiar nombre con la clave 91eb6659-c36c-40d9-b291-4f2c93151351 se ha omitido; no se cambiará el nombre del elemento [Intervega].[OrdenServicio].[Id] (SqlSimpleColumn) a PKID';


GO
PRINT N'Creando [Intervega]...';


GO
CREATE SCHEMA [Intervega]
    AUTHORIZATION [dbo];


GO
PRINT N'Creando [Intervega].[OrdenDeServicio]...';


GO
CREATE TABLE [Intervega].[OrdenDeServicio] (
    [PKID]                              INT           NOT NULL,
    [IDconsolidadoCarga]                INT           NULL,
    [IDResponsableConsolidadoCarga]     INT           NULL,
    [NumeroConsolidadoCarga]            VARCHAR (50)  NULL,
    [NombreResponsableConsolidadoCarga] VARCHAR (100) NULL,
    [Fecha]                             DATETIME      NOT NULL,
    CONSTRAINT [PK_OrdenDeServicio] PRIMARY KEY CLUSTERED ([PKID] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'Creando [dbo].[eIntervega_OrdenDeServivicio]...';


GO
CREATE VIEW [dbo].[eIntervega_OrdenDeServivicio]
AS
SELECT        PKID AS ID, IDconsolidadoCarga, IDResponsableConsolidadoCarga, NumeroConsolidadoCarga, NombreResponsableConsolidadoCarga, Fecha
FROM            Intervega.OrdenDeServicio
GO
-- Paso de refactorización para actualizar el servidor de destino con los registros de transacciones implementadas
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '91eb6659-c36c-40d9-b291-4f2c93151351')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('91eb6659-c36c-40d9-b291-4f2c93151351')

GO

GO
PRINT N'Actualización completada.';


GO
