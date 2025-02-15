-- =============================================
-- Author:		Eduardo Madrigal Marin
-- Description:	Retrieves the sessions of the current month (PostgreSQL version)
-- =============================================

CREATE OR REPLACE FUNCTION FN_GetCurrentCalendar()
RETURNS TABLE (
    session_id INT,
    session_name VARCHAR(50),
    session_date DATE,
    start_time TIME,
    duration INT,
    available_spaces INT,
    session_cost DECIMAL(10,2),
    is_cancelled BOOLEAN,
    instructor_name VARCHAR(100),
    instructor_identification VARCHAR(20),
    instructor_email VARCHAR(100),
    instructor_type VARCHAR(50),
    service_name VARCHAR(50),
    service_type_cost DECIMAL(10,2),
    service_max_spaces INT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        cs.session_id,
        cs.name AS session_name,
        cs.session_date,
        cs.start_time,
        cs.duration,
        cs.available_spaces,
        cs.cost AS session_cost,
        cs.is_cancelled,
        cs.instructor_name,
        cs.instructor_identification,
        cs.instructor_email,
        cs.instructor_type,
        cs.service_name,
        cs.cost AS service_type_cost,
        cs.service_max_spaces
    FROM 
        complete_sessions cs
    WHERE 
        cs.session_date >= CURRENT_DATE;
END;
$$ LANGUAGE plpgsql;
