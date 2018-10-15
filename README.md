# Docker out of Docker Jenkins Slave

Having Jenkins Slaves with the ability to use Docker is mandatory in a well designed CI/CD environment. 

This repository is just an example of how to achieve it using the Docker out of Docker concept (or "sibling") as explained at [Using Docker-in-Docker for your CI or testing environment? Think twice](https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci) article, without giving root access to the host.


The images of this repository are based on the [jenkins/jnlp-slave](https://hub.docker.com/r/jenkins/jnlp-slave/) official image from the [Jenkins's Docker Hub account](https://hub.docker.com/u/jenkins/).

### Quick start:

```
docker run --rm --env-file slave.env -v /var/run/docker.sock:/var/run/docker.sock \
    quay.io/marco2704/dood-jenkins-slave:18.06.1-3.26-1-alpine
```

### Using Compose:

Before running `docker-compose up` command make sure variables of `slave.env` are properly set.

```
version: '3'
services:
  slave:
    image: quay.io/marco2704/dood-jenkins-slave:18.06.1-3.26-1-alpine
    container_name: dood_jenkins_slave
    env_file:
      - slave.env
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - slave-data:/home/jenkins/agent
volumes:
  slave-data:
```

### Using with the Kubernetes Plugin

Configure the image being is also the jnlp agent:

![](https://github.com/marco2704/dood-jenkins-slave/blob/master/examples/images/k8-plugin-2.png)

Mount the node Docker socket into the container:

![](https://github.com/marco2704/dood-jenkins-slave/blob/master/examples/images/k8-plugin-1.png)

