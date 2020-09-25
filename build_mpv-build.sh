#!/bin/bash


# Reference
# https://github.com/mpv-player/mpv-build
# https://nwgat.ninja/compling-mpv-ffmpeg-on-ubuntu-20-04-lts/
# https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=mpv-full-build-git


#Current issue: doesnt open youtube videos.

# dependencies
sudo apt-get install libxkbcommon-dev autoconf autogen pkg-config libtool libfreetype6-dev libfribidi-dev fontconfig libfontconfig1-dev yasm xorg-dev libgnutls28-dev libluajit-5.1-dev libva-dev libegl-dev libpulse-dev

DIR="/home/pborges/build/mpv-build"

if [ -d "$DIR" ]; then
    cd "$DIR"
    git pull
else
    git clone https://github.com/mpv-player/mpv-build.git
fi

cd "$DIR"
echo "--disable-libopencv" >> ffmpeg_options
echo "--disable-libtls" >> ffmpeg_options
echo "--disable-mbedtls" >> ffmpeg_options
echo "--disable-programs" >> ffmpeg_options
echo "--enable-gnutls" >> ffmpeg_options
echo "--enable-pulse" >> mpv_options
echo "--enable-libmpv-shared" >> mpv_options
echo "--lua=luajit" >> mpv_options
echo "--enable-lua" >> mpv_options
echo "--enable-wayland" >> mpv_options
echo "--enable-wayland-protocols" >> mpv_options
echo "--enable-wayland-scanner" >> mpv_options
echo "--enable-vaapi-wayland" >> mpv_options
echo "--enable-gl-wayland" >> mpv_options
echo "--enable-libmpv-shared" >> mpv_options
#echo "--enable-egl-x11" >> mpv_options
echo "--enable-vaapi-x11" >> mpv_options
echo "--enable-vaapi-x11" >> mpv_options

#echo "--enable-vaapi-x-egl" >> mpv_options
./rebuild -j4
sudo ./install
