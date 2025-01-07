# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="A security toolkit for Amazon S3"
HOMEPAGE="https://github.com/ankane/s3tk"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ankane/s3tk"
else
	SRC_URI="https://github.com/ankane/s3tk/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="test"

RESTRICT="!test? ( test )"

DEPEND="${PYTHON_DEPS}
	dev-python/boto3[${PYTHON_USEDEP}]
	dev-python/botocore[${PYTHON_USEDEP}]
	dev-python/clint[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/joblib[${PYTHON_USEDEP}]"

RDEPEND="${DEPEND}"

DOCS=( CHANGELOG.md README.md )

distutils_enable_tests pytest
