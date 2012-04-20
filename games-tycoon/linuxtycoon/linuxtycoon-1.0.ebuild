# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit unpacker multilib versionator

MY_PN="LinuxTycoon"
MY_PV=$(replace_version_separator 2 '-')
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Lunduke made Linux Tycoon"
HOMEPAGE="http://lunduke.com/?page_id=2646"
SRC_URI="http://www.lunduke.com/linuxtycoon/${MY_PN}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND="
          x11-libs/pango
          media-libs/libpng
          x11-libs/pixman"

DEPEND=""

S="${WORKDIR}/LinuxTycoon"

src_install() {

dobin    "${S}/LinuxTycoon"
#dolib.so "${S}/LinuxTycoon Libs/libRBXML.so"
#dolib.so "${S}/LinuxTycoon Libs/libRBAppearancePak.so"
#insinto  "${S}/LinuxTycoon.png"

}