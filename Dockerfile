# VERSION    1.0
FROM jeanblanchard/busybox-java

MAINTAINER Vadim Bauer <hello@z-rechnung.de>

ENV el=elasticsearch-1.4.2

RUN curl -kLO http://download.elasticsearch.org/elasticsearch/elasticsearch/${el}.tar.gz &&\
    gunzip ${el}.tar.gz &&\
    tar -xf ${el}.tar -C /opt &&\
    rm ${el}.tar

EXPOSE 9200

ENTRYPOINT ["/opt/${el}/bin/elasticsearch"]
