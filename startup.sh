#!/bin/bash

set -x
set -e

echo "Preparing container..."

echo "/etc/asound.conf"
cat /etc/asound.conf
echo ' '

if [ "$ALSA_EQUALIZATION" != "" ]; then
  echo "Applying equalization '$ALSA_EQUALIZATION'"
  /equalizer.sh "$ALSA_EQUALIZATION"
fi

PARAMS=()

if [ "$VERBOSE" == "true" ]; then
  PARAMS+=(-v)
fi

if [ "$SPOTIFY_NAME" == "" ]; then
  SPOTIFY_NAME=Raspotify speaker
fi
PARAMS+=(--name "$SPOTIFY_NAME")

if [ "$BACKEND_NAME" == "" ]; then
  BACKEND_NAME=alsa
fi
PARAMS+=(--backend $BACKEND_NAME)

if [ "$DEVICE_NAME" != "" ]; then
  PARAMS+=(--device $DEVICE_NAME)
fi

if [ "$SPOTIFY_USER" != "" ]; then
  PARAMS+=(--SPOTIFY_USER $SPOTIFY_USER)
fi

if [ "$SPOTIFY_PASS" != "" ]; then
  PARAMS+=(--SPOTIFY_PASSword $SPOTIFY_PASS)
fi

if [ "$SPOTIFY_BITRATE" != "" ]; then
  PARAMS+=(--SPOTIFY_BITRATE $SPOTIFY_BITRATE)
fi

if [ "$ENABLE_AUDIO_CACHE" != "true" ]; then
  PARAMS+=(--disable-audio-cache)
fi

if [ "$ENABLE_NORMALIZATION" == "true" ]; then
  PARAMS+=(--enable-volume-normalisation)
fi

if [ "$INITIAL_VOLUME" != "" ]; then
  PARAMS+=(--initial-volume $INITIAL_VOLUME)
fi

echo "Starting Raspotify..."
/usr/bin/librespot "${PARAMS[@]}" $LIBRESPOT_OPTS
