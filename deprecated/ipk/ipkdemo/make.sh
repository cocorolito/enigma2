#!/bin/bash
PKG_NAME=ipkdemo
CONTROL_FILES="postrm postinst preinst"
DATA_PATH=/tmp
DATA_FILES="README.md"
VERSION_FILE=version.txt
VERSION=$(grep VERSION= ${VERSION_FILE} | cut -d= -f2 | tr -d \')

rm -rf ipk
rm -rf control.tar.gz data.tar.gz ${PKG_NAME}*ipk
mkdir -p ipk/${DATA_PATH}
cp ${DATA_FILES} ipk/${DATA_PATH}
cat control.tmpl | sed "s#VERSION#${VERSION}#g" > control
tar czvf control.tar.gz control ${CONTROL_FILES}
cd ipk; tar czvf ../data.tar.gz *; cd ..
echo 2.0 > debian-binary
./myar.sh $(echo ${PKG_NAME}-VERSION.ipk | sed "s/VERSION/${VERSION}/g") debian-binary data.tar.gz control.tar.gz
