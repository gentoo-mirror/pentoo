# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )

IUSE="test"
inherit distutils-r1

DESCRIPTION="Packet crafting/sending/... PCAP processing tool with python3 compatibility"
HOMEPAGE="https://pypi.python.org/pypi/scapy-python3/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="!net-analyzer/scapy
	!virtual/python-scapy"

src_prepare(){
	#we provide common files (binaries/man/doc) via virtual package
	sed -i -e '/scripts = SCRIPTS/d' setup.py
	sed -i -e '/data_files/d' setup.py
	eapply_user
}
