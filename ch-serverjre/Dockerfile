FROM ch-oraclelinux as builder

ENV JAVA_PKG=server-jre-8u???-linux-x64.tar.gz \
    JAVA_HOME=/usr/java/jdk-8

COPY $JAVA_PKG /tmp/jdk.tgz

RUN mkdir -p "$JAVA_HOME" && \
    cd "$JAVA_HOME" && \
    tar -xf /tmp/jdk.tgz --strip-components 1 && \
    rm /tmp/jdk.tgz

COPY certs /tmp/certs

RUN cd /tmp/certs && \
    for CERT_FILE in $(ls -1 *.pem); do \
        $JAVA_HOME/bin/keytool -importcert -alias ${CERT_FILE%*.pem} -keystore $JAVA_HOME/jre/lib/security/cacerts -file ${CERT_FILE} -storepass changeit -noprompt; \
    done

FROM ch-oraclelinux

ENV JAVA_HOME=/usr/java/jdk-8 
ENV PATH $JAVA_HOME/bin:$PATH

COPY --from=builder $JAVA_HOME $JAVA_HOME

RUN java -Xshare:dump
