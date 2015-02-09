#!/bin/bash

# Add ELK repositories
sudo wget -qO - https://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
sudo echo 'deb http://packages.elasticsearch.org/logstash/1.4/debian stable main' | sudo tee /etc/apt/sources.list.d/logstash.list
sudo echo 'deb http://packages.elasticsearch.org/elasticsearch/1.4/debian stable main' | sudo tee /etc/apt/sources.list.d/elasticsearch.list

sudo apt-get update

# Install Java, Elasticsearch, Logstash and Nginx
sudo apt-get install -y openjdk-7-jre logstash elasticsearch

# Add Elasticsearch as a service
sudo update-rc.d elasticsearch defaults 95 10

# Install Kibana
sudo mkdir ~/kibana

sudo curl -O https://download.elasticsearch.org/kibana/kibana/kibana-4.0.0-beta3.tar.gz
sudo tar xvf kibana-4.0.0-beta3.tar.gz -C ~/kibana --strip-components=1
sudo rm -f kibana-4.0.0-beta3.tar.gz
