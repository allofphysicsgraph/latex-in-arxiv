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
    texlive-full \
    cmake \
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
COPY utils /opt/

RUN gcc strip_non_ascii.c -o  strip_non_ascii.out
RUN mv strip_non_ascii.out /usr/bin/

RUN gcc newcommand.c -o  newcommand.out
RUN mv newcommand.out /usr/bin/
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
#RUN pip3 install --no-cache-dir gensim
RUN pip3 install --no-cache-dir nltk
RUN pip3 install --no-cache-dir pandas
RUN pip3 install --no-cache-dir psycopg2-binary
RUN pip3 install --no-cache-dir sentencepiece
RUN pip3 install --no-cache-dir spacy
RUN pip3 install --no-cache-dir sqlalchemy
RUN pip3 install --no-cache-dir stanza
RUN pip3 install --no-cache-dir sumy
RUN pip3 install --no-cache-dir yake
# Build the scanner
RUN make scanner
#RUN  make read_tf_idf

# Set default command (optional - adjust based on your actual application)
CMD ["/bin/bash"] 
