#!/bin/bash

# Configure logstash
sudo cp ~/elk/config/01-logstash-input.conf /etc/logstash/conf.d/01-logstash-input.conf
sudo cp ~/elk/config/11-nginx.conf /etc/logstash/conf.d/11-nginx.conf
sudo cp ~/elk/config/99-output.conf /etc/logstash/conf.d/99-output.conf
sudo cp ~/elk/config/logstash-web.conf /etc/init/logstash-web.conf

# Start all the services
sudo service elasticsearch start
sudo service logstash start
sudo nohup bash ~/kibana/bin/kibana &
