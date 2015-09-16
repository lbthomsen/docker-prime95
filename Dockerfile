FROM debian:latest

RUN apt-get -y update && apt-get install -y vim curl gzip

RUN curl -SL http://www.mersenne.org/ftp_root/gimps/p95v287.linux64.tar.gz | tar -xz mprime && mv mprime /usr/sbin && chmod +x /usr/sbin/mprime

COPY runprime /
RUN chmod +x ./runprime

RUN mkdir prime

CMD ["/bin/bash", "-c", "./runprime"]

