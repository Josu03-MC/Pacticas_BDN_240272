/* =========================================================
   CREACIÓN DE USUARIOS
   ========================================================= */

CREATE USER IF NOT EXISTS 'marco.ramirez'@'%' IDENTIFIED BY 'quwerty123';
CREATE USER IF NOT EXISTS 'josu.oloarte'@'%' IDENTIFIED BY '240272';
CREATE USER IF NOT EXISTS 'olovier.sanchez'@'%' IDENTIFIED BY '111111';
CREATE USER IF NOT EXISTS 'jonathan.leal'@'%' IDENTIFIED BY '111111';
 CREATE USER IF NOT EXISTS 'user.good'@'%' IDENTIFIED BY '240272';


/* =========================================================
   CREACIÓN DE ROLES
   ========================================================= */
CREATE ROLE IF NOT EXISTS 'superadmin';
CREATE ROLE IF NOT EXISTS 'admin';
CREATE ROLE IF NOT EXISTS 'seller';
CREATE ROLE IF NOT EXISTS 'buyer';
CREATE ROLE IF NOT EXISTS 'support';
CREATE ROLE IF NOT EXISTS 'common';
CREATE ROLE IF NOT EXISTS 'guest';
CREATE ROLE IF NOT EXISTS 'user_not_registered';


/* =========================================================
   PRIVILEGIOS DE ADMIN 
   ========================================================= */

GRANT ALL PRIVILEGES
ON db_test_7b.*
TO 'admin';


/* =========================================================
   PRIVILEGIOS DE SELLER (maneja productos)
   ========================================================= */

GRANT SELECT, INSERT, UPDATE, DELETE
ON db_test_7b.tb_products
TO 'seller';


/* =========================================================
   PRIVILEGIOS DE SUPPORT (atiende usuarios y productos)
   ========================================================= */

GRANT SELECT, UPDATE, INSERT
ON db_test_7b.tb_users
TO 'support';

GRANT SELECT, UPDATE, INSERT
ON db_test_7b.tb_products
TO 'support';


/* =========================================================
   PRIVILEGIOS DE BUYER (solo consulta productos)
   ========================================================= */

GRANT SELECT
ON db_test_7b.tb_products
TO 'buyer';


/* =========================================================
   PRIVILEGIOS DE COMMON (solo lectura general)
   ========================================================= */

GRANT SELECT
ON db_test_7b.tb_products
TO 'common';


/* =========================================================
   PRIVILEGIOS TEMPORALES OTORGADOS DIRECTO (se quitan abajo)
   ========================================================= */

GRANT SELECT, INSERT, UPDATE, DELETE ON `db_test_7b`.* TO 'marco.ramirez'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON `db_test_7b`.* TO 'olovier.sanchez'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON `db_test_7b`.* TO 'jonathan.leal'@'%';


/* =========================================================
   QUITAR PRIVILEGIOS DIRECTOS (el control queda solo en el rol)
   ========================================================= */

REVOKE ALL PRIVILEGES, GRANT OPTION
FROM 'marco.ramirez'@'%';

REVOKE ALL PRIVILEGES, GRANT OPTION
FROM 'olovier.sanchez'@'%';

REVOKE ALL PRIVILEGES, GRANT OPTION
FROM 'jonathan.leal'@'%';


/* =========================================================
   ASIGNACIÓN DE ROLES
   ========================================================= */

/* JOSU = ADMIN */
GRANT 'admin' TO 'josu.oloarte'@'%';

/* MARCO (docente) = ADMIN */
GRANT 'admin' TO 'marco.ramirez'@'%';

/* OLIVER = SUPPORT */
GRANT 'support' TO 'olovier.sanchez'@'%';

/* JONATHAN = SELLER */
GRANT 'seller' TO 'jonathan.leal'@'%';


/* =========================================================
   ROLES POR DEFECTO
   ========================================================= */

SET DEFAULT ROLE 'admin' TO 'josu.oloarte'@'%';
SET DEFAULT ROLE 'admin' TO 'marco.ramirez'@'%';
SET DEFAULT ROLE 'support' TO 'olovier.sanchez'@'%';
SET DEFAULT ROLE 'seller' TO 'jonathan.leal'@'%';


/* =========================================================
   ACTUALIZAR PRIVILEGIOS
   ========================================================= */

FLUSH PRIVILEGES;


/* =========================================================
   COMPROBAR PRIVILEGIOS
   ========================================================= */

SHOW GRANTS FOR 'josu.oloarte'@'%';
SHOW GRANTS FOR 'marco.ramirez'@'%';
SHOW GRANTS FOR 'olovier.sanchez'@'%';
SHOW GRANTS FOR