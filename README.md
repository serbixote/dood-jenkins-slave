# Docker out of Docker Jenkins Slave

Having Jenkins Slaves with the ability to use Docker is mandatory in a well designed CI/CD environment. 

This repository is just an example of how to achieve it using the Docker out of Docker concept (or "sibling") as explained at [Using Docker-in-Docker for your CI or testing environment? Think twice](https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci) article, without giving root access to the host.


The images of this repository are based on the [jenkins/jnlp-slave](https://hub.docker.com/r/jenkins/jnlp-slave/) official images from the [Jenkins's Docker Hub account](https://hub.docker.com/u/jenkins/).

### Quick start:

```
docker run --rm --env-file slave.env -v /var/run/docker.sock:/var/run/docker.sock \
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
