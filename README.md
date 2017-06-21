# aws-automation-bash
A docker project to create a shall with all nessasary tools to automate AWS with ansible, maven and docker.

The idea is to create a environment which can be reproduced ans shared, but will not influence your own environment. 
By mounting custom information into the docker you can use your own project, ssh key and config inside the container. 

##Tools provides by the BASH
 
The follwoing tool will be provices by this shell

 * AWS-CLI
 * BOTO and BOTO3
 * Ansible 
 * Java
 * Maven
 * Docker-ce
 
 ## Hot to get it work
 
 You can start the bash of this container with the follwing command:
 
    docker run -ti -v $(pwd):/project -v ~/.aws:/root/.aws -v $HOME/.ssh:/root/.ssh  -v /var/run/docker.sock:/var/run/docker.sock kochp/aws-automation-bash:v1.3 bash
    
 This command configures the follwing option: 
 
 * -v $(pwd):/project: Mount the current folder as Project folder into the container.
 * -v ~/.aws:/root/.aws: Mount your personal aws settings and credentials into the container.
 * -v $HOME/.ssh:/root/.ssh: Mount your personal ssh key into the container.
 * -v /var/run/docker.sock:/var/run/docker.sock: Mount the docker socket into the container to user docker in docker.

## How to build and push

    docker login
    docker build -t kochp/aws-automation-bash:v1.3 .
    docker push kochp/aws-automation-bash:v1.3

## Dependencies

Depends on the image: williamyeh/ansible:ubuntu16.04
 
 
