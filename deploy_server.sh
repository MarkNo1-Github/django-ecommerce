#! /bin/bash

# Configuration
PORT=8000
IP=192.168.0.16
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

replace() {
    local search=$1
    local replace=$2
    local file=$3
    sed -i "s~${search}~${replace}~" $file

}

# NGIX
cp $TEMPLATE_NGIX_PATH $FILE_NGIX_PATH
replace @SERVER $PLUME_SERVER_PATH $FILE_NGIX_PATH
replace @PORT $PORT $FILE_NGIX_PATH
replace @IP $IP $FILE_NGIX_PATH
# Make Symbolic Link
ln -s $FILE_NGIX_PATH /etc/nginx/sites-enable


# UWSGI
cp $TEMPLATE_UWSGI_PATH $FILE_UWSGI_PATH
replace @SERVER $PLUME_SERVER_PATH $FILE_UWSGI_PATH
