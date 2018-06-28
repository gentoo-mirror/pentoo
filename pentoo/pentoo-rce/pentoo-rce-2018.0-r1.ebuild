# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="6"

DESCRIPTION="Pentoo RCE meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL-3"
IUSE="hardened minipentoo"
KEYWORDS="amd64 arm x86"

PDEPEND="hardened? ( sys-apps/paxctl )
	sys-devel/gdb
	dev-util/jd-gui-bin
	dev-util/jadx-bin

	!minipentoo? (
		!hardened? ( sys-devel/prelink )
		!arm? ( dev-lang/nasm
			dev-util/cutter
			dev-util/edb-debugger
		)
		amd64? ( dev-util/emilpro
			dev-util/radare2
		)
		dev-util/ltrace
		dev-util/strace
	)"
