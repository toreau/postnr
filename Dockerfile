FROM perl:5.36-slim-bullseye

WORKDIR /opt/postnr

COPY . /opt/postnr

ARG CPM_CMD=/usr/local/bin/cpm
ARG CPM_WORKERS=4

RUN ${CPM_CMD} install --global --show-build-log-on-failure -w ${CPM_WORKERS}

RUN prove -l lib t

ENV MOJO_MODE production

CMD [ "hypnotoad", "-f", "/opt/postnr/script/postnr" ]
