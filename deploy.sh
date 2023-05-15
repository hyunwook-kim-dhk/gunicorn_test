#!/bin/bash
echo "git fetch -p"
git fetch -p

echo "git checkout master"
git checkout master

echo "git merge --ff-only origin/master"
git merge --ff-only origin/master

python ~/workshop_dashboard/workshop/manage.py collectstatic --no-input

echo "service uwsgi restart"
service uwsgi restart
echo "service nginx restart"
service nginx restart
