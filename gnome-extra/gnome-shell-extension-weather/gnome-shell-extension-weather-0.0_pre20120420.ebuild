# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit vcs-snapshot gnome2-utils unpacker

DESCRIPTION="Gnome Shell Extension Weather plugin for Gnome3"
HOMEPAGE="https://github.com/simon04/gnome-shell-extension-weather.git"
SRC_URI="http://192.168.2.3:8080/${PN}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

COMMON_DEPEND="
        >=dev-libs/glib-2.26
        >=gnome-base/gnome-desktop-3:2"
RDEPEND="${COMMON_DEPEND}
        gnome-base/gnome-desktop:3
        media-libs/clutter:1.0
        net-libs/telepathy-glib
        x11-libs/gtk+:3
        x11-libs/pango"
DEPEND="${COMMON_DEPEND}
        sys-devel/gettext
        >=dev-util/pkgconfig-0.22
        >=dev-util/intltool-0.26
        gnome-base/gnome-common"

S="${WORKDIR}"

src_install() {

}