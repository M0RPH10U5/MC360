#!/bin/bash

cd ${0%/*}
which XBMCTex &>/dev/null || { echo Can\'t find XBMCTex; exit 1 ;}

SKINNAME=MC360

echo ------------------------------
echo Creating $SKINNAME Build Folder
rm -Rf BUILD
mkdir -p BUILD/$SKINNAME/media

echo ------------------------------
echo Creating XPR Files...
XBMCTex -input media/Default -output textures.xpr -quality max -noprotect
XBMCTex -input media/Carbon -output Carbon.xpr -quality max -noprotect
XBMCTex -input media/Glass -output Glass.xpr -quality max -noprotect


echo ------------------------------
echo Copying XPR Files...
mv -f *.xpr BUILD/$SKINNAME/media/ 


echo ------------------------------
echo Building Skin Directory...

for i in 1080i 720p NTSC NTSC16x9 PAL PAL16x9 fonts colors sounds extras language *.xml
do
  cp -R $i BUILD/$SKINNAME/
done

cp *.txt BUILD
   
echo ------------------------------
echo Removing SVN directories from build
for inode in $(ls -Ria BUILD/$SKINNAME|grep ".svn$"|cut -d' ' -f1)
do
	find -inum $inode -exec rm -Rf '{}' \; &>/dev/null
done

echo Build Complete - Scroll Up to check for errors.
echo Final build is located in the BUILD directory
echo ftp the $SKINNAME folder in the build dir to your xbox
