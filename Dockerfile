FROM alpine:latest
LABEL maintainer="peter@pouliot.net"
COPY Dockerfile /Dockerfile
ADD VERSION .
ARG IPXE_GIT_SRC_URL=git://git.ipxe.org/ipxe.git
RUN \
    echo "!!! Adding basic iPXE build packages !!!" \
    && apk add --no-cache \
    git \
	make \
	gcc \
	perl \
	binutils
RUN \
	echo "!!! Cloning iPXE git source from ${IPXE_GIT_SRC_URL} !!!" \
	&& git clone ${IPXE_GIT_SRC_URL}