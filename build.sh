#!/bin/bash

cd mobile-ffmpeg
rm -d -r prebuilt

./apple.sh --disable-arm64-mac-catalyst \
--disable-armv7 \
--disable-armv7s --disable-arm64 \
--disable-arm64e \
--disable-i386-simulator \
--disable-x86-64-simulator \
--disable-arm64-simulator \
--disable-x86-64-mac-catalyst \
--enable-apple-videotoolbox \
--enable-apple-audiotoolbox

rm -d -r prebuilt/macos/universal-x86_64-arm64
mkdir prebuilt/macos/universal-x86_64-arm64
lipo -create -output prebuilt/macos/universal-x86_64-arm64/ffmpeg prebuilt/macos/x86_64/ffmpeg/bin/ffmpeg prebuilt/macos/arm64/ffmpeg/bin/ffmpeg
string=$(lipo -archs prebuilt/macos/universal-x86_64-arm64/ffmpeg)
if [[ $string != *"x86_64 arm64"* ]]; then
	echo "Executable is not universal!"
	exit 1
fi

