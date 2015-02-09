#!/bin/bash

# Add ELK repositories
sudo wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
sudo echo 'deb http://packages.elasticsearch.org/logstash/1.4/debian stable main' | sudo tee /etc/apt/sources.list.d/logstash.list

sudo wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
sudo echo 'deb http://packages.elasticsearch.org/elasticsearch/1.0/debian stable main' | sudo tee /etc/apt/sources.list.d/elasticsearch.list

sudo apt-get update

# Install Java, Elasticsearch, Logstash and Nginx
sudo apt-get install -y openjdk-7-jre
sudo apt-get install -y logstash
sudo apt-get install -y elasticsearch
sudo apt-get install -y nginx

# Add Elasticsearch as a service
sudo update-rc.d elasticsearch defaults 95 10

# Install Kibana
sudo mkdir /opt/kibana
sudo mkdir /opt/kibana/kibana3
sudo mkdir /opt/kibana/kibana4

sudo curl -O https://download.elasticsearch.org/kibana/kibana/kibana-3.1.1.tar.gz
sudo tar xvf kibana-3.1.1.tar.gz -C /opt/kibana3 --strip-components=1
sudo rm -f kibana-3.1.1.tar.gz

sudo curl -O https://download.elasticsearch.org/kibana/kibana/kibana-4.0.0-beta3.tar.gz
sudo tar xvf kibana-4.0.0-beta3.tar.gz -C /opt/kibana4 --strip-components=1
sudo rm -f kibana-4.0.0-beta3.tar.gz
