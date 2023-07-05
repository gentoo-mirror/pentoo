# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Pentoo RCE meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL-3"
IUSE="hardened pentoo-extra pentoo-full X"
KEYWORDS="amd64 arm x86"

PDEPEND="hardened? ( sys-apps/paxctl )
	app-arch/upx
	dev-util/gef
	sys-devel/gdb
	sys-devel/gdb-dashboard
	amd64? ( ||
				(
					dev-util/jd-gui-bin
					dev-util/jd-gui
				)
			)
	dev-util/jadx-bin
	X? (
		app-editors/wxhexeditor
	)
	pentoo-full? (
		app-editors/dhex
		dev-util/vbindiff
		X? (
			app-editors/gedit
			app-editors/ghex
		)
		!hardened? ( sys-devel/prelink )
		!arm? ( dev-lang/nasm
			dev-util/edb-debugger
		)
		amd64? ( dev-util/cutter
			dev-util/ghidra
		)
		dev-util/ltrace
		dev-util/strace
	)
	pentoo-extra? (
		amd64? ( dev-util/radare2 )
	)
	"
