# InvenTree APK Builder (Android)

Builds the InvenTree Android app from source using Docker, producing an APK file in the output directory.

The official InvenTree mobile app requires a paid download. This tool builds it for free from the open-source MIT-licensed source code at https://github.com/inventree/inventree-app.

## Requirements

- Docker Desktop (Windows/Mac) or Docker Engine (Linux)
- ~10 GB free disk space (Flutter SDK + Android NDK + build cache)

## Usage

**1. Clone this repository**

    git clone https://github.com/laurensramandt/inventree-mobile-app-apk-builder
    cd inventree-apk-builder

**2. Build the Docker image**

    docker build -t inventree-apk-builder .

**3. Create the output directory and run the build**

    mkdir output
    docker run --rm -v ${PWD}/output:/output inventree-apk-builder

On first run, Gradle will download the Android SDK, NDK, and CMake. This takes 15-30 minutes depending on your connection. Subsequent runs use Docker layer cache and are much faster.

**4. Install the APK**

The APK will be at `output/app.apk`. Transfer it to your Android device and install it. You may need to enable "Install from unknown sources" in your device settings.

## Connecting to InvenTree

After installing, open the app and add your server:

- Server URL: http://YOUR_SERVER_IP:PORT
- Username and password: your InvenTree admin credentials
- Your phone must be on the same network as your InvenTree server for local installs

## Output

- `output/app.apk` - signed release APK ready to install on Android

## Notes

- The Dockerfile clones the latest stable InvenTree app source on every image build. To pin to a specific version, edit the git clone line in the Dockerfile to use a specific tag.
- The APK is signed with a self-generated dummy keystore. It is not suitable for Play Store publishing.
- iOS is not supported. Apple requires a paid developer account to sideload apps.

## Troubleshooting

- **Out of disk space**: The build requires ~10 GB. Free up space or increase Docker Desktop's disk image size in Settings > Resources.
- **Build fails with Gradle error**: Run `docker build --no-cache` to force a fresh clone of the latest source.
- **App cannot connect to server**: Ensure your phone and server are on the same network. Use the IP address, not a hostname.

## License

Licensed under the MIT License. See the LICENSE file for more information.

The InvenTree app source code is also MIT licensed: https://github.com/inventree/inventree-app
