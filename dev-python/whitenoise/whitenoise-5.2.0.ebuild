# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Radically simplified static file serving for WSGI applications"
HOMEPAGE="http://whitenoise.evans.io/en/stable/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="test brotli"

RDEPEND="brotli? ( app-arch/brotli[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
