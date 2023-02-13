# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Virtual for pulling in appropriate opencl stuffs"
HOMEPAGE="https://pentoo.ch"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="opencl-cpu video_cards_amdgpu video_cards_nvidia"
REQUIRED_USE="|| ( opencl-cpu video_cards_amdgpu video_cards_nvidia )"

DEPEND=""
BDEPEND=""

RDEPEND="virtual/opencl
		opencl-cpu? ( amd64? ( || ( dev-libs/pocl dev-util/intel-ocl-sdk ) ) )
		video_cards_amdgpu? ( dev-libs/rocm-opencl-runtime )
		video_cards_nvidia? ( x11-drivers/nvidia-drivers )
		"

pkg_setup() {
	if use opencl-cpu && ! use amd64; then
		die "opencl-cpu is only available for 64 bit systems"
	fi
}
