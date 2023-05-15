CREATE DATABASE gunicorn_test;
USE mysql;
CREATE USER 'root'@'%' identified BY 'root';
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';
UPDATE user SET plugin='mysql_native_password' WHERE user='root';
GRANT ALL PRIVILEGES ON *.* to 'root'@'%';
flush privileges;
