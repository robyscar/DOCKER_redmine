### docker run -itd --restart=unless-stopped --name postgresSQL --network=host --add-host db-postgresSQL:192.168.2.231 -p 5432:5432 --memory="128M" --memory-swap="128M" --env-file test_postgresql.env -v POSTGRES_DATA:/var/lib/postgresql/data -v POSTGRES_CONFIG:/etc postgres:latest

https://hub.docker.com/_/redmine/

https://www.redmine.org/projects/redmine/wiki/HowTos


#       version: '3.1'
#       services:
#       
#         redmine:
#           image: redmine
#           restart: always
#           ports:
#             - 8080:3000
#           environment:
#             REDMINE_DB_MYSQL: db
#             REDMINE_DB_PASSWORD: example
#             REDMINE_SECRET_KEY_BASE: supersecretkey
#       
#         db:
#           image: mysql:5.7
#           restart: always
#           environment:
#             MYSQL_ROOT_PASSWORD: example
#             MYSQL_DATABASE: redmine
#       

#   -v /my/own/datadir:/usr/src/redmine/files

useradd -m -U redmine

docker network create redmine-network

cls && docker volume rm POSTGRES_CONFIG && docker volume rm POSTGRES_DATA && docker volume rm POSTGRES_LOG

docker volume create POSTGRES_CONFIG && docker volume create POSTGRES_DATA && docker volume create POSTGRES_LOG


# PostgreSQL
CREATE ROLE redmine LOGIN ENCRYPTED PASSWORD 'R13dM1ne' NOINHERIT VALID UNTIL 'infinity';
CREATE DATABASE REDMINE_DB WITH ENCODING='UTF8' OWNER=redmine;

### SQL Server --------------------------------------------------------------------------------------------- {begin}
### The database, login and user can be created within SQL Server Management Studio with a few clicks.
### If you prefer the command line option with SQLCMD, here's some basic example:

USE [master]
GO
-- Very basic DB creation
CREATE DATABASE [REDMINE_DB]
GO
-- Creation of a login with SQL Server login/password authentication and no password expiration policy
CREATE LOGIN [REDMINE] WITH PASSWORD=N'R13dM1ne', DEFAULT_DATABASE=[REDMINE_DB], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
-- User creation using previously created login authentication
USE [REDMINE_DB]
GO
CREATE USER [REDMINE] FOR LOGIN [REDMINE_DB]
GO
-- User permissions set via roles
EXEC sp_addrolemember N'db_datareader', N'REDMINE_DB'
GO
EXEC sp_addrolemember N'db_datawriter', N'REDMINE_DB'
GO
### SQL Server --------------------------------------------------------------------------------------------- {end}

### $ docker run -d --name some-redmine --network some-network -e REDMINE_DB_POSTGRES=some-postgres -e REDMINE_DB_USERNAME=redmine -e REDMINE_DB_PASSWORD=secret redmine

#   --mount type=bind,target=/mnt/session_data,source=/data

cls && docker volume rm REDMINE_FILES 

docker volume create REDMINE_FILES


docker run -itd \
--restart=unless-stopped \
--name redmine \
--hostname redmine \
--link postgresSQL \
-p 3000:3000 \
--memory="128M" \
--memory-swap="128M" \
--cpus 0.5 \
--cpu-quota 60000 \
-e REDMINE_DB_POSTGRES=postgresSQL \
-e REDMINE_DB_USERNAME=redmine \
-e REDMINE_DB_PASSWORD=D1etP33H0le \
-v REDMINE_FILES:/usr/src/redmine/files \
--user redmine:redmine \
--link postgresSQL:postgres redmine \
redmine:latest


--add-host list postgresSQL:192.168.2.222
# --network 
# --ip 192.168.2.232
# --link-local-ip
# --mount /MNT/REDMINE_FILES /usr/src/redmine/files
type=bind,target=/MNT/REDMINE_FILES,source=/usr/src/redmine/files
