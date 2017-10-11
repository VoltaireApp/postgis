FROM postgres:10
MAINTAINER Basit Mustafa <basit@voltaireapp.com>

ENV POSTGIS_VERSION 2.4.0
ENV GEOS_NIGHTLY 20171010
RUN rm -f /etc/apt/trusted.gpg
RUN apt-get update
RUN apt-get install wget postgresql-server-dev-10 build-essential pkg-config libxml2-dev libgdal-dev libproj-dev libjson-c-dev xsltproc docbook-xsl docbook-mathml libprotobuf-dev libprotoc-dev libprotobuf10 libprotoc10  protobuf-c-compiler protobuf-compiler -y

RUN wget http://geos.osgeo.org/snapshots/geos-$GEOS_NIGHTLY.tar.bz2
RUN tar xfj geos-$GEOS_NIGHTLY.tar.bz2
WORKDIR geos-$GEOS_NIGHTLY
RUN ls
RUN ./configure
RUN make
RUN make install
WORKDIR ..

RUN wget http://download.osgeo.org/postgis/source/postgis-$POSTGIS_VERSION.tar.gz
RUN tar xfvzp postgis-$POSTGIS_VERSION.tar.gz
WORKDIR postgis-$POSTGIS_VERSION
RUN ./configure
RUN make install
RUN ldconfig
RUN make comments-install
RUN /etc/init.d/postgresql restart