-- =============================================
-- Author:		Eduardo Madrigal Marin
-- Description:	Adds a service to an instructor (PostgreSQL version)
-- =============================================

CREATE OR REPLACE FUNCTION FN_AddServiceToInstructor(
    p_instructor_number INT,
    p_service_number INT
) RETURNS INT AS $$
DECLARE
    v_instructor_id INT;
    v_service_id INT;
    v_instructor_service_id INT;
    
    -- Error codes
    v_sp_error_code CONSTANT INT := -50001;
    v_instructor_not_found_error_code CONSTANT INT := -50008;
    v_service_not_found CONSTANT INT := -50019;
    v_service_already_offered CONSTANT INT := -50021;
BEGIN
    -- Check if instructor exists and is active
    SELECT id INTO v_instructor_id
    FROM instructor
    WHERE id = p_instructor_number AND active = true;
    
    IF v_instructor_id IS NULL THEN
        RETURN v_instructor_not_found_error_code;
    END IF;

    -- Check if service exists and is active
    SELECT id INTO v_service_id
    FROM services
    WHERE id = p_service_number AND active = true;
    
    IF v_service_id IS NULL THEN
        RETURN v_service_not_found;
    END IF;

    -- Check if instructor already offers this service
    SELECT id INTO v_instructor_service_id
    FROM instructor_services
    WHERE service_id = p_service_number 
    AND instructor_id = p_instructor_number;
    
    IF v_instructor_service_id IS NOT NULL THEN
        RETURN v_service_already_offered;
    END IF;

    -- Add service to instructor
    INSERT INTO instructor_services (instructor_id, service_id)
    VALUES (p_instructor_number, p_service_number);

    RETURN 1;

EXCEPTION
    WHEN OTHERS THEN
        RETURN v_sp_error_code;
END;
$$ LANGUAGE plpgsql; 