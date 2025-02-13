CREATE OR REPLACE VIEW complete_users AS
SELECT 
    usr.username,
    usr.id AS user_id,
    usr.password,
    usr.activo AS active,
    type.id AS type_id,
    type.nombre AS type,
    client.id AS unique_identifier,
    client.nombre AS name
FROM 
    usuario AS usr
INNER JOIN 
    tipousuario AS type ON type.id = usr.tipousuario
INNER JOIN 
    usuariocliente AS client_user ON usr.id = client_user.id
INNER JOIN 
    cliente AS client ON client_user.clienteid = client.id

UNION ALL

SELECT 
    usr.username,
    usr.id AS user_id,
    usr.password,
    usr.activo AS active,
    type.id AS type_id,
    type.nombre AS type,
    admin.id AS unique_identifier,
    admin.nombre AS name
FROM 
    usuario AS usr
INNER JOIN 
    tipousuario AS type ON type.id = usr.tipousuario
INNER JOIN 
    usuarioadmin AS admin_user ON usr.id = admin_user.id
INNER JOIN 
    administrador AS admin ON admin_user.id = admin.id;

-- Example query:
-- SELECT * FROM complete_users; 