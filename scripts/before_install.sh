#!/bin/bash

# Install curl and download keys
sudo apt-get update
sudo apt-get install curl -y

sudo curl http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
sudo echo deb http://packages.elasticsearch.org/elasticsearch/1.3/debian stable main > sudo /etc/apt/sources.list.d/elasticsearch.list

sudo curl http://nginx.org/keys/nginx_signing.key | sudo apt-key add -
sudo echo deb http://nginx.org/packages/ubuntu/ trusty nginx > sudo /etc/apt/sources.list.d/nginx.list

sudo echo deb http://packages.elasticsearch.org/logstash/1.4/debian stable main > sudo /etc/apt/sources.list.d/logstash.list

# Install ELK and nginx
sudo apt-get update
sudo apt-get install openjdk-7-jdk elasticsearch logstash=1.4.2-1-2c0f5a1 nginx -y

# Install Kibana
sudo mkdir /opt/kibana \
sudo curl -O https://download.elasticsearch.org/kibana/kibana/kibana-3.1.1.tar.gz \
sudo tar xvf kibana-3.1.1.tar.gz -C /opt/kibana --strip-components=1 \
sudo rm -f kibana-3.1.1.tar.gz

# Configure and start elasticsearch
sudo cp ~/elk/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml


### configure and start logstash

# cert/key
sudo mkdir -p /etc/pki/tls/certs
sudo mkdir /etc/pki/tls/private
sudo cp ~/elk/logstash-forwarder.crt /etc/pki/tls/certs/logstash-forwarder.crt
sudo cp ~/elk/logstash-forwarder.key /etc/pki/tls/private/logstash-forwarder.key

# filters
sudo cp ~/elk/01-logstash-input.conf /etc/logstash/conf.d/01-logstash-input.conf
sudo cp ~/elk/10-syslog.conf /etc/logstash/conf.d/10-syslog.conf
sudo cp ~/elk/11-nginx.conf /etc/logstash/conf.d/11-nginx.conf

# patterns
sudo cp ~/elk/nginx.pattern /opt/logstash/patterns/nginx
sudo chown logstash:logstash /opt/logstash/patterns/nginx

### configure kibana

sudo cp ~/elk/kibana-config.js /opt/kibana/config.js


### configure and start nginx

sudo cp ~/elk/nginx.conf /etc/nginx/nginx.conf
sudo echo "daemon off;" >> /etc/nginx/nginx.conf

sudo cp ~/elk/nginx-site.conf /etc/nginx/conf.d/default.conf

sudo cp ~/elk/start.sh /usr/local/bin/start.sh
sudo chmod +x /usr/local/bin/start.sh

# Start all the services

sudo service elasticsearch start
sudo service logstash start
sudo service nginx start