# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_PN="github.com/chuot/rdio-scanner"

# use dev-go/get-ego-vendor to generate EGO_SUM
EGO_SUM=(
        "github.com/davecgh/go-spew v1.1.0"
        "github.com/davecgh/go-spew v1.1.0/go.mod"
        "github.com/dhowden/tag v0.0.0-20201120070457-d52dcb253c63"
        "github.com/dhowden/tag v0.0.0-20201120070457-d52dcb253c63/go.mod"
        "github.com/dustin/go-humanize v1.0.0"
        "github.com/dustin/go-humanize v1.0.0/go.mod"
        "github.com/fsnotify/fsnotify v1.5.1"
        "github.com/fsnotify/fsnotify v1.5.1/go.mod"
        "github.com/go-sql-driver/mysql v1.6.0"
        "github.com/go-sql-driver/mysql v1.6.0/go.mod"
        "github.com/golang-jwt/jwt/v4 v4.1.0"
        "github.com/golang-jwt/jwt/v4 v4.1.0/go.mod"
        "github.com/google/go-cmp v0.5.3"
        "github.com/google/go-cmp v0.5.3/go.mod"
        "github.com/google/uuid v1.3.0"
        "github.com/google/uuid v1.3.0/go.mod"
        "github.com/gorilla/websocket v1.4.2"
        "github.com/gorilla/websocket v1.4.2/go.mod"
        "github.com/kardianos/service v1.2.0"
        "github.com/kardianos/service v1.2.0/go.mod"
        "github.com/kballard/go-shellquote v0.0.0-20180428030007-95032a82bc51"
        "github.com/kballard/go-shellquote v0.0.0-20180428030007-95032a82bc51/go.mod"
        "github.com/mattn/go-isatty v0.0.12/go.mod"
        "github.com/mattn/go-isatty v0.0.14"
        "github.com/mattn/go-isatty v0.0.14/go.mod"
        "github.com/mattn/go-sqlite3 v1.14.9"
        "github.com/mattn/go-sqlite3 v1.14.9/go.mod"
        "github.com/pmezard/go-difflib v1.0.0"
        "github.com/pmezard/go-difflib v1.0.0/go.mod"
        "github.com/remyoudompheng/bigfft v0.0.0-20200410134404-eec4a21b6bb0"
        "github.com/remyoudompheng/bigfft v0.0.0-20200410134404-eec4a21b6bb0/go.mod"
        "github.com/stretchr/objx v0.1.0/go.mod"
        "github.com/stretchr/testify v1.7.0"
        "github.com/stretchr/testify v1.7.0/go.mod"
        "github.com/yuin/goldmark v1.2.1/go.mod"
        "github.com/yuin/goldmark v1.4.0/go.mod"
        "golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
        "golang.org/x/crypto v0.0.0-20191011191535-87dc89f01550/go.mod"
        "golang.org/x/crypto v0.0.0-20200622213623-75b288015ac9/go.mod"
        "golang.org/x/crypto v0.0.0-20211117183948-ae814b36b871"
        "golang.org/x/crypto v0.0.0-20211117183948-ae814b36b871/go.mod"
        "golang.org/x/mod v0.3.0/go.mod"
        "golang.org/x/mod v0.4.2/go.mod"
        "golang.org/x/mod v0.5.1"
        "golang.org/x/mod v0.5.1/go.mod"
        "golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
        "golang.org/x/net v0.0.0-20190620200207-3b0461eec859/go.mod"
        "golang.org/x/net v0.0.0-20201021035429-f5854403a974/go.mod"
        "golang.org/x/net v0.0.0-20210805182204-aaa1db679c0d/go.mod"
        "golang.org/x/net v0.0.0-20211112202133-69e39bad7dc2/go.mod"
        "golang.org/x/net v0.0.0-20211201190559-0a0e4e1bb54c"
        "golang.org/x/net v0.0.0-20211201190559-0a0e4e1bb54c/go.mod"
        "golang.org/x/sync v0.0.0-20190423024810-112230192c58/go.mod"
        "golang.org/x/sync v0.0.0-20201020160332-67f06af15bc9/go.mod"
        "golang.org/x/sync v0.0.0-20210220032951-036812b2e83c/go.mod"
        "golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
        "golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
        "golang.org/x/sys v0.0.0-20200116001909-b77594299b42/go.mod"
        "golang.org/x/sys v0.0.0-20200930185726-fdedc70b468f/go.mod"
        "golang.org/x/sys v0.0.0-20201015000850-e3ed0017c211/go.mod"
        "golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
        "golang.org/x/sys v0.0.0-20201126233918-771906719818/go.mod"
        "golang.org/x/sys v0.0.0-20210423082822-04245dca01da/go.mod"
        "golang.org/x/sys v0.0.0-20210615035016-665e8c7367d1/go.mod"
        "golang.org/x/sys v0.0.0-20210630005230-0f9fa26af87c/go.mod"
        "golang.org/x/sys v0.0.0-20210809222454-d867a43fc93e/go.mod"
        "golang.org/x/sys v0.0.0-20210902050250-f475640dd07b/go.mod"
        "golang.org/x/sys v0.0.0-20211007075335-d3039528d8ac/go.mod"
        "golang.org/x/sys v0.0.0-20211124211545-fe61309f8881"
        "golang.org/x/sys v0.0.0-20211124211545-fe61309f8881/go.mod"
        "golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
        "golang.org/x/text v0.3.0/go.mod"
        "golang.org/x/text v0.3.3/go.mod"
        "golang.org/x/text v0.3.6/go.mod"
        "golang.org/x/text v0.3.7"
        "golang.org/x/text v0.3.7/go.mod"
        "golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
        "golang.org/x/tools v0.0.0-20191119224855-298f0cb1881e/go.mod"
        "golang.org/x/tools v0.0.0-20201124115921-2c860bdd6e78/go.mod"
        "golang.org/x/tools v0.1.7"
        "golang.org/x/tools v0.1.7/go.mod"
        "golang.org/x/xerrors v0.0.0-20190717185122-a985d3407aa7/go.mod"
        "golang.org/x/xerrors v0.0.0-20191011141410-1b5146add898/go.mod"
        "golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543/go.mod"
        "golang.org/x/xerrors v0.0.0-20200804184101-5ec99f83aff1"
        "golang.org/x/xerrors v0.0.0-20200804184101-5ec99f83aff1/go.mod"
        "gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
        "gopkg.in/ini.v1 v1.66.1"
        "gopkg.in/ini.v1 v1.66.1/go.mod"
        "gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c"
        "gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
        "lukechampine.com/uint128 v1.1.1"
        "lukechampine.com/uint128 v1.1.1/go.mod"
        "modernc.org/cc/v3 v3.33.6/go.mod"
        "modernc.org/cc/v3 v3.33.9/go.mod"
        "modernc.org/cc/v3 v3.33.11/go.mod"
        "modernc.org/cc/v3 v3.34.0/go.mod"
        "modernc.org/cc/v3 v3.35.0/go.mod"
        "modernc.org/cc/v3 v3.35.4/go.mod"
        "modernc.org/cc/v3 v3.35.5/go.mod"
        "modernc.org/cc/v3 v3.35.7/go.mod"
        "modernc.org/cc/v3 v3.35.8/go.mod"
        "modernc.org/cc/v3 v3.35.10/go.mod"
        "modernc.org/cc/v3 v3.35.15/go.mod"
        "modernc.org/cc/v3 v3.35.16/go.mod"
        "modernc.org/cc/v3 v3.35.17/go.mod"
        "modernc.org/cc/v3 v3.35.18"
        "modernc.org/cc/v3 v3.35.18/go.mod"
        "modernc.org/ccgo/v3 v3.9.5/go.mod"
        "modernc.org/ccgo/v3 v3.10.0/go.mod"
        "modernc.org/ccgo/v3 v3.11.0/go.mod"
        "modernc.org/ccgo/v3 v3.11.1/go.mod"
        "modernc.org/ccgo/v3 v3.11.3/go.mod"
        "modernc.org/ccgo/v3 v3.12.4/go.mod"
        "modernc.org/ccgo/v3 v3.12.6/go.mod"
        "modernc.org/ccgo/v3 v3.12.8/go.mod"
        "modernc.org/ccgo/v3 v3.12.11/go.mod"
        "modernc.org/ccgo/v3 v3.12.14/go.mod"
        "modernc.org/ccgo/v3 v3.12.18/go.mod"
        "modernc.org/ccgo/v3 v3.12.20/go.mod"
        "modernc.org/ccgo/v3 v3.12.21/go.mod"
        "modernc.org/ccgo/v3 v3.12.22/go.mod"
        "modernc.org/ccgo/v3 v3.12.25/go.mod"
        "modernc.org/ccgo/v3 v3.12.29/go.mod"
        "modernc.org/ccgo/v3 v3.12.36/go.mod"
        "modernc.org/ccgo/v3 v3.12.38/go.mod"
        "modernc.org/ccgo/v3 v3.12.43/go.mod"
        "modernc.org/ccgo/v3 v3.12.46/go.mod"
        "modernc.org/ccgo/v3 v3.12.47/go.mod"
        "modernc.org/ccgo/v3 v3.12.50/go.mod"
        "modernc.org/ccgo/v3 v3.12.51/go.mod"
        "modernc.org/ccgo/v3 v3.12.53/go.mod"
        "modernc.org/ccgo/v3 v3.12.54/go.mod"
        "modernc.org/ccgo/v3 v3.12.55/go.mod"
        "modernc.org/ccgo/v3 v3.12.56/go.mod"
        "modernc.org/ccgo/v3 v3.12.57/go.mod"
        "modernc.org/ccgo/v3 v3.12.60/go.mod"
        "modernc.org/ccgo/v3 v3.12.65/go.mod"
        "modernc.org/ccgo/v3 v3.12.66/go.mod"
        "modernc.org/ccgo/v3 v3.12.67/go.mod"
        "modernc.org/ccgo/v3 v3.12.73/go.mod"
        "modernc.org/ccgo/v3 v3.12.81/go.mod"
        "modernc.org/ccgo/v3 v3.12.82"
        "modernc.org/ccgo/v3 v3.12.82/go.mod"
        "modernc.org/ccorpus v1.11.1"
        "modernc.org/ccorpus v1.11.1/go.mod"
        "modernc.org/httpfs v1.0.6"
        "modernc.org/httpfs v1.0.6/go.mod"
        "modernc.org/libc v1.9.8/go.mod"
        "modernc.org/libc v1.9.11/go.mod"
        "modernc.org/libc v1.11.0/go.mod"
        "modernc.org/libc v1.11.2/go.mod"
        "modernc.org/libc v1.11.5/go.mod"
        "modernc.org/libc v1.11.6/go.mod"
        "modernc.org/libc v1.11.11/go.mod"
        "modernc.org/libc v1.11.13/go.mod"
        "modernc.org/libc v1.11.16/go.mod"
        "modernc.org/libc v1.11.19/go.mod"
        "modernc.org/libc v1.11.24/go.mod"
        "modernc.org/libc v1.11.26/go.mod"
        "modernc.org/libc v1.11.27/go.mod"
        "modernc.org/libc v1.11.28/go.mod"
        "modernc.org/libc v1.11.31/go.mod"
        "modernc.org/libc v1.11.34/go.mod"
        "modernc.org/libc v1.11.37/go.mod"
        "modernc.org/libc v1.11.39/go.mod"
        "modernc.org/libc v1.11.42/go.mod"
        "modernc.org/libc v1.11.44/go.mod"
        "modernc.org/libc v1.11.45/go.mod"
        "modernc.org/libc v1.11.47/go.mod"
        "modernc.org/libc v1.11.49/go.mod"
        "modernc.org/libc v1.11.51/go.mod"
        "modernc.org/libc v1.11.53/go.mod"
        "modernc.org/libc v1.11.54/go.mod"
        "modernc.org/libc v1.11.55/go.mod"
        "modernc.org/libc v1.11.56/go.mod"
        "modernc.org/libc v1.11.58/go.mod"
        "modernc.org/libc v1.11.70/go.mod"
        "modernc.org/libc v1.11.71/go.mod"
        "modernc.org/libc v1.11.75/go.mod"
        "modernc.org/libc v1.11.82/go.mod"
        "modernc.org/libc v1.11.86/go.mod"
        "modernc.org/libc v1.11.87"
        "modernc.org/libc v1.11.87/go.mod"
        "modernc.org/mathutil v1.1.1/go.mod"
        "modernc.org/mathutil v1.2.2/go.mod"
        "modernc.org/mathutil v1.4.0/go.mod"
        "modernc.org/mathutil v1.4.1"
        "modernc.org/mathutil v1.4.1/go.mod"
        "modernc.org/memory v1.0.4/go.mod"
        "modernc.org/memory v1.0.5"
        "modernc.org/memory v1.0.5/go.mod"
        "modernc.org/opt v0.1.1"
        "modernc.org/opt v0.1.1/go.mod"
        "modernc.org/sqlite v1.14.1"
        "modernc.org/sqlite v1.14.1/go.mod"
        "modernc.org/strutil v1.1.1"
        "modernc.org/strutil v1.1.1/go.mod"
        "modernc.org/tcl v1.8.13"
        "modernc.org/tcl v1.8.13/go.mod"
        "modernc.org/token v1.0.0"
        "modernc.org/token v1.0.0/go.mod"
        "modernc.org/z v1.2.19"
        "modernc.org/z v1.2.19/go.mod"
        )
go-module_set_globals

DESCRIPTION="A complete, modular, portable and easily extensible MITM framework"
HOMEPAGE="https://github.com/chuot/rdio-scanner"

HASH_COMMIT=4bca72a2020282043a5bcf3790489a58abc6e1a7

SRC_URI="https://github.com/chuot/rdio-scanner/archive/${HASH_COMMIT}.zip -> ${P}.zip
	https://dev.pentoo.ch/~blshkv/distfiles/webapp-20211204.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

S="${WORKDIR}/${PN}-${HASH_COMMIT}/server"

src_prepare() {
	mv ${WORKDIR}/webapp .
	eapply_user
}

src_compile() {
	env GOBIN="${S}/bin" go install ./... || die "compile failed"
}

src_install() {
	newbin bin/server ${PN}
}
