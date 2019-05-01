# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
EGO_PN="github.com/xtaci/kcptun"
EGO_VENDOR=(
	"github.com/pkg/errors            v0.8.1"
	"github.com/urfave/cli            v1.20.0"
	"github.com/xtaci/kcp-go          v5.2.7"
	"github.com/tjfoc/gmsm            v1.2"
	"github.com/templexxx/xor         0.1.2"
	"github.com/klauspost/reedsolomon v1.9.1"
	"github.com/klauspost/cpuid       v1.2.1"
	"github.com/templexxx/cpufeat     cef66df" # 20180724
	"github.com/xtaci/smux            v1.2.10"
)

inherit golang-vcs-snapshot

DESCRIPTION="A Stable & Secure Tunnel Based On KCP with N:M Multiplexing"
HOMEPAGE="https://github.com/xtaci/kcptun"

SRC_URI="https://github.com/xtaci/kcptun/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

KEYWORDS="~amd64 ~arm64 ~mips"
LICENSE="MIT"
IUSE="+server"
SLOT="0"

RDEPEND="!net-vpn/kcptun-bin
	dev-go/go-text:=
	dev-go/go-snappy:=
	dev-go/go-net:=
	dev-go/go-tools:=
	dev-go/go-crypto:=
	dev-go/go-sys:="

DEPEND="${RDEPEND}
	>=dev-lang/go-1.12"

src_compile() {
	for x in client $(usev server); do
		CGO_ENABLED=0 GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)" \
			go build -v -work -x -ldflags "-X main.VERSION=${PV}" -o "bin/${PN}-${x}" "${EGO_PN}/${x}"
	done
}

src_install() {
	dobin bin/${PN}-*
	dodoc src/"${EGO_PN}"/{README.md,Dockerfile}

	insinto "/etc/kcptun"
	for x in client $(usev server); do
		doins "${FILESDIR}"/example-${x}.json

		newinitd "${FILESDIR}"/kcptun-${x}.initd kcptun-${x}
		newconfd "${FILESDIR}"/kcptun-${x}.confd kcptun-${x}

		# help2man ./bin/${PN}-*
		doman "${FILESDIR}"/${PN}-${x}.1
	done
}

pkg_postinst() {
	ewarn "Suggested \"/etc/sysctl.conf\" parameters for better handling of UDP packets:"
	ewarn "    net.core.rmem_max=26214400 // BDP - bandwidth delay product"
	ewarn "    net.core.rmem_default=26214400"
	ewarn "    net.core.wmem_max=26214400"
	ewarn "    net.core.wmem_default=26214400"
	ewarn "    net.core.netdev_max_backlog=2048 // proportional to -rcvwnd"

	elog "\nSee documentation:"
	elog "    https://github.com/xtaci/kcptun#quickstart"
	elog "    https://github.com/skywind3000/kcp/blob/master/README.en.md\n"
}
