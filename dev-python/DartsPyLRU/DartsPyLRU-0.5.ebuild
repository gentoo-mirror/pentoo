# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv $

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )
inherit distutils-r1

MY_PN="darts.util.lru"
DESCRIPTION="LRU Dictionaries"
HOMEPAGE="https://github.com/deterministic-arts/DartsPyLRU"
SRC_URI="mirror://pypi/d/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S=${WORKDIR}/"${MY_PN}-${PV}"

#DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

#python_test() {
#	esetup.py test
#}
