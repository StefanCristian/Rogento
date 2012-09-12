# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="CLI version of tv-maxe"
HOMEPAGE="http://nknwn.github.com/tvmaxe-cli/"
SRC_URI="dl.dropbox.com/u/5635113/tvmaxe-cli-20120906.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="media-video/mplayer
	 net-p2p/sopcast-bin"
DEPEND=""

S="${WORKDIR}"

src_install() {
	cd "${S}"
	dodir /usr/bin/${PN} || die "Error. Could not create directory."
	insinto /usr/bin/${PN} || die "Error. Could not set install path."
	doins  "${S}"/${PN}-${PV}/* || die " Error. Could not install."
	doins "${S}"/${PN}-${PV}/".subscrieri" || die "MERGI IN PULA MEA"
	fperms 755 /usr/bin/${PN}/${PN} || die "Error. Permissions not set."
	#fperms 666 /usr/bin/".subscrieri" || die "Error. Permissions not set."
}
