/*
	Restablecer contraseña root MySQL

	Si has perdido la contraseña de tu usuario root, no te preocupes, es posible restablecerla siguiendo los siguientes pasos.
	Si el servidor se encuentra en una maquina remota debemos de ingresar a esta mediante SSH Tutorial
*/

-- Lo primero que debemos de hacer es detener el servidor:

#	mysql.server stop
#	service mysqld stop
#	mysqld stop

-- Una vez el servidor se encuentre detenido, debemos de reiniciarlo en un modo seguro:
#	sudo mysqld_safe --skip-grant-tables --skip-networkin

-- --skip-grant-tables Permite conectarnos al servidor sin la necesidad de un password, además de otrogar todos los privilegios a la sesión.
-- --skip-networkin Detiene la escucha de peticiones TCP/IP

-- Ahora, en una nueva pestaña, debemos de conectarnos al servidor utilizando el usuario root:
#	mysql -u root

-- Una vez dentro del servidor, debemos de trabajar con la base de datos MySQL:
USE mysql;

-- Con el cambio de base de datos haremos la actualización:
UPDATE user SET password=PASSWORD('tu_password') WHERE user='root';

-- Si la actualización fue exitosa debemos de salir del servidor:
FLUSH PRIVILEGES;
exit

-- El paso final es detener el servidor en modo seguro. Iniciamos el servidor como te costumbre y nos autenticamos, la contraseña ya estará funcionando:
#	mysql -u root -p 