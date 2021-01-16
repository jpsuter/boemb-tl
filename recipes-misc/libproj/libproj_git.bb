# Recipe created by recipetool
# This is the basis of a recipe and may need further editing in order to be fully functional.
# (Feel free to remove these comments when editing.)

SUMMARY = "Cartographic projection software"
# WARNING: the following LICENSE and LIC_FILES_CHKSUM values are best guesses - it is
# your responsibility to verify that the values are complete and correct.
#
# The following license files were not able to be identified and are
# represented as "Unknown" below, you will need to check them yourself:
#   COPYING
#
LICENSE = "Unknown"
LIC_FILES_CHKSUM = "file://COPYING;md5=74d9aaec5fa0cd734341e8c4dc91b608"

SRC_URI = "git://github.com/svn2github/libproj;protocol=https"

# Modify these as desired
PV = "1.0+git${SRCPV}"
SRCREV = "adca77c31d065780d62470944331e95e1b58f665"

S = "${WORKDIR}/git"

# NOTE: unable to map the following CMake package dependencies: JNI
inherit cmake

# Specify any options you want to pass to cmake using EXTRA_OECMAKE:
EXTRA_OECMAKE = ""

