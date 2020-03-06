# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="Digital Speech Decoder rewritten as a C++ library"
HOMEPAGE=""
SRC_URI=""

if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/f4exb/dsdcc.git"
else
	KEYWORDS="~amd64 ~x86"
	COMMIT="41abd5fa94e79fa60cb82f3365a7016ae4e84cd7"
	SRC_URI="https://github.com/f4exb/dsdcc/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${COMMIT}"
fi

LICENSE="GPL-3+"
SLOT="0"
IUSE="mbelib"

DEPEND="mbelib? ( media-libs/mbelib )"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	sed -i -e 's#-Wall##g' -e 's#-fmax-errors=10 -O2 -ffast-math -ftree-vectorize##g' CMakeLists.txt
	sed -i -e 's#PATCH_VERSION 5#PATCH_VERSION 6#' CMakeLists.txt
	cmake-utils_src_prepare
}

src_configure() {
	mycmakeargs=(
		-DUSE_MBELIB="$(usex mbelib)"
	)
	cmake-utils_src_configure
}
