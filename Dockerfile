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
    ragel \
    libtool \
    bash \
    g++ \
    make


WORKDIR /opt/
COPY src /opt/

#RUN ./common/install_ragel.sh  # Replace install_ragel.sh contents as needed.

# the scanner will need to be re-compiled when the user makes a change,
# but we'll compile it the first time so they can get started immediately.
ENV PATH="${PATH}:/usr/local/bin"

# Add a non-root user
ARG USER_ID=1000
ARG GROUP_ID=1000

RUN addgroup -g ${GROUP_ID} user && \
    adduser -u ${USER_ID} -G user -s /bin/bash -D user

# Change ownership of /opt/postings_list
RUN chown -R user:user /opt/postings_list

# Set working directory
WORKDIR /opt/postings_list/query

# Switch to the non-root user AFTER setting permissions and working directory
USER user

# Create and activate virtualenv
RUN python3 -m venv venv
ENV VIRTUAL_ENV=/opt/postings_list/query/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Install pandas in virtualenv
RUN pip3 install --no-cache-dir pandas

# Build the scanner
RUN make scanner
#RUN  make read_tf_idf

# Set default command (optional - adjust based on your actual application)
CMD ["/bin/bash"] i
