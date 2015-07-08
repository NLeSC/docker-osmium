FROM nlesc/osmium:develop

USER root
COPY ./joblauncher.yml /var/lib/osmium/
COPY ./ssh_key /var/lib/osmium/.ssh/id_rsa
COPY ./ssh_key.pub /var/lib/osmium/.ssh/id_rsa.pub
COPY ./ssh_config /var/lib/osmium/.ssh/config
COPY ./ssh_known_hosts /var/lib/osmium/.ssh/known_hosts

RUN chown -R osmium:osmium /var/lib/osmium \
  && chmod 0600 /var/lib/osmium/.ssh/id_rsa \
               /var/lib/osmium/.ssh/id_rsa.pub

USER osmium

# Make sure that this port matches the one in joblauncher.yml
EXPOSE 9998
