# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="1"

inherit kernel-2
detect_version
detect_arch

#nvidia doesn't have a release for x86 that supports >4.17 yet, so now we give up on them
KEYWORDS="amd64 x86"
HOMEPAGE="https://github.com/pentoo/pentoo-livecd/tree/master/kernel/4.13.8"
IUSE="experimental pax_kernel"

DESCRIPTION="Pentoo kernel sources (kernel series ${KV_MAJOR}.${KV_MINOR})"
PENPATCHES_VER="1"
PENPATCHES="penpatches-4.13.8-${PENPATCHES_VER}.tar.xz"
PENPATCHES_URI="http://dev.pentoo.ch/~zero/distfiles/${PENPATCHES}"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI} ${PENPATCHES_URI}"

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"

	ewarn "It may be desired to download the official pentoo kernel config from here:"
	if use amd64; then
		ewarn "https://raw.githubusercontent.com/pentoo/pentoo-livecd/master/livecd/amd64/kernel/config-${PV}"
	fi
	if use x86; then
		ewarn "https://raw.githubusercontent.com/pentoo/pentoo-livecd/master/livecd/x86/kernel/config-${PV}"
	fi

	use pax_kernel && ewarn "pax_kernel is no longer available, you MUST ensure the use flag is no longer set"
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
