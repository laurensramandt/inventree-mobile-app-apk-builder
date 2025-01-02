FROM fischerscode/flutter-sudo:stable
#USER root
# Set working directory
WORKDIR /app

# Install dependencies
RUN sudo apt-get update && sudo apt-get install -y git python3 python3-pip unzip wget python3-venv android-sdk ninja-build

# Create a virtual environment for Python dependencies
RUN sudo python3 -m venv /env
RUN sudo /env/bin/pip install --upgrade pip
RUN sudo /env/bin/pip install invoke

# Clean the app directory and clone the Git repository
RUN rm -rf /app/* \
    && git clone --branch 0.17.2 https://github.com/inventree/inventree-app.git /app
RUN git config --global --add safe.directory /home/mobiledevops/.flutter-sdk
# Create a symlink for Python
RUN sudo ln -s /usr/bin/python3 /usr/bin/python

# Run localization before pub get using virtual environment's invoke
RUN /env/bin/invoke translate

# Install dependencies using flutter pub get with global flutter
RUN flutter pub get

USER root

# Run Android-specific setup
RUN git config --global --add safe.directory /home/flutter/flutter-sdk

RUN apt-get -y install openjdk-17-jdk 

RUN echo "storePassword=Secret123\nkeyPassword=Secret123\nkeyAlias=key\nstoreFile=/tmp/keys.jks" > /app/android/key.properties

RUN echo -ne "\n24333f8a63b6825ea9c5514f83c2829b004d1fee" > /usr/lib/android-sdk/licenses/android-sdk-license && \
	keytool -genkeypair -v -keystore /tmp/keys.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key -storepass Secret123 -keypass Secret123 -dname "CN=Dummy, OU=Dummy, O=Dummy, L=Dummy, ST=Dummy, C=US" 
RUN /env/bin/invoke android

RUN mkdir -p /output

VOLUME ["/output"]

# Set the default command to build the APK
CMD flutter build apk && mkdir -p /output && cp build/app/outputs/flutter-apk/app-release.apk /output/app.apk
