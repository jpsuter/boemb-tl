SUMMARY = "A Qt5 development image"
HOMEPAGE = "http://www.jumpnowtek.com"
LICENSE = "MIT"

inherit core-image

JPS_PKGS = " \
    initramfs-live-boot initramfs-live-install initramfs-live-install-efi \
    packagegroup-core-x11 \
    ethtool \
    procps \
    iw \
    wpa-supplicant \
    glibc-utils \
    localedef \
    gettext \
    glibc-gconv-cp1252 \
    glibc-charmap-cp1252 \
    coreutils \
    ntp \
    rpm \
    tzdata \
    gparted \
    ldd \
    chromium \
    mosquitto-clients \
    ppp \
    socat \
    cronie \
    net-snmp \
    phytool \
    openvpn \
    apache2 \
    resolvconf \
    config-boter \
    userkiosk \
    jq \
    tl-bornes \
    proj \
    geos \
    boost \
    python \
    git \
    imagemagick \
    libmysqlclient \
    libspatialite \
    synthese \
"

IMAGE_INSTALL += " \
    ${JPS_PKGS} \
"

export IMAGE_BASENAME = "boemb-image"
