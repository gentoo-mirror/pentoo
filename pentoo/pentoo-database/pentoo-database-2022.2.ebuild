# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Pentoo database attack meta ebuild"
HOMEPAGE="https://www.pentoo.org"
KEYWORDS="~amd64 ~arm ~x86"
SLOT="0"
LICENSE="GPL-3"
IUSE="pentoo-full"
S="${WORKDIR}"

PDEPEND="
	dev-db/sqlmap
	dev-db/sqlitebrowser
	pentoo-full? (
		net-analyzer/sqlninja
	)
"
