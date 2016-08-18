#!/bin/bash

echo "set uwsgi.py path: $1"
echo "set django path: $2"
echo "[program:django]" > /etc/supervisor/conf.d/django-supervisord.conf
echo "command=/usr/bin/uwsgi -s 127.0.0.1:9000 --file $1/wsgi.py --callable application --processes 2 -t 60 -M --need-app -b 32768" >> /etc/supervisor/conf.d/django-supervisord.conf
echo "directory=$2" >> /etc/supervisor/conf.d/django-supervisord.conf
echo "stopsignal=INT" >> /etc/supervisor/conf.d/django-supervisord.conf

echo "[program:nginx]" >> /etc/supervisor/conf.d/django-supervisord.conf
echo "command=/etc/init.d/nginx start" >> /etc/supervisor/conf.d/django-supervisord.conf
echo "stopsignal=INT" >> /etc/supervisor/conf.d/django-supervisord.conf

/etc/init.d/supervisord restart
