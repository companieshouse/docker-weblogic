FROM 300288021642.dkr.ecr.eu-west-2.amazonaws.com/ch-oraclelinux:2.0.2

# Use fixed JAVA_HOME for consistency with other images
ENV JAVA_HOME=/usr/java/jdk
ENV PATH=${JAVA_HOME}/bin:$PATH

# Install security updates, OpenJDK and link from JAVA_HOME
RUN yum -y update-minimal --security && \
    yum install -y java-21-openjdk-devel.x86_64 && \
    mkdir -p /usr/java && \
    ln -s /etc/alternatives/java_sdk ${JAVA_HOME} && \
    yum clean all && \
    rm -rf /var/cache/yum

# Import custom certificates into the Java keystore
COPY certs /tmp/certs
RUN cd /tmp/certs && \
    for CERT_FILE in $(ls -1 *.pem); do \
        $JAVA_HOME/bin/keytool -importcert -alias ${CERT_FILE%*.pem} -keystore ${JAVA_HOME}/lib/security/cacerts -file ${CERT_FILE} -storepass changeit -noprompt || exit 1; \
    done && \
    rm -rf /tmp/certs

# Dump the shared class cache to improve startup performance
RUN java -Xshare:dump
