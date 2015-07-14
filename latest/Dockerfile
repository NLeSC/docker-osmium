FROM debian:wheezy
MAINTAINER Joris Borgdorff <j.borgdorff@esciencecenter.nl>

# Create directories
RUN mkdir -p /usr/local/src /var/lib/osmium/.ssh

# Install runtime dependencies
RUN apt-get update -y && apt-get install -y --no-install-recommends \
      openjdk-7-jre-headless openssh-client

# Install build dependencies; install osmium; uninstall build dependencies.
# Written in one command to yield a relatively small image
RUN apt-get update -y && apt-get install -y --no-install-recommends \
      openjdk-7-jdk \
      maven \
      git \
  && git clone https://github.com/NLeSC/osmium /usr/local/src/osmium \
  && cd /usr/local/src/osmium \
  && mvn package \
  && cp target/osmium-?.?.?.jar /var/lib/osmium/osmium.jar \
  && cp joblauncher.yml-dist /var/lib/osmium/joblauncher.yml \
  && apt-get --purge autoremove -y \
      openjdk-7-jdk \
      maven \
      git \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/local/src/osmium ~/.m2

COPY ./start.sh /

# Set permissions
RUN groupadd -r osmium \
  && useradd -d /var/lib/osmium -g osmium osmium \
  && chown -R osmium:osmium /var/lib/osmium \
  && chmod 0755 /start.sh

USER osmium
WORKDIR /var/lib/osmium
ENTRYPOINT ["/start.sh"]
CMD ["osmium"]

