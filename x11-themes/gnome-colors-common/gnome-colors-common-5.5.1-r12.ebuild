# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
SLREV=
inherit gnome2-utils

DESCRIPTION="Colorized icons shared between all gnome-colors iconsets"
HOMEPAGE="http://code.google.com/p/gnome-colors/"

SRC_URI="http://gnome-colors.googlecode.com/files/gnome-colors-${PV}.tar.gz
	branding? ( http://dl.dropbox.com/u/1338709/x11-themes/fdo-icons-rogentos${SLREV}.tar.xz )"

LICENSE="GPL-2 public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+branding"

RDEPEND="x11-themes/gnome-icon-theme"
DEPEND=""
RESTRICT="binchecks strip"

src_prepare() {
	if use branding; then
		cp -r fdo-icons-rogentos/* ${PN} || die "Rogentos branding failed"
	fi
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	dodir /usr/share/icons
	insinto /usr/share/icons
	doins -r "${WORKDIR}/${PN}" || die "Installing icons failed"
	dodoc AUTHORS ChangeLog README
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