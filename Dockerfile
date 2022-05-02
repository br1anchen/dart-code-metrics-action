FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y bash curl file git unzip xz-utils zip libglu1-mesa sudo && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /home/flutter

ARG flutterVersion=stable

ADD https://api.github.com/repos/flutter/flutter/compare/${flutterVersion}...${flutterVersion} /dev/null

RUN git clone https://github.com/flutter/flutter.git -b ${flutterVersion} flutter-sdk

RUN flutter-sdk/bin/flutter precache

RUN flutter-sdk/bin/flutter config --no-analytics

ENV PATH="$PATH:/home/flutter/flutter-sdk/bin"
ENV PATH="$PATH:/home/flutter/flutter-sdk/bin/cache/dart-sdk/bin"

RUN flutter doctor

COPY ./action_app/ /action_app/

WORKDIR /action_app

RUN ls -al
RUN dart pub get

ENTRYPOINT ["dart", "run", "/action_app/bin/main.dart"]
