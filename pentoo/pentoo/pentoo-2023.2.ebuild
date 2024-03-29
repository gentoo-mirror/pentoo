# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KEYWORDS="amd64 arm x86"
DESCRIPTION="Pentoo meta ebuild to install all apps"
HOMEPAGE="https://www.pentoo.org"
SLOT="0"
LICENSE="GPL-3"
IUSE="+analyzer +bluetooth +cracking +database +desktop +exploit +footprint +forensics \
	+forging +fuzzers +misc +mitm +mobile +nfc pentoo +proxies +radio +rce \
	+scanner +voip +wireless"

PDEPEND="analyzer? ( pentoo/pentoo-analyzer )
	bluetooth? ( pentoo/pentoo-bluetooth )
	cracking? ( pentoo/pentoo-cracking )
	database? ( pentoo/pentoo-database )
	desktop? ( pentoo/pentoo-desktop )
	exploit? ( pentoo/pentoo-exploit )
	footprint? ( pentoo/pentoo-footprint )
	forensics? ( pentoo/pentoo-forensics )
	forging? ( pentoo/pentoo-forging )
	fuzzers? ( pentoo/pentoo-fuzzers )
	misc? ( pentoo/pentoo-misc )
	mitm? ( pentoo/pentoo-mitm )
	mobile? ( pentoo/pentoo-mobile )
	nfc? ( pentoo/pentoo-nfc )
	pentoo? ( pentoo/pentoo-system )
	proxies? ( pentoo/pentoo-proxies )
	radio? ( pentoo/pentoo-radio )
	rce? ( pentoo/pentoo-rce )
	scanner? ( pentoo/pentoo-scanner )
	voip? ( pentoo/pentoo-voip )
	wireless? ( pentoo/pentoo-wireless )"
