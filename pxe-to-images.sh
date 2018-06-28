#!/usr/bin/env bash
VERSION=`cat ./VERSION`
mkdir -p build
docker run -v `pwd`/build:/ipxe/src/bin pxe2/ipxe-builder:$VERSION
