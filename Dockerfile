FROM cirrusci/android-sdk:30

USER root

ENV FLUTTER_HOME=${HOME}/sdks/flutter \
    FLUTTER_VERSION=stable
ENV FLUTTER_ROOT=$FLUTTER_HOME

ENV PATH ${PATH}:${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin

RUN git clone --depth 1 --branch ${FLUTTER_VERSION} https://github.com/flutter/flutter.git ${FLUTTER_HOME}

RUN yes | flutter doctor --android-licenses \
    && flutter doctor \
    && chown -R root:root ${FLUTTER_HOME}

COPY ./action_app/ /action_app/

WORKDIR /action_app

RUN dart pub get

ENTRYPOINT ["dart", "run", "/action_app/bin/main.dart"]
