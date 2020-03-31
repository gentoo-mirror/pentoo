# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )
inherit distutils-r1

DESCRIPTION="Fast and full-featured SSL scanner"
HOMEPAGE="https://github.com/nabla-c0d3/sslyze"
SRC_URI="https://github.com/nabla-c0d3/sslyze/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="=dev-python/nassl-3.0*[${PYTHON_USEDEP}]
	>=dev-python/cryptography-2.5[${PYTHON_USEDEP}]
	>=dev-python/tls_parser-1.2.0[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/typing-extensions[${PYTHON_USEDEP}]' python3_{6,7)
	"
#typing-extensions
#https://github.com/nabla-c0d3/sslyze/issues/421

src_prepare(){
	rm -r tests
	#https://github.com/nabla-c0d3/sslyze/issues/421
	sed "s|python_version<'3.8'|python_version<'3.7'|g" -i setup.py || die
	sed "s|cryptography==2.5|cryptography>=2.5|g" -i setup.py
	eapply_user
}
