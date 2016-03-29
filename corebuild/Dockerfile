FROM rhel7
MAINTAINER fatherlinux <scott.mccarty@gmail.com>

ENV COREBUILD_VERSION 7.2

RUN yum install -y --setopt=tsflags=nodocs --disablerepo="*" --enablerepo="rhel-7-server-rpms" yum-utils deltarpm && \
    yum-config-manager --disable "*" && \
    yum-config-manager --enable rhel-7-server-rpms && \
    yum update-minimal -y --security --sec-severity=Important --sec-severity=Critical --setopt=tsflags=nodocs && \
    yum install -y --setopt=tsflags=nodocs iputils net-tools nmap-ncat nmap && \
    yum install -y --setopt=tsflags=nodocs tar && \
    yum clean all

# Avoid updating software supplied by base image unless necessary (I disagree completely with this advice)
# https://github.com/projectatomic/containeor-best-practices/blob/master/creating/creating_index.adoc#updating-software-supplied-by-base-image
# I (goern) in part disagree with it and added an example where you MUST do a software update 

COPY ./motd /etc/motd
RUN echo "cat /etc/motd" >> /etc/bashrc && \
    useradd -u 1001 -r -g 0 -m -d /opt/app-root -s /sbin/nologin -c "Default Application User" default && \
    chown -R 1001:0 /opt/app-root
