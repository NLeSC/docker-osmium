FROM debian:wheezy
MAINTAINER Joris Borgdorff <j.borgdorff@esciencecenter.nl>

# Create directories
RUN mkdir -p /usr/local/src /var/lib/osmium/.ssh /var/lib/osmium/sandbox

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

# Set permissions
RUN groupadd -r osmium \
  && useradd -d /var/lib/osmium -g osmium osmium \
  && chown -R osmium:osmium /var/lib/osmium

USER osmium
WORKDIR /var/lib/osmium
CMD ["/usr/bin/java", "-server", "-Xms10m", "-jar", "osmium.jar", "server", "joblauncher.yml", "osmium"]
