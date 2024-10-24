USE MASTER
GO
/* Database and schemas creation */
    CREATE DATABASE BDFerreteria
    GO
    USE BDFerreteria
    GO
   /* --- */ 

/*database tables creation */
CREATE TABLE Empleado (
    IdEmpleado INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(200) NOT NULL,
	Apellido NVARCHAR (200) NOT NULL,
    Direccion NVARCHAR(500) NOT NULL,
    Puesto NVARCHAR(200) NOT NULL,
    Carnet NVARCHAR(100) NOT NULL,
    Telefono NVARCHAR(25) NOT NULL,
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
    CreadoPor NVARCHAR(100) NOT NULL DEFAULT SUSER_NAME()
)






GO
CREATE TABLE Usuario (
    IdUsuario INT IDENTITY(1,1) PRIMARY KEY,
    Usuario NVARCHAR(100) NOT NULL,
    Clave NVARCHAR(100) NOT NULL,
	TipoUsuario INT NOT NULL,
    IdEmpleado INT UNIQUE NOT NULL,
    Activo BIT NOT NULL DEFAULT 1,
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
    CreadoPor NVARCHAR(100) NOT NULL DEFAULT SUSER_NAME(),
    CONSTRAINT FK_EmpleadoUsuario FOREIGN KEY (IdEmpleado) REFERENCES Empleado(IdEmpleado)
)

GO
-- Crear la tabla Cliente
CREATE TABLE Cliente (
    IdCliente INT IDENTITY(1,1) UNIQUE NOT NULL,
    Nombre NVARCHAR(255)NOT NULL,
	Apellido NVARCHAR (200) NOT NULL,
    Direccion NVARCHAR(255)NOT NULL,
    Telefono NVARCHAR(15)NOT NULL,
    Correo NVARCHAR(255)NOT NULL,
    FechaNacimiento DATE,
   FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
    CreadoPor NVARCHAR(100) NOT NULL DEFAULT SUSER_NAME(),
	CONSTRAINT PK_CLIENTE PRIMARY KEY (IdCliente),
);



		

GO
-- Crear la tabla Factura
CREATE TABLE Factura (
    IdFactura INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
    TipoFactura VARCHAR(255),
    TotalFactura DECIMAL(10, 2) NOT NULL,
    AplicaGarantia CHAR(1) NOT NULL,
    IdCliente INT,
    IdEmpleado INT,
    FechaFacturacion DATETIME,
   FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
    CreadoPor NVARCHAR(100) NOT NULL DEFAULT SUSER_NAME(),
    FOREIGN KEY (IdEmpleado) REFERENCES Empleado(IdEmpleado),
	CONSTRAINT FK_IdCliente FOREIGN KEY (IdCliente) REFERENCES Cliente(IdCliente),
);




		

GO
-- Crear la tabla ProductoCategoria
CREATE TABLE ProductoCategoria(
    IdCategoria INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
    Nombre VARCHAR(255) NOT NULL,
    Descripcion TEXT,
   FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
    CreadoPor NVARCHAR(100) NOT NULL DEFAULT SUSER_NAME(),

);


GO
-- Crear la tabla Producto
CREATE TABLE Producto(
    IdProducto INT PRIMARY KEY NOT NULL,
    Nombre VARCHAR(255) NOT NULL,
    Descripcion TEXT,
    IdCategoria INT NOT NULL,
    Cantidad INT NOT NULL,
   FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
    CreadoPor NVARCHAR(100) NOT NULL DEFAULT SUSER_NAME(),
    FOREIGN KEY (IdCategoria) REFERENCES ProductoCategoria(IdCategoria)
);



GO
-- Crear la tabla Proveedor
CREATE TABLE Proveedor (
    IdProveedor INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
     IdProducto INT NOT NULL,
    Nombre VARCHAR(255) NOT NULL,
    Direccion VARCHAR(255) NOT NULL,
    Telefono VARCHAR(15) NOT NULL,
    Correo VARCHAR(255) NOT NULL,
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
    CreadoPor NVARCHAR(100) NOT NULL DEFAULT SUSER_NAME(),
	CONSTRAINT IdProducto FOREIGN KEY (IdProducto) REFERENCES Producto(IdProducto),
	);


		



GO
-- Crear la tabla DetalleFactura
CREATE TABLE DetalleFactura (
    IdDetalleFactura INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
    IdFactura INT NOT NULL,
    IdProducto INT NOT NULL,
    Cantidad INT NOT NULL,
    Precio DECIMAL(10, 2) NOT NULL,
    PrecioUnitario DECIMAL(10, 2) NOT NULL,
    AplicaIva CHAR(1) NOT NULL,
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
    CreadoPor NVARCHAR(100) NOT NULL DEFAULT SUSER_NAME(),
    FOREIGN KEY (IdFactura) REFERENCES Factura(IdFactura),
    FOREIGN KEY (IdProducto) REFERENCES Producto(IdProducto)
);








GO
-- Crear tabla Inventario
CREATE TABLE Inventario (
    IdInventario INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    IdProducto INT NOT NULL,
    TipoMovimiento NVARCHAR(50) NOT NULL,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(10, 2) NOT NULL,
     FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
    CreadoPor NVARCHAR(100) NOT NULL DEFAULT SUSER_NAME(),
    FOREIGN KEY (IdProducto) REFERENCES Producto(IdProducto)
);


SELECT TipoUsuario
FROM Usuario
WHERE Usuario = 'mbarrera'
AND Clave = 'EstaEsMiContra123!'

SELECT TipoUsuario
FROM Usuario
WHERE Usuario = @Usuario
AND Clave = @Clave

INSERT INTO Empleado(Nombre, Apellido, Direccion, Puesto, Carnet, Telefono)
VALUES('MARCOS ','BARRERA','EL TREBOL SANTA ANA','ADMIN','BE10000','22577777')

INSERT INTO Usuario(Usuario,Clave,IdEmpleado,TipoUsuario,Activo)
VALUES('mbarrera','EstaEsMiContra123!',1,1,1)

INSERT INTO Empleado(Nombre, Apellido, Direccion, Puesto, Carnet, Telefono)
VALUES('CESAR ','RIVERA','SANTA ANA','BASICO','BE110000','22232141')

INSERT INTO Usuario(Usuario,Clave,IdEmpleado,TipoUsuario,Activo)
VALUES('CRivera','CRIVERA2418',2,2,1)

SELECT * FROM Empleado
SELECT * FROM Usuario
SELECT * FROM Producto
SELECT * FROM Factura
SELECT * FROM ProductoCategoria
SELECT * FROM Inventario
SELECT * FROM DetalleFactura
SELECT * FROM Cliente
SELECT * FROM Proveedor




 DELETE FROM Empleado WHERE IdEmpleado= 4

 DELETE FROM Usuario WHERE IdUsuario= 7

 SELECT 
    f.IdFactura,
    f.TipoFactura,
    c.Nombre AS NombreCliente,
    c.Apellido AS ApellidoCliente,
    c.Correo AS EmailCliente,
    e.Nombre AS NombreEmpleado,
    e.Apellido AS ApellidoEmpleado,
    e.Carnet AS CarnetEmpleado,
    e.Puesto AS PuestoEmpleado,
    f.TotalFactura,
    f.AplicaGarantia,
    f.FechaFacturacion,
    f.CreadoPor
FROM Factura f
INNER JOIN DetalleFactura df
ON f.IdFactura = df.IdFactura
INNER JOIN Cliente c
ON f.IdCliente = c.IdCliente
INNER JOIN Empleado e
ON f.IdEmpleado = e.IdEmpleado


 --NUEVOS INSERTS
INSERT INTO Cliente (Nombre, Apellido, Direccion, Telefono, Correo, FechaNacimiento)
VALUES 
('Patricia', 'Martínez', 'Avenida 789, Ciudad', '555-1111', 'patricia.martinez@email.com', '1980-09-15'),
('Ricardo', 'Guzmán', 'Calle 234, Ciudad', '555-2222', 'ricardo.guzman@email.com', '1992-04-20'),
('Laura', 'Torres', 'Avenida 567, Ciudad', '555-3333', 'laura.torres@email.com', '1985-12-10'),
('Daniel', 'Cabrera', 'Calle 890, Ciudad', '555-4444', 'daniel.cabrera@email.com', '1998-06-02'),
('María', 'Ortega', 'Calle 123, Ciudad', '555-5555', 'maria.ortega@email.com', '1983-11-22'),
('Gabriela', 'López', 'Calle 345, Ciudad', '555-1111', 'gabriela.lopez@email.com', '1987-03-12'),
('Jorge', 'Herrera', 'Avenida 678, Ciudad', '555-2222', 'jorge.herrera@email.com', '1995-08-18'),
('Sara', 'Ríos', 'Calle 901, Ciudad', '555-3333', 'sara.rios@email.com', '1984-01-23'),
('Martín', 'Fuentes', 'Avenida 234, Ciudad', '555-4444', 'martin.fuentes@email.com', '1993-06-30'),
('Adriana', 'Reyes', 'Calle 567, Ciudad', '555-5555', 'adriana.reyes@email.com', '1989-09-05');
-- Agrega más datos según sea necesario

INSERT INTO Factura (TipoFactura, TotalFactura, AplicaGarantia, IdCliente, IdEmpleado, FechaFacturacion)
VALUES 
('Venta', 90.25, 'N', 57, 1, '2023-02-16 13:30:00'),
('Compra', 110.50, 'S', 58, 2, '2023-02-17 09:45:00'),
('Venta', 80.00, 'N', 59, 1, '2023-02-18 11:15:00'),
('Compra', 130.75, 'S', 60, 2, '2023-02-19 14:30:00'),
('Venta', 100.80, 'N', 61, 1, '2023-02-20 16:00:00'),
('Venta', 150.25, 'N', 62, 1, '2023-03-01 14:30:00'),
('Compra', 120.50, 'S', 63, 2, '2023-03-02 10:00:00'),
('Venta', 95.00, 'N', 64, 1, '2023-03-03 11:45:00'),
('Compra', 130.75, 'S', 65, 2, '2023-03-04 15:15:00'),
('Venta', 110.80, 'N', 66, 1, '2023-03-05 16:45:00');


-- Agrega más datos según sea necesario

INSERT INTO ProductoCategoria (Nombre, Descripcion)
VALUES 
(1, 'Herramientas', 'Categoría para herramientas de construcción'),
(2, 'Electricidad', 'Categoría para productos eléctricos'),
(3, 'Pinturas', 'Categoría para pinturas y accesorios'),
(4, 'Plomería', 'Categoría para productos de plomería'),
(5, 'Jardinería', 'Categoría para productos de jardinería'),
(6, 'Ferretería', 'Categoría para productos generales de ferretería'),
(7, 'Construcción', 'Categoría para materiales de construcción'),
(8, 'Iluminación', 'Categoría para productos de iluminación'),
(9, 'Fontanería', 'Categoría para productos de fontanería'),
(10, 'Electrónicos', 'Categoría para productos electrónicos'),
(11, 'Iluminación', 'Categoría para productos de iluminación'),
(12, 'Cerrajería', 'Categoría para productos de cerrajería'),
(13, 'Seguridad', 'Categoría para productos de seguridad'),
(14, 'Hogar', 'Categoría para productos de hogar'),
(15, 'Automotriz', 'Categoría para productos automotrices'),
-- Agrega más datos según sea necesario

INSERT INTO Producto (IdProducto, Nombre, Descripcion, IdCategoria, Cantidad)
VALUES 
(1, 'Martillo', 'Martillo de acero forjado', 1, 50),
(2, 'Bombillo LED', 'Bombillo LED de 60W', 2, 100),
(3, 'Pintura blanca', 'Pintura blanca de interior', 3, 30),
(4, 'Llave ajustable', 'Llave ajustable de 10 pulgadas', 4, 20),
(5, 'Podadora eléctrica', 'Podadora eléctrica para césped', 5, 15),
(6, 'Destornillador', 'Destornillador de punta plana', 1, 40),
(7, 'Ladrillos', 'Ladrillos para construcción', 2, 500),
(8, 'Lámpara LED', 'Lámpara LED de 15W', 3, 80),
(9, 'Grifo', 'Grifo de cocina', 4, 30),
(10, 'Cable HDMI', 'Cable HDMI de 2 metros', 5, 100),
(11, 'Destornillador', 'Destornillador de punta plana', 1, 40),
(12, 'Cemento', 'Saco de cemento Portland', 2, 100),
(13, 'Bombilla LED', 'Bombilla LED de 15W', 3, 80),
(14, 'Grifo', 'Grifo para cocina', 4, 30),
(15, 'Cable eléctrico', 'Cable eléctrico de 5 metros', 5, 100),
(16, 'Lata de Pintura', 'Lata de pintura blanca de 1 galón', 11, 25),
(17, 'Cerradura', 'Cerradura de seguridad para puertas', 12, 15),
(18, 'Podadora de Césped', 'Podadora de césped eléctrica', 13, 10),
(19, 'Tornillos Variados', 'Set de tornillos para diferentes usos', 14, 100),
(20, 'Cámara de Seguridad', 'Cámara de seguridad para interiores', 15, 8),
(21, 'Destornillador Phillips', 'Destornillador con punta Phillips', 26, 30),
(22, 'Cemento Rápido', 'Cemento de secado rápido', 27, 80),
(23, 'Focos LED', 'Pack de focos LED de 60W', 28, 50),
(24, 'Llave Inglesa', 'Llave inglesa de 12 pulgadas', 29, 25),
(25, 'Manguera de Jardín', 'Manguera para riego de jardín', 30, 15),

-- Agrega más datos según sea necesario


INSERT INTO Proveedor (IdProducto, Nombre, Direccion, Telefono, Correo)
VALUES 
(1, 'Ferretería ProMart', 'Calle Principal, Ciudad', '555-1111', 'promart@email.com'),
(2, 'Iluminaciones S.A.', 'Avenida Central, Ciudad', '555-2222', 'iluminaciones@email.com'),
(3, 'Pinturas Express', 'Calle Secundaria, Ciudad', '555-3333', 'pinturas@email.com'),
(4, 'Plomería Total', 'Avenida Secundaria, Ciudad', '555-4444', 'plomeria@email.com'),
(5, 'Jardines Verdes', 'Calle del Jardín, Ciudad', '555-5555', 'jardines@email.com'),
(6, 'Herramientas Express', 'Calle de las Herramientas, Ciudad', '555-6666', 'herramientas@email.com'),
(7, 'Materiales ConstruMAX', 'Avenida de la Construcción, Ciudad', '555-7777', 'construmax@email.com'),
(8, 'Luz Brillante S.A.', 'Calle de la Iluminación, Ciudad', '555-8888', 'luzbrillante@email.com'),
(9, 'Fontanería Total', 'Avenida del Fontanero, Ciudad', '555-9999', 'fontaneria@email.com'),
(10, 'Electrónicos Mundo', 'Calle de los Electrónicos, Ciudad', '555-0000', 'electronica@email.com'),



-- Agrega más datos según sea necesario



INSERT INTO DetalleFactura (IdFactura, IdProducto, Cantidad, Precio, PrecioUnitario, AplicaIva)
VALUES 
(45, 1, 2, 30.00, 15.00, 'S'),
(46, 2, 5, 50.00, 10.00, 'S'),
(47, 3, 3, 60.00, 20.00, 'N'),
(48, 4, 1, 25.00, 25.00, 'S'),
(49, 5, 4, 45.50, 11.38, 'S'),
(50, 6, 3, 15.00, 5.00, 'N'),
(51, 7, 100, 300.00, 3.00, 'S'),
(52, 8, 5, 40.00, 8.00, 'N'),
(53, 9, 2, 30.00, 15.00, 'S'),
(54, 10, 8, 80.00, 10.00, 'S');


-- Agrega más datos según sea necesario

INSERT INTO Inventario (IdProducto, TipoMovimiento, Cantidad, PrecioUnitario)
VALUES 
(1, 'Entrada', 20, 12.00),
(2, 'Entrada', 50, 8.00),
(3, 'Entrada', 10, 18.00),
(4, 'Salida', 5, 25.00),
(5, 'Entrada', 8, 15.50),
(6, 'Entrada', 20, 8.00),
(7, 'Entrada', 300, 2.50),
(8, 'Entrada', 10, 7.00),
(9, 'Salida', 5, 15.00),
(10, 'Entrada', 50, 9.00);


-- Agrega más datos según sea necesario


