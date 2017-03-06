FROM yusukeito/swift:release-3.0.2

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
    
# install protoc
RUN apt-get update && apt-get install -y unzip && apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    mkdir -p /tmp/protoc && \
    wget -O /tmp/protoc/protoc.zip https://github.com/google/protobuf/releases/download/v3.1.0/protoc-3.1.0-linux-x86_64.zip && \
    cd /tmp/protoc && \
    unzip protoc.zip && \
    cp /tmp/protoc/bin/protoc /usr/local/bin && \
    cp -R /tmp/protoc/include/* /usr/local/include/ && \
    chmod go+rx /usr/local/bin/protoc && \
    cd /tmp && \
    rm -r /tmp/protoc

# Build grpc & protobuf gen
RUN cd /tmp/ && \
    git clone -b 0.1.10 https://github.com/grpc/grpc-swift.git && \
    cd grpc-swift/Plugin && \
    make && \
    cp protoc-gen-swift /usr/local/bin && \
    cp protoc-gen-swiftgrpc /usr/local/bin && \
    rm -rf /tmp/grpc-swift
    