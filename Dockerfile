FROM phusion/baseimage:0.11
MAINTAINER banyan.cheung@gmail.com

RUN echo /home/worker > /etc/container_environment/HOME

ADD build /build

RUN /build/prepare.sh && \
    /build/php.sh && \
	/build/nginx.sh && \
	/build/finish.sh

# add CONFIG
ADD config /home/worker/

# start up
RUN mkdir -p /etc/my_init.d && \
    chmod -R 777 /etc/my_init.d

WORKDIR /home/worker/data/www

CMD ["/sbin/my_init"]