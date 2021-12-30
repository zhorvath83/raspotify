# Raspotify docker container

You can use this container to create a Spotify Speaker at your home, but you must have a Spotify Premium account.

The process run is librespot, an open source client library for Spotify. This docker container image leverages the work from David Cooper.

## Usage

* Download docker-compose.yaml
* Run `docker-compose up -d`
* Open Spotify App and click on a speaker icon (Connect to a device)
* Select the speaker "Raspotify speaker"
* Enjoy!

## ENVs

* LIBRESPOT_DEVICE_NAME: Specifies the name of this speaker (shown in Spotify client)
* LIBRESPOT_AUDIO_DEVICE: defined to a hardware (eg. "hw:0,0") to which the sound will be output using ALSA
* LIBRESPOT_INITIAL_VOLUME: Initial volume in % from 0-100.
* LIBRESPOT_OPTS: Additional Librespot opts.
* LIBRESPOT_VERBOSE: Enable verbose output	
* SPOTIFY_USER: Optional username used to sign in with.
* SPOTIFY_PASS: Optional Password used to sign in with.
* SPOTIFY_BITRATE: Bitrate (kbps): 96, 160, 320. Defaults to 320.
* SPOTIFY_VOLUME_CONTROL: Volume control type cubic, fixed, linear, log. Defaults to linear.
* ENABLE_AUDIO_CACHE: Enable/disable caching of the audio data.
* ENABLE_NORMALIZATION: Enables volume normalisation for librespot.
