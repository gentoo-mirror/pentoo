# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1

DESCRIPTION="A python package to parse ranges easily"
HOMEPAGE="https://bitbucket.org/colinwarren/rangeparser"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/RangeParser-${PV}.tar.gz"
LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""
DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/RangeParser-${PV}"
