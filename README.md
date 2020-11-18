# Albert AppImage build script

This is my attempt to get Albert to build as an appimage. It's very fragile and very broken and relies on patching albert and on patcing appimage-builder to get the fully built appimage to work properly. You probably shouldn't use it, but it does come out with a fairly sane executable which works with older versions of Libc and on systems which don't have any of the required libraries (Qt/Sqlite/etc).

At some point I should tidy this up and make it less awful.