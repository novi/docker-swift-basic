FROM yusukeito/swift:swift22

# Install dependency library
RUN apt-get update && \
    apt-get install -y libcurl4-openssl-dev libxml2-dev libmysqlclient-dev git automake libtool autoconf && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
# Install libuv
RUN git clone https://github.com/libuv/libuv.git && \
    cd libuv/ && \
    sh autogen.sh && \
    ./configure && \
    make && \
    make install && \
    cd .. && \
    rm -rf libuv
    

    
    