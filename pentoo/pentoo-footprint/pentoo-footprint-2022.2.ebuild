# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Pentoo footprint meta ebuild"
HOMEPAGE="https://www.pentoo.ch"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="amd64 ~arm x86"
IUSE="pentoo-full"

PDEPEND="
	net-analyzer/whatweb
	net-analyzer/wafw00f
	net-analyzer/amass

	pentoo-full? (
		net-analyzer/sublist3r
		net-analyzer/subfinder
		net-analyzer/fierce
		net-analyzer/dnsrecon
		net-analyzer/metagoofil
		net-analyzer/p0f
		net-analyzer/scanssh
		net-analyzer/siphon
		!x86? ( net-analyzer/theHarvester )
		net-analyzer/wfuzz
		net-analyzer/xprobe
	)"
#temporary removal, gentoo removed dicttoxml
#net-analyzer/recon-ng
