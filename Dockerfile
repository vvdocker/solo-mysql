# Dockerfile

##########################
# base sql version
##########################
FROM mysql:5.7
#FROM mysql:5.6
#FROM mysql:latest

##########################
# ENV
##########################
ENV MYSQL_ROOT_USER root
ENV MYSQL_ROOT_PASSWORD root
ENV MYSQL_DATABASE sample_db
ENV MYSQL_USER test
ENV MYSQL_PASSWORD password

##########################
# my.cnf
##########################
#COPY conf.d/my.cnf /etc/mysql/conf.d/

##########################
# start up shell command
##########################
VOLUME ./init.d:/docker-entrypoint-initdb.d

