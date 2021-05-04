USE PlusGymProject

INSERT INTO FormaDePago (Id, Nombre)
VALUES (1, 'Tarjeta');

INSERT INTO TipoUsuario (Id, Nombre)
VALUES (1, 'Administrador');
INSERT INTO TipoUsuario (Id, Nombre)
VALUES (2, 'Cliente');

INSERT INTO dbo.TipoInstructor VALUES ('planta'),('temporal');

INSERT INTO TipoMovimiento (Id, Nombre)
VALUES (1, 'Credito');

INSERT INTO Usuario (Username, [Password], TipoUsuario)
VALUES ('Admin1',1234,1);

INSERT INTO Usuario (Username, [Password], TipoUsuario)
VALUES ('Cliente1',1234,2);

INSERT INTO Usuario (Username, [Password], TipoUsuario)
VALUES ('Cliente2',1234,2);

INSERT INTO UsuarioAdmin (Id, Nombre)
VALUES (1, 'Jorge El Curioso');

INSERT INTO Cliente (Cedula,Nombre,Correo,Celular)
    VALUES 
    ('1100','Popeye','popeyeElMarino@gmail.com','60009999'),
    ('1111','Cliente','cliente@gmail.com','99999999');

insert into
    dbo.Cliente (Cedula, Nombre, Correo, Celular)
VALUES
    ('118090772', 'Elclien T. Rodriguez', 'aaa@a.gmail', '+506 70560910')

INSERT INTO UsuarioCliente (Id, ClienteId)
VALUES (2, 1);

INSERT INTO dbo.UsuarioCliente (Id, ClienteId)
VALUES(3,2);
-- Id varia segun tabla Usuario

INSERT INTO Movimientos (Monto, Fecha, ClienteId,TipoMovimiento,Asunto)
VALUES (1000,GETDATE(),1,1, 'Mil colones de abono');
INSERT INTO Movimientos (Monto, Fecha, ClienteId,TipoMovimiento,Asunto)
VALUES (2000,GETDATE(),1,1, 'Abono antes de la quincena');

UPDATE Cliente
SET Saldo=3000
WHERE Id=1

INSERT INTO Credito (Id,FormaDePagoId)
VALUES (1,1);
INSERT INTO Credito (Id,FormaDePagoId)
VALUES (2,1);


insert into 
    dbo.Especialidades (Nombre, Aforo) 
values 
    ('Yoga', 15), 
    ('Funcional', 20)

insert into 
    dbo.Instructor (Nombre, Cedula, Correo, Tipo) 
values 
    ('instructor1', '1234567', 'a@a.com', 1), 
    ('instructor2', '762435', 'b@b.com', 1), 
    ('instructor3', '55555', 'c@c.com', 2)

INSERT INTO EspecialidadesDeInstructores (InstructorId,EspecialidadId)
VALUES(1,1);
INSERT INTO EspecialidadesDeInstructores (InstructorId,EspecialidadId)
VALUES(2,2);

insert INTO
    dbo.Sala (nombre,AforoMaximo, CostoMatricula)
VALUES
    ('PlusGym', 30, 36000.00)

insert into 
    dbo.Sesion (Nombre, Fecha, HoraInicio, DuracionMinutos, Cupo, Costo, InstructorId, EspecialidadId, SalaId) 
values 
    ('Sesion de Yoga', CONVERT(DATE, '2021-04-25'), CONVERT(TIME, '8:00'), 120, 12, 5000.00, 1, 1, 1),
    ('Sesion de Funcional', CONVERT(DATE, '2021-04-25'), CONVERT(TIME, '9:30'), 120, 12, 5000.00, 2, 2, 1),
    ('Sesion de Yoga', CONVERT(DATE, '2021-04-26'), CONVERT(TIME, '14:30'), 120, 12, 5000.00, 3, 1, 1)

insert into 
    dbo.Sesion (Nombre, Fecha, HoraInicio, DuracionMinutos, Cupo, Costo, InstructorId, EspecialidadId, SalaId) 
values 
    ('Sesion de YogaMax', CONVERT(DATE, '2021-05-10'), CONVERT(TIME, '10:00'), 120, 12, 5000.00, 1, 1, 1),
    ('Sesion de FuncionalMax', CONVERT(DATE, '2021-05-01'), CONVERT(TIME, '9:30'), 120, 12, 5000.00, 2, 2, 1),
    ('Sesion de YogaPro', CONVERT(DATE, '2021-05-15'), CONVERT(TIME, '14:30'), 120, 12, 5000.00, 3, 1, 1)

INSERT INTO
    dbo.Reserva(FechaReserva,ClienteId,SesionId)
    values
        (GETDATE(),1,4),
        (GETDATE(),1,5),
        (GETDATE(),1,1),
        (GETDATE(),2,4),
        (GETDATE(),2,5);

UPDATE dbo.Reserva 
    SET Activa = 0 
    WHERE Id = 2;