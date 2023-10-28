### 
### clear
### docker network create --driver bridge postgresSQL
### docker network inspect postgresSQL | grep Subnet
### 
### clear && docker volume rm POSTGRES_CONFIG && docker volume ### create POSTGRES_CONFIG && docker volume rm ###   POSTGRES_DATA && docker volume create POSTGRES_DATA && ### docker volume rm POSTGRES_LOG && docker volume create ###    POSTGRES_LOG
### 
### 

###         docker run -itd \
###         --restart=unless-stopped \
###         --name postgresSQL \
###         --hostname postgresSQL \
###         --network=postgresSQL \
###         -p 5432:5432 \
###         --memory="128M" \
###         --memory-swap="128M" \
###         --cpu-quota 60000 \
###         --env-file ./test_postgresql.env \
###         -v POSTGRES_DATA:/var/lib/postgresql/data \
###         -v POSTGRES_CONFIG:/etc \
###         postgres:latest

FROM debian:bullseye-slim

### ============ POSTGRESQL ============ { begin }
RUN set -eux; \
    alias cls='clear'; \
    apt-get update; \
    dpkg --configure -a; 
\
    apt-get install -y --no-install-recommends \
    apt-utils patch; \
\
    dpkg --configure -a; apt-get install -y --no-install-recommends \
    wget nano less mc iproute2 fping git curl \
    openssh-server openssh-client ca-certificates \
    patch xauth psmisc ; \

### =================== POSTGRESQL ============ { end }



### ============ REDMINE ============ { begin }


RUN groupadd -r -g 999 redmine && useradd -r -g redmine -u 999 redmine; \


### ============ REDMINE ============ { end }


