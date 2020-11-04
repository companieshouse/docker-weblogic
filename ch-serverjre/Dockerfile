FROM ch-oraclelinux as builder

ENV JAVA_PKG=server-jre-8u???-linux-x64.tar.gz \
JAVA_HOME=/usr/java/jdk-8

COPY $JAVA_PKG /tmp/jdk.tgz

RUN set -eux; \
mkdir -p "$JAVA_HOME"; \
cd "$JAVA_HOME"; \
tar -xf /tmp/jdk.tgz --strip-components 1; \
rm /tmp/jdk.tgz

FROM ch-oraclelinux

ENV JAVA_HOME=/usr/java/jdk-8 
ENV PATH $JAVA_HOME/bin:$PATH

COPY --from=builder $JAVA_HOME $JAVA_HOME

RUN java -Xshare:dump
