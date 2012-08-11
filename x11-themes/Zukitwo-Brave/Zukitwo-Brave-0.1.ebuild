# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils gnome2-utils

DESCRIPTION="Zukitwo-Brave Rogentos theme"
HOMEPAGE="http://rogentos.ro"
SRC_URI="http://dl.dropbox.com/u/1338709/${CATEGORY}/${PN}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE="gtk3 gtk2 gnome-shell unity cinnamon xfwm4"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${PN}/
THEME="/usr/share/themes"

src_prepare() {
	mkdir -p ${THEME}/${PN} || "Creation didn't work"
}

src_install() {
	insinto ${THEME}/${PN} || die "Cannot insinto"
	doins "${S}"/index.theme || die "Did not copy index.theme"

	if use gtk3; then
		insinto ${THEME}/${PN} || die
		doins -r "${S}"/gtk-3.0/ ${THEME}/${PN}/ || die "Cannot copy gtk3"
	else
	ewarn "Gtk3 Files weren't copied"
	fi

	if use gtk2; then
		insinto ${THEME}/${PN}
		doins -r "${S}"/gtk-2.0/ ${THEME}/${PN}/ || die "Cannot copy gtk2"
	else
	ewarn "Gtk2 Files were not copied"
	fi

	if use gnome-shell; then
		insinto ${THEME}/${PN} || die
		doins -r "${S}"/gnome-shell ${THEME}/${PN}/ || die "Cannot copy gnome-shell"
	else
	ewarn "Gnome-shell Files were not copied"
	fi

	if use cinnamon; then
		insinto ${THEME}/${PN} || die
		doins -r "${S}"/cinnamon ${THEME}/${PN}/ || die "Cannot copy cinnamon"
	else
	ewarn "Cinnamon Files were not copied"
	fi

	if use unity; then
		insinto ${THEME}/${PN} || die
		doins -r "${S}"/unity ${THEME}/${PN} || die "Cannot copy unity"
	else
	ewarn "Unity Files were not copied"
	fi

	if use xfwm4; then
		insinto ${THEME}/${PN} || die
		doins -r "${S}"/xfwm4 ${THEME}/${PN} || die "Cannot copy xfwm"
	else
	ewarn "Xfwm Files were not copied"
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
