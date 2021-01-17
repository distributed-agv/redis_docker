FROM redis:latest 
 COPY ./conf/redis.conf /usr/local/etc/redis/redis.conf 
 COPY ./lua /usr/local/etc/redis/lua
 RUN mkdir -p /usr/local/python3
 COPY ./Python-3.7.1  /usr/local/python3/Python-3.7.1
 RUN set -ex \
    && apt-get update \
	&& apt-get upgrade -y \
	&& apt install build-essential -y
 RUN set -ex \
	&& apt install libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev -y \
	&& apt install zlib1g-dev \
	&& apt install wget -y\
	&& apt install openssl -y\
	&& apt install curl -y\
	&& apt install libsqlite3-dev -y\
	&& apt-get clean 

 

 RUN set -ex \
	&& cd /usr/local/python3 \
	&& cd Python-3.7.1 \
	&& ./configure prefix=/usr/local/python3 \
	&& make && make install \
	&& ln -s /usr/local/python3/bin/python3.7 /usr/local/bin/python3 \
	&& ln -s /usr/local/python3/bin/pip3 /usr/local/bin/pip3 
	
 RUN set -ex \
	&& cd /usr/local/python3 \
	&& python3 -V  

 RUN /usr/local/python3/bin/pip3 install pymysql
 RUN /usr/local/python3/bin/pip3 install redis

 RUN set -ex \
	&& chmod 777 /usr/local/etc/redis/lua/run.sh \
	&& cd /usr/local/etc/redis/lua 

 
 

 



