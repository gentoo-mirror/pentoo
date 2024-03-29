# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..12} )
PYTHON_REQ_USE="ssl(+)"

inherit distutils-r1

DESCRIPTION="A Python library for accessing the Twitter API "
HOMEPAGE="https://www.tweepy.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc examples test"

RESTRICT="test"	#missing in tarball

	#dev-python/pip[${PYTHON_USEDEP}]
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )
	"
RDEPEND="
	>=dev-python/requests-2.4.3[${PYTHON_USEDEP}]
	>=dev-python/requests-oauthlib-0.4.1[${PYTHON_USEDEP}]
	>=dev-python/six-1.7.3[${PYTHON_USEDEP}]
"
python_prepare_all() {
	# Required to avoid file collisions at install
	sed \
		-e "/find_packages/s:]:,'tests.*','examples']:g" \
		-i setup.py || die
	distutils-r1_python_prepare_all
}

python_test() {
	nosetests -v  -c tests/travis-tests.cfg || die
}

python_compile_all() {
	use doc && emake -C docs html
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi

	distutils-r1_python_install_all
}
