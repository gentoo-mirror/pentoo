# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit udev

if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/RfidResearchGroup/proxmark3.git"
else
	#snapshot
	#HASH_COMMIT="1ac5211601b50b82b41737dce0c3a72d9e0374ac"
	#SRC_URI="https://github.com/RfidResearchGroup/${PN}/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	#S=${WORKDIR}/${PN}-${HASH_COMMIT}

	#or release
	KEYWORDS="amd64"
	SRC_URI="https://github.com/RfidResearchGroup/proxmark3/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi
DESCRIPTION="A general purpose RFID tool for Proxmark3 hardware"
HOMEPAGE="https://github.com/RfidResearchGroup/proxmark3"

LICENSE="GPL-2+ GPL-3+"
SLOT="0"
STANDALONE="standalone-lf-em4100emul standalone-lf-em4100rswb standalone-lf-em4100rwc standalone-lf-icehid standalone-lf-samyrun standalone-lf-proxbrute standalone-lf-hidbrute standalone-hf-14asniff standalone-hf-legic +standalone-hf-msdsal standalone-hf-young standalone-hf-mattyrun standalone-hf-colin standalone-hf-bog"
IUSE="+bluez deprecated +firmware +pm3rdv4 +qt ${STANDALONE}"
REQUIRED_USE="?? ( ${STANDALONE/+/} )
			standalone-lf-icehid? ( pm3rdv4 )
			standalone-hf-14asniff? ( pm3rdv4 )
			standalone-hf-colin? ( pm3rdv4 )
			standalone-hf-bog? ( pm3rdv4 )"

RDEPEND="virtual/libusb:0
	sys-libs/ncurses:*[tinfo]
	sys-libs/readline:=
	bluez? ( net-wireless/bluez )
	qt? ( dev-qt/qtcore:5
	dev-qt/qtwidgets:5
	dev-qt/qtgui:5 )
	"
DEPEND="${RDEPEND}
	firmware? ( sys-devel/gcc-arm-none-eabi:0 )"

QA_FLAGS_IGNORED="usr/share/proxmark3/firmware/bootrom.elf
				usr/share/proxmark3/firmware/fullimage.elf"

src_compile(){
	#first we set platform
	if use pm3rdv4; then
		echo 'PLATFORM=PM3RDV4' > Makefile.platform
		echo 'PLATFORM_EXTRAS=BTADDON' >> Makefile.platform
	else
		echo 'PLATFORM=PM3OTHER' > Makefile.platform
	fi
	#then we set a standalone mode
	if use standalone-lf-em4100emul; then
		echo 'STANDALONE=LF_EM4100EMUL' >> Makefile.platform
	elif use standalone-lf-em4100rswb; then
		echo 'STANDALONE=LF_EM4100RSWB' >> Makefile.platform
	elif use standalone-lf-em4100rwc; then
		echo 'STANDALONE=LF_EM4100RWC' >> Makefile.platform
	elif use standalone-lf-icehid; then
		echo 'STANDALONE=LF_ICEHID' >> Makefile.platform
	elif use standalone-lf-samyrun; then
		echo 'STANDALONE=LF_SAMYRUN' >> Makefile.platform
	elif use standalone-lf-proxbrute; then
		echo 'STANDALONE=LF_PROXBRUTE' >> Makefile.platform
	elif use standalone-lf-hidbrute; then
		echo 'STANDALONE=LF_HIDBRUTE' >> Makefile.platform
	elif use standalone-hf-14asniff; then
		echo 'STANDALONE=HF_14ASNIFF' >> Makefile.platform
	elif use standalone-hf-legic; then
		echo 'STANDALONE=HF_LEGIC' >> Makefile.platform
	elif use standalone-hf-msdsal; then
		echo 'STANDALONE=HF_MSDSAL' >> Makefile.platform
	elif use standalone-hf-young; then
		echo 'STANDALONE=HF_YOUNG' >> Makefile.platform
	elif use standalone-hf-mattyrun; then
		echo 'STANDALONE=HF_MATTYRUN' >> Makefile.platform
	elif use standalone-hf-colin; then
		echo 'STANDALONE=HF_COLIN' >> Makefile.platform
	elif use standalone-hf-bog; then
		echo 'STANDALONE=HF_BOG' >> Makefile.platform
	else
		echo 'STANDALONE=' >> Makefile.platform
	fi

	export PREFIX=/usr
	export V=1
	use qt || export SKIPQT=1
	use bluez || export SKIPBT=1
	if use firmware; then
		emake all
	elif use deprecated; then
		emake client mfkey nonce2key
	else
		emake client
	fi
}

src_install(){
	export PREFIX=/usr
	export DESTDIR="${ED}"
	export UDEV_PREFIX="$(get_udevdir)/rules.d"
	export INSTALLDOCSRELPATH="/share/doc/${PF}"
	if use firmware; then
		emake INSTALLDOCSRELPATH="/share/doc/${PF}" install
	elif use deprecated; then
		emake INSTALLDOCSRELPATH="/share/doc/${PF}" client/install mfkey/install nonce2key/install common/install
	else
		emake INSTALLDOCSRELPATH="/share/doc/${PF}" client/install common/install
	fi
}

src_test() {
	if use firmware; then
		./pm3test.sh
	else
		./pm3test.sh client
	fi
}

pkg_postinst() {
	if use firmware; then
		if use pm3rdv4; then
			ewarn "Please note, all firmware and recovery files are intended for the Proxmark3 RDV4"
			ewarn "including support for the optional blueshark accessory."
			ewarn "If this is not what you intended please unset the pm3rdv4 use flag for generic firmware"
		else
			ewarn "Please note, all firmware and recovery files are built for a generic target."
			ewarn "If you have a Proxmark3 RDV4 you should set the pm3rdv4 use flag for an improved firmware"
		fi
	fi
}
