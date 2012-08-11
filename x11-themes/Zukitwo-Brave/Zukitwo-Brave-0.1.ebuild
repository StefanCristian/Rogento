# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Zukitwo-Brave Rogentos theme"
HOMEPAGE="http://rogentos.ro"
SRC_URI="http://dl.dropbox.com/u/1338709/${CATEGORY}/${PN}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE="gtk3 gtk2 gnome-shell unity cinnamon xfwm4"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${PN}
THEME="/usr/share/themes"

src_install() {
	dodir /usr/share/themes/Zukitwo-Brave || die "Cannot create folder"
	doins "${S}"/index.theme ${THEME}/${PN} || die "Cannot copy index"
	
	if use gtk3; then
                doins "${S}"/gtk-3.0 ${THEME}/${PN}/ || die "Cannot copy files"
        else
        ewarn "Files weren't copied"
        fi

        if use gtk2; then
                doins "${S}"/gtk-2.0 ${THEME}/${PN}/ || die "Cannot copy files"
        else
        ewarn "Files were not copied"
        fi

        if use gnome-shell; then
                doins "${S}"/gnome-shell ${THEME}/${PN}/ || die "Cannot copy files"
        else
        ewarn "Files were not copied"
        fi

        if use cinnamon; then
                doins "${S}"/cinnamon ${THEME}/${PN}/ || die "Cannot copy files"
        else
        ewarn "Files were not copied"
        fi

        if use unity; then
                doins "${S}"/unity ${THEME}/${PN} || die "Cannot copy files"
        else
        ewarn "Files were not copied"
        fi

        if use xfwm4; then
                doins "${S}"/xfwm4 ${THEME}/${PN} || die "Cannot copy files"
        else
        ewarn "Files were not copied"
        fi
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
