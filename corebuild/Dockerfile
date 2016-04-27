FROM rhel7
MAINTAINER fatherlinux <scott.mccarty@gmail.com>

ENV COREBUILD_VERSION 7.2

RUN yum install -y --setopt=tsflags=nodocs --disablerepo="*" --enablerepo="rhel-7-server-rpms" yum-utils && \
    yum-config-manager $(for i in `subscription-manager repos --list-enabled | grep "Repo ID" | awk '{print $3}'`; do echo "--disable $i"; done) \
                               --enable rhel-7-server-rpms \
                               --enable rhel-7-server-extras-rpms
RUN yum install -y --setopt=tsflags=nodocs deltarpm iputils net-tools nmap-ncat nmap tar && \
    yum update -y --setopt=tsflags=nodocs && \
    yum clean all

# Avoid updating software supplied by base image unless necessary (I disagree completely with this advice)
# https://github.com/projectatomic/container-best-practices/blob/master/creating/creating_index.adoc#updating-software-supplied-by-base-image

COPY ./motd /etc/motd
RUN echo "cat /etc/motd" >> /etc/bashrc && \
    useradd -u 1001 -r -g 0 -m -d /opt/app-root -s /sbin/nologin -c "Default Application User" default && \
    chown -R 1001:0 /opt/app-root
