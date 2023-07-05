# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Radio tools for pentoo"
HOMEPAGE="pentoo.org"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="+bladerf bluetooth +hackrf +limesdr pentoo-extra pentoo-full +plutosdr pulseaudio +rtlsdr +uhd"

PDEPEND="net-wireless/gnuradio[uhd?]
	net-wireless/gqrx
	net-wireless/gr-osmosdr
	hackrf? ( net-wireless/hackrf-tools )
	bladerf? ( net-wireless/bladerf )
	limesdr? ( net-wireless/limesuite )
	plutosdr? ( || ( net-wireless/gnuradio[iio] net-wireless/gr-iio ) )
	rtlsdr? ( net-wireless/rtl-sdr )

	bluetooth? (
				net-wireless/nrf_sniffer_ble
				bladerf? ( net-wireless/btle-sniffer )
				hackrf? ( net-wireless/btle-sniffer )
				)
	pentoo-full? (
		amd64? (
			net-wireless/editcp-bin
			net-wireless/mjackit
			net-wireless/srsran
			)
		app-misc/rtlamr
		app-mobilephone/dfu-util
		media-radio/fldigi
		pulseaudio? ( media-radio/qsstv )
		media-radio/wsjtx
		media-sound/audacity
		net-analyzer/multimon-ng
		net-dialup/minimodem
		net-wireless/qdmr
		net-wireless/dump1090
		net-wireless/gr-ieee802154
		net-wireless/nrf802154_sniffer
		net-wireless/gr-rds
		net-wireless/inspectrum
		net-wireless/killerbee
		net-wireless/rfcat
		net-wireless/rtl_433
		net-wireless/sigdigger
		net-wireless/tempestsdr
		net-wireless/osmo-fl2k
		hackrf? (
			net-wireless/portapack-firmware
			net-wireless/portapack-mayhem
			)
		net-wireless/qspectrumanalyzer
		net-wireless/rx_tools
		uhd? ( net-wireless/uhd )
		media-radio/gpredict
		net-wireless/jackit
	)
	pentoo-extra? (
		net-wireless/urh
	)"

#no python3 yet
#		net-wireless/chirp
#		net-wireless/mousejack
