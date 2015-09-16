FROM debian:latest
RUN apt-get -y update && apt-get install -y openssh-server vim curl gzip
RUN echo 'root:ionic' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

RUN mkdir -p /var/run/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

RUN curl -SL http://www.mersenne.org/ftp_root/gimps/p95v287.linux64.tar.gz | tar -xz mprime && mv mprime /usr/sbin && chmod +x /usr/sbin/mprime

COPY runprime /

CMD ["/bin/bash", "-c", "runprime"]


