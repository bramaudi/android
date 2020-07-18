#!/bin/sh

echo "Create debug keystore..."
keytool -genkey -v -keystore debugapp.keystore -alias debugapp -keyalg RSA -keysize 2048 -validity 10000