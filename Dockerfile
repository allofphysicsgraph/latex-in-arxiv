# docker build . -t 'latex'
# docker run -it --rm latex:latest /bin/bash
# docker run -it --rm -v `pwd`:/scratch latex:latest /bin/bash

# https://hub.docker.com/r/phusion/baseimage/tags
FROM phusion/baseimage:master

RUN apt-get update && \
    apt-get install -y \
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
	python3-setuptools 

WORKDIR /opt/

RUN apt-get install -y build-essential flex bison

RUN echo "alias python=python3" > /root/.bashrc
#RUN /bin/bash -l /root/.bashrc

#RUN wget https://www.cs.cornell.edu/projects/kddcup/download/hep-th-2003.tar.gz
#RUN tar -xf hep-th-2003.tar.gz

RUN apt-get install -y autoconf-archive

RUN pip3 install nltk

RUN pip3 install black

RUN git clone https://github.com/dankamongmen/notcurses
WORKDIR notcurses
RUN mkdir build
WORKDIR build
RUN cmake ..
RUN make
RUN make test
RUN make install
RUN ldconfig 
#RUN git clone https://github.com/opencog/link-grammar.git
#WORKDIR link-grammar
#RUN bash autogen.sh 
#RUN make
#RUN ./configure 
#RUN make
#RUN make install
#RUN ldconfig


