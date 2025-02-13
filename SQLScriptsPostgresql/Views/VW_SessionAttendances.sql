CREATE OR REPLACE VIEW session_attendances AS
SELECT 
    booking.clienteid AS client_id,
    EXTRACT(YEAR FROM session.session_date) AS year,
    EXTRACT(MONTH FROM session.session_date) AS month,
    CASE
        WHEN EXTRACT(DAY FROM session.session_date) BETWEEN 1 AND 7 THEN 1
        WHEN EXTRACT(DAY FROM session.session_date) BETWEEN 8 AND 14 THEN 2
        WHEN EXTRACT(DAY FROM session.session_date) BETWEEN 15 AND 21 THEN 3
        ELSE 4
    END AS week_of_month,
    session.service_id,
    session.session_id
FROM 
    complete_sessions AS session
INNER JOIN
    reserva AS booking ON booking.sesionid = session.session_id
WHERE 
    booking.asistencia = true;

-- Example query:
-- SELECT * FROM session_attendances; 