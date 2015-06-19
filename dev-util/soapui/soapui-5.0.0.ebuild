# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="The Swiss-Army Knife for SOAP Testing"
HOMEPAGE="http://www.soapui.org/"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
SRC_URI="http://sourceforge.net/projects/${PN}/files/${PN}/${PV}/SoapUI-${PV}-linux-bin.tar.gz"
RESTRICT="strip mirror"
RDEPEND=">=virtual/jre-1.6"

INSTALLDIR="/opt/SoapUI"
S="${WORKDIR}/SoapUI-${PV}"

src_install() {
	# application
	insinto ${INSTALLDIR}
	doins -r Tutorials bin lib wsi-test-tools soapui-settings.xml

	# binaries
	chmod 755 "${D}/${INSTALLDIR}/bin/loadtestrunner.sh"
	chmod 755 "${D}/${INSTALLDIR}/bin/mockservicerunner.sh"
	chmod 755 "${D}/${INSTALLDIR}/bin/securitytestrunner.sh"
	chmod 755 "${D}/${INSTALLDIR}/bin/soapui.sh"
	chmod 755 "${D}/${INSTALLDIR}/bin/testrunner.sh"
	chmod 755 "${D}/${INSTALLDIR}/bin/toolrunner.sh"
	chmod 755 "${D}/${INSTALLDIR}/bin/wargenerator.sh"

	# default docs
	dodoc README.md
	dodoc LICENSE.txt
	dodoc RELEASENOTES.txt
}
