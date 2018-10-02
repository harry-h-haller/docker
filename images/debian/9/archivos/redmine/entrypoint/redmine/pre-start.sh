#!/bin/bash

export REDMINE_VERSION="2.5.0"

if [ -z "$MYSQL_REDMINE_DATABASE" ]; then
    echo "[$(date +'%Y/%m/%d %H:%M:%S')] MYSQL_REDMINE_DATABASE not set";
    exit 1;
fi
if [ -z "$MYSQL_REDMINE_HOST" ]; then
    echo "[$(date +'%Y/%m/%d %H:%M:%S')] MYSQL_REDMINE_HOST not set";
    exit 1;
fi
if [ -z "$MYSQL_REDMINE_PORT" ]; then
    echo "[$(date +'%Y/%m/%d %H:%M:%S')] MYSQL_REDMINE_HOST not set";
    exit 1;
fi
if [ -z "$MYSQL_REDMINE_USERNAME" ]; then
    echo "[$(date +'%Y/%m/%d %H:%M:%S')] MYSQL_REDMINE_USERNAME not set";
    exit 1;
fi
if [ -z "$MYSQL_REDMINE_PASSWORD" ]; then
    echo "[$(date +'%Y/%m/%d %H:%M:%S')] MYSQL_REDMINE_PASSWORD not set";
    exit 1;
fi
if [ -z "$REDMINE_NETWORK_INTERFACE" ]; then
export REDMINE_NETWORK_INTERFACE="0.0.0.0"
fi
if [ -z "$REDMINE_NETWORK_PORT" ]; then
    export REDMINE_NETWORK_PORT="80"
fi

cd /opt/redmine-${REDMINE_VERSION}
[ ! -f /var/log/redmine.deployed ] && (
    echo "production:" > /opt/redmine-${REDMINE_VERSION}/config/database.yml 
    echo "  adapter: mysql2" >> /opt/redmine-${REDMINE_VERSION}/config/database.yml 
    echo "  database: $MYSQL_REDMINE_DATABASE" >> /opt/redmine-${REDMINE_VERSION}/config/database.yml 
    echo "  host: $MYSQL_REDMINE_HOST" >> /opt/redmine-${REDMINE_VERSION}/config/database.yml 
    echo "  port: $MYSQL_REDMINE_PORT" >> /opt/redmine-${REDMINE_VERSION}/config/database.yml 
    echo "  username: $MYSQL_REDMINE_USERNAME" >> /opt/redmine-${REDMINE_VERSION}/config/database.yml 
    echo "  password: $MYSQL_REDMINE_PASSWORD" >> /opt/redmine-${REDMINE_VERSION}/config/database.yml 
    echo "  encoding: utf8" >> /opt/redmine-${REDMINE_VERSION}/config/database.yml 

    gem install bundler
    bundle install --without development test
    gem install rdoc-data; rdoc-data --install
    bundle exec rake generate_secret_token
    RAILS_ENV=production bundle exec rake db:migrate
    RAILS_ENV=production bundle exec rake redmine:load_default_data

    touch /var/log/redmine.deployed
    chown root:root /var/log/redmine.deployed
    chmod 600 /var/log/redmine.deployed
)
