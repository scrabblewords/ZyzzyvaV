#!/bin/sh

export QTDIR=/usr/local/opt/qt
export PATH=$QTDIR/bin:$PATH
export CPPFLAGS=-I$QTDIR/include
export LDFLAGS=-L$QTDIR/lib
export PKG_CONFIG_PATH=$QTDIR/lib/pkgconfig

qmake
make
cd bin
mv libzyzzyva5*dylib Zyzzyva.app/Contents/MacOS/
install_name_tool -change libzyzzyva5.1.dylib @executable_path/libzyzzyva5.1.dylib Zyzzyva.app/Contents/MacOS/Zyzzyva
cp -R ../data $QTDIR/libexec/Assistant.app Zyzzyva.app/Contents/MacOS
macdeployqt Zyzzyva.app/Contents/MacOS/Assistant.app
macdeployqt Zyzzyva.app
zip -r Collins-Zyzzyva-5.1.0.zip Zyzzyva.app
zip -j Collins-Zyzzyva-5.1.0.zip ../installer/MacOS-Installation-Instructions.txt
