# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
inherit python-single-r1 git-r3

DESCRIPTION="An intentionally designed broken web application based on REST API"
HOMEPAGE="https://github.com/payatu/Tiredful-API"
#EGIT_REPO_URI="https://github.com/payatu/Tiredful-API.git"
EGIT_REPO_URI="https://github.com/siddharthbezalwar/Tiredful-API-py3-beta.git"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
	dev-python/django[${PYTHON_USEDEP}]
	dev-python/django-oauth-toolkit[${PYTHON_USEDEP}]
	dev-python/djangorestframework[${PYTHON_USEDEP}]
	dev-python/oauthlib[${PYTHON_USEDEP}]
	dev-python/python-oauth2[${PYTHON_USEDEP}]
	dev-python/pyjwt[${PYTHON_USEDEP}]
	')"
#	dev-python/oauth[${PYTHON_USEDEP}]
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_install() {
	dodir /opt/Tiredful-API
	cp -R "${S}"/Tiredful-API "${D}"/opt/
}
