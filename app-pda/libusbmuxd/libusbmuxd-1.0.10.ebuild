# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libusbmuxd/libusbmuxd-1.0.9.ebuild,v 1.2 2014/08/03 12:08:23 ssuominen Exp $

EAPI=5
inherit autotools-utils

DESCRIPTION="USB multiplex daemon for use with Apple iPhone/iPod Touch devices"
HOMEPAGE="http://www.libimobiledevice.org/"
SRC_URI="http://www.libimobiledevice.org/downloads/${P}.tar.bz2"

# tools/iproxy.c is GPL-2+, everything else is LGPL-2.1+
LICENSE="GPL-2+ LGPL-2.1+"
SLOT="0/2" # based on SONAME of libusbmuxd.so
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86"
IUSE="kernel_linux static-libs"

RDEPEND=">=app-pda/libplist-1.11:=
	virtual/libusb:1"
DEPEND="${RDEPEND}
	virtual/os-headers
	virtual/pkgconfig"

DOCS=( AUTHORS README )

src_configure() {
	local myeconfargs=( $(use_enable static-libs static) )
	use kernel_linux || myeconfargs+=( --without-inotify )

	autotools-utils_src_configure
}