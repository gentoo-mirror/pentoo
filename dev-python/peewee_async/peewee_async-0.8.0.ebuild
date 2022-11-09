# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# https://projects.gentoo.org/python/guide/distutils.html#pep-517-build-systems
#DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Asynchronous interface for peewee ORM powered by asyncio."
HOMEPAGE="https://github.com/05bit/peewee-async"
#SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
SRC_URI="https://github.com/05bit/peewee-async/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="test"

RDEPEND=">=dev-python/peewee-3.5.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

S="${WORKDIR}/peewee-async-${PV}"

distutils_enable_tests pytest
