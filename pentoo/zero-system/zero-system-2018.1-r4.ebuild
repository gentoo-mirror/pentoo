# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

DESCRIPTION="The ZERO (Zoning & Emotional Range Omitted) System is a technology for interfacing the brain of the pilot with the mobile suit's computer."
HOMEPAGE="http://www.pentoo.ch/"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE="nu printer"
S="${WORKDIR}"

PDEPEND="
		app-eselect/eselect-sh
		app-arch/pixz
		app-shells/zsh
		app-shells/gentoo-zsh-completions
		app-shells/dash
		app-shells/mksh
		dev-vcs/mercurial
		app-arch/p7zip
		net-dns/dnsmasq
		app-portage/overlint
		app-portage/repoman
		app-misc/fslint
		app-doc/pms
		dev-vcs/cvs
		net-misc/keychain
		app-portage/genlop
		dev-util/checkbashisms
		sys-devel/distcc
		nu? ( dev-util/catalyst
			net-p2p/mktorrent
			dev-util/jenkins-bin
		)
		!nu? ( printer? ( net-print/samsung-unified-linux-driver )
			dev-ruby/pry
			app-doc/doxygen
			mail-client/thunderbird
			!arm? ( mail-client/thunderbird-bin )
			www-client/firefox
			!arm? ( www-client/firefox-bin )
			net-ftp/filezilla
			!arm? ( www-plugins/chrome-binary-plugins:stable )
			amd64? ( www-client/chromium )
			!arm? ( www-client/google-chrome )
			app-office/libreoffice
			!arm? ( app-emulation/virtualbox app-emulation/virtualbox-extpack-oracle app-emulation/virtualbox-additions )
			!arm? ( sys-apps/preload )
			x11-misc/slim
			!arm? ( www-plugins/google-talkplugin )
			!arm? ( net-p2p/vuze )
			!arm? ( app-emulation/wine-vanilla )
			media-gfx/gimp
			x11-apps/mesa-progs
			media-video/xine-ui
			media-video/mplayer
			net-wireless/hidclient
			!www-plugins/adobe-flash
			x11-misc/redshift
			!arm? ( media-sound/baudline )
			app-portage/eclass-manpages
			dev-util/meld
			app-misc/workrave
			dev-ruby/bundler-audit
			app-vim/nerdtree
			app-vim/syntastic
			dev-util/shellcheck
			media-sound/asunder
			)
"

src_install() {
	if [ -d /home/zero ]; then
		insinto /home/zero
		newins "${FILESDIR}"/zshrc .zshrc
		newins "${FILESDIR}"/vimrc .vimrc
		keepdir /home/zero/.vim-scratch
	fi
	insinto /root
	newins "${FILESDIR}"/zshrc .zshrc
	newins "${FILESDIR}"/vimrc .vimrc
	keepdir /root/.vim-scratch
	insinto /etc/skel
	newins "${FILESDIR}"/zshrc .zshrc
	newins "${FILESDIR}"/vimrc .vimrc
	keepdir /etc/skel/.vim-scratch
}

pkg_postinst() {
	if grep -q '^root' /etc/passwd && [ "$(grep '^root' /etc/passwd | awk -F: '{print $7}')" != "/bin/zsh" ]; then
		chsh -s /bin/zsh
	fi
	if grep -q '^zero' /etc/passwd && [ "$(grep '^zero' /etc/passwd | awk -F: '{print $7}')" != "/bin/zsh" ]; then
		chsh -s /bin/zsh zero
	fi
}
