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

RUN tar xf /root/flutter_linux_3.19.3-stable.tar.xz

RUN export PATH="$PATH:`pwd`/flutter/bin" && \
    git config --global --add safe.directory /root/flutter && \
    flutter config --no-cli-animations && \
    flutter doctor -v 

RUN ls /usr/lib/android-sdk/platform-tools
