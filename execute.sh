#!/bin/bash
#This file is a hardcoded script to trigger some actions on an endpoint, writing output to the console. 
#This is designed to be triggered by VMware Pulse IoT. 
# Author: Mitch Ryan
# Version: 1.1
# Last Update: 10/Jan/20

AGENTBINPATH="/opt/vmware/iotc-agent/bin/"
AGENTDATAPATH="/opt/vmware/iotc-agent/data/data/"
DEVICEID=$(${AGENTBINPATH}DefaultClient get-devices | head -n2 | awk 'NR>1 {split($0,a); print a[1]}')
TEMPLATE=shelf_container
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
	
################################################################################
## Check to see if running Containers are registered in Pulse, if not, Register
################################################################################
for i in $(docker ps -a --format "{{.Names}}"); do
        if ls $AGENTDATAPATH | grep "$i"; then
            echo "Container" ${i} "is registered"
        else
            echo "Container is not registered"
            (sudo ${AGENTBINPATH}DefaultClient enroll-device --template=$TEMPLATE --name=T-DockerContainer-${i} --parent-id=$DEVICEID) | grep "Device Id:" | head -1 > ${AGENTDATAPATH}${i}.container
            RESULT=$?
                if [ $RESULT -eq 0 ]; then
                    echo "Container " ${i} " registered successfully" 
                else
                    echo "Unable to register Container " ${i}  
                    exit 1
                fi
        fi
done

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
	
################################################################################
## Check to see if running Containers are registered in Pulse, if not, Register
################################################################################
for i in $(docker ps -a --format "{{.Names}}"); do
        if ls $AGENTDATAPATH | grep "$i"; then
            echo "Container" ${i} "is registered"
        else
            echo "Container is not registered"
            (sudo ${AGENTBINPATH}DefaultClient enroll-device --template=$TEMPLATE --name=T-DockerContainer-${i} --parent-id=$DEVICEID) | grep "Device Id:" | head -1 > ${AGENTDATAPATH}${i}.container
            RESULT=$?
                if [ $RESULT -eq 0 ]; then
                    echo "Container " ${i} " registered successfully" 
                else
                    echo "Unable to register Container " ${i}  
                    exit 1
                fi
        fi
done

echo "$now: Starting dockermonitor service"|tee -a campaign.log|wall -n
service dockermonitor start |wall -n
	echo "$now: dockermonitor service started"|tee -a campaign.log|wall -n
 	echo "$now: Pulse campaign successfully completed"|tee -a campaign.log|wall -n
sleep 2
