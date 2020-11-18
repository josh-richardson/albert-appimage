# Albert AppImage build script

This is my attempt to get Albert to build as an appimage. It's very fragile and very broken and relies on patching albert and on patcing appimage-builder to get the fully built appimage to work properly. You probably shouldn't use it, but it does come out with a fairly sane executable which works with older versions of Libc and on systems which don't have any of the required libraries (Qt/Sqlite/etc).

To get started:
```
docker build -t albert .
./rundocker.sh
```

After the build process has completed, `./Albert-latest-x86_64.AppImage` should appear in the 'host' directory, however it probably won't because I don't check out a specific branch or pin the version of appimage-builder used, so it'll probably stop working very soon.

At some point I should tidy this up and make it less awful.
