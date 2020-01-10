#!/bin/bash
#This file is a hardcoded script to trigger some actions on an endpoint, writing output to the console. 
#This is designed to be triggered by VMware Pulse IoT. 
# Author: Mitch Ryan
# Version: 1.1
# Last Update: 10/Jan/20
now=$(date +"%T")
	cd /tmp/dockermonitor/
 	chmod 777 *.sh
	echo "$now: Pulse campaign successfully loaded"|tee -a campaign.log|wall -n
	echo "$now: Configuring dockermonitor service"|tee -a campaign.log|wall -n
	mkdir /opt/dockermonitor
	cp dockermonitor.sh /opt/dockermonitor
	chmod +x /opt/dockermonitor/dockermonitor.sh
	cp dockermonitor.service /etc/systemd/system
	chmod 644 /etc/systemd/system/dockermonitor.service
	systemctl daemon-reload
	systemctl enable dockermonitor.service
sleep 2
	echo "$now: Downloading docker image alpine/alpine"|tee -a campaign.log|wall -n
	echo "docker pull alpine"|tee -a campaign.log|wall -n
docker pull alpine |wall -n
	echo "$now: Downloaded docker image alpine/alpine"|tee -a campaign.log|wall -n
	echo "$now: Starting docker image alpine/alpine"|tee -a campaign.log|wall -n
	echo "docker run -td --name alpine alpine"|tee -a campaign.log|wall -n
sleep 2
	docker run -td --name alpine alpine|tee -a campaign.log|wall -n
	echo "$now: Docker container alpine alpine running"|tee -a campaign.log|wall -n
sleep 2
 	echo "$now: Pulse campaign successfully completed"|tee -a campaign.log|wall -n
sleep 2
