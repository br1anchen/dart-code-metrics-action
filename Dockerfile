# Container image that runs your code
FROM alpine:latest

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY ./action_app/ /action_app/
COPY entrypoint.sh /entrypoint.sh

RUN apk add --update --no-cache docker
RUN ["chmod", "+x", "/entrypoint.sh"]

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
