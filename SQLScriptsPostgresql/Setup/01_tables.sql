-- Table creation scripts converted from Drop&Create.sql 

-- Drop tables if they exist (in correct order due to dependencies)
DROP TABLE IF EXISTS PremiosPorCliente CASCADE;
DROP TABLE IF EXISTS EstrellasMensuales CASCADE;
DROP TABLE IF EXISTS Premios CASCADE;
DROP TABLE IF EXISTS Reserva CASCADE;
DROP TABLE IF EXISTS Sesion CASCADE;
DROP TABLE IF EXISTS SesionPreliminar CASCADE;
DROP TABLE IF EXISTS EspecialidadesDeInstructores CASCADE;
DROP TABLE IF EXISTS Instructor CASCADE;
DROP TABLE IF EXISTS ServiciosFavoritos CASCADE;
DROP TABLE IF EXISTS Especialidades CASCADE;
DROP TABLE IF EXISTS Credito CASCADE;
DROP TABLE IF EXISTS Movimientos CASCADE;
DROP TABLE IF EXISTS UsuarioCliente CASCADE;
DROP TABLE IF EXISTS Notificaciones CASCADE;
DROP TABLE IF EXISTS Cliente CASCADE;
DROP TABLE IF EXISTS UsuarioAdmin CASCADE;
DROP TABLE IF EXISTS Administrador CASCADE;
DROP TABLE IF EXISTS Usuario CASCADE;
DROP TABLE IF EXISTS DiaDeAtencion CASCADE;
DROP TABLE IF EXISTS Sala CASCADE;
DROP TABLE IF EXISTS TipoMovimiento CASCADE;
DROP TABLE IF EXISTS TipoInstructor CASCADE;
DROP TABLE IF EXISTS ConceptosDeCobroFijos CASCADE;
DROP TABLE IF EXISTS TipoUsuario CASCADE;
DROP TABLE IF EXISTS FormaDePago CASCADE;

-- Create tables
CREATE TABLE FormaDePago (
    Id SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL
);

CREATE TABLE TipoUsuario (
    Id SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL
);

CREATE TABLE ConceptosDeCobroFijos (
    Id SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Monto DECIMAL(10,2) NOT NULL
);

CREATE TABLE TipoInstructor (
    Id SERIAL PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL
);

CREATE TABLE TipoMovimiento (
    Id SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    EsCredito BOOLEAN NOT NULL
);

CREATE TABLE Sala (
    Id SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    AforoMaximo INTEGER NOT NULL,
    CostoMatricula DECIMAL(10,2) NOT NULL
);

CREATE TABLE DiaDeAtencion (
    Id SERIAL PRIMARY KEY,
    SalaId INTEGER REFERENCES Sala(Id),
    HoraApertura TIME NOT NULL,
    HoraCierre TIME NOT NULL,
    DiaSemana INTEGER NOT NULL
);

CREATE TABLE Usuario (
    Id SERIAL PRIMARY KEY,
    Username VARCHAR(100) NOT NULL UNIQUE,
    Password VARCHAR(100) NOT NULL,
    TipoUsuario INTEGER REFERENCES TipoUsuario(Id)
);

CREATE TABLE Administrador (
    Id SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL
);

CREATE TABLE UsuarioAdmin (
    Id INTEGER PRIMARY KEY REFERENCES Usuario(Id),
    AdminId INTEGER REFERENCES Administrador(Id)
);

CREATE TABLE Cliente (
    Id SERIAL PRIMARY KEY,
    Cedula VARCHAR(20) NOT NULL UNIQUE,
    Nombre VARCHAR(100) NOT NULL,
    Correo VARCHAR(100) NOT NULL,
    Celular VARCHAR(20) NOT NULL,
    Saldo DECIMAL(10,2) DEFAULT 0
);

CREATE TABLE Notificaciones (
    Id SERIAL PRIMARY KEY,
    Message TEXT NOT NULL,
    Date DATE NOT NULL,
    Time TIME NOT NULL,
    ClienteId INTEGER REFERENCES Cliente(Id)
);

CREATE TABLE UsuarioCliente (
    Id INTEGER PRIMARY KEY REFERENCES Usuario(Id),
    ClienteId INTEGER REFERENCES Cliente(Id)
);

CREATE TABLE Movimientos (
    Id SERIAL PRIMARY KEY,
    Monto DECIMAL(10,2) NOT NULL,
    Fecha TIMESTAMP NOT NULL,
    ClienteId INTEGER REFERENCES Cliente(Id),
    TipoMovimiento INTEGER REFERENCES TipoMovimiento(Id),
    Asunto VARCHAR(200) NOT NULL
);

CREATE TABLE Credito (
    Id INTEGER PRIMARY KEY REFERENCES Movimientos(Id),
    FormaDePagoId INTEGER REFERENCES FormaDePago(Id)
);

CREATE TABLE Especialidades (
    Id SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Aforo INTEGER NOT NULL,
    Costo DECIMAL(10,2) NOT NULL
);

CREATE TABLE ServiciosFavoritos (
    Id SERIAL PRIMARY KEY,
    ClienteId INTEGER REFERENCES Cliente(Id),
    EspecialidadId INTEGER REFERENCES Especialidades(Id)
);

CREATE TABLE Instructor (
    Id SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Cedula VARCHAR(20) NOT NULL UNIQUE,
    Correo VARCHAR(100) NOT NULL,
    Tipo INTEGER REFERENCES TipoInstructor(Id)
);

CREATE TABLE EspecialidadesDeInstructores (
    Id SERIAL PRIMARY KEY,
    InstructorId INTEGER REFERENCES Instructor(Id),
    EspecialidadId INTEGER REFERENCES Especialidades(Id)
);

CREATE TABLE SesionPreliminar (
    Id SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    DiaSemana INTEGER NOT NULL,
    Mes INTEGER NOT NULL,
    Año INTEGER NOT NULL,
    HoraInicio TIME NOT NULL,
    DuracionMinutos INTEGER NOT NULL,
    Cupo INTEGER NOT NULL,
    EspecialidadId INTEGER REFERENCES Especialidades(Id),
    SalaId INTEGER REFERENCES Sala(Id),
    InstructorId INTEGER REFERENCES Instructor(Id),
    Confirmada BOOLEAN DEFAULT FALSE
);

CREATE TABLE Sesion (
    Id SERIAL PRIMARY KEY,
    Fecha DATE NOT NULL,
    Costo DECIMAL(10,2) NOT NULL,
    InstructorId INTEGER REFERENCES Instructor(Id),
    SessionPreliminarId INTEGER REFERENCES SesionPreliminar(Id)
);

CREATE TABLE Reserva (
    Id SERIAL PRIMARY KEY,
    FechaReserva TIMESTAMP NOT NULL,
    ClienteId INTEGER REFERENCES Cliente(Id),
    SesionId INTEGER REFERENCES Sesion(Id),
    Activa BOOLEAN DEFAULT TRUE
);

CREATE TABLE Premios (
    Id SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    EstrellasNecesarias INTEGER NOT NULL
);

CREATE TABLE EstrellasMensuales (
    Id SERIAL PRIMARY KEY,
    ClienteId INTEGER REFERENCES Cliente(Id),
    Año INTEGER NOT NULL,
    Mes INTEGER NOT NULL,
    SemanaDelMes INTEGER NOT NULL,
    Cantidad INTEGER NOT NULL
);

CREATE TABLE PremiosPorCliente (
    Id SERIAL PRIMARY KEY,
    ClienteId INTEGER REFERENCES Cliente(Id),
    PremioId INTEGER REFERENCES Premios(Id),
    Mes INTEGER NOT NULL,
    Año INTEGER NOT NULL
); 
