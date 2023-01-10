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
	libmagickcore-dev

WORKDIR /opt/

RUN apt-get install -y build-essential flex bison

RUN echo "alias python=python3" > /root/.bashrc
RUN echo "export PATH=$PATH:/usr/lib/postgresql/12/bin/ >> /root/.bashrc"
#RUN /bin/bash -l /root/.bashrc

#RUN wget https://www.cs.cornell.edu/projects/kddcup/download/hep-th-2003.tar.gz
#RUN tar -xf hep-th-2003.tar.gz
RUN apt-get install -y autoconf-archive

COPY requirements.txt /opt/
RUN pip3 install -r requirements.txt

RUN python3 -m nltk.downloader punkt
RUN python3 -m nltk.downloader averaged_perceptron_tagger 

WORKDIR /opt/

WORKDIR /opt/
#RUN git clone https://github.com/allofphysicsgraph/latex-in-arxiv
COPY .  /opt/latex-in-arxiv
WORKDIR /opt/latex-in-arxiv/
RUN make openssl
RUN make Kore
#RUN make sampledata
RUN mkdir -p /dev/shm/db
RUN tar -xf /opt/latex-in-arxiv/websocket/assets/html/2003.tar.xz
#RUN chown postgres -R /dev/shm/db
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

EXPOSE 8888
ENTRYPOINT [ "./entry.sh" ]
