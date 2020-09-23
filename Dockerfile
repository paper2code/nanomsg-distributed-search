FROM python:3-slim
MAINTAINER Michalski Luc <michalski.luc@gmail.com>

WORKDIR /opt/service

RUN apt-get update && \
    apt-get install -y git ca-certificates make cmake gcc g++ clang zlib1g-dev libboost-dev libboost-thread-dev nano bash jq asciidoctor curl libtbb-dev && \
    curl -sSL https://get.haskellstack.org/ | sh

RUN git clone --depth=1 https://github.com/nanomsg/nanomsg /opt/source/nanomsg && \
    mkdir -p /opt/source/nanomsg/build && \
    cd /opt/source/nanomsg/build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DNN_STATIC_LIB=ON .. && \
    cmake --build . && \
    ctest . && \
    cmake --build . --target install && \
    ldconfig    

RUN git clone --depth=1 --recursive https://github.com/Microsoft/bond /opt/source/bond && \
    mkdir -p /opt/source/bond/build && \
    cd /opt/source/bond/build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DBOND_ENABLE_GRPC=FALSE .. && \
    make -j12 && \
    make install

ENV PATH=$PATH:/root/.local/bin

COPY . .

RUN make bond && \
    make all    

CMD ["/bin/bash"]
