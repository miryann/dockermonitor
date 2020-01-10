#!/bin/bash
#This file is a hardcoded script to trigger some actions on an endpoint, writing output to the console. 
#This is designed to be triggered by VMware Pulse IoT. 
# Author: Mitch Ryan
# Version: 1.1
# Last Update: 10/Jan/20

now=$(date +"%T")
	echo "$now: Pulse campaign successfully loaded"|tee -a campaign.log|wall -n
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
./runonce.sh
sleep 2
	echo "$now: Downloading docker image ubuntu/ubuntu"|tee -a campaign.log|wall -n
	echo "docker pull ubuntu"|tee -a campaign.log|wall -n
docker pull ubuntu |wall -n
	echo "$now: Downloaded docker image ubuntu/ubuntu"|tee -a campaign.log|wall -n
	echo "$now: Starting docker image ubuntu/ubuntu"|tee -a campaign.log|wall -n
	echo "docker run -td --name ubuntu ubuntu"|tee -a campaign.log|wall -n
sleep 2
	docker run -td --name ubuntu ubuntu|tee -a campaign.log|wall -n
	echo "$now: Docker container ubuntu ubuntu running"|tee -a campaign.log|wall -n
 ./runonce.sh
	echo "$now: Installing and enabling dockermonitor service"|tee -a campaign.log|wall -n
service dockermonitor start |wall -n
	echo "$now: dockermonitor service started"|tee -a campaign.log|wall -n
 	echo "$now: Pulse campaign successfully completed"|tee -a campaign.log|wall -n
sleep 2
