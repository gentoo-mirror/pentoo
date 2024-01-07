# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="A swiss army knife for pentesting Windows/Active Directory environments"
HOMEPAGE="https://github.com/Pennyw0rth/NetExec"
SRC_URI="https://github.com/Pennyw0rth/NetExec/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD-2"
KEYWORDS="~amd64"
SLOT="0"
RESTRICT="test"

#pyproject.toml, [tool.poetry.dependencies]
RDEPEND="
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	>=dev-python/lsassy-3.1.8[${PYTHON_USEDEP}]
	dev-python/termcolor[${PYTHON_USEDEP}]
	dev-python/msgpack[${PYTHON_USEDEP}]
	>=dev-python/neo4j-4.1.1[${PYTHON_USEDEP}]
	>=dev-python/pylnk3-0.4.2[${PYTHON_USEDEP}]
	>=dev-python/pypsrp-0.8.1[${PYTHON_USEDEP}]
	>=dev-python/paramiko-3.3.1[${PYTHON_USEDEP}]
	>=dev-python/dsinternals-1.2.4[${PYTHON_USEDEP}]
	>=dev-python/xmltodict-0.13.0[${PYTHON_USEDEP}]
	>=dev-python/terminaltables-3.1.0[${PYTHON_USEDEP}]
	>=dev-python/aioconsole-0.6.2[${PYTHON_USEDEP}]
	>=dev-python/pywerview-0.3.3[${PYTHON_USEDEP}]
	>=dev-python/minikerberos-0.4.1[${PYTHON_USEDEP}]
	>=app-exploits/pypykatz-0.6.8[${PYTHON_USEDEP}]
	>=dev-python/aardwolf-0.2.7[${PYTHON_USEDEP}]
	>=dev-python/dploot-2.2.1[${PYTHON_USEDEP}]
	>=dev-python/bloodhound-1.6.1[${PYTHON_USEDEP}]
	>=dev-python/asyauth-0.0.14[${PYTHON_USEDEP}]
	>=dev-python/masky-0.2.0[${PYTHON_USEDEP}]
	>=dev-python/sqlalchemy-2.0.4[${PYTHON_USEDEP}]
	>=dev-python/aiosqlite-0.19.0[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-modules-0.3.0[${PYTHON_USEDEP}]
	>=dev-python/rich-13.3.5[${PYTHON_USEDEP}]
	>=dev-python/python-libnmap-0.7.3[${PYTHON_USEDEP}]
	>=dev-python/resource-0.2.1[${PYTHON_USEDEP}]

	>=dev-util/ruff-0.0.292[${PYTHON_USEDEP}]
"

#FIXME: check why ruff = "=0.0.292"
#FIXME: check why this is required:
# impacket =  { git = "https://github.com/Pennyw0rth/impacket.git", branch = "gkdi" }
#	>=dev-python/pyreadline-2.1[${PYTHON_USEDEP}]

#src_prepare() {
#	default
#	# exclude is not supported by pyproject2setuppy
#	sed -i '/^exclude/,/^\]/d' pyproject.toml || die
#}
