USE MASTER;
GO

-- Database and schemas creation
CREATE DATABASE DbFerreteria;
GO

USE DbFerreteria;
GO



CREATE SCHEMA [business];
GO

CREATE SCHEMA [security];
GO

-- Business database tables creation
CREATE TABLE [business].Empleado (
    IdEmpleado INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(200) NOT NULL,
    Direccion NVARCHAR(500) NOT NULL,
    Puesto NVARCHAR(200) NOT NULL,
    Carnet NVARCHAR(100) NOT NULL,
    Telefono NVARCHAR(25) NOT NULL,
    CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedBy NVARCHAR(100) NOT NULL DEFAULT SUSER_NAME(),
    UpdateDate DATETIME,
    UpdatedBy NVARCHAR(100)
);
GO

-- Security database tables creation
CREATE TABLE [security].TipoUsuario (
    IdTipoUsuario INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(200) NOT NULL,
    Descripcion NVARCHAR(500) NOT NULL,
    Activo BIT NOT NULL DEFAULT 1,
    CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedBy NVARCHAR(100) NOT NULL DEFAULT SUSER_NAME(),
    UpdateDate DATETIME,
    UpdatedBy NVARCHAR(100)
);
GO

CREATE TABLE [security].Usuario (
    IdUsuario INT IDENTITY(1,1) PRIMARY KEY,
    Usuario NVARCHAR(100) NOT NULL,
    IdEmpleado INT NOT NULL,
    IdTipoUsuario INT NOT NULL,
    Activo BIT NOT NULL DEFAULT 1,
    CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedBy NVARCHAR(100) NOT NULL DEFAULT SUSER_NAME(),
    UpdateDate DATETIME,
    UpdatedBy NVARCHAR(100),
    FOREIGN KEY (IdEmpleado) REFERENCES [business].Empleado(IdEmpleado),
    FOREIGN KEY (IdTipoUsuario) REFERENCES [security].TipoUsuario(IdTipoUsuario)
);
GO

-- Create the Cliente table
CREATE TABLE [business].Cliente (
    IdCliente INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Direccion VARCHAR(255) NOT NULL,
    Telefono VARCHAR(15) NOT NULL,
    Correo VARCHAR(255) NOT NULL,
    FechaNacimiento DATE,
    FechaCreacion DATETIME NOT NULL,
    CreadoPor INT NOT NULL,
    FechaModificacion DATETIME,
    ModificadoPor INT
);
GO

-- Create the Venta table
CREATE TABLE [business].Venta (
    IdVenta INT IDENTITY(1,1) PRIMARY KEY,
    IdCliente INT NOT NULL,
    FechaVenta DATE NOT NULL,
    EmpleadoVenta VARCHAR(255) NOT NULL,
    TotalVenta DECIMAL(10, 2) NOT NULL,
    FechaCreacion DATETIME NOT NULL,
    CreadoPor INT NOT NULL,
    FechaModificacion DATETIME,
    ModificadoPor INT,
    FOREIGN KEY (IdCliente) REFERENCES [business].Cliente(IdCliente)
);
GO

-- Create the Plaza table
CREATE TABLE [business].Plaza (
    IdPlaza INT PRIMARY KEY NOT NULL,
    Nombre VARCHAR(255) NOT NULL,
    Descripcion TEXT,
    Activo CHAR(1) NOT NULL,
    FechaCreacion DATETIME NOT NULL,
    CreadoPor INT NOT NULL,
    FechaModificacion DATETIME,
    ModificadoPor INT
);
GO

-- Create the Factura table
CREATE TABLE [business].Factura (
    IdFactura INT PRIMARY KEY NOT NULL,
    TipoFactura VARCHAR(255),
    TotalFactura DECIMAL(10, 2) NOT NULL,
    AplicaGarantia CHAR(1) NOT NULL,
    IdCliente INT,
    IdEmpleado INT,
    FechaFacturacion DATE,
    FechaCreacion DATETIME NOT NULL,
    CreadoPor INT NOT NULL,
    FechaModificacion DATETIME,
    ModificadoPor INT,
    FOREIGN KEY (IdCliente) REFERENCES [business].Cliente(IdCliente),
    FOREIGN KEY (IdEmpleado) REFERENCES [business].Empleado(IdEmpleado)
);
GO

-- Create the ProductoCategoria table
CREATE TABLE [business].ProductoCategoria (
    IdCategoria INT PRIMARY KEY NOT NULL,
    Nombre VARCHAR(255) NOT NULL,
    Descripcion TEXT,
    FechaCreacion DATETIME NOT NULL,
    CreadoPor INT NOT NULL,
    FechaModificacion DATETIME,
    ModificadoPor INT
);
GO

-- Create the Producto table
CREATE TABLE [business].Producto (
    IdProducto INT PRIMARY KEY NOT NULL,
    Nombre VARCHAR(255) NOT NULL,
    Descripcion TEXT,
    IdCategoria INT NOT NULL,
    Cantidad INT NOT NULL,
    FechaCreacion DATETIME NOT NULL,
    CreadoPor INT NOT NULL,
    FechaModificacion DATETIME,
    ModificadoPor INT,
    FOREIGN KEY (IdCategoria) REFERENCES [business].ProductoCategoria(IdCategoria)
);
GO

-- Create the Proveedor table
CREATE TABLE [business].Proveedor (
    IdProveedor INT PRIMARY KEY NOT NULL,
    Nombre VARCHAR(255) NOT NULL,
    Direccion VARCHAR(255) NOT NULL,
    Telefono VARCHAR(15) NOT NULL,
    Correo VARCHAR(255) NOT NULL,
    FechaCreacion DATETIME NOT NULL,
    CreadoPor INT NOT NULL,
    FechaModificacion DATETIME,
    ModificadoPor INT
);
GO

-- Create the DetalleFactura table
CREATE TABLE [business].DetalleFactura (
    IdDetalleFactura INT PRIMARY KEY NOT NULL,
    IdFactura INT NOT NULL,
    IdProducto INT NOT NULL,
    Cantidad INT NOT NULL,
    Precio DECIMAL(10, 2) NOT NULL,
    PrecioUnitario DECIMAL(10, 2) NOT NULL,
    AplicaIva CHAR(1) NOT NULL,
    FechaCreacion DATETIME NOT NULL,
    CreadoPor INT NOT NULL,
    FechaModificacion DATETIME,
    ModificadoPor INT,
    FOREIGN KEY (IdFactura) REFERENCES [business].Factura(IdFactura),
    FOREIGN KEY (IdProducto) REFERENCES [business].Producto(IdProducto)
);
GO

-- Correction of foreign key constraints
ALTER TABLE [security].Usuario
ADD CONSTRAINT FK_EMPLEADO FOREIGN KEY (IdEmpleado) REFERENCES [business].Empleado(IdEmpleado);

ALTER TABLE [business].Factura
ADD CONSTRAINT FK_Empleado FOREIGN KEY (IdEmpleado) REFERENCES [business].Empleado(IdEmpleado);

-- Alterations of data types for certain tables
ALTER TABLE [business].Venta
ALTER COLUMN CreadoPor NVARCHAR(100);

ALTER TABLE [business].Venta
ALTER COLUMN ModificadoPor NVARCHAR(100);

ALTER TABLE [business].Plaza
ALTER COLUMN CreadoPor NVARCHAR(100);

ALTER TABLE [business].Plaza
ALTER COLUMN ModificadoPor NVARCHAR(100);

ALTER TABLE [business].Factura
ALTER COLUMN CreadoPor NVARCHAR(100);

ALTER TABLE [business].Factura
ALTER COLUMN ModificadoPor NVARCHAR(100);

ALTER TABLE [business].ProductoCategoria
ALTER COLUMN CreadoPor NVARCHAR(100);

ALTER TABLE [business].ProductoCategoria
ALTER COLUMN ModificadoPor NVARCHAR(100);

ALTER TABLE [business].Producto
ALTER COLUMN CreadoPor NVARCHAR(100);

ALTER TABLE [business].Producto
ALTER COLUMN ModificadoPor NVARCHAR(100);

ALTER TABLE [business].Proveedor
ALTER COLUMN CreadoPor NVARCHAR(100);

ALTER TABLE [business].Proveedor
ALTER COLUMN ModificadoPor NVARCHAR(100);

ALTER TABLE [business].DetalleFactura
ALTER COLUMN CreadoPor NVARCHAR(100);

ALTER TABLE [business].DetalleFactura
ALTER COLUMN ModificadoPor NVARCHAR(100);

-- Drop foreign key constraints
ALTER TABLE [business].Factura DROP CONSTRAINT FK__Factura__IdEmple__52593CB8;
ALTER TABLE [security].Usuario DROP CONSTRAINT FK_EMPLEADO;
ALTER TABLE [business].Factura DROP CONSTRAINT IdTipoUsuario;

-- Drop tables and schemas
DROP TABLE [business].Empleado;
DROP TABLE [security].Usuario;
DROP TABLE [security].TipoUsuario;
DROP SCHEMA [business];
DROP SCHEMA [security];
