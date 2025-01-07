# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="Coroutine-based CLI generator using prompt_toolkit"
HOMEPAGE="https://github.com/KimiNewt/aiocmd"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="test"

RDEPEND=">=dev-python/prompt-toolkit-3.0.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
