FROM ubuntu:16.04

RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get -qq update \
 && apt-get install --no-install-recommends -y \
        build-essential \
        cmake \
        git \
        libmuparser-dev \
        libqalculate-dev \
        libqt5svg5-dev \
        libqt5x11extras5-dev \
        python3-dev \
        qtbase5-dev \
        qtdeclarative5-dev \
        unzip \
        virtualbox \
        wget python3-pip python3-setuptools patchelf desktop-file-utils libgdk-pixbuf2.0-dev fakeroot

RUN wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage -O /usr/local/bin/appimagetool
RUN chmod +x /usr/local/bin/appimagetool

# Install virtualbox headers
RUN mkdir /tmp/vbox \
 && cd /tmp/vbox \
 && wget -q http://download.virtualbox.org/virtualbox/5.2.22/VirtualBoxSDK-5.2.22-126460.zip \
 && unzip VirtualBoxSDK-5.2.22-126460.zip \
 && mv sdk/bindings/xpcom/include /usr/lib/virtualbox/sdk/bindings/xpcom \
 && cd - \
 && rm -rf /tmp/vbox

RUN git config --global http.sslverify false 


CMD ["bash", "-c", "/host/build.sh"]
