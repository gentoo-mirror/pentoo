# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 pypi

DESCRIPTION="Socks5 / Socks4 client and server library"
HOMEPAGE="https://github.com/skelsec/asysocks"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE=""

RDEPEND="
	dev-python/asn1crypto[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
