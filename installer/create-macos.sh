#!/bin/sh

export QTDIR=/usr/local/opt/qt
export PATH=$QTDIR/bin:$PATH
export CPPFLAGS=-I$QTDIR/include
export LDFLAGS=-L$QTDIR/lib
export PKG_CONFIG_PATH=$QTDIR/lib/pkgconfig

qmake
make
mv bin/libzyzzyva5*dylib bin/Zyzzyva.app/Contents/MacOS/
install_name_tool -change libzyzzyva5.1.dylib @executable_path/libzyzzyva5.1.dylib bin/Zyzzyva.app/Contents/MacOS/Zyzzyva
cp -R data $QTDIR/libexec/Assistant.app bin/Zyzzyva.app/Contents/MacOS
macdeployqt bin/Zyzzyva.app/Contents/MacOS/Assistant.app
rm -f bin/Zyzzyva.dmg
macdeployqt bin/Zyzzyva.app -dmg
