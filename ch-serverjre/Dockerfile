FROM 300288021642.dkr.ecr.eu-west-2.amazonaws.com/ch-oraclelinux:2.0.1 AS builder

ENV JAVA_PKG=jdk-21-21.?.*_linux-x64_bin.tar.gz \
    JAVA_HOME=/usr/java/jdk

COPY $JAVA_PKG /tmp/jdk.tgz

RUN mkdir -p "$JAVA_HOME" && \
    cd "$JAVA_HOME" && \
    tar -xf /tmp/jdk.tgz --strip-components 1 && \
    rm /tmp/jdk.tgz

COPY certs /tmp/certs

RUN cd /tmp/certs && \
    for CERT_FILE in $(ls -1 *.pem); do \
        $JAVA_HOME/bin/keytool -importcert -alias ${CERT_FILE%*.pem} -keystore $JAVA_HOME/lib/security/cacerts -file ${CERT_FILE} -storepass changeit -noprompt; \
    done

FROM 300288021642.dkr.ecr.eu-west-2.amazonaws.com/ch-oraclelinux:2.0.1

ENV JAVA_HOME=/usr/java/jdk
ENV PATH=$JAVA_HOME/bin:$PATH

COPY --from=builder $JAVA_HOME $JAVA_HOME

RUN java -Xshare:dump
