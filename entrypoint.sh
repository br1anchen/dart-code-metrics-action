#!/bin/sh -l

FLUTTER_VERSION=$1

cd /action_app
echo "creating docker image with flutter version: $FLUTTER_VERSION"

# here we can make the construction of the image as customizable as we need
# and if we need parameterizable values it is a matter of sending them as inputs
docker build -t action_app \
	--build-arg flutter_version="$FLUTTER_VERSION" \
	--build-arg GITHUB_WORKSPACE="$GITHUB_WORKSPACE" \
	--build-arg GITHUB_REPOSITORY="$GITHUB_REPOSITORY" \
	--build-arg GITHUB_SHA="$GITHUB_SHA" \
	. && docker run action_app
