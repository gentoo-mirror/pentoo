# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
inherit distutils-r1

DESCRIPTION="Kismet REST Python API"
HOMEPAGE="https://kismetwireless.net/docs/devel/webui_rest/endpoints/"
if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/kismetwireless/python-kismet-rest.git"
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/kismetwireless/python-kismet-rest/archive/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/python-${P}"
fi

LICENSE="GPL-2+"
SLOT="0"

DEPEND="dev-python/requests
		!<net-wireless/kismet-2019.05.1"
RDEPEND="${DEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
