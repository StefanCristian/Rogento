# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Kogaion elementary icons"
HOMEPAGE="https://github.com/bionel/kogaion-src"
SRC_URI="https://dl.dropbox.com/u/51887609/kogaion-src/${CATEGORY}/${PN}/${PN}-${PVR}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE=""

RDEPEND=""

DEPEND=""

DEST="/usr/share/icons"
S="${WORKDIR}"

src_install() {
	insinto ${DEST} || die
	doins -r ${S}/Kogaion-elementary || die
	doins -r ${S}/Kogaion-elementary-dark || die

}
