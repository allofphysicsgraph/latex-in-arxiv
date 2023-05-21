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
        subversion \
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

WORKDIR /opt/

WORKDIR /opt/
COPY .  /opt/latex-in-arxiv
WORKDIR /opt/latex-in-arxiv/
RUN svn export https://github.com/allofphysicsgraph/latex-in-arxiv.git/trunk/ragel_files/python



ENTRYPOINT [ "./entry.sh" ]
