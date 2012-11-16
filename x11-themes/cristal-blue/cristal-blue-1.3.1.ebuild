# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Cristal-Blue Rogentos theme"
HOMEPAGE="http://rogentos.ro"
SRC_URI="http://pkg2.rogentos.ro/~noxis/distro/${CATEGORY}/${PN}-${PV}.tar.gz
	http://pkg.rogentos.ro/~rogentos/distro/${CATEGORY}/${PN}-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk2"

RDEPEND="gtk2? ( x11-themes/gtk-engines-unico )
	>=x11-themes/gtk-engines-murrine-0.98.1.1
	x11-themes/gtk-engines"
DEPEND=""

Z="cristal-blue"
S="${WORKDIR}"/${Z}/
THEME="/usr/share/themes"

src_install() {
	dodir ${THEME}/${Z} || die
	insinto ${THEME}/${Z} || die
	doins "${S}"/index.theme || die

	if use gtk2; then
		doins -r "${S}"/gtk-3.0 || die "Cannot copy gtk2"
	fi
}
