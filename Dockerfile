FROM debian:10.11-slim

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

ENV SPOTIFY_NAME='Raspotify speaker' \
    BACKEND_NAME='alsa' \
    DEVICE_NAME='equal' \
    ALSA_EQUALIZATION='' \
    ALSA_SLAVE_PCM='plughw:0,0' \
    VERBOSE='false' \
    EQUALIZATION='' \
    SPOTIFY_USER='' \
    SPOTIFY_PASS='' \
    SPOTIFY_BITRATE='' \
    SPOTIFY_VOLUME_CONTROL='linear' \
    ENABLE_AUDIO_CACHE='false' \
    ENABLE_NORMALIZATION='false' \
    INITIAL_VOLUME='90' \
    LIBRESPOT_OPTS=''

ENTRYPOINT /startup.sh
