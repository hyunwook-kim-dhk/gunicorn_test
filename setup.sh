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
python workshop/manage.py collectstatic --no-input
chown -R www-data ../

# setup nginx and gunicorn and mysql
# echo "----------[SETTING UP GUNICORN]--------"
# copy gucniron setting file
# service gunicorn restart
# echo "----------[SETTING UP NGINX]----------"
# cp ./nginx.conf /etc/nginx/sites-available/default
# service nginx restart
echo "----------[SETTING UP MYSQL]----------"
service mysql restart
mysql < setup.sql
