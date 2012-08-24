# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

DESCRIPTION="Lunduke made Linux Tycoon"
HOMEPAGE=""
SRC_URI="mirror://sourceforge/project/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=""
DEPEND=""

S="${WORKDIR}"

src_install() {
	cd "${S}" || die
	install -D -m755 awemenugen.sh "${PN}"/opt/${PN}/awemenugen.sh || die
	install -D -m755 awemenugen.sh "${PN}"/usr/bin/awemenugen || die
	install -D -m644 awemenugen.jar "${PN}"/opt/${PN}/awemenugen.jar || die
	install -D -m644 lib/freemarker.jar "${PN}"/opt/${PN}/lib/freemarker.jar || die
}
