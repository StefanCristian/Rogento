# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="A GTK+ front-end for the SopCast P2P TV player."
HOMEPAGE=""
SRC_URI="ftp://calculate-linuxmaniac.tk/pub/downloads/sopcast-player-0.7.4-r1.tar.xz"

LICENSE=""
SLOT="unstable"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/python
		dev-python/pygtk
		sys-libs/libstdc++-v3
		virtual/libstdc++
		media-video/vlc"
RDEPEND="${DEPEND}"

src_install() {
	cd "${WORKDIR}"
	cp -R * "${D}/"
	elog "??? ???????? ? ??????? ?? ????????? ??? sopcast@support!"
	echo
}
