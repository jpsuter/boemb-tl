SUMMARY = "A Qt5 development image"
HOMEPAGE = "http://www.jumpnowtek.com"
LICENSE = "MIT"

require console-image.bb

JPS_PKGS = " \
    webkitgtk \
    packagegroup-core-x11 \
    epiphany \
"

IMAGE_INSTALL += " \
    ${JPS_PKGS} \
"

export IMAGE_BASENAME = "jps2-image"
