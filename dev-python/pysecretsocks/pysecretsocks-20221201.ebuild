# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 git-r3

EGIT_REPO_URI="https://github.com/BC-SECURITY/PySecretSOCKS.git"
EGIT_COMMIT_DATE="${PV}"

DESCRIPTION="A python SOCKS server for tunneling connections over another channel."
HOMEPAGE="https://github.com/BC-SECURITY/PySecretSOCKS"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
