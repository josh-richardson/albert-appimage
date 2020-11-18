git clone --recursive git://github.com/albertlauncher/albert.git /albert
cp /host/main.cpp /albert/src/app/main.cpp
mkdir albert-build
cd albert-build
cmake /albert -DBUILD_VIRTUALBOX=OFF -DBUILD_WITH_QTCHARTS=OFF
make -j4
make install DESTDIR=AppDir

apt-get install -y apt-transport-https ca-certificates software-properties-common
add-apt-repository ppa:deadsnakes/ppa -y
apt-get update
apt-get install python3.8 python3.8-distutils strace file libfuse2 -y
apt remove python3-pip -y
python3.8 -m easy_install pip
pip3 install appimage-builder

mkdir -p /albert-build/AppDir/usr/share/icons
cp ./AppDir/usr/local/share/icons/hicolor/scalable/apps/albert.svg /albert-build/AppDir/usr/share/icons

cp ../host/AppImageBuilder.yml .

sed -i '40d' /usr/local/lib/python3.8/dist-packages/AppImageBuilder/commands/apt_get.py


appimage-builder --skip-tests

mv Albert-latest-x86_64.AppImage /host