# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Lunduke made Linux Tycoon"
HOMEPAGE="http://whatever/"
SRC_URI="http://http.us.debian.org/debian/pool/main/d/${PN}/${PN}_${PV}-3.1+b1_amd64.deb"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="x11-libs/pango"
DEPEND=""

S="${WORKDIR}"

src_unpack() {
	unpack "${A}"
}

src_prepare() {
	cd "${D}"
	tar -xvf "${S}"/data.tar.gz
	cd "${D}"
	ls $D
}

src_install() {
	insinto /usr/bin
	doins "${S}"/usr/bin/*
	
	insinto /usr/share/applications/
	doins "${S}"/usr/share/applications/*
	
	insinto /usr/share/djplay/
	doins "${S}"/usr/share/djplay/*

	insinto /usr/share/
	doins -r "${S}"/usr/share/doc/

	insinto /usr/share/
	doins -r "${S}"/usr/share/man*
}
