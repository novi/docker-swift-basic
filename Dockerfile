FROM swift:5.0

ENV PROTOC_VER 3.9.1

# 
RUN ln -fs /usr/share/zoneinfo/Etc/GMT /etc/localtime

# Install dependency library
RUN apt-get update && \
    apt-get install -y libxml2-dev libmysqlclient-dev unzip libnghttp2-dev curl libssl-dev libcurl4-openssl-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install protoc
RUN curl -s -O -L https://github.com/google/protobuf/releases/download/v${PROTOC_VER}/protoc-${PROTOC_VER}-linux-x86_64.zip && \
    unzip protoc-${PROTOC_VER}-linux-x86_64.zip -d /usr && \
    rm protoc-${PROTOC_VER}-linux-x86_64.zip

# Build and install the swiftgrpc plugin
RUN git clone -b 1.0.0-alpha.4 --depth=1 https://github.com/grpc/grpc-swift && \
    cd grpc-swift && \
    make && \
    cp protoc-gen-swift /usr/bin && \
    cp protoc-gen-swiftgrpc /usr/bin && \
    cd ../ && rm -rf grpc-swift

