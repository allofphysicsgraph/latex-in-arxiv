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
  libtool

WORKDIR /opt/
COPY postings_list /opt/
COPY src /opt/
RUN ./install_ragel.sh
# the scanner will need to be re-compiled when the user makes a change, 
# but we'll compile it the first time so they can get started immediately.
ENV PATH="${PATH}:/usr/local/ragel7/bin"
RUN make scanner

RUN echo "alias python=python3" > /root/.bashrc
RUN echo "export PATH=$PATH:/usr/local/ragel7/bin" >> /root/.bashrc

#RUN /bin/bash -l /root/.bashrc


