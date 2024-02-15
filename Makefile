createNW:
	docker network create --subnet=172.24.0.0/16 instar-net

build:
	docker build -t ddns-master .

start:
	docker run -d --rm --name=ddns-master --net=instar-net --ip=172.24.0.2  ddns-master

check:
	docker exec -ti ddns-master /bin/bash 
	
#named-checkconf named-checkzone instar-net.io /etc/bind/zones/db.instar-net.io

service1:
	docker run -d --rm --name=service1 --net=instar-net --ip=172.24.0.3 --dns=172.24.0.2 nginx:1.21.6-alpine /bin/ash -c "while :; do sleep 10; done"

service2:
	docker run -d --rm --name=service2 --net=instar-net --ip=172.24.0.4 --dns=172.24.0.2 nginx:1.21.6-alpine /bin/ash -c "while :; do sleep 10; done"

inspect_network:
	docker network inspect instar-net

#triying ping to service2 with a custom dns 
test1:
	docker exec -it service1 nslookup service2.instar-net.io

test2:
	docker exec -it service1 nslookup google.com 

stop:
	docker stop ddns-master service1 service2

stop2:
	docker stop $$(docker ps -aq)