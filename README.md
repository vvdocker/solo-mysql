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
## custom my.cnf
+ edit conf.d/my.cnf
+ edit Dockerfile

## startup command
### shell
+ edit init.d/startup.sh
+ edit Dockerfile

### sql
+ edit init.d/startup.sql
+ edit Dockerfile
