#!/bin/sh -ex

# wait for the app container to delete .app_is_ready and perform rsync, etc.
sleep 30

while ! pg_isready -h $DB_HOST -U $DB_USER; do
	echo waiting until $DB_HOST is ready...
	sleep 3
done

DST_DIR=/var/www/html/tt-rss

while [ ! -s $DST_DIR/config.php -a -e $DST_DIR/.app_is_ready ]; do
	echo waiting for app container...
	sleep 3
done

exec /usr/bin/php /var/www/html/tt-rss/update_daemon2.php