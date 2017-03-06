FROM yusukeito/swift:swift3.1

# Add MariaDB repository
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8 && \
    add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://ftp.yz.yamagata-u.ac.jp/pub/dbms/mariadb/repo/10.1/ubuntu xenial main'

# 
RUN ln -fs /usr/share/zoneinfo/Etc/GMT /etc/localtime

# Install dependency library
RUN apt-get update && \
    apt-get install -y libxml2-dev libmariadbclient-dev git automake libtool autoconf uuid-dev libssl-dev libz-dev unzip tzdata && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install protoc
RUN curl -O -L https://github.com/google/protobuf/releases/download/v3.2.0/protoc-3.2.0-linux-x86_64.zip && \
    unzip protoc-3.2.0-linux-x86_64.zip -d /usr && \
    rm protoc-3.2.0-linux-x86_64.zip

# Build and install the swiftgrpc plugin
RUN git clone https://github.com/grpc/grpc-swift && \
    cd grpc-swift/Plugin && \
    make && \
    cp protoc-gen-swift /usr/bin && \
    cp protoc-gen-swiftgrpc /usr/bin && \
    cd ../.. && rm -rf grpc-swift

