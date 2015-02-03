#!/bin/bash

# Configure logstash
sudo cp ~/elk/01-logstash-input.conf /etc/logstash/conf.d/01-logstash-input.conf
sudo cp ~/elk/11-nginx.conf /etc/logstash/conf.d/11-nginx.conf
sudo cp ~/elk/99-output.conf /etc/logstash/conf.d/99-output.conf

sudo cp ~/elk/logstash-web.conf /etc/init/logstash-web.conf

# patterns
sudo cp ~/elk/nginx.pattern /opt/logstash/patterns/nginx
sudo chown logstash:logstash /opt/logstash/patterns/nginx

# Configure nginx
sudo cp ~/elk/nginx-site.conf /etc/nginx/sites-available/default

# Start all the services
sudo service elasticsearch start
sudo service logstash start
sudo service nginx start
