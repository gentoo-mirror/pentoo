# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

EGIT_REPO_URI="https://github.com/Nekmo/proxy-db.git"
DESCRIPTION="Manage free and private proxies on local db for Python Projects"
HOMEPAGE="https://github.com/Nekmo/proxy-db"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

RDEPEND="
	>=dev-python/beautifulsoup4-4.5.1[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/sqlalchemy[${PYTHON_USEDEP}]
"

BDEPEND="
	test? (
		dev-python/requests-mock[${PYTHON_USEDEP}]
	)
"

distutils_enable_sphinx docs
distutils_enable_tests unittest

# don't include tests for the installation
src_prepare() {
	sed -i '101a packages.remove("tests")' setup.py
	eapply_user
}
