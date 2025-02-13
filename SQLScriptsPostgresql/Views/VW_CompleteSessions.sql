CREATE OR REPLACE VIEW complete_sessions AS
SELECT 
    session.id AS session_id,
    session.fecha AS session_date,
    session.cancelada AS is_cancelled,
    session.asistenciataken AS attendance_taken,
    
    preliminary_session.nombre AS name,
    preliminary_session.cupo AS spaces,
    preliminary_session.duracionminutos AS duration,
    preliminary_session.horainicio AS start_time,
    
    service.id AS service_id,
    service.nombre AS service_name,
    service.aforo AS service_max_spaces,
    service.costo AS cost,

    instructor.id AS instructor_id,
    instructor.nombre AS instructor_name,
    instructor.cedula AS instructor_identification,
    instructor.correo AS instructor_email,

    instructor_type.id AS instructor_type_id,
    instructor_type.nombre AS instructor_type,

    room.id AS room_id,
    room.nombre AS room_name,

    COALESCE(preliminary_session.cupo - r.bookings, preliminary_session.cupo) AS available_spaces
FROM 
    sesion AS session
INNER JOIN 
    sesionpreliminar AS preliminary_session ON preliminary_session.id = session.sessionpreliminarid
INNER JOIN 
    especialidades AS service ON service.id = preliminary_session.especialidadid
INNER JOIN
    instructor ON instructor.id = session.instructorid
INNER JOIN
    tipoinstructor AS instructor_type ON instructor.tipo = instructor_type.id
INNER JOIN 
    sala AS room ON room.id = preliminary_session.salaid
LEFT JOIN (
    SELECT sesionid, COUNT(sesionid) AS bookings 
    FROM reserva
    WHERE activa = true
    GROUP BY sesionid
) AS r ON r.sesionid = session.id;

-- Example query:
-- SELECT * FROM complete_sessions; 