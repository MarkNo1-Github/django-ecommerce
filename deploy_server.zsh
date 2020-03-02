#!/usr/bin/env zsh
source ~/.zshrc


# Elevate Privilage
if [ $(id -u) != '0' ]; then
  sudo "$0" "$@"
  exit $?
fi

# Configuration
PORT=8000
IP=192.168.0.14
PLUME_SERVER_PATH=$(pwd)
# File to deploy
TEMPLATE_NGIX_PATH=${PLUME_SERVER_PATH}/misc/plume_website.conf
TEMPLATE_UWSGI_PATH=${PLUME_SERVER_PATH}/misc/plume_uwsgi.ini
FILE_NGIX_PATH=/etc/nginx/sites-available/plume_website.conf
FILE_UWSGI_PATH=${PLUME_SERVER_PATH}/uwsgi/plume_uwsgi.ini


echo "Deploying Server - v1"
echo "Path: $PLUME_SERVER_PATH"
echo "Ip: $IP"
echo "Port: $PORT"

symLink() { ln -s $1 $2}

Nothing(){}


# NGIX
echo "Configuring Ngix"
cp $TEMPLATE_NGIX_PATH $FILE_NGIX_PATH
Replace $FILE_NGIX_PATH @SERVER $PLUME_SERVER_PATH
Replace $FILE_NGIX_PATH @PORT $PORT
Replace $FILE_NGIX_PATH @IP $IP
# Make Symbolic Link if file dosen't
If isFile Nothing symLink $FILE_NGIX_PATH /etc/nginx/sites-enable



# UWSGI
echo "Configuring Uwsgi"
cp $TEMPLATE_UWSGI_PATH $FILE_UWSGI_PATH
Replace $FILE_UWSGI_PATH @SERVER $PLUME_SERVER_PATH
