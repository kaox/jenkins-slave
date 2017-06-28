Jenkins Slave SSH
==================

[![Docker Stars](https://img.shields.io/docker/stars/jenkinsci/slave.svg)](https://hub.docker.com/r/kaox/jenkins-slave/)
[![Docker Pulls](https://img.shields.io/docker/pulls/jenkinsci/slave.svg)](https://hub.docker.com/r/kaox/jenkins-slave/)
[![Docker Automated build](https://img.shields.io/docker/automated/jenkinsci/slave.svg)](https://hub.docker.com/r/kaox/jenkins-slave/)


Jenkins slave SSH esta basado en la imagen de openjdk.

-------

###Instalación:

	docker pull kaox/jenkins-slave:jdk6
	
###Dockerfile

```Dockerfile
	FROM kaox/jenkins-slave
	
	#Instalación Maven
	ARG MAVEN_VERSION=3.5.0
	ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries
	
	RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
		&& curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-$MAVEN_VERSION-bin.tar.gz \
		&& tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
		&& rm -f /tmp/apache-maven.tar.gz \
		&& ln -s /usr/share/maven/bin/mvn /usr/bin/mvn
	WORKDIR /home/jenkins
	
	EXPOSE 22
	
	CMD  ["/usr/sbin/sshd", "-D"]
```

###docker-compose.yml

```
	version: '3'
	
	services:
	
	jenkins:
		image: jenkins:2.46.2
		container_name: jenkins-master
		ports:
		- 8080:8080
		- 50000:50000
	
	jenkins-slave:
		image: kaox/jenkins-slave:jdk7
		container_name: jenkins-slave
```

###Parametros

	USER --> Usuario de slave (jenkins default)
	PASS --> Password de slave (jenkins default)

