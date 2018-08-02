# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Packages needed to power the client NUC for WCTF events"
HOMEPAGE="http://wctf.us"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE=""
S="${WORKDIR}"

DEPEND="!pentoo/pentoo-system"

PDEPEND="dev-vcs/git
		net-misc/dhcpcd
		sys-apps/rng-tools
		sys-power/thermald
		sys-kernel/pentoo-sources
		app-misc/screen
		app-editors/nano
		app-editors/vim
		net-wireless/rtl8812au_aircrack-ng
		sys-process/iotop
		sys-process/htop
		sys-boot/grub:2
		app-portage/layman
		sys-kernel/genkernel
		app-admin/sudo
		net-wireless/wpa_supplicant
		net-wireless/aircrack-ng
		>=sys-apps/util-linux-2.31_rc1
		net-wireless/kismet
		app-portage/gentoolkit
		app-portage/smart-live-rebuild
		|| ( net-misc/iputils[arping(+)] net-analyzer/arping )"

src_install() {
	#/usr/share/pentoo
	insinto /usr/share/pentoo
	doins "${FILESDIR}/pentoo-keyring.asc"

	#/etc/portage/repos.conf
	insinto /etc/portage/repos.conf
	doins "${FILESDIR}/pentoo.conf"

	insinto /etc/local.d
	doexe "${FILESDIR}"/99-ldm.start
}
