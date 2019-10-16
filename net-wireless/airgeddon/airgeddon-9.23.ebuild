# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="bash script for Linux systems to audit wireless networks"
HOMEPAGE="https://github.com/v1s1t0r1sh3r3/airgeddon"
SRC_URI="https://github.com/v1s1t0r1sh3r3/airgeddon/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="opencl"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""
PDEPEND=">=app-shells/bash-4.2
		sys-apps/net-tools
		net-wireless/wireless-tools
		virtual/awk
		net-wireless/aircrack-ng
		x11-terms/xterm
		sys-apps/iproute2
		sys-apps/pciutils
		sys-process/procps
		app-misc/tmux
		net-analyzer/ettercap
		net-analyzer/bettercap
		app-misc/crunch
		net-analyzer/sslstrip
		net-wireless/mdk
		net-misc/dhcp
		opencl? ( app-crypt/hashcat )
		net-analyzer/dsniff
		net-wireless/hostapd[wpe(+)]
		net-wireless/reaver-wps-fork-t6x
		net-wireless/bully
		net-wireless/pixiewps
		|| ( net-firewall/nftables net-firewall/iptables )
		app-crypt/asleap
		dev-libs/openssl
		www-apps/beef
		x11-apps/xdpyinfo
		sys-apps/ethtool
		sys-apps/usbutils
		sys-apps/util-linux
		net-misc/wget
		app-admin/ccze
		x11-apps/xset"

src_install() {
	make_wrapper ${PN} ./airgeddon.sh /usr/share/airgeddon "" /usr/sbin
	insinto /usr/share/${PN}
	doins language_strings.sh known_pins.db
	exeinto /usr/share/${PN}
	doexe airgeddon.sh
	insinto /etc
	newins .airgeddonrc airgeddonrc
}
