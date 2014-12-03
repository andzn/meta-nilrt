PACKAGES =+ "${PN}-hostname ${PN}-ls ${PN}-chcon"

EXTRA_OECONF_class-target += "--enable-install-program=hostname"

FILES_${PN}-hostname = "${base_bindir}/hostname.${PN}"
FILES_${PN}-ls = "${base_bindir}/ls.${PN}"
FILES_${PN}-chcon = "${bindir}/chcon.${PN}"

do_install_append() {
	# rename hostname manually since its not part of base_bindir_progs
	mv ${D}${bindir}/hostname ${D}${base_bindir}/hostname.${BPN}
}

pkg_postinst_coreutils-hostname () {
	update-alternatives --install ${base_bindir}/hostname hostname hostname.${BPN} 100
}

pkg_prerm_coreutils-hostname () {
	update-alternatives --remove hostname hostname.${BPN}
}

pkg_postinst_coreutils-ls () {
	update-alternatives --install ${base_bindir}/ls ls ls.${BPN} 100
}

pkg_prerm_coreutils-ls () {
	update-alternatives --remove ls ls.${BPN}
}

pkg_postinst_coreutils-chcon () {
	update-alternatives --install ${bindir}/chcon chcon chcon.${BPN} 100
}

pkg_prerm_coreutils-chcon () {
	update-alternatives --remove chcon chcon.${BPN}
}
