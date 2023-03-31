FROM debian:stable-slim

RUN apt-get update -y \
    && apt-get install -y \
           build-essential \
           curl \
           libnet-ssleay-perl \
           perl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt

WORKDIR /opt/postnr

COPY . /opt/postnr

ARG CPM_CMD=/usr/local/bin/cpm
ARG CPM_WORKERS=4

RUN curl -fsSL --compressed https://git.io/cpm > ${CPM_CMD} && chmod +x ${CPM_CMD}

RUN ${CPM_CMD} install --global --show-build-log-on-failure -w ${CPM_WORKERS}

RUN prove -l lib t

ENV MOJO_MODE production

CMD [ "hypnotoad", "-f", "/opt/postnr/script/postnr" ]
