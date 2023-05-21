# docker build . -t 'latex'
# docker run -it --rm latex:latest /bin/bash
# docker run -it --rm -v `pwd`:/scratch latex:latest /bin/bash

# https://hub.docker.com/r/phusion/baseimage/tags
FROM phusion/baseimage:master

RUN apt-get update && \
    apt-get install -y \
        autoconf  \
        automake \
        bison \
        build-essential \
        cmake \
        doctest-dev \
        flex  \
        git \
        help2man \
        latexml \
        libavformat-dev \
        libavutil-dev \
        libcurl4-openssl-dev \
        libdeflate-dev \
        libgpm-dev \
        libmagickcore-dev \
        libncurses-dev \
        libswscale-dev \
        libtool \
        libunistring-dev \
        libxslt1-dev \
        pandoc \
        pkg-config \
        postgresql-server-dev-all \
        python3 \
        python3-cffi \
        python3-dev \
        python3-dev \
        python3-pip \
        python3-pypandoc \
        python3-setuptools \
        ragel \
        sudo \
        swig \
        texlive \
        vim \
        virtualenv \ 
        wget \
        zip 

WORKDIR /opt/

RUN apt-get install -y build-essential flex bison

RUN echo "alias python=python3" > /root/.bashrc
RUN python3 -m nltk.downloader punkt
RUN python3 -m nltk.downloader stopwords 
RUN python3 -m nltk.downloader averaged_perceptron_tagger 

WORKDIR /opt/

WORKDIR /opt/
COPY .  /opt/latex-in-arxiv
WORKDIR /opt/latex-in-arxiv/



ENTRYPOINT [ "./entry.sh" ]
