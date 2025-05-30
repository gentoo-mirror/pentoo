# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Scans a disk image for regular expressions and other content"
HOMEPAGE="https://github.com/simsong/bulk_extractor"
SRC_URI="https://github.com/simsong/bulk_extractor/releases/download/v${PV}/${P}.tar.gz"
PATCHES=(
	"${FILESDIR}/${P}_uint32_t.patch"
)

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"

#fails to compile with ewf
#fails to compile with exiv2
#fails to compile without rar
IUSE="aff doc beviewer exiv2 hashdb +rar"

#	ewf? ( app-forensics/libewf )
RDEPEND="
	aff? ( app-forensics/afflib )
	dev-libs/expat
	dev-libs/libgcrypt:=
	dev-libs/re2
	exiv2? ( media-gfx/exiv2 )
	sys-libs/zlib
	hashdb? ( dev-libs/hashdb )
	beviewer? (
		|| ( virtual/jre:* virtual/jdk:* )
	)"

DEPEND="${RDEPEND}
	dev-db/sqlite:3
	dev-libs/boost
	dev-libs/openssl:0=
	dev-libs/libxml2
	doc? ( app-text/doxygen )
	virtual/man"

BDEPEND="
	sys-devel/flex
	virtual/pkgconfig"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	econf \
		--disable-o3 \
		--disable-libewf
#		$(use ewf || echo "--disable-libewf")
#		$(use beviewer || echo "--disable-BEViewer") \
#		$(use exiv2 && echo "--enable-exiv2") \
#		$(use aff || echo "--disable-afflib") \
#		$(use hashdb || echo "--disable-hashdb") \
#		$(use rar || echo "--disable-rar" )
}

src_install() {
	dobin src/${PN}
	doman man/*.1
	dodoc AUTHORS ChangeLog NEWS README.md

	if use doc ; then
		pushd doc/doxygen >/dev/null || die
		doxygen || die "doxygen failed"
		popd >/dev/null || die

		dodoc -r \
			doc/doxygen/html \
			doc/Diagnostics_Notes \
			doc/announce \
			doc/*.{pdf,txt,md} \
			doc/programmer_manual/*.pdf
	fi

#	if use beviewer; then
#		local bev_dir="/opt/beviewer-${PV}"

#		insinto "${bev_dir}"
#		doins java_gui/BEViewer.jar

#		insinto /usr/share/pixmaps
#		newins java_gui/icons/24/run-build-install.png ${PN}.png

#		make_wrapper "beviewer" \
#			"/usr/bin/java -Xmx1g -jar \"${bev_dir}/BEViewer.jar\""
#		make_desktop_entry \
#			"beviewer" \
#			"BEViewer (bulk_extractor)" \
#			"${PN}" "Utility"
#	fi
}

#pkg_postinst() {
#	if use beviewer; then
#		xdg_icon_cache_update
#		xdg_desktop_database_update
#	fi
#}

#pkg_postrm() {
#	if use beviewer; then
#		xdg_icon_cache_update
#		xdg_desktop_database_update
#	fi
#}
