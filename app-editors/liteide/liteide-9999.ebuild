# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

<<<<<<< HEAD
EAPI="5"
=======
EAPI="4"
>>>>>>> f3ecc99115b5dc90c3d58908a161f01425fdaddd

inherit qt4-r2 git-2

DESCRIPTION="LiteIDE is a simple, open source, cross-platform Go IDE."
HOMEPAGE="http://code.google.com/p/liteide"
EGIT_REPO_URI="git://github.com/visualfc/liteide.git"

LICENSE="LGPL-2.1"
KEYWORDS=""
SLOT="0"
IUSE="debug"

DEPEND="
<<<<<<< HEAD
	dev-lang/go
	dev-qt/qtgui
	dev-qt/qtdbus
	dev-qt/qtwebkit
=======
dev-lang/go
dev-qt/qtgui
dev-qt/qtdbus
dev-qt/qtwebkit
>>>>>>> f3ecc99115b5dc90c3d58908a161f01425fdaddd
"

RDEPEND="${DEPEND}"

src_prepare() {
<<<<<<< HEAD
=======
	
>>>>>>> f3ecc99115b5dc90c3d58908a161f01425fdaddd
	S="${WORKDIR}"/"${PN}"-"${PV}"/liteidex
	dodir /opt/
	dodir /opt/${PN}
	dodir /opt/${PN}/bin
	dodir /opt/${PN}/share/${PN}
<<<<<<< HEAD
=======
	dodir /opt/${PN}/lib/${PN}
>>>>>>> f3ecc99115b5dc90c3d58908a161f01425fdaddd
	dodir /opt/${PN}/lib/${PN}/plugins
	qt4-r2_src_prepare
}

src_install() {
<<<<<<< HEAD
	insinto /opt/${PN}/
	doins -r "${S}"/*

	insinto /opt/${PN}/
	export GOPATH=$(pwd)

	go install -v -ldflags "-s -r ." liteidex
	go install -v -ldflags -s tools/goastview
	go install -v -ldflags -s tools/godocview
	go install -v -ldflags -s tools/goexec
	go install -v -ldflags -s tools/goapi

	dodoc LICENSE.LGPL LGPL_EXCEPTION.TXT ../README.md

	insinto /opt/${PN}/bin
	doins "${S}"/bin/*

	insinto /opt/${PN}/bin
	doins "${S}"/${PN}/bin/*

	insinto /opt/${PN}/lib/
	doins "${S}"/${PN}/lib/${PN}/*

	insinto /opt/${PN}/lib/${PN}/plugins/
	doins "${S}"/${PN}/lib/${PN}/plugins/*.so

=======

	# insinto /opt/${PN}/
	# doins -r "${S}"/*

	export GOPATH=$(pwd)
	

	# Go Tools
	go install -ldflags "-s" -v tools/goastview
	go install -ldflags "-s" -v tools/godocview
	go install -ldflags "-s" -v tools/goexec
	go install -ldflags "-s" -v tools/goapi
		
	# Licence & Readme
	dodoc LICENSE.LGPL LGPL_EXCEPTION.TXT ../README.md
		
	# Binaries
	insinto /opt/${PN}/bin
	doins "${S}"/bin/*		  
		
	# Plugins
	insinto /opt/${PN}/lib/${PN}/plugins/
	doins "${S}"/${PN}/lib/${PN}/plugins/*.so
		
	# Documentation
>>>>>>> f3ecc99115b5dc90c3d58908a161f01425fdaddd
	insinto /opt/${PN}/share/${PN}/
	doins -r "${S}"/deploy/*
	doins -r "${S}"/os_deploy/*

<<<<<<< HEAD
	fperms u+x /opt/${PN}/bin/liteide*
	fperms u+x /opt/${PN}/bin/go*
}
=======
	
	# QT Libraries
	addread /usr/lib64/qt4/
	insinto /opt/${PN}/lib/${PN}
	doins /usr/lib64/qt4/libQtCore.so*
	doins /usr/lib64/qt4/libQtXml.so*
	doins /usr/lib64/qt4/libQtNetwork.so*
	doins /usr/lib64/qt4/libQtGui.so*
	doins /usr/lib64/qt4/libQtDBus.so*
	doins /usr/lib64/qt4/libQtWebKit.so*

	fperms u+x /opt/${PN}/bin/liteide*
	fperms u+x /opt/${PN}/bin/go*
	  	
}
>>>>>>> f3ecc99115b5dc90c3d58908a161f01425fdaddd
