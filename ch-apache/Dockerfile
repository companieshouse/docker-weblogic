FROM 300288021642.dkr.ecr.eu-west-2.amazonaws.com/ch-oraclelinux:2.0.1 AS builder

# Install build tools and dependencies
RUN yum -y install gcc && \
    yum -y install pcre-devel && \
    yum -y install expat-devel && \
    yum -y install openssl && \
    yum -y install make

# Copy over apache and apr source
COPY *.tar.gz .

# Extract source and build
RUN tar -xzf httpd-2.*.tar.gz && \
    tar -xzf apr-1.*.tar.gz && \
    tar -xzf apr-util-1.*.tar.gz && \
    rm *.tar.gz && \
    cd httpd-2.* && \
    mv ../apr-util-* srclib/apr-util && \
    mv ../apr-* srclib/apr && \
    ./configure --with-included-apr && \
    make install

FROM 300288021642.dkr.ecr.eu-west-2.amazonaws.com/ch-serverjre:2.0.0

ENV APACHE_HOME=/usr/local/apache2
ENV PLUGINS_HOME=${APACHE_HOME}/modules/WLSPlugin14.1.2.0
ENV LD_LIBRARY_PATH=${PLUGINS_HOME}

# Copy the apache folder over
COPY --from=builder ${APACHE_HOME} ${APACHE_HOME}

# Copy the WebLogic Apache plugin lib folder onto the image   
COPY lib ${PLUGINS_HOME}

WORKDIR ${APACHE_HOME}

# Use a custom start script to allow creation of exportedlogs/apache directory before startup
COPY start-apache.sh bin/start-apache.sh
RUN chmod +x bin/start-apache.sh

# Reference the plugin module
RUN sed -i '/mod_rewrite.so$/a LoadModule weblogic_module modules\/WLSPlugin14.1.2.0\/mod_wl_24.so' conf/httpd.conf

CMD ["bin/start-apache.sh"]
