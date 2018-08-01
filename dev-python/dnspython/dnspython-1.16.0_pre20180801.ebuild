# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{5,6} )

inherit distutils-r1

DESCRIPTION="DNS toolkit for Python"
HOMEPAGE="http://www.dnspython.org/ https://pypi.python.org/pypi/dnspython"
#SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"
#EGIT_REPO_URI="https://github.com/rthalley/dnspython.git"
#EGIT_COMMIT="be7e71e54a6edc87ead1b15af8981b8921e0e83d"
HASH_COMMIT="be7e71e54a6edc87ead1b15af8981b8921e0e83d"
SRC_URI="https://github.com/rthalley/dnspython/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

IUSE="examples test"

RDEPEND="dev-python/idna[${PYTHON_USEDEP}]
	dev-python/ecdsa[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	!dev-python/pycrypto
	!dev-python/dnspython:py2
	!dev-python/dnspython:py3"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	app-arch/unzip"

# For testsuite
DISTUTILS_IN_SOURCE_BUILD=1

S="${WORKDIR}/${PN}-${HASH_COMMIT}"

python_test() {
	cd tests || die
	"${PYTHON}" utest.py || die "tests failed under ${EPYTHON}"
	einfo "Testsuite passed under ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
