-- Forma de Pago
INSERT INTO formadepago (id, nombre)
VALUES (1, 'Tarjeta');

-- Tipo Usuario
INSERT INTO tipousuario (id, nombre) VALUES 
    (1, 'Administrador'),
    (2, 'Cliente');

-- Conceptos de Cobro Fijos
-- INSERT INTO conceptosdecobrosfijos (id, nombre, monto) 
-- VALUES (1, 'Matrícula', 30000.0);

-- Tipo Instructor
INSERT INTO tipoinstructor (nombre) VALUES 
    ('planta'),
    ('temporal');

-- Tipo Movimiento
INSERT INTO tipomovimiento (id, nombre, escredito) VALUES 
    (1, 'Credito', true),
    (2, 'CobroFijo', false),
    (3, 'CobroPorReserva', false);

-- Sala
INSERT INTO sala (nombre, aforomaximo, costomatricula)
VALUES ('PlusGym2', 30, 36000.00);

-- Dia de Atencion
--INSERT INTO diaatencion (salaid, horaapertura, horacierre, diasemana)
--VALUES
--    (1, '05:30', '09:30', 1),
--    (1, '05:30', '09:30', 2),
--    (1, '05:30', '09:30', 3),
--    (1, '05:30', '09:30', 4),
--    (1, '05:30', '09:30', 5),
--    (1, '06:30', '09:30', 6),
--    (1, '06:30', '08:30', 7);

-- Usuario
INSERT INTO usuario (username, password, tipousuario)
VALUES 
    ('Admin1', '1234', 1),
    ('Cliente1', '1234', 2),
    ('Cliente2', '1234', 2);

-- Administrador
INSERT INTO administrador (nombre)
VALUES ('Jorge El Curioso');

-- Usuario Admin
INSERT INTO usuarioadmin (id, adminid)
VALUES (1, 1);

-- Cliente
INSERT INTO cliente (cedula, nombre, correo, celular, saldo)
VALUES 
    ('1100', 'Popeye', 'popeyeElMarino@gmail.com', '60009999', 0),
    ('1111', 'Cliente', 'cliente@gmail.com', '99999999', 0),
    ('118090772', 'Elclien T. Rodriguez', 'aaa@a.gmail', '+506 70560910', 0);

-- Notificaciones
--INSERT INTO notificaciones (message, date, time, clienteid)
--VALUES 
--    ('Prueba', '2021-08-19', '08:00', 1),
--    ('Prueba', '2021-08-19', '08:00', 1),
--    ('Aprovecha un 50% de descuento con el cupon: 100 EN PROGRA', '2021-08-19', '08:00', 1),
--    ('Recuerda pagar la membresía en cajas', '2021-08-19', '08:00', 1),
--    ('Bienvenido a GYM+', '2021-08-19', '08:00', 1),
--    ('Que tengas un buen día en GYM+', '2021-08-19', '08:00', 1);

-- Usuario Cliente
INSERT INTO usuariocliente (id, clienteid) VALUES 
    (2, 1),
    (3, 2);

-- Movimientos
INSERT INTO movimientos (monto, fecha, clienteid, tipomovimiento, asunto)
VALUES 
    (1000, CURRENT_TIMESTAMP, 1, 1, 'Mil colones de abono'),
    (2000, CURRENT_TIMESTAMP, 1, 1, 'Abono antes de la quincena');

-- Update Cliente Balance
UPDATE cliente
SET saldo = 3000
WHERE id = 1;

-- Credito
INSERT INTO credito (id, formadepagoid) VALUES 
    (1, 1),
    (2, 1);

-- Especialidades
INSERT INTO especialidades (nombre, aforo, costo) VALUES 
    ('Yoga', 15, 2000),
    ('Funcional', 20, 2000);

-- Servicios Favoritos
INSERT INTO serviciosfavoritos (clienteid, especialidadid)
VALUES (1, 1);

-- Instructor
INSERT INTO instructor (nombre, cedula, correo, tipo) VALUES 
    ('instructor1', '1234567', 'a@a.com', 1),
    ('instructor2', '762435', 'b@b.com', 1),
    ('instructor3', '55555', 'c@c.com', 2);

-- Especialidades de Instructores
INSERT INTO especialidadesdeinstructores (instructorid, especialidadid) VALUES
    (1, 1),
    (2, 2),
    (3, 2);

-- Sesion Preliminar
INSERT INTO sesionpreliminar 
    (nombre, diasemana, mes, año, horainicio, duracionminutos, cupo, especialidadid, salaid, instructorid) 
VALUES 
    ('Sesion de Yoga', 1, 8, 2021, '08:00', 120, 12, 1, 1, 1),
    ('Sesion de Funcional', 1, 8, 2021, '09:30', 120, 12, 2, 1, 2),
    ('Sesion de Yoga', 2, 8, 2021, '14:30', 120, 12, 1, 1, 1),
    ('Sesion de YogaMax', 3, 7, 2021, '10:00', 120, 12, 1, 1, 2),
    ('Sesion de FuncionalMax', 4, 7, 2021, '09:30', 120, 12, 2, 1, 1),
    ('Sesion de YogaPro', 4, 7, 2021, '14:30', 120, 12, 1, 1, 2);

-- Sesion
INSERT INTO sesion (fecha, costo, instructorid, sessionpreliminarid)
VALUES
    ('2021-08-31', 10, 1, 1),
    ('2021-08-30', 10, 2, 2),
    ('2021-07-27', 10, 1, 3),
    ('2021-07-29', 10, 1, 4);

-- Update Sesion Preliminar
UPDATE sesionpreliminar
SET confirmada = true
WHERE id <= 4;

-- Reserva
INSERT INTO reserva (fechareserva, clienteid, sesionid)
VALUES
    (CURRENT_TIMESTAMP, 1, 4),
    (CURRENT_TIMESTAMP, 1, 1),
    (CURRENT_TIMESTAMP, 2, 4);

-- Update Reserva Status
UPDATE reserva 
SET activa = false 
WHERE id = 2;

-- Additional Reservas for Observer Test
INSERT INTO reserva (fechareserva, clienteid, sesionid)
VALUES
    (CURRENT_TIMESTAMP, 3, 2),
    (CURRENT_TIMESTAMP, 1, 2),
    (CURRENT_TIMESTAMP, 1, 2),
    (CURRENT_TIMESTAMP, 1, 2),
    (CURRENT_TIMESTAMP, 1, 2),
    (CURRENT_TIMESTAMP, 1, 2),
    (CURRENT_TIMESTAMP, 1, 2),
    (CURRENT_TIMESTAMP, 1, 2),
    (CURRENT_TIMESTAMP, 1, 2),
    (CURRENT_TIMESTAMP, 1, 2),
    (CURRENT_TIMESTAMP, 1, 2),
    (CURRENT_TIMESTAMP, 1, 2);

-- Premios
INSERT INTO premios (nombre, estrellasnecesarias) VALUES 
    ('Bolso de Gym', 1),
    ('Botella', 1),
    ('Paño de Billete de 10,000', 1),
    ('Valoracion Nutricional', 2),
    ('Sesión de de Descarga Muscular', 3);

-- Estrellas Mensuales
INSERT INTO estrellasmensuales (clienteid, año, mes, semanadelmes , cantidad) VALUES
    (1, 2020, 1, 1, 3),
    (1, 2020, 1, 2, 3),
    (1, 2020, 1, 3, 1),
    (1, 2020, 1, 4, 3),
    (1, 2020, 2, 1, 3),
    (1, 2020, 2, 2, 3),
    (1, 2020, 2, 3, 3),
    (1, 2020, 2, 4, 3);

-- Premios Por Cliente
INSERT INTO premiosporcliente (clienteid, premioid, mes, año) VALUES
    (1, 1, 1, 2020),
    (2, 4, 1, 2020);

-- Additional Sesiones for Testing
INSERT INTO sesion (fecha, costo, instructorid, sessionpreliminarid)
VALUES
    ('2021-04-20', 10, 1, 1),
    ('2021-04-30', 10, 2, 2),
    ('2021-04-27', 10, 1, 3),
    ('2021-04-29', 10, 1, 4),
    ('2021-03-20', 10, 1, 1),
    ('2021-03-30', 10, 2, 2),
    ('2021-03-27', 10, 1, 3),
    ('2021-03-29', 10, 1, 4);

-- Additional Reservas
INSERT INTO reserva (fechareserva, clienteid, sesionid)
VALUES
    (CURRENT_TIMESTAMP, 3, 5),
    (CURRENT_TIMESTAMP, 1, 5),
    (CURRENT_TIMESTAMP, 2, 5),
    (CURRENT_TIMESTAMP, 3, 6),
    (CURRENT_TIMESTAMP, 1, 6),
    (CURRENT_TIMESTAMP, 2, 6),
    (CURRENT_TIMESTAMP, 3, 11),
    (CURRENT_TIMESTAMP, 1, 12);
