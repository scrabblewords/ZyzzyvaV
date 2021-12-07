#!/bin/sh

if [ -z "$QTDIR" ]; then
    echo The QTDIR environment variable needs to be set before running this script:
    echo QTDIR=/path/to/qt5 $0
    exit 1
fi

export PATH=$QTDIR/bin:$PATH
export CPPFLAGS=-I$QTDIR/include
export LDFLAGS=-L$QTDIR/lib
export PKG_CONFIG_PATH=$QTDIR/lib/pkgconfig

VERSION=$(tr -d '\n' < VERSION)

$QTDIR/bin/qmake -recursive
rm -rf bin/*
make clean

make -j $(sysctl -a | awk '{ if ($1 == "machdep.cpu.core_count:") print $2 }')
cp -R data bin/Zyzzyva.app/Contents/MacOS
cd bin
mv libzyzzyva5*dylib Zyzzyva.app/Contents/MacOS/
install_name_tool -change libzyzzyva5.1.dylib @executable_path/libzyzzyva5.1.dylib Zyzzyva.app/Contents/MacOS/Zyzzyva
cp $QTDIR/libexec/Assistant.app/Contents/MacOS/Assistant Zyzzyva.app/Contents/MacOS
install_name_tool -add_rpath '@loader_path/../Frameworks' Zyzzyva.app/Contents/MacOS/Assistant
$QTDIR/bin/macdeployqt Zyzzyva.app -executable=Zyzzyva.app/Contents/MacOS/Assistant -dmg
hdiutil convert Zyzzyva.dmg -format UDRW -o ZyzzyvaRW.dmg
rm Zyzzyva.dmg
hdiutil attach ZyzzyvaRW.dmg
cp ../installer/MacOS-Installation-Instructions.txt /Volumes/Zyzzyva
hdiutil detach /Volumes/Zyzzyva
hdiutil convert ZyzzyvaRW.dmg -format UDZO -o Collins-Zyzzyva-$VERSION.dmg
rm ZyzzyvaRW.dmg
