SUMMARY = "A Qt5 development image"
HOMEPAGE = "http://www.jumpnowtek.com"
LICENSE = "MIT"

require console-image.bb

JPS_PKGS = " \
    packagegroup-core-x11 \
    webkitgtk \
"

IMAGE_INSTALL += " \
    ${JPS_PKGS} \
"

export IMAGE_BASENAME = "jps-image"
