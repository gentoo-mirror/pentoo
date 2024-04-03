# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Bluetooth radio packet sniffer/scanner and sender"
HOMEPAGE="http://sdr-x.github.io/BTLE-SNIFFER/ https://github.com/JiaoXianjun/BTLE"
HASH_COMMIT=6384cb05285f38cda79a1cd4c91021b2b3dd34b2
SRC_URI="https://github.com/JiaoXianjun/BTLE/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/BTLE-${HASH_COMMIT}/host"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bladerf +hackrf"

DEPEND="hackrf? ( net-libs/libhackrf )"
RDEPEND="${DEPEND}"

REQUIRED_USE="^^ ( bladerf hackrf )"

src_configure() {
	#without -DUSE_BLADERF=1 means HACKRF will be used by default
	local mycmakeargs=(
		$(usex bladerf -DUSE_BLADERF=1)
	)
	cmake_src_configure
}
