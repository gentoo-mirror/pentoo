# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

MY_PN="ZAP"
MY_P="${MY_PN}_${PV}"

#Workaround to sava zap ext under different filename
ZAP_EXTENSIONS_URI="https://github.com/zaproxy/zap-extensions/releases/download/2.5"

declare -a PLUGINS
PLUGINS[0]="ascanrules;release;24"
PLUGINS[1]="pscanrules;release;17"
PLUGINS[2]="directorylistv1;release;3"
PLUGINS[3]="directorylistv2_3;release;3"
PLUGINS[4]="directorylistv2_3_lc;release;3"
PLUGINS[5]="scripts;beta;16"
PLUGINS[6]="diff;beta;6"
PLUGINS[7]="websocket;release;11"
PLUGINS[8]="sse;alpha;9"
PLUGINS[9]="beanshell;beta;5"
PLUGINS[10]="fuzzdb;release;4"
PLUGINS[11]="quickstart;release;18"
PLUGINS[12]="plugnhack;beta;9"
PLUGINS[13]="sqliplugin;beta;11"
PLUGINS[14]="wappalyzer;alpha;7"
PLUGINS[15]="selenium;release;7"
PLUGINS[16]='spiderAjax;release;15'
PLUGINS[17]='zest;beta;22'
PLUGINS[18]='invoke;beta;4'

for i in "${PLUGINS[@]}"
do
	arr=(${i//;/ })
	#url-base versioning workaround
	PL_URL="${PL_URL} ${ZAP_EXTENSIONS_URI}/${arr[0]}-${arr[1]}-${arr[2]}.zap -> ${P}-${arr[0]}-${arr[1]}-${arr[2]}.zap"
done

DESCRIPTION="The OWASP Zed Attack Proxy for finding vulnerabilities in web applications"
HOMEPAGE="https://github.com/zaproxy/zaproxy"
SRC_URI="https://github.com/zaproxy/zaproxy/releases/download/${PV}/ZAP_${PV}_Core.tar.gz
	plugins? ( $PL_URL ) "

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="+plugins"
RESTRICT="mirror"

RDEPEND="|| ( virtual/jre virtual/jdk )
	!virtual/jre:1.6
	!virtual/jdk:1.6"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	if use plugins ; then
		rm "${S}"/plugin/ascanrules-*.zap
		rm "${S}"/plugin/diff-*.zap
		rm "${S}"/plugin/plugnhack-*.zap
		rm "${S}"/plugin/pscanrules-*.zap
		rm "${S}"/plugin/quickstart-*.zap
		rm "${S}"/plugin/invoke-*.zap

		for i in "${PLUGINS[@]}"
		do
			arr=(${i//;/ })
			cp "${DISTDIR}/${P}-${arr[0]}-${arr[1]}-${arr[2]}.zap" "${S}"/plugin/${arr[0]}-${arr[1]}-${arr[2]}.zap
#			einfo "DEBUG: copying ${arr[0]}-${arr[1]}-${arr[2]}.zap"
		done
	fi
	#use external tool
#	rm -r "${S}"/fuzzers/fuzzdb-1.09 || die "Unable to remove fuzzdb"
}

src_install() {
	dodir /opt/"${PN}"
	cp -R "${S}"/* "${D}/opt/${PN}" || die "Install failed!"
	dosym /opt/"${PN}"/zap.sh /usr/bin/zaproxy
}

pkg_postinst() {
	einfo "Zaproxy requires jdk/jre >=7. Make sure it is enabled by running the following:"
	einfo "eselect java-vm set [user|system] [vm]"
}
