# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="The core jetty server artifact"
HOMEPAGE="http://www.eclipse.org/jetty/"
SRC_URI="https://repo1.maven.org/maven2/org/eclipse/jetty/${PN}/${PV}/${P}-sources.jar"
LICENSE="EPL-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND=">=virtual/jre-11:*"

DEPEND="${RDEPEND}
>=virtual/jdk-11:*
	app-arch/unzip
	dev-java/jetty-io
	dev-java/jetty-util
	dev-java/jetty-http
	dev-java/jetty-jmx
	dev-java/jakarta-servlet-api:5
	"

JAVA_GENTOO_CLASSPATH="jetty-io,jetty-util,jakarta-servlet-api:5,jetty-http,jetty-jmx"

src_prepare(){
	rm module-info.java
	eapply_user
}
