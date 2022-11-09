# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Pipe interface for rizin"
HOMEPAGE="https://rizin.re/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
#rizin is not stable, but it's ok
KEYWORDS="amd64 ~arm64 x86"
IUSE=""
RESTRICT="test"

RDEPEND="dev-util/rizin"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
