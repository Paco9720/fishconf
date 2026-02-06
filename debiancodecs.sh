#!/bin/bash

echo "Instalando Codecs"
sudo apt update
sudo apt install \
ffmpeg \
libavcodec-extra\
gstreamer1.0-plugins-base \
gstreamer1.0-plugins-good \
gstreamer1.0-plugins-bad \
gstreamer1.0-plugins-ugly \
gstreamer1.0-libav
echo "Codecs Instalados"
