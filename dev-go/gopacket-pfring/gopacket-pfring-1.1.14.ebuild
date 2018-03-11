# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
EGO_PN=github.com/google/gopacket/pfring

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	KEYWORDS="~amd64 ~x86 ~arm ~arm64"
	EGIT_COMMIT="v${PV}"
	SRC_URI="https://github.com/google/gopacket/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="Package pfring wraps the PF_RING C library for Go."
HOMEPAGE="https://github.com/google/gopacket"
LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND="sys-kernel/pf_ring-kmod
	net-libs/libpfring"
RDEPEND="${DEPEND}"
