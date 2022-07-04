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
	python3-setuptools \
	libxslt1-dev \
	libmagickcore-dev

WORKDIR /opt/

RUN apt-get install -y build-essential flex bison

RUN echo "alias python=python3" > /root/.bashrc
#RUN /bin/bash -l /root/.bashrc

#RUN wget https://www.cs.cornell.edu/projects/kddcup/download/hep-th-2003.tar.gz
#RUN tar -xf hep-th-2003.tar.gz
RUN apt-get install -y autoconf-archive

COPY requirements.txt /opt/
RUN pip3 install -r requirements.txt

RUN python3 -m nltk.downloader punkt
RUN python3 -m nltk.downloader averaged_perceptron_tagger 

RUN git clone https://github.com/brucemiller/LaTeXML
WORKDIR LaTeXML
RUN    perl -MCPAN -e 'install XML::LibXML'
RUN    perl -MCPAN -e 'install XML::LibXSLT'
RUN    perl -MCPAN -e 'install XML::LibXSLT'
RUN    perl -MCPAN -e 'install Parse::RecDescent'
RUN    perl -MCPAN -e 'install Image::Magick'
RUN    perl -MCPAN -e 'install Pod::Parser'
RUN    perl -MCPAN -e 'install IO::String'
RUN    perl -MCPAN -e 'install Image::Size'
RUN    perl -MCPAN -e 'install JSON::XS'
RUN    perl -MCPAN -e 'install Text::Unidecode'
RUN    echo install -f Archive::Zip |cpan
RUN    perl Makefile.PL
RUN    make
RUN    make test
RUN    make install

WORKDIR /opt/


WORKDIR /opt/
RUN git clone https://github.com/allofphysicsgraph/latex-in-arxiv
WORKDIR /opt/latex-in-arxiv/
RUN make sampledata
#RUN make install_libbloom
#RUN make bloom

#RUN ./bloom_filter sound1.tex

#RUN git clone https://github.com/dankamongmen/notcurses
#WORKDIR notcurses
#RUN mkdir build
#WORKDIR build
#RUN cmake ..
#RUN make
#RUN make test
#RUN make install
#RUN ldconfig 



