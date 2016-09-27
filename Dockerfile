FROM yusukeito/swift:snapshot-2016-09-19-a

# Add MariaDB repository
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db && \
    add-apt-repository 'deb [arch=amd64,i386] http://ftp.yz.yamagata-u.ac.jp/pub/dbms/mariadb/repo/10.1/ubuntu trusty main'
    
# Install dependency library
RUN apt-get update && \
    apt-get install -y libcurl4-openssl-dev libxml2-dev libmariadbclient-dev git automake libtool autoconf uuid-dev libssl-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
# Install libuv
RUN git clone -b v1.9.1 https://github.com/libuv/libuv.git && \
    cd libuv/ && \
    sh autogen.sh && \
    ./configure && \
    make && \
    make install && \
    cd .. && \
    rm -rf libuv
    