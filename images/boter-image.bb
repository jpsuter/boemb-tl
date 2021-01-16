SUMMARY = "A Qt5 development image"
HOMEPAGE = "http://www.jumpnowtek.com"
LICENSE = "MIT"

require console-image.bb

JPS_PKGS = " \
    packagegroup-core-x11 \
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
"

IMAGE_INSTALL += " \
    ${JPS_PKGS} \
"

export IMAGE_BASENAME = "boter-image"
