FROM openjdk:7u121-jdk
LABEL maintainer "andresgarcia.kaox@gmail.com"

ARG USER=jenkins
ARG PASS=jenkins

# Instalando SSH
RUN apt-get update && \
	apt-get install -y openssh-server && mkdir /var/run/sshd && \
	# Creando usuario
	useradd -m -d /home/jenkins -s /bin/sh jenkins && \
	echo "${USER}:${PASS}" | chpasswd && \
	apt-get clean

WORKDIR /home/jenkins

EXPOSE 22

CMD  ["/usr/sbin/sshd", "-D"]