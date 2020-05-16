# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
#FIXME: Gentoo: add python3.8 to netaddr
PYTHON_COMPAT=( python3_7 )

inherit distutils-r1

DESCRIPTION="Python library to parse remote lsass dumps"
HOMEPAGE="https://github.com/Hackndo/lsassy/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/impacket[${PYTHON_USEDEP}]
	dev-python/netaddr[${PYTHON_USEDEP}]
	>=app-exploits/pypykatz-0.3.0[${PYTHON_USEDEP}]
	"
DEPEND="${RDEPEND}"

src_prepare(){
	rm -r tests
	eapply_user
}
