FROM corebuild

# This image provides a Ruby 2.2 environment you can use to run your Ruby
# applications.

EXPOSE 8080

ENV RUBY_VERSION 2.2

LABEL summary="Platform for building and running Ruby 2.2 applications" \
      io.k8s.description="Platform for building and running Ruby 2.2 applications" \
      io.k8s.display-name="Ruby 2.2" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,ruby,ruby22"

# Labels consumed by Red Hat build service
LABEL BZComponent="rh-ruby22-docker" \
      Name="rhscl/ruby-22-rhel7" \
      Version="2.2" \
      Release="1" \
      Architecture="x86_64"

RUN yum-config-manager --enable rhel-server-rhscl-7-rpms && \
    yum-config-manager --enable rhel-7-server-optional-rpms && \
    INSTALL_PKGS="rh-ruby22 rh-ruby22-ruby-devel rh-ruby22-rubygem-rake v8314 rh-ruby22-rubygem-bundler nodejs010" && \
    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && rpm -V $INSTALL_PKGS && \
    yum clean all -y

RUN chown -R 1001:0 /opt/app-root

USER 1001

ADD ./cmd.sh /

CMD ["/cmd.sh"]
