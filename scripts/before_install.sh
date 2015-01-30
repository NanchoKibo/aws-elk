#!/bin/bash

sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update

# Install Java
sudo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
sudo echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
sudo apt-get install oracle-java7-installer -y

# Install Elasticsearch, nginx and logstash
wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
sudo echo 'deb http://packages.elasticsearch.org/elasticsearch/1.1/debian stable main' | sudo tee /etc/apt/sources.list.d/elasticsearch.list
sudo echo 'deb http://packages.elasticsearch.org/logstash/1.4/debian stable main' | sudo tee /etc/apt/sources.list.d/logstash.list

sudo apt-get update
sudo apt-get -y install elasticsearch=1.1.1 logstash=1.4.2-1-2c0f5a1 nginx

# Install Kibana
sudo mkdir /opt/kibana
sudo curl -O https://download.elasticsearch.org/kibana/kibana/kibana-3.1.1.tar.gz
sudo tar xvf kibana-3.1.1.tar.gz -C /opt/kibana --strip-components=1
sudo rm -f kibana-3.1.1.tar.gz
