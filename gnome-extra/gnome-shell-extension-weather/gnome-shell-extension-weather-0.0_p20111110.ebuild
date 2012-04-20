# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI="4"

inherit gnome2-utils

DESCRIPTION="Gnome-shell-extension-weather for Gnome3.2 by Simon04"
WEATHER="https://github.com/simon04/gnome-shell-extension-weather"
SRC_URI="mirror://sabayon/${CATEGORY}/${PN}/${P}.tar.gz"
HOMEPAGE="${WEATHER}"

LICENSE="GPL-3"
SLOT="0"
IUSE=" "
KEYWORDS="~amd64 ~x86"

EXTENSIONS="/usr/share/gnome-shell/extensions"
SCHEMAS="/usr/share/glib-2.0/schemas"
DESKTOPS="/usr/share/applications"
MY_DIR="${WORKDIR}/${PF}"

COMMON_DEPEND="
        >=dev-libs/glib-2.26
        >=gnome-base/gnome-desktop-3.2.1"
RDEPEND="${COMMON_DEPEND}
        gnome-base/gnome-desktop
        media-libs/clutter:1.0
        net-libs/telepathy-glib
        x11-libs/gtk+:3
        x11-libs/pango"
DEPEND="${COMMON_DEPEND}
        sys-devel/gettext
        >=dev-util/pkgconfig-0.22
        >=dev-util/intltool-0.26
        gnome-base/gnome-common"


src_unpack()  {
	mkdir ${MY_DIR}
}

src_configure() {
        :
}