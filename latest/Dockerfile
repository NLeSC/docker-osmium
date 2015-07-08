FROM debian:wheezy
MAINTAINER Joris Borgdorff <j.borgdorff@esciencecenter.nl>

# install Java, maven and git
RUN apt-get update -y && apt-get install -y --no-install-recommends \
  openjdk-7-jre-headless \
  openjdk-7-jdk \
  maven \
  git

# Create user and directories
RUN groupadd -r osmium && useradd -d /var/lib/osmium -g osmium osmium \
  && mkdir -p /var/lib/osmium/.ssh \
  && mkdir -p /usr/local/src

COPY ./start.sh /var/lib/osmium/

# Set permissions
RUN chown -R osmium:osmium /var/lib/osmium \
  && chmod 0755 /var/lib/osmium/start.sh \
  && chown -R osmium:osmium /usr/local/src

# Install osmium
USER osmium
RUN git clone https://github.com/NLeSC/osmium /usr/local/src/osmium
WORKDIR /usr/local/src/osmium
RUN mvn package \
  && cp target/osmium-?.?.?.jar /var/lib/osmium/osmium.jar

# Clean up to reduce image size. JDK was only needed for compiling.
USER root
RUN apt-get --purge autoremove -y openjdk-7-jdk \
  && apt-get clean -y
USER osmium
RUN rm -r /usr/local/src/osmium ~/.m2

WORKDIR /var/lib/osmium
ENTRYPOINT ["./start.sh"]
