FROM alpine:latest

# Install necessary packages
RUN apk update && apk add --no-cache \
    autoconf \
    automake \
    bison \
    flex \
    git \
    help2man \
    pkgconfig \
    python3 \
    python3-dev \
    py3-pip \
    swig \
    texlive \
    vim \
    wget \
    zip \
    libtool \
    bash \
    g++ \
    make \
    ragel

WORKDIR /opt/
COPY src /opt/

#RUN ./common/install_ragel.sh  # Replace install_ragel.sh contents as needed.

# the scanner will need to be re-compiled when the user makes a change, 
# but we'll compile it the first time so they can get started immediately.
ENV PATH="${PATH}:/usr/local/bin"
WORKDIR /opt/postings_list/query
RUN make scanner
#RUN  make read_tf_idf


# Add a non-root user
ARG USER_ID=1000
ARG GROUP_ID=1000

RUN addgroup -g ${GROUP_ID} user && \
    adduser -u ${USER_ID} -G user -s /bin/bash -D user

USER user
WORKDIR /home/user

# Create and activate virtualenv
RUN python3 -m venv venv
ENV VIRTUAL_ENV=/home/user/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Install pandas in virtualenv
RUN pip3 install --no-cache-dir pandas

# Set default command (optional - adjust based on your actual application)
CMD ["/bin/bash"] 

