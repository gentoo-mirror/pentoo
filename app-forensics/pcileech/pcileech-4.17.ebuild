# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Direct Memory Access (DMA) Attack Software"
HOMEPAGE="https://github.com/ufrisk/pcileech"
SRC_URI="https://github.com/ufrisk/pcileech/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

DEPEND="virtual/libusb:1
	>=dev-libs/LeechCore-2.7
	>=dev-libs/memprocfs-4.7"
RDEPEND="${DEPEND}"

src_prepare() {
	sed '/mv leechcore.so/d' -i pcileech/Makefile || die
	sed '/mv vmm.so/d' -i pcileech/Makefile || die
	eapply_user
}

src_compile() {
	emake -C pcileech
}

src_install(){
	dobin files/pcileech
}
