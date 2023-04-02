# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1

DESCRIPTION="Fast and full-featured SSL scanner"
HOMEPAGE="https://github.com/nabla-c0d3/sslyze"
SRC_URI="https://github.com/nabla-c0d3/sslyze/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

IUSE="test"

DEPEND=""
RDEPEND=">=dev-python/nassl-4.0.2[${PYTHON_USEDEP}]
	>=dev-python/cryptography-2.6[${PYTHON_USEDEP}]
	>=dev-python/tls_parser-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-1.7[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-20[${PYTHON_USEDEP}]"
BDEPEND="test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/Faker[${PYTHON_USEDEP}]
	)"

#It takes really long, so be patient
distutils_enable_tests pytest
