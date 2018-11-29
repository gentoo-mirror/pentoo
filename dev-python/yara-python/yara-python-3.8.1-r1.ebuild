# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_6,3_7} )
inherit distutils-r1

DESCRIPTION="Python interface for a malware identification and classification tool"
HOMEPAGE="https://github.com/VirusTotal/yara-python"
SRC_URI="https://github.com/virustotal/yara-python/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/virustotal/yara/archive/v${PV}.tar.gz -> yara-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="=app-forensics/yara-${PV}"
RDEPEND="${DEPEND}"

src_prepare() {
	cp -r "${WORKDIR}/yara-${PV}/"* "${S}/yara/"
	default
}
