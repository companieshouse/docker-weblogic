FROM oraclelinux:8

ENV LANG=en_GB.UTF-8

RUN yum -y install iputils.x86_64 \
    vim-minimal \
    bind-utils \
    less \
    unzip; \
    yum clean all && \
    rm -fr /var/cache
