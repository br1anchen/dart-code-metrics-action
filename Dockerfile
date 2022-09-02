ARG FLUTTER_VERSION=stable

FROM cirrusci/flutter:${FLUTTER_VERSION}

COPY ./action_app/ /action_app/

WORKDIR /action_app

RUN dart pub get

ENTRYPOINT ["dart", "run", "/action_app/bin/main.dart"]
