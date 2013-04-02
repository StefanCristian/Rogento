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
  S="${WORKDIR}/liteide-9999/liteidex"
  qt4-r2_src_prepare
}

src_install() {
        dodir /opt/liteide
	insinto /opt/liteide
        export GOPATH=$(pwd)
	

	doins ${S}/src/tools/goastview
	doins ${S}/src/tools/godocview
	doins ${S}/src/tools/goexec
	doins ${S}/src/tools/goapi

	# Go Tools
	go install -ldflags "-s" -v tools/goastview
	go install -ldflags "-s" -v tools/godocview
	go install -ldflags "-s" -v tools/goexec
	go install -ldflags "-s" -v tools/goapi
		
	# Licence & Readme
	dodoc LICENSE.LGPL LGPL_EXCEPTION.TXT ../README.md
		
	# Binaries
	dobin ${S}/bin/* /opt/liteide/bin/*
		  
		
	# Plugins
	dodir /opt/liteide/lib/liteide/plugins
	insinto /opt/liteide/lib/liteide/plugins
	doins ${S}/liteide/lib/liteide/plugins/*.so
		
	# Documentation
	dodir /opt/liteide/share/liteide
	insinto /otp/liteide/share/liteide
	doins -r ${S}/deploy/* ${S}/os_deploy/linux/*
	
	# QT Libraries
	addread /usr/lib64/qt4/
	dodir /opt/liteide/lib/liteide
	insinto /opt/liteide/lib/liteide
	doins /usr/lib64/qt4/libQtCore.so*
	doins /usr/lib64/qt4/libQtXml.so*
	doins /usr/lib64/qt4/libQtNetwork.so*
	doins /usr/lib64/qt4/libQtGui.so*
	doins /usr/lib64/qt4/libQtDBus.so*
	doins /usr/lib64/qt4/libQtWebKit.so*
	  	
}