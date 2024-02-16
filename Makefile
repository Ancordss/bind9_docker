createNW:
	docker network create --subnet=172.24.0.0/16 instar-net

build:
	docker build -t ddns-master .

start: start_dns service1 service2 service3

start_tests: test1 test2 test3 test4

#run to enter the command line of the container
check:
	docker exec -ti ddns-master /bin/bash 
	
#named-checkconf named-checkzone instar-net.io /etc/bind/zones/db.instar-net.io

start_dns:
	docker run -d --rm --name=ddns-master --net=instar-net --ip=172.24.0.2 ddns-master

service1:
	docker run -d --rm --name=service1 --net=instar-net --ip=172.24.0.3 --dns=172.24.0.2 nginx:1.21.6-alpine /bin/ash -c "while :; do sleep 10; done"

service2:
	docker run -d --rm --name=service2 --net=instar-net --ip=172.24.0.4 --dns=172.24.0.2 nginx:1.21.6-alpine /bin/ash -c "while :; do sleep 10; done"

service3:
	docker build -t flask-api -f Dockerfile.app .
	docker run -d --rm --name=service3 --net=instar-net --ip=172.24.0.5 --dns=172.24.0.2 -p 5000:5000 flask-api

inspect_network:
	docker network inspect instar-net

#triying ping to service2 with a custom dns 
test1:
	echo "triying to service2 with a custom dns"
	docker exec -it service1 nslookup service2.so2umg.xyz

test2:
	echo "triying to resolve google.com with the custom dns"
	docker exec -it service1 nslookup google.com 

test3:
	echo "triying to resolve api1.so2umg.xyz with the custom dns"
	docker exec -it service1 nslookup api1.so2umg.xyz

test4:
	echo "triying to get the response from api1.so2umg.xyz with the custom dns"
	docker exec -it service1 curl api1.so2umg.xyz:5000

stop:
	docker stop ddns-master service1 service2 service3

stop2:
	docker stop $$(docker ps -aq)