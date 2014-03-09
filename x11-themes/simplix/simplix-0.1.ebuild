# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="simpliX theme for Xfce & Openbox"
HOMEPAGE="http://sixsixfive.deviantart.com/art/simpliX-346404452"
SRC_URI="http://fc08.deviantart.net/fs70/f/2014/059/4/6/simplix_by_sixsixfive-d5q8ndw.7z"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk3 gtk2 xfwm4 openbox marco metacity xfce-notify"

RDEPEND="gtk3? ( x11-themes/gtk-engines-unico )
	xfce-base/xfwm4
	x11-themes/gtk-engines
	x11-themes/gtk-engines-xfce
	x11-libs/gdk-pixbuf
	xfce-extra/xfce4-notifyd"
DEPEND=""

S="${WORKDIR}"


src_install() {
	cd "${S}"
	dodir /usr/share/themes/${PN} || die
	insinto /usr/share/themes/${PN} || die
	doins -r "${S}"/${PN}-${PV}/${PN}/* || die
}

