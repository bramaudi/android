#!/bin/bash

set -e

KEYSTORE_PASS="debugapp"
SDK_DIR="/usr/lib/android-sdk"
BUILD_TOOLS="$SDK_DIR/build-tools/27.0.1"

AAPT="$BUILD_TOOLS/aapt"
DX="$BUILD_TOOLS/dx"
ZIPALIGN="$BUILD_TOOLS/zipalign"
PLATFORM="$SDK_DIR/platforms/android-23/android.jar"

echo "Cleaning..."
rm -rf bin/*
rm -rf obj/*
rm -rf src/com/example/helloandroid/R.java

echo "Generating R.java file..."
$AAPT package -f -m -J src -M AndroidManifest.xml -S res -I $PLATFORM

echo "Compiling..."
javac -d obj -classpath src -bootclasspath $PLATFORM -source 1.7 -target 1.7 src/com/example/helloandroid/MainActivity.java
javac -d obj -classpath src -bootclasspath $PLATFORM -source 1.7 -target 1.7 src/com/example/helloandroid/R.java

echo "Translating in Dalvik bytecode..."
$DX --dex --output=classes.dex obj

echo "Making APK..."
$AAPT package -f -m -F bin/hello.unaligned.apk -M AndroidManifest.xml -S res -I $PLATFORM
$AAPT add bin/hello.unaligned.apk classes.dex

echo "Signing and aligning APK..."
# Change -storepass with the keystore pass
jarsigner -keystore debugapp.keystore -storepass $KEYSTORE_PASS bin/hello.unaligned.apk debugapp
$ZIPALIGN -f 4 bin/hello.unaligned.apk bin/hello.apk
