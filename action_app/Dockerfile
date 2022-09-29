ARG flutter_version

FROM cirrusci/flutter:${flutter_version}

COPY ./ /action_app/

WORKDIR /action_app

RUN dart pub get

ENTRYPOINT ["dart", "run", "/action_app/bin/main.dart"]
