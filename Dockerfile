FROM ubuntu:latest

RUN apt-get update

RUN apt update && apt install android-sdk -y 

RUN apt-get install ruby-full -y && ruby -v && \
    gem install fastlane 

RUN apt-get install -y wget && \
    apt-get install -y unzip && \
    apt-get install -y git && \
    apt-get install -y curl && \
    apt-get install -y xz-utils 

WORKDIR /root

RUN wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.19.3-stable.tar.xz

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

RUN which scr