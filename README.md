# Docker out of Docker Jenkins Slave

This repository is aimed to provide an example of a Docker Jenkins slave, using the Docker out of Docker concept (or "sibling" as explained at [Using Docker-in-Docker for your CI or testing environment? Think twice]( https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci)) without giving users root access to the host.

### Quick start:

```
docker run --rm --env-file slave.env \
    -v /var/run/docker.sock:/var/run/docker.sock \
    quay.io/marco2704/dood-jenkins-slave:1.8.23
```

### Using Compose:

Before running `docker-compose up` command make sure the value variables of `slave.env` are properly set. Also have in mind that the following `docker-compose.yml` file is just an example:

```
version: '3.4'
services:
  slave:
    image: quay.io/marco2704/dood-jenkins-slave:1.8.23 
    container_name: jenkins_slave
    env_file:
      - slave.env
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - slave-data:/home/jenkins/agent
volumes:
  slave-data:
```
