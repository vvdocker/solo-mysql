# vvdocker/solo-mysql
+ mysql 5.6 5.7 ... latest
+ mysql data (busybox, local file...)
+ init shell command
+ init sql command
+ etc custom

## quick-start
### build
```
docker build -t vvdocker-mysql .
```

### run
```
docker run --name app-db -d vvdocker-mysql
```

### attach
```
docker exec -it app-db bash
mysql -uroot -p
```

## mysql data
### local file
```
 docker run --name app-db -v /vagrant/app/db/datadir:/var/lib/mysql -d  vvdocker-mysql
```

### use busybox
```
 docker run --name app-db --volumes-from strage_container -d  vvdocker-mysql
```
## Dockerfile
```
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

```

## custom my.cnf
+ edit Dockerfile
+ edit conf.d/my.cnf
```
[client]                           
port=3306
socket=/tmp/mysql.sock

[mysqld]                           
port=3306
socket=/tmp/mysql.sock
key_buffer_size=16M
max_allowed_packet=8M

[mysqldump]                        
quick

[mysqld_safe]                      
log-error=/var/log/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid
```

## startup command
### shell
+ edit Dockerfile
+ edit init.d/startup.sh
```
#! /bin/bash
CREATE_USER='mysql'
CREATE_PASSWORD='secret'
GRANT="GRANT ALL ON ${MYSQL_DATABASE}.* TO ${CREATE_USER}@'%' IDENTIFIED BY ${CREATE_PASSWORD}; FLUSH PRIVILEGES"
echo $GRANT | mysql -u ${MYSQL_ROOT_USER} -p${MYSQL_ROOT_PASSWORD}

```

### sql
+ edit Dockerfile
+ edit init.d/startup.sql
```
DROP TABLE IF EXISTS `personal`;
CREATE TABLE `personal` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
      `name` varchar(10) DEFAULT NULL,
        KEY `id` (`id`)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
      LOCK TABLES `personal` WRITE;
      /*!40000 ALTER TABLE `personal` DISABLE KEYS */;
INSERT INTO `personal` (`id`, `name`)
SELECT * FROM (SELECT 1, 'root@local') AS tmp
WHERE NOT EXISTS (
      SELECT `id` FROM `personal` WHERE `id` = 1
    ) LIMIT 1;
```
