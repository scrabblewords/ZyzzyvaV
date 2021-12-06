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

qmake
make
cd bin
mv libzyzzyva5*dylib Zyzzyva.app/Contents/MacOS/
install_name_tool -change libzyzzyva5.1.dylib @executable_path/libzyzzyva5.1.dylib Zyzzyva.app/Contents/MacOS/Zyzzyva
cp $QTDIR/libexec/Assistant.app/Contents/MacOS/Assistant Zyzzyva.app/Contents/MacOS
install_name_tool -add_rpath '@loader_path/../Frameworks' Zyzzyva.app/Contents/MacOS/Assistant
macdeployqt Zyzzyva.app -executable=Zyzzyva.app/Contents/MacOS/Assistant
cp -R ../data Zyzzyva.app/Contents/MacOS
rm -f Collins-Zyzzyva-$VERSION.zip
zip -r Collins-Zyzzyva-$VERSION.zip Zyzzyva.app
zip -j Collins-Zyzzyva-$VERSION.zip ../installer/MacOS-Installation-Instructions.txt
