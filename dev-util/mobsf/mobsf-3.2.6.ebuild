# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..8} )
DISTUTILS_USE_SETUPTOOLS=rdepend
inherit distutils-r1

MY_PN="Mobile-Security-Framework-MobSF"

DESCRIPTION="Automated, all-in-one mobile application (Android/iOS/Windows) pen-testing"
HOMEPAGE="https://github.com/MobSF/Mobile-Security-Framework-MobSF"
SRC_URI="https://github.com/MobSF/Mobile-Security-Framework-MobSF/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

#Dynamic Analysis or genymotion
IUSE="genymotion pdf"

QA_FLAGS_IGNORED="usr/lib/python.*/site-packages/mobsf/DynamicAnalyzer.*
		usr/lib/python.*/site-packages/mobsf/StaticAnalyzer.*"
QA_PRESTRIPPED="usr/lib/python.*/site-packages/mobsf/DynamicAnalyzer.*
		usr/lib/python.*/site-packages/mobsf/StaticAnalyzer.*"

RDEPEND="
	dev-python/django[${PYTHON_USEDEP}]
	dev-util/androguard[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/rsa[${PYTHON_USEDEP}]
	dev-python/biplist[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	dev-python/colorlog[${PYTHON_USEDEP}]
	dev-python/macholib[${PYTHON_USEDEP}]
	dev-python/google-play-scraper[${PYTHON_USEDEP}]
	dev-python/whitenoise[${PYTHON_USEDEP}]
	dev-python/waitress[${PYTHON_USEDEP}]
	dev-python/frida-python[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/shelljob[${PYTHON_USEDEP}]
	dev-python/asn1crypto[${PYTHON_USEDEP}]
	dev-python/oscrypto[${PYTHON_USEDEP}]
	dev-python/distro[${PYTHON_USEDEP}]
	dev-python/IP2Location[${PYTHON_USEDEP}]
	dev-util/lief[${PYTHON_USEDEP}]
	>=dev-python/http-tools-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/libsast-1.3.7[${PYTHON_USEDEP}]
	dev-python/apkid[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	dev-python/ruamel-yaml[${PYTHON_USEDEP}]

	dev-python/yara-python[${PYTHON_USEDEP}]

	pdf? ( $(python_gen_cond_dep 'dev-python/pdfkit[${PYTHON_USEDEP}]') )
	www-servers/gunicorn
	genymotion? ( app-emulation/genymotion-bin )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"

src_prepare() {
	sed -e 's|==|>=|' -i requirements.txt || die "sed failed"
	sed -e '/pyOpenSSL/d' -e '/cryptography/d' -i requirements.txt || die "sed failed"
	eapply_user
}

pkg_postinst() {

#python manage.py makemigrations
#python manage.py makemigrations StaticAnalyzer
#python manage.py migrate
#run.sh`

	einfo "https://github.com/MobSF/Mobile-Security-Framework-MobSF/wiki/1.-Documentation"
	einfo " gunicorn -b 0.0.0.0:8000 MobSF.wsgi:application --workers=1"
}
