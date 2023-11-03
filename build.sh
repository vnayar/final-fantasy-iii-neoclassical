#!/bin/sh

tar -czvf final-fantasy-iii-neoclassical.tgz --transform 's#^#final-fantasy-iii-neoclassical/#' \
  'Final Fantasy III (Japan).ips' README.txt
