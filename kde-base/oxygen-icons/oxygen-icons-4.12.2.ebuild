# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

if [[ ${PV} == *9999 ]]; then
	KMNAME="kdesupport"
fi
KDE_REQUIRED="never"
KDE_SCM="svn"
inherit kde4-base

SLREV=4
DESCRIPTION="Oxygen SVG icon theme."
HOMEPAGE="http://www.oxygen-icons.org/"
[[ ${PV} == *9999 ]] || \
SRC_URI="
	!bindist? ( http://dev.gentoo.org/~mrueg/distfiles/${P}.repacked.tar.xz )
	mirror://kogaion/x11-themes/fdo-icons-kogaion${SLREV}.tar.gz
	bindist? ( ${SRC_URI} )
"

LICENSE="LGPL-3"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="aqua bindist"

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	kde4-base_src_prepare
	cp -r "${WORKDIR}"/fdo-icons-kogaion/* "${S}" || die
}
