FROM yusukeito/swift:snapshot-2016-11-15-a

# Add MariaDB repository
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8 && \
    add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://ftp.yz.yamagata-u.ac.jp/pub/dbms/mariadb/repo/10.1/ubuntu xenial main'
    
# Install dependency library
RUN apt-get update && \
    apt-get install -y libxml2-dev libmariadbclient-dev git automake libtool autoconf uuid-dev libssl-dev && \
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
    
# Install grpc
RUN git clone --depth=10 https://github.com/grpc/grpc.git && \
    cd grpc/ && \
    git checkout 6b6954050cf0379dbbee90dd18313a3779e0dd52 && \
    git submodule update --init && \
    make && \
    make install && \
    cd .. && \
    rm -rf grpc
    
    