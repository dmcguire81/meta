FROM ubuntu:22.04

ENV CC=clang-14
ENV CXX=clang++-14
ENV PATH=/meta/build:$PATH

COPY . /meta

RUN apt-get update && apt-get install -y \
    clang-14  \
    cmake  \
    git  \
    libc++-14-dev  \
    libc++abi-14-dev \
    libjemalloc-dev  \
    lld-14  \
    software-properties-common \
    zlib1g-dev

WORKDIR /meta
RUN git submodule update --init --recursive
RUN mkdir build
RUN sed -i 's:\.\./:/meta/:g' config.toml

WORKDIR /meta/build
RUN cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=On -DBUILD_STATIC_ICU=On -DLIBCXX_LIBRARY=/lib/llvm-14/lib/libc++.so.1
RUN make
RUN ./unit-test --reporter=spec
RUN make install

WORKDIR /app