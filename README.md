# Albert AppImage build script

This is my attempt to get Albert to build as an appimage. It's very fragile and very broken and relies on patching albert and on patcing appimage-builder to get the fully built appimage to work properly. You probably shouldn't use it, but it does come out with a fairly sane executable which works with older versions of Libc and on systems which don't have any of the required libraries (Qt/Sqlite/etc).

To get started:
```
docker build -t albert .
./rundocker.sh
```

After the build process has completed, `./Albert-latest-x86_64.AppImage` should appear in the 'host' directory, however it probably won't because I don't check out a specific branch or pin the version of appimage-builder used, so it'll probably stop working very soon.

Alternatively just download the release, and let me know if the AppImage somehow doesn't work on your system.

Components:
- Must build on an older system so appimage is built against older version of libc
- Start with basis from Albert 16.04 dockerfile
- Uses appimages inside docker container so fuse must be allowed when running the container
- Patches main.cpp in Albert to add env variable for `ALBERT_PLUGIN_PATH`. Using CLI parameter to specify as the entrypoint of the AppImage causes the single-albert-instance lock to break, using an appimage path mapping (as specified [here](https://appimage-builder.readthedocs.io/en/latest/examples/gimp_path_mapping.html)) fails as the userland libc hook [fails to hook statx which is used by Qt](https://github.com/AppImageCrafters/AppRun/issues/23). So the path of least resistance was to just to patch Albert
- Installs python 3.8 on the Ubuntu 16.04 image to be able to run appimage-builder
- Appimage builder config stored in `AppImageBuilder`. Probably somewhat bloated but most libraries there are needed. Lots of gdb & stracing to get this right as Albert will fail in different places on different installations/distros where certain libraries are present/different/not present if things are removed
- Removes line 40 of `apt_get.py` in appimage-builder as this causes already installed packages on the parent system not to be installed into the appimage. Not sure why this happens/it's configured this way
- Builds the appimage, coppies it to host shared directory.
