# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils git

DESCRIPTION="Python binding to VLC library"
HOMEPAGE="http://wiki.videolan.org/Python_bindings"
EGIT_REPO_URI="git://git.videolan.org/vlc/bindings/python.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="generated examples wxwidgets qt4 gtk"

DEPEND="media-video/vlc"
RDEPEND="${DEPEND}
	examples? ( dev-python/pygtk )"

DOCS="README"

src_compile(){

	cd "${S}"/bindings/python
	distutils_src_compile
}

src_install(){

	cd "${S}"/bindings/python
	distutils_src_install

	if use examples ; then
	docinto examples
		if use wxwidgets ; then
			dodoc wxvlc.py
		fi
		if use qt4 ; then
			dodoc qtvlc.py
		fi
		if use gtk ; then
			dodoc gtkvlc.py
		fi
	fi
	if use generated ; then
		insinto generated
		dodoc vlc.py
	fi
}
