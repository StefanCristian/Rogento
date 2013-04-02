# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit qt4-r2 git-2

DESCRIPTION="LiteIDE is a simple, open source, cross-platform Go IDE."
HOMEPAGE="http://code.google.com/p/liteide"
EGIT_REPO_URI="git://github.com/visualfc/liteide.git"

LICENSE="LGPL-2.1"
KEYWORDS=""
SLOT="0"
IUSE="debug"

DEPEND="
dev-lang/go
dev-qt/qtgui
dev-qt/qtdbus
dev-qt/qtwebkit
"

RDEPEND="${DEPEND}"

src_prepare() {
	
	S="${WORKDIR}"/"${PN}"-"${PV}"/liteidex
	dodir /opt/
	dodir /opt/${PN}
	dodir /opt/${PN}/bin
	dodir /opt/${PN}/share/${PN}
	dodir /opt/${PN}/lib/${PN}
	dodir /opt/${PN}/lib/${PN}/plugins
	qt4-r2_src_prepare
}

src_install() {

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
	insinto /opt/${PN}/share/${PN}/
	doins -r "${S}"/deploy/*
	doins -r "${S}"/os_deploy/*

	
	# QT Libraries
	addread /usr/lib64/qt4/
	insinto /opt/${PN}/lib/${PN}
	doins /usr/lib64/qt4/libQtCore.so*
	doins /usr/lib64/qt4/libQtXml.so*
	doins /usr/lib64/qt4/libQtNetwork.so*
	doins /usr/lib64/qt4/libQtGui.so*
	doins /usr/lib64/qt4/libQtDBus.so*
	doins /usr/lib64/qt4/libQtWebKit.so*
	  	
}