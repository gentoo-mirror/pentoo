# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..11} )

DISTUTILS_USE_SETUPTOOLS=rdepend
inherit distutils-r1

DESCRIPTION="CLI for SQLite Databases with auto-completion and syntax highlighting"
HOMEPAGE="https://github.com/dbcli/litecli"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="BSD"
SLOT="0"

#sqlparse issue
#https://github.com/dbcli/litecli/issues/104
RDEPEND="
	>=dev-python/click-4.1[${PYTHON_USEDEP}]
	>=dev-python/pygments-1.6[${PYTHON_USEDEP}]
	>=dev-python/prompt-toolkit-3.0.3[${PYTHON_USEDEP}] <dev-python/prompt-toolkit-4.0.0
	=dev-python/sqlparse-0.3*[${PYTHON_USEDEP}]
	>=dev-python/configobj-5.0.5[${PYTHON_USEDEP}]
	>=dev-python/cli_helpers-1.0.1[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
