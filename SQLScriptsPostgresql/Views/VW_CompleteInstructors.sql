CREATE OR REPLACE VIEW complete_instructors AS
SELECT 
    instructor.id AS instructor_id,
    instructor.nombre AS instructor_name,
    instructor.correo AS instructor_email,
    instructor.cedula AS instructor_identification,
    instructor.activo AS active,
    type.id AS type_id,
    type.nombre AS type
FROM 
    instructor
INNER JOIN 
    tipoinstructor AS type ON type.id = instructor.tipo;

-- Example query:
-- SELECT * FROM complete_instructors; 