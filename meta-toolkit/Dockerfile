FROM debian:stretch

MAINTAINER Maciej Szymkiewicz "matthew.szymkiewicz@gmail.com"

ENV METADIR /opt/meta
RUN mkdir -p $METADIR

#meta build issues with newer versions of debian
#debian jessie/stretch fails to update, end of life
RUN sed -i 's/security.debian/archive.debian/g' /etc/apt/sources.list
RUN sed -i 's/deb.debian/archive.debian/g' /etc/apt/sources.list

RUN apt-get update ;exit 0
RUN apt install cmake -y
RUN apt-get -y install cmake libicu-dev git g++ zlib1g-dev g++  git make wget libjemalloc-dev && apt-get clean

WORKDIR $METADIR
RUN git clone --depth 1 https://github.com/meta-toolkit/meta.git .
RUN git submodule update --init --recursive
COPY CMakeLists.txt /opt/meta/CMakeLists.txt
COPY data /opt/meta/
COPY deps /opt/meta/

# from your build directory
RUN mkdir $METADIR/build

WORKDIR $METADIR/build
COPY downloads $METADIR/build
COPY data /opt/meta/build
COPY deps /opt/meta/build
RUN cp  $METADIR/config.toml .
RUN cmake $METADIR -DCMAKE_BUILD_TYPE=Release 

#fails build on ICU
#RUN make
#RUN sed -i 's/xlocale/locale/g' /opt/meta/build/deps/icu-58.2/src/ExternalICU/source/i18n/digitlst.cpp
#RUN make

#RUN ctest --output-on-failure

#RUN apt-get -y purge git && apt-get -y autoremove 
