# docker build . -t 'latex'
# docker run -it --rm latex:latest /bin/bash
# docker run -it --rm -v `pwd`:/scratch latex:latest /bin/bash

# https://hub.docker.com/r/phusion/baseimage/tags
FROM phusion/baseimage:master

RUN apt-get update && \
    apt-get install -y \
	libcurl4-openssl-dev \
	postgresql-server-dev-all \
	sudo \
	latexml \
	 wget \
         zip \
         vim \
         python3 \
         python3-pip \
         python3-dev \
         texlive \
         bison \
	 autoconf  \
	 flex  \
	 automake \
	 help2man \
	 git \
	 pkg-config \
	 swig \
	 libtool \
	 build-essential \
	 cmake \
	libdeflate-dev \
	doctest-dev \
	libavformat-dev \
	libavutil-dev \
	libgpm-dev \
	libncurses-dev \
	libswscale-dev \
	libunistring-dev \
	pandoc \
	python3-cffi \
	python3-dev \
	python3-pypandoc \
	python3-setuptools \
	libxslt1-dev \
	libmagickcore-dev \
	ragel \
	virtualenv \

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
