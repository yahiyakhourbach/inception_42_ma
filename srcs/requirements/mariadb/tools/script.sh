#!/bin/bash

sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

service mariadb start


DB="CREATE DATABASE IF NOT EXISTS $DB_NAME ;"
USR="CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS' ;"
GRT="GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' ;"
ALT="ALTER USER root@localhost IDENTIFIED BY '$DB_ROOT_PASS' ;"
FL="FLUSH PRIVILEGES;"

echo $DB $USR $GRT $ALT $FL > tmp.sql

mariadb < tmp.sql

