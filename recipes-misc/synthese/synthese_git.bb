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
#   COPYING.md
#   legacy/tools/synthesepy/web/manager/static/vendor/bootstrap/LICENSE
#   legacy/old_packages/admin/files/admin/edit_area/license_bsd.txt
#   legacy/old_packages/admin/files/admin/edit_area/license_lgpl.txt
#   legacy/old_packages/admin/files/admin/edit_area/license_apache.txt
#   legacy/old_packages/map/files/map/vendor/OpenLayers/licenses/BSD-LICENSE.txt
#
# NOTE: spec file indicates the license may be "Mixed"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://COPYING;md5=6c786c3b7a4afbd3c990f1b81261d516"

SRC_URI = "git://git@bianca.t-l.ch/tl/synthese.git;protocol=ssh;branch=Branch_3.10.8_Maintenance"

SRC_URI += "\
        file://000_patch_CMakeList.patch \
	file://001_patch_cmake_find.patch \
	file://010_compile_err.patch \
"

# Modify these as desired
PV = "3.10.8.13+git${SRCPV}"
SRCREV = "c83434728571849d67810586f69b5200dfe319af"

S = "${WORKDIR}/git/server"

inherit cmake

FILES_${PN} = "/usr"
FILES_${PN}-dev = ""

DEPENDS = "boost geos proj libspatialite libharu curl libmysqlclient"
