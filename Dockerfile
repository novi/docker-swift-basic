FROM swift:5.7.1-focal AS base
ARG PROTOC_VER=3.20.3
ARG GRPC_SWIFT_VER=1.13.0

FROM base AS base-amd64
ARG PROTOC_ARCH=x86_64

FROM base AS base-arm64
ARG PROTOC_ARCH=aarch_64

FROM base-$TARGETARCH AS final

# Install dependency library
RUN apt-get update && \
    apt-get install -y libxml2-dev libmariadbclient-dev unzip curl make libcurl4-nss-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install protoc
RUN curl -s -O -L https://github.com/google/protobuf/releases/download/v${PROTOC_VER}/protoc-${PROTOC_VER}-linux-${PROTOC_ARCH}.zip && \
    unzip protoc-${PROTOC_VER}-linux-${PROTOC_ARCH}.zip -d /usr && \
    rm protoc-${PROTOC_VER}-linux-${PROTOC_ARCH}.zip && protoc --version

# Build and install the swiftgrpc plugin
RUN git clone -b ${GRPC_SWIFT_VER} --depth=1 https://github.com/grpc/grpc-swift && \
    cd grpc-swift && \
    make plugins && \
    cp ./.build/release/protoc-gen-swift /usr/bin && \
    cp ./.build/release/protoc-gen-grpc-swift /usr/bin && \
    cd ../ && rm -rf grpc-swift && swift --version

