#!/usr/bin/bash
# install packages
echo "----------[INSTALLING PACKAGES]----------"
apt-get update -y && apt-get upgrade -y
apt-get install -y \
              python3.10-venv \
              nginx \
              mysql-client \
              mysql-server \
              python3-dev \
              default-libmysqlclient-dev \
              build-essential \
              uwsgi-plugin-python3 \
              uwsgi

# setup python
echo "----------[SETTING UP PYTHON]----------"
python3 -m venv ./venv
source ./venv/bin/activate
pip install -r ./requirements.pip
python guniprj/manage.py collectstatic --no-input
chown -R www-data ../
ln -s ~/gunicorn_test /var/www/gunicorn_test

# setup nginx and uwsgi and mysql
echo "----------[SETTING UP UWSGI]----------"
cp ./django_uwsgi.ini /etc/uwsgi/apps-enabled/django.ini
service uwsgi restart
echo "----------[SETTING UP NGINX]----------"
cp ./nginx.conf /etc/nginx/sites-available/default
service nginx restart
echo "----------[SETTING UP MYSQL]----------"
service mysql restart
mysql < setup.sql
