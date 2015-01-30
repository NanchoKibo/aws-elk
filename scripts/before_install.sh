#!/bin/bash

sudo su

# Install curl and download keys
apt-get update
apt-get install curl -y

curl http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
echo deb http://packages.elasticsearch.org/elasticsearch/1.3/debian stable main > /etc/apt/sources.list.d/elasticsearch.list

curl http://nginx.org/keys/nginx_signing.key | apt-key add -
echo deb http://nginx.org/packages/ubuntu/ trusty nginx > /etc/apt/sources.list.d/nginx.list

echo deb http://packages.elasticsearch.org/logstash/1.4/debian stable main > /etc/apt/sources.list.d/logstash.list

# Install ELK and nginx
apt-get update
apt-get install openjdk-7-jdk elasticsearch logstash=1.4.2-1-2c0f5a1 nginx -y

# Install Kibana
mkdir /opt/kibana \
curl -O https://download.elasticsearch.org/kibana/kibana/kibana-3.1.1.tar.gz \
tar xvf kibana-3.1.1.tar.gz -C /opt/kibana --strip-components=1 \
rm -f kibana-3.1.1.tar.gz

# Configure and start elasticsearch
cp ~/elk/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml


### configure and start logstash

# cert/key
mkdir -p /etc/pki/tls/certs
mkdir /etc/pki/tls/private
cp ~/elk/logstash-forwarder.crt /etc/pki/tls/certs/logstash-forwarder.crt
cp ~/elk/logstash-forwarder.key /etc/pki/tls/private/logstash-forwarder.key

# filters
cp ~/elk/01-logstash-input.conf /etc/logstash/conf.d/01-logstash-input.conf
cp ~/elk/10-syslog.conf /etc/logstash/conf.d/10-syslog.conf
cp ~/elk/11-nginx.conf /etc/logstash/conf.d/11-nginx.conf

# patterns
cp ~/elk/nginx.pattern /opt/logstash/patterns/nginx
chown logstash:logstash /opt/logstash/patterns/nginx

### configure kibana

cp ~/elk/kibana-config.js /opt/kibana/config.js


### configure and start nginx

cp ~/elk/nginx.conf /etc/nginx/nginx.conf
echo "daemon off;" >> /etc/nginx/nginx.conf

cp ~/elk/nginx-site.conf /etc/nginx/conf.d/default.conf

cp ~/elk/start.sh /usr/local/bin/start.sh
chmod +x /usr/local/bin/start.sh

# Start all the services

service elasticsearch start
service logstash start
service nginx start