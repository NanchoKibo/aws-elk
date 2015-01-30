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
sudo mkdir /opt/kibana
sudo curl -O https://download.elasticsearch.org/kibana/kibana/kibana-3.1.1.tar.gz
sudo tar xvf kibana-3.1.1.tar.gz -C /opt/kibana --strip-components=1
sudo rm -f kibana-3.1.1.tar.gz
