# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Parser for PHP written using PLY"
HOMEPAGE="https://github.com/ramen/phply"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
IUSE="test"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/ply
	test? ( dev-python/nose )
	"
RDEPEND="${DEPEND}"

python_prepare_all() {
	distutils-r1_python_prepare_all
	# remove package of tests to avoid installing it
	rm "${S}/tests/__init__.py"
}

python_test() {
	distutils_install_for_testing
	cd "${TEST_DIR}"/lib || die
	nosetests || die "Tests fail with ${EPYTHON}"
}
