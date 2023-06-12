# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1

DESCRIPTION="An automated wireless attack tool"
HOMEPAGE="https://github.com/kimocoder/wifite2"
LICENSE="GPL-2"
SLOT="2"
IUSE="dict opencl extra"

MY_P="${PN}2-${PV}"

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/kimocoder/wifite2.git"
else
	SRC_URI="https://github.com/kimocoder/wifite2/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="amd64 x86"
	S="${WORKDIR}/${MY_P}"
fi

RDEPEND="dev-python/chardet[${PYTHON_USEDEP}]
	net-analyzer/scapy[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
PDEPEND="net-wireless/aircrack-ng
	net-wireless/hcxdumptool
	net-wireless/hcxtools
	amd64? ( opencl? ( app-crypt/hashcat ) )
	dict? ( sys-apps/cracklib-words )
	extra? ( net-analyzer/wireshark
		net-wireless/reaver-wps-fork-t6x
		!net-wireless/reaver
		net-wireless/bully
		net-wireless/cowpatty
		net-analyzer/macchanger
	)"

RESTRICT="test"

#python2 only:
#net-wireless/pyrit[${PYTHON_USEDEP},opencl?]
