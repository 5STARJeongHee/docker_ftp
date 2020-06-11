# docker_ftp

#read ME
---------------------------

0.4v은 안됩니다. 

0.5v이 되는 거고, 컨테이너 내부 포트는 아래의 실행 명령어를 참조해서 쓰시면 됩니다. 

도커 파일을 이용해서 하고 싶으시면 아래의 dockerfile, ftp_start.sh, vsftpd.conf 파일들을  한 디렉토리 내부에 생성하시고 아래의 스크립트들을 복붙하시면 됩니다.

#dockerfile 
----------------------
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

RUN sed -i '/n=0/a\sleep 1'  /etc/init.d/vsftpd

RUN service vsftpd start

ADD ftp_serv.sh /

CMD ./ftp_serv.sh

#vsftpd.conf
----------------------------------------
listen=NO

listen_port=21

pasv_enable=YES

pasv_min_port=10050

pasv_max_port=10100

listen_ipv6=YES

anonymous_enable=NO

local_enable=YES

write_enable=YES

dirmessage_enable=YES

use_localtime=YES

xferlog_enable=YES

connect_from_port_20=YES

ascii_upload_enable=YES

ascii_download_enable=YES

chroot_local_user=YES

allow_writeable_chroot=YES

#chroot_list_enable=YES

#chroot_list_file=/etc/vsftpd.chroot_list

user_sub_token=$USER

local_root=/home/$USER

secure_chroot_dir=/var/run/vsftpd/empty

pam_service_name=vsftpd

rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem

rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key

ssl_enable=NO
                        

#ftp_serv.sh
-------------------------
#!/bin/bash

service vsftpd start


/bin/bash

sh 파일을 실행하려면 파일 권한 수정 필요


#usage :
-------------------------------
 sudo docker run -dit -p 10000-10001:20-21 -p 10050-10100:10050-10100  qhxmaoflr/ftp_serv:0.5v


