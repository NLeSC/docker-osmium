# Docker recipe for Osmium

[Osmium](https://github.com/NLeSC/osmium) is the web service to the middleware library [Xenon](http://nlesc.github.io/Xenon). This docker image is a base image, do a local build (in `local` directory) to configure it correctly. In that directory place:

    joblauncher.yml  # Osmium configuration
    ssh_key          # public key to be added to anywhere Osmium should SSH to
    ssh_key.pub      # private key (no passphrase) belonging to the public key
    ssh_known_hosts  # SSH known hosts file, to avoid hostname spoofing
    ssh_config       # SSH configuration for each host

The Osmium configuration is described on the [Osmium git repository](https://github.com/NLeSC/osmium). Make sure that the exposed port in the local Dockerfile matches the HTTP ports in `joblauncher.yml`.

SSH keys can be generated with:

    ssh-keygen -f ssh_key -N ""

SSH known hosts and SSH config may be empty, depending on your preferences.