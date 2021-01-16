SUMMARY = "Add environment variable to show user@host in remote titlebar"

LICENSE = "GPL-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

SRC_URI = "file://biv.conf \
	   file://xinitrc \
	   file://startX \
	   file://infos_mqtt.sh \
	   file://config.sh \
	   file://gpio-config.sh \
	   file://socat.sh \
	   file://waitconfig.sh \
	   file://kiosk.sh \
	   file://boemb.cfg \
	   file://wpa_supplicant.conf \
	   file://on.sh \
	   file://off.sh \
"

PR = "0"

S = "${WORKDIR}"

do_install () {
	install -d ${D}${sysconfdir}/apache2/conf.d
	install -m 0644 biv.conf ${D}${sysconfdir}/apache2/conf.d/biv.conf
	install -d ${D}${sysconfdir}/X11/
	install -m 0644 xinitrc ${D}${sysconfdir}/X11/xinitrc
	install -m 0755 startX ${D}${sysconfdir}/X11/startX
	install -d ${D}/opt/scripts/
	install -m 0755 infos_mqtt.sh ${D}/opt/scripts/infos_mqtt.sh
	install -m 0755 on.sh ${D}/opt/scripts/on.sh
	install -m 0755 off.sh ${D}/opt/scripts/off.sh
	install -m 0755 config.sh ${D}/opt/scripts/config.sh
	install -m 0755 gpio-config.sh ${D}/opt/scripts/gpio-config.sh
	install -m 0755 socat.sh ${D}/opt/scripts/socat.sh
	install -m 0755 waitconfig.sh ${D}/opt/scripts/waitconfig.sh
	install -d ${D}/opt/config/
	install -m 0755 boemb.cfg ${D}/opt/config/boemb.cfg
	install -m 0755 wpa_supplicant.conf ${D}/opt/config/wpa_supplicant.conf
	install -d ${D}/home/kiosk/
	install -m 0755 kiosk.sh ${D}/home/kiosk/kiosk.sh
}

FILES_${PN} = "/"
