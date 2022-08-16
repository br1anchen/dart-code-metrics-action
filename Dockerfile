FROM plugfox/flutter:stable

COPY ./action_app/ /action_app/

WORKDIR /action_app

RUN dart pub get

ENTRYPOINT ["dart", "run", "/action_app/bin/main.dart"]
