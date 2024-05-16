FROM alpine:edge
LABEL maintainer="peter@pouliot.net"
COPY Dockerfile /Dockerfile
ADD VERSION .
ARG IPXE_GIT_SRC_URL=git:github.com:ipxe/ipxe.git
ARG IPXE_CA_CERT_URL=https://ca.ipxe.org/ca.crt
ARG LOCAL_CA_CERT 
ENV local_ca_cert $LOCAL_CA_CERT
VOLUME pxe/src/bin
RUN \
    echo "!!! Adding basic iPXE build packages !!!" \
    && apk add --no-cache --virtual build-dependencies \
        bash \
        build-base \
	alpine-sdk \
	binutils \
	cdrkit \
	mtools \
	perl \
	syslinux \
	xz-dev \
	xz-libs
RUN \
    echo "!!! Cloning iPXE git source from ${IPXE_GIT_SRC_URL} !!!" \
    && git clone ${IPXE_GIT_SRC_URL}

COPY default.ipxe ipxe/src/pxe.to.ipxe
ADD http://ca.ipxe.org/ca.crt ipxe/src/ca.ipxe.org.crt
WORKDIR ipxe/src
ENTRYPOINT make all TRUST=ca.ipxe.org.crt,${local_ca_cert} EMBED=pxe.to.ipxe
