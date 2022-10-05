# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE="doc source"
MAVEN_ID="jakarta.servlet:jakarta.servlet-api:5.0.0"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Jakarta Servlet API"
HOMEPAGE="https://jakarta.ee/specifications/servlet/5.0/"
SRC_URI="https://repo1.maven.org/maven2/jakarta/servlet/jakarta.servlet-api/${PV}/jakarta.servlet-api-${PV}-sources.jar"
LICENSE="EPL-2.0 GPL-2-with-classpath-exception"
SLOT="5"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND=">=virtual/jre-11"
DEPEND=">=virtual/jdk-11"
