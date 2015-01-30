#!/bin/bash

# Install curl and download keys
sudo apt-get update
sudo apt-get install curl

curl http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
echo deb http://packages.elasticsearch.org/elasticsearch/1.3/debian stable main > /etc/apt/sources.list.d/elasticsearch.list

curl http://nginx.org/keys/nginx_signing.key | apt-key add -
echo deb http://nginx.org/packages/ubuntu/ trusty nginx > /etc/apt/sources.list.d/nginx.list

echo deb http://packages.elasticsearch.org/logstash/1.4/debian stable main > /etc/apt/sources.list.d/logstash.list

# Install ELK and nginx
sudo apt-get update
sudo apt-get install openjdk-7-jdk elasticsearch logstash=1.4.2-1-2c0f5a1 nginx

# Install Kibana
mkdir /opt/kibana \
curl -O https://download.elasticsearch.org/kibana/kibana/kibana-3.1.1.tar.gz \
tar xvf kibana-3.1.1.tar.gz -C /opt/kibana --strip-components=1 \
rm -f kibana-3.1.1.tar.gz

# Configure and start elasticsearch
cp /home/ubuntu/elk/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml


### configure and start logstash

# cert/key
sudo mkdir -p /etc/pki/tls/certs
sudo mkdir /etc/pki/tls/private
sudo cp /home/ubuntu/elk/logstash-forwarder.crt /etc/pki/tls/certs/logstash-forwarder.crt
sudo cp /home/ubuntu/elk/logstash-forwarder.key /etc/pki/tls/private/logstash-forwarder.key

# filters
sudo cp /home/ubuntu/elk/01-logstash-input.conf /etc/logstash/conf.d/01-logstash-input.conf
sudo cp /home/ubuntu/elk/10-syslog.conf /etc/logstash/conf.d/10-syslog.conf
sudo cp /home/ubuntu/elk/11-nginx.conf /etc/logstash/conf.d/11-nginx.conf

# patterns
sudo cp /home/ubuntu/elk/nginx.pattern /opt/logstash/patterns/nginx
sudo chown logstash:logstash /opt/logstash/patterns/nginx

### configure kibana

sudo cp /home/ubuntu/elk/kibana-config.js /opt/kibana/config.js


### configure and start nginx

sudo cp /home/ubuntu/elk/nginx.conf /etc/nginx/nginx.conf
echo "daemon off;" >> /etc/nginx/nginx.conf

sudo cp /home/ubuntu/elk/nginx-site.conf /etc/nginx/conf.d/default.conf

sudo cp /home/ubuntu/elk/start.sh /usr/local/bin/start.sh
sudo chmod +x /usr/local/bin/start.sh

# Start all the services

service elasticsearch start
service logstash start
service nginx start