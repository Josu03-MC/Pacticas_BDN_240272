/* Creacion de usuarios remotos y asignacion de privilegios */
CREATE USER 'marco.ramirez'@'%' IDENTIFIED BY 'quwerty123';
CREATE USER 'josu.oloarte'@'%' IDENTIFIED BY '240272';
CREATE USER 'olovier.sanchez'@'%' IDENTIFIED BY '111111';
CREATE USER 'jonathan.leal'@'%' IDENTIFIED BY '111111';

/*Asignar los privilegios de superusuario*/
GRANT ALL PRIVILEGES ON *.* TO 'josu.oloarte'@'%';

/*Asignar los privilegios de lectura, escritura, actualizacion y eliminacion a los usuarios remotos*/
GRANT SELECT, INSERT, UPDATE, DELETE ON `db_test_7b`.* TO 'marco.ramirez'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON `db_test_7b`.* TO 'olovier.sanchez'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON `db_test_7b`.* TO 'jonathan.leal'@'%';

/*Creacio de roles y asignacion de privilegios a los roles*/
CREATE ROLE 'admin';
CREATE ROLE 'seller';
CREATE ROLE 'buyer';
CREATE ROLE 'guest';
CREATE ROLE 'support';
CREATE ROLE 'common';
CREATE ROLE 'user_not_registered';

/*Asignacion de privilegios a los roles*/
GRANT ALL PRIVILEGES ON db_test_7b TO 'admin';

GRANT 'admin' TO 'josu.oloarte'@'%';
GRANT 'support' TO 'olovier.sanchez'@'%';