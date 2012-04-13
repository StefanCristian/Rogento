# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit distutils


DESCRIPTION="Python bindings for libsmbclient"
HOMEPAGE="http://pypi.python.org/"
SRC_URI="http://pypi.python.org/packages/source/p/pysmbc/${P}.tar.bz2#md5=019dbb3bc6ee217f7389a2330cda9fe0"

LICENSE="GPLv2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
    distutils_src_compile
    # ...
}

