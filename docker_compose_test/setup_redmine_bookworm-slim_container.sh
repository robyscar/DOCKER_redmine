cls

### https://docs.docker.com/network/

### -p HOST:container
###
### -p 8080:80/tcp -p 8080:80/udp	
###         Map TCP port 80 in the container to 
###         TCP port 8080 on the Docker host
###         and 
###         map UDP port 80 in the container 
###         to UDP port 8080 on the Docker host
### 
### -p 192.168.1.100:8080:80
###         Map TCP port 80 in the container to 
###         port 8080 on the Docker host for
###         connections to host IP 192.168.1.100.


docker network create --driver bridge redmine-postgres
docker network inspect redmine-postgres | grep Subnet

### "Subnet": "172.19.0.0/16"


docker run -itd \
--restart=unless-stopped \
--name redmine-postgres-bookworm-slim-test \
--hostname redmine-postgres \
--network=redmine-postgres \
-p 22:22 \
-p 5432:5432 \
-p 8383:80 \
-p 3000:3000 \
--memory="256M" \
--memory-swap="256M" \
--cpu-quota 60000 \
debian:bookworm-slim

docker exec -it redmine-postgres-bookworm-slim-test sh -c bash


### --env-file ./test_postgresql.env \
### -v POSTGRES_DATA:/var/lib/postgresql/data \
### -v POSTGRES_CONFIG:/etc \
