
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 07/10/2017 01:23:12
-- Generated from EDMX file: C:\Users\Rishabh\Documents\Visual Studio 2015\Projects\Zebra\Zebra-CMS\Zebra.Domain\Models\TemplateFieldRelation.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [ZebraDB_Master];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_FieldTypesFields]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Fields] DROP CONSTRAINT [FK_FieldTypesFields];
GO
IF OBJECT_ID(N'[dbo].[FK_TemplatesTemplateFieldMap]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[TemplateFieldMaps] DROP CONSTRAINT [FK_TemplatesTemplateFieldMap];
GO
IF OBJECT_ID(N'[dbo].[FK_FieldsTemplateFieldMap]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[TemplateFieldMaps] DROP CONSTRAINT [FK_FieldsTemplateFieldMap];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Templates]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Templates];
GO
IF OBJECT_ID(N'[dbo].[Fields]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Fields];
GO
IF OBJECT_ID(N'[dbo].[FieldTypes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[FieldTypes];
GO
IF OBJECT_ID(N'[dbo].[TemplateFieldMaps]', 'U') IS NOT NULL
    DROP TABLE [dbo].[TemplateFieldMaps];
GO
IF OBJECT_ID(N'[dbo].[Users]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Users];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Templates'
CREATE TABLE [dbo].[Templates] (
    [TemplateId] int  NOT NULL,
    [TemplateName] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'Fields'
CREATE TABLE [dbo].[Fields] (
    [FieldId] int  NOT NULL,
    [FieldName] nvarchar(max)  NOT NULL,
    [TypeId] int  NOT NULL
);
GO

-- Creating table 'FieldTypes'
CREATE TABLE [dbo].[FieldTypes] (
    [TypeId] int  NOT NULL,
    [TypeName] nvarchar(max)  NOT NULL,
    [ClassPath] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'TemplateFieldMaps'
CREATE TABLE [dbo].[TemplateFieldMaps] (
    [MapId] int IDENTITY(1,1) NOT NULL,
    [TemplateId] int  NOT NULL,
    [FieldId] int  NOT NULL
);
GO

-- Creating table 'Users'
CREATE TABLE [dbo].[Users] (
    [UserId] int IDENTITY(1,1) NOT NULL,
    [UserName] nvarchar(max)  NOT NULL,
    [Roles] nvarchar(max)  NOT NULL,
    [Password] nvarchar(max)  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [TemplateId] in table 'Templates'
ALTER TABLE [dbo].[Templates]
ADD CONSTRAINT [PK_Templates]
    PRIMARY KEY CLUSTERED ([TemplateId] ASC);
GO

-- Creating primary key on [FieldId] in table 'Fields'
ALTER TABLE [dbo].[Fields]
ADD CONSTRAINT [PK_Fields]
    PRIMARY KEY CLUSTERED ([FieldId] ASC);
GO

-- Creating primary key on [TypeId] in table 'FieldTypes'
ALTER TABLE [dbo].[FieldTypes]
ADD CONSTRAINT [PK_FieldTypes]
    PRIMARY KEY CLUSTERED ([TypeId] ASC);
GO

-- Creating primary key on [MapId] in table 'TemplateFieldMaps'
ALTER TABLE [dbo].[TemplateFieldMaps]
ADD CONSTRAINT [PK_TemplateFieldMaps]
    PRIMARY KEY CLUSTERED ([MapId] ASC);
GO

-- Creating primary key on [UserId] in table 'Users'
ALTER TABLE [dbo].[Users]
ADD CONSTRAINT [PK_Users]
    PRIMARY KEY CLUSTERED ([UserId] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [TypeId] in table 'Fields'
ALTER TABLE [dbo].[Fields]
ADD CONSTRAINT [FK_FieldTypesFields]
    FOREIGN KEY ([TypeId])
    REFERENCES [dbo].[FieldTypes]
        ([TypeId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_FieldTypesFields'
CREATE INDEX [IX_FK_FieldTypesFields]
ON [dbo].[Fields]
    ([TypeId]);
GO

-- Creating foreign key on [TemplateId] in table 'TemplateFieldMaps'
ALTER TABLE [dbo].[TemplateFieldMaps]
ADD CONSTRAINT [FK_TemplatesTemplateFieldMap]
    FOREIGN KEY ([TemplateId])
    REFERENCES [dbo].[Templates]
        ([TemplateId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_TemplatesTemplateFieldMap'
CREATE INDEX [IX_FK_TemplatesTemplateFieldMap]
ON [dbo].[TemplateFieldMaps]
    ([TemplateId]);
GO

-- Creating foreign key on [FieldId] in table 'TemplateFieldMaps'
ALTER TABLE [dbo].[TemplateFieldMaps]
ADD CONSTRAINT [FK_FieldsTemplateFieldMap]
    FOREIGN KEY ([FieldId])
    REFERENCES [dbo].[Fields]
        ([FieldId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_FieldsTemplateFieldMap'
CREATE INDEX [IX_FK_FieldsTemplateFieldMap]
ON [dbo].[TemplateFieldMaps]
    ([FieldId]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------