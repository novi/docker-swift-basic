FROM yusukeito/swift:swift5.0-dev

ENV PROTOC_VER 3.7.1

# 
RUN ln -fs /usr/share/zoneinfo/Etc/GMT /etc/localtime

# Install dependency library
RUN apt-get update && \
    apt-get install -y libxml2-dev libmysqlclient-dev unzip libssl-dev libnghttp2-dev curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install protoc
RUN curl -s -O -L https://github.com/google/protobuf/releases/download/v${PROTOC_VER}/protoc-${PROTOC_VER}-linux-x86_64.zip && \
    unzip protoc-${PROTOC_VER}-linux-x86_64.zip -d /usr && \
    rm protoc-${PROTOC_VER}-linux-x86_64.zip

# Build and install the swiftgrpc plugin
RUN git clone -b 0.9.0 --depth=1 https://github.com/grpc/grpc-swift && \
    cd grpc-swift && \
    make && \
    cp protoc-gen-swift /usr/bin && \
    cp protoc-gen-swiftgrpc /usr/bin && \
    cd ../ && rm -rf grpc-swift

