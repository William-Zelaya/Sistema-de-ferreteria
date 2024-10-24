CREATE TABLE [security].Usuario(
    IdUsuario INT IDENTITY(1,1) UNIQUE NOT NULL,
    Usuario NVARCHAR(100) NOT NULL,
	Contrasena NVARCHAR (100) NOT NULL,
    IdEmpleado INT NOT NULL,
    IdTipoUsuario INT NOT NULL,
    Activo BIT NOT NULL DEFAULT 1,
    CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedBy NVARCHAR(100) NOT NULL DEFAULT SUSER_NAME(),
    UpdateDate DATETIME,
    UpdatedBy NVARCHAR(100)
    CONSTRAINT PK_USUARIO PRIMARY KEY(IdUsuario),
    CONSTRAINT FK_EMPLEADO FOREIGN KEY(IdEmpleado) REFERENCES business.Empleado(IdEmpleado)
)

SELECT * FROM security.Usuario

SELECT * FROM security.TipoUsuario

SELECT * FROM business.Empleado

INSERT INTO security.TipoUsuario(Nombre, Descripcion, Activo)
VALUES('Administrador','Usuario que administra todo el sistema',1)

INSERT INTO security.TipoUsuario(Nombre, Descripcion, Activo)
VALUES('Usuario','usuario estandar sin permisos de administracion',1)

INSERT INTO business.Empleado(Nombre, Direccion, Puesto, Carnet, Telefono)
VALUES('MARCOS BARRERA','EL TREBOL SANTA ANA','SUPERVISOR','BE10000','22577777')

INSERT INTO security.Usuario(Usuario,Contrasena,IdEmpleado,IdTipoUsuario,Activo)
VALUES('mbarrera','EstaEsMiContra123!',1,1,1)

SELECT COUNT(1) AS USER_EXISTS
FROM [security].Usuario
WHERE Usuario = 'mbarrera'
AND Contrasena = 'EstaEsMiContra123!'