#Crear base de datos
flanders@flanders-VirtualBox:~$ sudo -i -u postgres
postgres@flanders-VirtualBox:~$ createdb test01

#Listar base de datos
\l

#listar schemas
test01=> \dn
  List of schemas
  Name  |  Owner   
--------+----------
 public | postgres
(1 row)

test01=> 

#Conectarse a una Base de datos
postgres=# \c test01 
You are now connected to database "test01" as user "postgres".

#Listar Tablas
test01=# \dt
          List of relations
 Schema |   Name   | Type  |  Owner   
--------+----------+-------+----------
 public | usuarios | table | postgres
(1 row)

#Crear tablas
test01=# CREATE TABLE usuarios (
test01(# id INT, 
test01(# nombre VARCHAR (50) );
CREATE TABLE

#Insertar datos
INSERT INTO usuarios (id, nombre) VALUES ('01', 'Frank Fabra');
INSERT INTO users (id, nombre) VALUES ('10', 'Gordona');

#Consultar tabla
test01=# SELECT * FROM usuarios;
 id | nombre 
----+--------
(0 rows)

#Crear usuario
postgres=# create user homero with encrypted password 'simpsons';

#setear clave
postgres=# alter user homero with encrypted password 'simpsons';
ALTER ROLE

#PERMISOS
#grant all privileges
grant all privileges on database test01 to homero;

#remover usuario

1) Connecting to the database
\c mydatabase

2) Reassigning Ownership
REASSIGN OWNED BY ryan TO <newuser>;
Or/and just deleting the object
DROP OWNED BY homero;

3) Executing REVOKE PRIVILEGES
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM homero;
REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public FROM homero;
REVOKE ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public FROM homero;

4) Dropping the user
DROP USER homero;

-------------------------------------------------------------------

#Limitar el acceso al public schema
By default all public schemas will be available for regular (non-superuser) users. To prevent this, login as a superuser and issue a command:

REVOKE ALL ON DATABASE somedatabase FROM PUBLIC;

postgres=# REVOKE ALL ON DATABASE postgres FROM PUBLIC;
postgres=# REVOKE ALL ON DATABASE test01 FROM PUBLIC;

postgres@flanders-VirtualBox:~$ psql -U homero -h 127.0.0.1 -d postgres
Password for user homero: 
psql: error: FATAL:  permission denied for database "postgres"
DETAIL:  User does not have CONNECT privilege.
postgres@flanders-VirtualBox:~$ 

#Crear usuario
postgres=# create user lisa with encrypted password 'simpsons';

#permiso para conectar
GRANT CONNECT ON DATABASE test01 TO homero;

#Conectar a Base de Datos
psql -U homero -h 127.0.0.1 -d test01
psql -U homero -h 127.0.0.1 -d postgres

#readonly
CREATE ROLE readonly;
GRANT USAGE ON SCHEMA public TO readonly;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO readonly;
#otorgar readonly
GRANT readonly TO homero;

#readwrite
CREATE ROLE readwrite;
GRANT USAGE, CREATE ON SCHEMA public TO readwrite;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO readwrite;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO readwrite;

#ver secuencias
GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO readwrite;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT USAGE ON SEQUENCES TO readwrite;

#crear SP

CREATE PROCEDURE insertarusuarios(a int, b varchar)
LANGUAGE SQL
AS $$
INSERT INTO usuarios (id, nombre) VALUES (a, b);
$$;

CALL insertarusuarios(90, 'tony barhijo');
