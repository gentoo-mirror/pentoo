# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Frida CLI tools"
HOMEPAGE="https://github.com/frida/frida-tools"

SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${PN}-${PV}.tar.gz"

LICENSE="wxWinLL-3.1"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	>=dev-python/colorama-0.2.7[${PYTHON_USEDEP}]
	>=dev-python/frida-python-16.0.9[${PYTHON_USEDEP}]
	>=dev-python/prompt-toolkit-3.0.3[${PYTHON_USEDEP}] <dev-python/prompt-toolkit-4.0.0
	>=dev-python/pygments-2.0.2[${PYTHON_USEDEP}]"
