# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
inherit distutils-r1

DESCRIPTION="Library of web-related functions"
HOMEPAGE="https://github.com/scrapy/w3lib"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}"
