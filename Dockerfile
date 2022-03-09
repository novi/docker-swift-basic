FROM swift:5.5.3-focal

ENV PROTOC_VER 3.19.4

# Install dependency library
RUN apt-get update && \
    apt-get install -y libxml2-dev libmysqlclient-dev unzip libnghttp2-dev curl make libssl-dev libcurl4-openssl-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install protoc
RUN curl -s -O -L https://github.com/google/protobuf/releases/download/v${PROTOC_VER}/protoc-${PROTOC_VER}-linux-x86_64.zip && \
    unzip protoc-${PROTOC_VER}-linux-x86_64.zip -d /usr && \
    rm protoc-${PROTOC_VER}-linux-x86_64.zip

# Build and install the swiftgrpc plugin
RUN git clone -b 1.7.1 --depth=1 https://github.com/grpc/grpc-swift && \
    cd grpc-swift && \
    make plugins && \
    cp ./.build/release/protoc-gen-swift /usr/bin && \
    cp ./.build/release/protoc-gen-grpc-swift /usr/bin && \
    cd ../ && rm -rf grpc-swift && swift --version

