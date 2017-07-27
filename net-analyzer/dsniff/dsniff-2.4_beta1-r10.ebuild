# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit autotools eutils flag-o-matic toolchain-funcs

DESCRIPTION="A collection of tools for network auditing and penetration testing"
HOMEPAGE="http://monkey.org/~dugsong/dsniff/"
SRC_URI="
	http://monkey.org/~dugsong/${PN}/beta/${P/_beta/b}.tar.gz
	mirror://debian/pool/main/d/${PN}/${PN}_2.4b1+debian-22.1.debian.tar.gz
"
LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="X"

DEPEND="net-libs/libpcap
	>=net-libs/libnet-1.1.2.1-r1
	>=net-libs/libnids-1.21
	|| ( dev-libs/openssl:* dev-libs/libressl:* )
	>=sys-libs/db-4.2.52_p4:*
	X? ( x11-libs/libXmu
		 x11-libs/libX11 )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P/_beta1/}"

src_prepare() {
	# replace Debian patch 23 with a simpler one (bug #506076)
	mv -v \
		"${WORKDIR}"/debian/patches/23_urlsnarf_timestamp.patch{,.old} || die
	cp -v \
		"${FILESDIR}"/${PV}-urlsnarf-pcap_timestamps.patch \
		"${WORKDIR}"/debian/patches/23_urlsnarf_timestamp.patch || die

	# Debian patchset, needs to be applied in the exact order that "series"
	# lists or patching will fail.
	# Bug #479882
	epatch $(
		for file in $(< "${WORKDIR}"/debian/patches/series ); do
			printf "%s/debian/patches/%s " "${WORKDIR}" "${file}"
		done
	)

	# Bug 125084
	epatch "${FILESDIR}"/${PV}-httppostfix.patch

	# various Makefile.in patches
	epatch "${FILESDIR}"/${PV}-make.patch

	# bug #538462
	epatch "${FILESDIR}"/${PV}-macof-size-calculation.patch

	#Pentoo issue 61
	epatch "${FILESDIR}"/${PV}-libressl.patch

	#ssssh
	mv configure.in configure.ac

	eapply_user

	eautoreconf
}

src_configure() {
	econf \
		$(use_with X x) \
		|| die "econf failed"
}

src_compile() {
	#I don't actually know where nfs_prot.h comes from, but I do know that for high -j values it isn't there in time
	#I do know it doesn't come from glibc
	emake -j1 CC="$(tc-getCC)"
}

src_install() {
	emake install install_prefix="${D}"
	dodir /etc/dsniff
	cp "${D}"/usr/share/dsniff/{dnsspoof.hosts,dsniff.{magic,services}} \
		"${D}"/etc/dsniff/
	dodoc CHANGES README TODO
}
