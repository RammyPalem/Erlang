#!/bin/bash

# Set installation directories
PGADMIN_DIR="/data/pgadmin/pgadmin4"
VENV_DIR="$PGADMIN_DIR/venv"
UWSGI_DIR="$VENV_DIR/bin/uwsgi"

# Install dependencies
sudo apt-get update
sudo apt-get install -y python3-pip python3-venv uwsgi uwsgi-plugin-python3

# Create necessary directories
sudo mkdir -p $PGADMIN_DIR
sudo chown -R $USER:$USER $PGADMIN_DIR

# Install pgAdmin4 in the specified directory
pip install pgadmin4==6.2 --target $PGADMIN_DIR

# Create custom configuration file
sudo touch $PGADMIN_DIR/config_local.py
sudo bash -c 'cat <<EOF > $PGADMIN_DIR/config_local.py
SECURE_BROWSER_XSS_FILTER = False
SECURE_CONTENT_TYPE_NOSNIFF = False
DATA_DIRECTORY = "$PGADMIN_DIR/data"
SQLITE_PATH = "$PGADMIN_DIR/sqlite/pgadmin4.db"
SESSION_DB_PATH = "$PGADMIN_DIR/sessions"
LOG_FILE = "$PGADMIN_DIR/log/pgadmin4.log"
STORAGE_DIR = "$PGADMIN_DIR/storage"
SERVER_RUNTIME = 15
CONSOLE_LOG_LEVEL = 30
EMAIL_SERVER = "localhost"
EMAIL_PORT = 25
SHOW_PASSWORD_REQUIREMENTS = False
MAIL_DEBUG = False
from pgadmin.utils import DRIVER_MANAGER
SERVERS = {
    "1": {
        "NAME": "AWS RDS PostgreSQL",
        "HOST": "lwm2m-rds-prd.c2lfk2sxprhp.us-east-1.rds.amazonaws.com",
        "PORT": 5432,
        "SSL_MODE": True,
        "ALLOW_SAVE_PASSWORD": False,
        "CONNECT_TIMEOUT": 15,
        "BACKEND": "1",
    },
};
SERVER_MODE = False
DEFAULT_SERVER = "0.0.0.0"
SERVER_NAME = "lwm2m-dtpgadmin-internal.mediasearch.verizon.com"
ALLOWED_HOSTS = ["*"]
SESSION_COOKIE_SECURE = False
EOF'

# Adjust ownership and permissions
sudo chown -R $USER:$USER $PGADMIN_DIR
sudo chmod -R 755 $PGADMIN_DIR

# Start uWSGI
$UWSGI_DIR --http :5050 --virtualenv $VENV_DIR --module pgadmin4:app --callable app --logto $PGADMIN_DIR/uwsgi.log --logto2 $PGADMIN_DIR/debug.log