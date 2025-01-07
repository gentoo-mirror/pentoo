# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/defunkt/pystache.git"
else
	HASH_COMMIT="v${PV}"
	SRC_URI="https://github.com/defunkt/pystache/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="Mustache in Python"
HOMEPAGE="https://github.com/defunkt/pystache"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
