FROM ubuntu:18.04

RUN apt-get update && \

apt-get upgrade -y && \

apt-get install vsftpd ftp -y

RUN echo "root:ubuntu" | chpasswd

RUN adduser ubuntu

RUN echo "ubuntu:ubuntu" | chpasswd

RUN echo "ubuntu ALL=(ALL:ALL) ALL" >> /etc/sudoers

RUN chmod 777 /home/ubuntu

EXPOSE 80 21 20 3389 10000 10001 10002 10003 22

RUN rm /etc/vsftpd.conf

ADD vsftpd.conf /etc/

RUN sed -i '/n=0/a\sleep 1' /etc/init.d/vsftpd

RUN service vsftpd start

ADD ftp_serv.sh /

CMD ./ftp_serv.sh