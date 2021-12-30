FROM debian:11.2-slim as build-stage

ARG USERNAME=raspotify
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID -m $USERNAME && \
    usermod -a -G audio $USERNAME && \
    apt update && \
    apt install -y apt-transport-https ca-certificates curl gnupg && \
    curl -kfsSL https://dtcooper.github.io/raspotify/key.asc | gpg --dearmor --yes -o /usr/share/keyrings/raspotify-archive-keyring.gpg && \
    echo 'deb [signed-by=/usr/share/keyrings/raspotify-archive-keyring.gpg] https://dtcooper.github.io/raspotify raspotify main' > /etc/apt/sources.list.d/raspotify.list && \
    apt update && \
    apt install -y --no-install-recommends \
      alsa-utils libasound2-plugins libasound2-plugin-equal gettext \
      raspotify && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

COPY equalizer.sh startup.sh /
RUN chmod 755 /startup.sh && chmod 755 /equalizer.sh

USER $USERNAME

ENV LIBRESPOT_DEVICE_NAME='Raspotify speaker' \
    LIBRESPOT_BACKEND_NAME='alsa' \
    LIBRESPOT_AUDIO_DEVICE='' \
    LIBRESPOT_INITIAL_VOLUME='90' \
    LIBRESPOT_OPTS='' \
    LIBRESPOT_VERBOSE='true' \
    SPOTIFY_USER='' \
    SPOTIFY_PASS='' \
    SPOTIFY_BITRATE='320' \
    SPOTIFY_VOLUME_CONTROL='linear' \
    ENABLE_AUDIO_CACHE='false' \
    ENABLE_NORMALIZATION='false' \
    ALSA_EQUALIZATION=''

FROM build-stage as final-stage

ENTRYPOINT /startup.sh
