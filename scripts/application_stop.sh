#!/bin/bash

# Stop all the services
sudo service elasticsearch stop
sudo service logstash stop
sudo service logstash-web stop
sudo service nginx stop

# Kill Kibana
sudo kill $(ps aux | grep kibana | grep -v 'grep' | awk '{print $2}')
