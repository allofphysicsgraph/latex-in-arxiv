#origin	https://github.com/influxdata/flux/Dockerfile

COLM_VERSION=0.14.2
RAGEL7_VERSION=7.0.1
    curl https://www.colm.net/files/colm/colm-${COLM_VERSION}.tar.gz -O 
    tar -xzf colm-${COLM_VERSION}.tar.gz 
    cd colm-${COLM_VERSION}/ 
    ./configure --prefix=/usr/local/ragel7 
    make 
    sudo make install
    
    cd .. 
    curl https://www.colm.net/files/ragel/ragel-${RAGEL7_VERSION}.tar.gz -O 
    tar -xzf ragel-${RAGEL7_VERSION}.tar.gz 
    cd ragel-${RAGEL7_VERSION}/ 
    ./configure --prefix=/usr/local/ragel7 --with-colm=/usr/local/ragel7 --disable-manual 
    make 
    sudo make install 
