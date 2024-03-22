FROM ubuntu:latest

RUN apt-get update

RUN apt-get install -y wget && \
    apt-get install -y unzip && \
    apt-get install -y git && \
    apt-get install -y curl && \
    apt-get install -y xz-utils && \
    apt install openjdk-17-jdk -y && \
    apt install openjdk-17-jre -y && \
    apt install android-sdk -y

RUN apt-get install ruby-full -y && ruby -v && \
    gem install fastlane 
 
WORKDIR /root

RUN wget -q https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip && \
    mkdir -p /usr/lib/android-sdk/cmdline-tools/latest && \
    unzip /root/commandlinetools-linux-11076708_latest.zip -d /usr/lib/android-sdk/ && \
    rm /root/commandlinetools-linux-11076708_latest.zip

ENV PATH="/usr/lib/android-sdk/cmdline-tools/bin:${PATH}"

RUN ls /usr/lib/android-sdk/cmdline-tools/bin

RUN sdkmanager "platform-tools" "platforms;android-33" --sdk_root=/usr/lib/android-sdk/

RUN wget -q https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.19.3-stable.tar.xz

RUN mkdir /flutter && \
    tar xf /root/flutter_linux_3.19.3-stable.tar.xz -C /flutter && \
    rm /root/flutter_linux_3.19.3-stable.tar.xz && \
    git config --global --add safe.directory /flutter/flutter
    
ENV PATH="/flutter/flutter/bin:${PATH}"

RUN flutter --version

RUN flutter config --no-cli-animations && \
    flutter doctor -v && \
    flutter pub global activate script_runner

ENV PATH="/root/.pub-cache/bin:${PATH}"
