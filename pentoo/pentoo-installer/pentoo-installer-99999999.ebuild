# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Installer for pentoo, based on the ncurses Arch Linux installer"
HOMEPAGE="https://github.com/pentoo/pentoo-installer"

LICENSE="GPL-3"
SLOT="0"

if [[ "${PV}" == "99999999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/pentoo/${PN}.git"
else
	KEYWORDS="~amd64 ~x86"
	GIT_COMMIT="6cb324cc5a587def9ea8c32f1fbec7509a9eedf9"
	SRC_URI="https://github.com/pentoo/pentoo-installer/archive/${GIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${GIT_COMMIT}"
fi

IUSE=""

PDEPEND="
	app-crypt/pinentry[gtk,ncurses]
	app-misc/jq
	dev-util/dialog
	sys-apps/gptfdisk
	sys-apps/util-linux
	sys-block/parted
	sys-boot/efibootmgr
	sys-boot/grub:2[-multislot(-),grub_platforms_efi-32,grub_platforms_efi-64]
	sys-boot/os-prober
	sys-boot/shim
	sys-boot/mokutil
	sys-fs/btrfs-progs
	sys-fs/cryptsetup
	sys-fs/dosfstools
	sys-fs/f2fs-tools
	sys-fs/growpart
	sys-fs/jfsutils
	sys-fs/reiserfsprogs
	sys-fs/squashfs-tools
	sys-fs/xfsprogs
	x11-misc/wmctrl
	net-misc/rsync
	"
#	X? ( x11-misc/xdialog )

src_install() {
	dodir /usr/
	cp -R "${S}"/* "${ED}"/usr/ || die "Copy files failed"
	exeinto /etc/skel/Desktop/
	newexe share/applications/sudo-pentoo-installer.desktop pentoo-installer.desktop
}
