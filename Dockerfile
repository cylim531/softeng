FROM ubuntu:20.04

RUN apt update && apt install -y openssh-server
RUN apt -y install vim emacs

RUN mkdir /var/run/sshd
RUN echo 'root:mypassword' | chpasswd

RUN sed -i 's/#*PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd

ENV NOTVISIB="in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

CMD ["/usr/sbin/sshd", "-D"]

