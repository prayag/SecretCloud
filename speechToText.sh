#!/bin/sh
ffmpeg -f oss -i /dev/dsp -ar 16000 -ab 512000 ffmpeg.flac
wget -q -U "Mozilla/5.0" --post-file ffmpeg.flac --header="Content-Type: audio/x-flac; rate=16000" -O - "http://www.google.com/speech-api/v1/recognize?lang=en-us&client=chromium"

rm -rf ffmpeg.flac
