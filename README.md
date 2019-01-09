# Docker out of Docker Jenkins Slave

Having Jenkins Slaves with the ability to use Docker is mandatory in a well designed CI/CD environment. 

This repository is just an example of how to achieve it using the Docker out of Docker concept (or "sibling") as explained at [Using Docker-in-Docker for your CI or testing environment? Think twice](https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci) article, without giving root access to the host.

The images of this repository are based on the [jenkins/jnlp-slave](https://hub.docker.com/r/jenkins/jnlp-slave/) official image from the [Jenkins's Docker Hub account](https://hub.docker.com/u/jenkins/).

### Quick Example:

```
docker build -t dood-jenkins-slave:$DOCKER_VERSION-$SLAVE_VERSION \
                       --build-arg DOCKER_VERSION=$DOCKER_VERSION \
                       --build-arg SLAVE_VERSION=$SLAVE_VERSION .

docker run --rm --env-file slave.env 
          -v /var/run/docker.sock:/var/run/docker.sock 
          dood-jenkins-slave:$DOCKER_VERSION-$SLAVE_VERSION
```

`slave.env` must contain the environment variables required: `JENKINS_URL`, `JENKINS_AGENT_NAME`, `JENKINS_SECRET`, `JENKINS_AGENT_WORKDIR`, `JENKINS_TUNNEL`.
