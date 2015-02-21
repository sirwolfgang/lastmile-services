FROM debian:wheezy

ADD https://github.com/anope/anope/releases/download/2.0.1/anope-2.0.1-source.tar.gz /tmp/

RUN apt-get update && \
    apt-get install -y build-essential cmake libssl-dev ruby && \
    cd /tmp && \
    tar -xzf *.tar.gz && \
    cd anope-* && \
    mv modules/extra/m_ssl_openssl.cpp modules/ && \
    printf "INSTDIR=\"/srv/services\"\nRUNGROUP=\"\"\nUMASK=077\nDEBUG=\"no\"\nUSE_RUN_CC_PL=\"no\"\nUSE_PCH=\"no\"\nEXTRA_INCLUDE_DIRS=\"\"\nEXTRA_LIB_DIRS=\"\"\nEXTRA_CONFIG_ARGS=\"\"" > config.cache && \
    ./Config -quick && \
    cd build && \
    make && make install && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
CMD ["/srv/services/bin/services", "--nofork"]
