# docker build . -t 'latex'
# docker run -it --rm latex:latest /bin/bash
# docker run -it --rm -v `pwd`:/scratch latex:latest /bin/bash

# https://hub.docker.com/r/phusion/baseimage/tags
FROM phusion/baseimage:18.04-1.0.0

RUN apt-get update && \
    apt-get install -y \
    autoconf  \
    automake \
    bison \
    flex  \
    git \
    help2man \
    pkg-config \
    python3 \
    python3-dev \
    python3-pip \
    swig \
    texlive \
    vim \
    wget \
    zip \
    chktex \
 libtool

WORKDIR /opt/
COPY src /opt/
RUN ./common/install_ragel.sh

# the scanner will need to be re-compiled when the user makes a change, 
# but we'll compile it the first time so they can get started immediately.
ENV PATH="${PATH}:/usr/local/ragel7/bin"
WORKDIR /opt/postings_list/query
RUN make scanner
#RUN  make read_tf_idf


RUN echo "alias python=python3" > /root/.bashrc
RUN echo "export PATH=$PATH:/usr/local/ragel7/bin" >> /root/.bashrc

RUN pip3 install pandas
#RUN /bin/bash -l /root/.bashrc


