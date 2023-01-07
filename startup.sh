#!/bin/bash

set -x
set -e

echo "Preparing container..."

PARAMS=()

if [ "$LIBRESPOT_VERBOSE_LOGGING" != "true" ]; then
  PARAMS+=(--verbose)
fi

if [ "$LIBRESPOT_DEVICE_NAME" == "" ]; then
  LIBRESPOT_DEVICE_NAME=Raspotify speaker
fi
PARAMS+=(--name "$LIBRESPOT_DEVICE_NAME")

if [ "$LIBRESPOT_BACKEND_NAME" == "" ]; then
  LIBRESPOT_BACKEND_NAME=alsa
fi
PARAMS+=(--backend $LIBRESPOT_BACKEND_NAME)

if [ "$LIBRESPOT_AUDIO_DEVICE" != "" ]; then
  PARAMS+=(--device $LIBRESPOT_AUDIO_DEVICE)
fi

if [ "$SPOTIFY_USER" != "" ]; then
  PARAMS+=(--username $SPOTIFY_USER)
fi

if [ "$SPOTIFY_PASS" != "" ]; then
  PARAMS+=(--password $SPOTIFY_PASS)
fi

if [ "$SPOTIFY_BITRATE" != "" ]; then
  PARAMS+=(--bitrate $SPOTIFY_BITRATE)
fi

if [ "$SPOTIFY_VOLUME_CONTROL" != "" ]; then
  PARAMS+=(--volume-ctrl $SPOTIFY_VOLUME_CONTROL)
fi

if [ "$ENABLE_AUDIO_CACHE" != "true" ]; then
  PARAMS+=(--disable-audio-cache)
fi

if [ "$ENABLE_NORMALIZATION" == "true" ]; then
  PARAMS+=(--enable-volume-normalisation)
fi

if [ "$LIBRESPOT_INITIAL_VOLUME" != "" ]; then
  PARAMS+=(--initial-volume $LIBRESPOT_INITIAL_VOLUME)
fi

echo "Starting Raspotify..."
/usr/bin/librespot "${PARAMS[@]}" $LIBRESPOT_OPTS
