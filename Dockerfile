FROM ubuntu:jammy

ENV CC=clang-14
ENV CXX=clang++-14
ENV PATH=/meta/build:$PATH

COPY . /meta

RUN apt-get update
RUN apt install -y software-properties-common
RUN apt-get install -y git cmake libjemalloc-dev zlib1g-dev
RUN apt-get install -y clang-14 lld-14 libc++-14-dev libc++abi-14-dev

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