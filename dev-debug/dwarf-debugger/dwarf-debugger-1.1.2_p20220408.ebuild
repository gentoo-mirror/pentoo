# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

MY_PN="dwarf_debugger"
HASH_COMMIT="16d379b3def785f8cb3ad1049a3acdaf9298f1ee"

DESCRIPTION="Full featured multi arch/os debugger built on top of PyQt5 and frida"
HOMEPAGE="https://github.com/iGio90/Dwarf"
SRC_URI="https://github.com/iGio90/Dwarf/archive/${HASH_COMMIT}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"

RDEPEND="${PYTHON_DEPS}
	>=dev-libs/capstone-4.0.1[python,${PYTHON_USEDEP}]
	>=dev-python/requests-2.22.0[${PYTHON_USEDEP}]
	>=dev-python/frida-python-12.8.0[${PYTHON_USEDEP}]
	>=dev-python/PyQt5-5.11.3[${PYTHON_USEDEP}]
	>=dev-python/pyperclip-1.7.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

PATCHES=""${FILESDIR}"/1.1.2-disable_update.patch"

S="${WORKDIR}/Dwarf-${HASH_COMMIT}"
