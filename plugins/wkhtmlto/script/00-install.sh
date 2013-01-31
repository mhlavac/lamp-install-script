#!/bin/sh

baseDirectory=$(dirname $0)
architecture=$(dpkg --print-architecture)
pdfDownloadUrl="http://wkhtmltopdf.googlecode.com/files/wkhtmltopdf-0.11.0_rc1-static-$architecture.tar.bz2"
imageDownloadUrl="http://wkhtmltopdf.googlecode.com/files/wkhtmltoimage-0.11.0_rc1-static-$architecture.tar.bz2"
pdfTargetFile="wkhtmltopdf.tar.bz2"
imageTargetFile="wkhtmltoimage.tar.bz2"

wget -O $pdfTargetFile $pdfDownloadUrl
wget -O $imageTargetFile $imageDownloadUrl
tar -xvjf $pdfTargetFile
tar -xvjf $imageTargetFile

mv "wkhtmltopdf-$architecture" /usr/bin/wkhtmltopdf
mv "wkhtmltoimage-$architecture" /usr/bin/wkhtmltoimage

rm $pdfTargetFile $imageTargetFile
