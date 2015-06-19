# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv Exp $

EAPI=5

inherit eutils git-2

DESCRIPTION="An embeddable Javascript interpreter in C."
HOMEPAGE="http://mupdf.com/"
EGIT_REPO_URI="https://github.com/ccxvii/mujs.git"
EGIT_COMMIT="a381ba196327a606bfe0849436a8955d0cb729fc"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RDEPEND="app-text/mupdf"
DEPEND="${RDEPEND}"

src_install(){
	emake DESTDIR="${D}" prefix="/usr" install
}
