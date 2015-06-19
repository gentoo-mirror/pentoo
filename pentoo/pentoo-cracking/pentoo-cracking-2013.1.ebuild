# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Pentoo cracking meta ebuild"
HOMEPAGE="http://www.pentoo.ch"

LICENSE="GPL"
SLOT="0"
IUSE_VIDEO_CARDS="video_cards_fglrx video_cards_nvidia"
IUSE="cuda opencl dict ${IUSE_VIDEO_CARDS} livecd-stage1 minipentoo"
KEYWORDS="~amd64 ~arm ~x86"

DEPEND=""
RDEPEND="${DEPEND}
	app-crypt/johntheripper
	net-analyzer/hydra
	net-analyzer/medusa

	!minipentoo? (
		!arm? ( app-crypt/chntpw
		    app-crypt/hashcat-gui
		)
		!livecd-stage1? (
			video_cards_nvidia? ( opencl? ( app-crypt/pyrit )
						cuda? ( app-crypt/pyrit ) )
		)
		dict? ( app-dicts/raft-wordlists )
		app-crypt/ophcrack
		app-text/cewl
		app-crypt/SIPcrack
		net-analyzer/ncrack
		net-analyzer/thc-pptp-bruter
		net-misc/rdesktop-brute
	)"

#removed from stage2? because it doesn't build for me
#	app-crypt/cuda-rarcrypt
#	net-analyzer/authforce
#	app-crypt/md5bf

#stupid build system, doesn't work on hardened
#		app-crypt/hashkill
