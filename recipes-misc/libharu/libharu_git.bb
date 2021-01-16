# Recipe created by recipetool
# This is the basis of a recipe and may need further editing in order to be fully functional.
# (Feel free to remove these comments when editing.)

# WARNING: the following LICENSE and LIC_FILES_CHKSUM values are best guesses - it is
# your responsibility to verify that the values are complete and correct.
#
# NOTE: multiple licenses have been detected; if that is correct you should separate
# these in the LICENSE value using & if the multiple licenses all apply, or | if there
# is a choice between the multiple licenses. If in doubt, check the accompanying
# documentation to determine which situation is applicable.
#
# The following license files were not able to be identified and are
# represented as "Unknown" below, you will need to check them yourself:
#   LICENCE
#
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://LICENCE;md5=924546dab2bef90e370d7c0c090ddcf0 "

SRC_URI = "git://github.com/libharu/libharu;protocol=https"

# Modify these as desired
PV = "1.0+git${SRCPV}"
SRCREV = "d84867ebf9f3de6afd661d2cdaff102457fbc371"

S = "${WORKDIR}/git"

DEPENDS = "libpng zlib"

inherit cmake

FILES_${PN} = "/usr"
FILES_${PN}-dev = ""
