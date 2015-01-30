#!/bin/bash

# Configure and start elasticsearch
sudo cp ~/elk/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml

# configure logstash

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

### configure nginx
sudo cp ~/elk/nginx.conf /etc/nginx/nginx.conf
sudo echo "daemon off;" | sudo tee /etc/nginx/nginx.conf

sudo cp ~/elk/nginx-site.conf /etc/nginx/conf.d/default.conf
