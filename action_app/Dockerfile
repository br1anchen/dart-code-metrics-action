ARG flutter_version

ARG GITHUB_WORKSPACE
ENV GITHUB_WORKSPACE $GITHUB_WORKSPACE

ARG GITHUB_REPOSITORY
ENV GITHUB_REPOSITORY $GITHUB_REPOSITORY

ARG GITHUB_SHA
ENV GITHUB_SHA $GITHUB_SHA

FROM cirrusci/flutter:${flutter_version}

COPY ./ /action_app/

WORKDIR /action_app

RUN dart pub get

ENTRYPOINT ["dart", "run", "/action_app/bin/main.dart"]
