#!/bin/bash

while [ ! "mysqladmin ping  -h'$DB_HOST' -P'$DB_PORT' -u'$DB_USER' -p'$DB_PASS' --silent" ] ; do
    echo "waiting for connection to the db..."
    sleep 1
done

echo $DB_HOST

if  [ ! -f "/var/www/html/wordpress/wp-config.php" ]; then

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
mkdir -p /var/www/html/wordpress
cd /var/www/html/wordpress
wp core download --allow-root --path='/var/www/html/wordpress'

wp config create --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASS" --dbhost="$DB_HOST" --dbprefix='wp_' --allow-root --path='/var/www/html/wordpress'
wp core install  --url="$URL" --title="$TITLE" --admin_user="$ADMIN_USER" --admin_password="$ADMINE_PASS" --admin_email="$ADMIN_EMAIL" --allow-root --path='/var/www/html/wordpress'
wp user create  "$USER_LOGIN" "yahya9@gmail.com" --role="$ROLE" --user_pass="$USER_PASS"   --allow-root --path='/var/www/html/wordpress'
fi

sed -i "s/^listen\s*=.*$/listen = $WP_PORT/" "$PHP_FPM_P"

php-fpm7.4 -F