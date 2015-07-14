FROM debian:jessie
MAINTAINER Joris Borgdorff <j.borgdorff@esciencecenter.nl>

# Remove warnings during apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Create directories
RUN mkdir -p /usr/local/src /var/lib/osmium/.ssh

# Install runtime dependencies
RUN apt-get update -y && apt-get install -y --no-install-recommends \
      openjdk-7-jre-headless \
      openssh-client \
      openjdk-7-jdk \
      gradle \
      git \
      ant

RUN git clone https://github.com/NLeSC/xenon /usr/local/src/xenon \
    && cd /usr/local/src/xenon \
    && git checkout develop \
    && ant

RUN git clone https://github.com/NLeSC/osmium.git /usr/local/src/osmium \
    && cd /usr/local/src/osmium \
    && git checkout gradle \
    && cp /usr/local/src/xenon/lib/*.jar lib \
    && cp /usr/local/src/xenon/lib/*/*.jar lib \
    && cp /usr/local/src/xenon/dist/nlesc-xenon-*/lib/xenon-*.jar lib/xenon.jar \
    && gradle fatJar \
    && cp build/libs/osmium-all-*.jar /var/lib/osmium/osmium.jar \
    && cp joblauncher.yml-dist /var/lib/osmium/joblauncher.yml

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
