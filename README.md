# android

Forked from: [https://github.com/mojtabamarashee/android](https://github.com/mojtabamarashee/android)

## Requirement

- Linux

  Install Android SDK, try command below if your distro is supporting, else do install manually.
  ```
  sudo apt install android-sdk
  ```

## Build

1. Create a keystore file by execute `keystore.sh` then insert your password.
2. Edit `build.sh` then change `KEYSTORE_PASS`, `SDK_DIR`, `BUILD_TOOLS` variable, adjust with your current environment.
3. Execute `build.sh`, if no error this will build an apk file in `bin` folder named `hello.apk`.