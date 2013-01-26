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
	x11-libs/qt-gui
	x11-libs/qt-dbus
	x11-libs/qt-webkit
"

RDEPEND="${DEPEND}"

src_prepare() {
  S="${S}/liteidex"
  qt4-r2_src_prepare
}

src_install() {
  # Go Tools
  go install -ldflags "-s" -v src/tools/goastview
  go install -ldflags "-s" -v src/tools/godocview
  go install -ldflags "-s" -v src/tools/goexec
  go install -ldflags "-s" -v src/tools/goapi

  # Licence & Readme
  dodoc LICENSE.LGPL LGPL_EXCEPTION.TXT ../README.md

  # Binaries
  dobin bin/* liteide/bin/*

  # QT Libraries
  dodir /usr/lib/liteide
  insinto /usr/lib/liteide
  doins /usr/lib/libQtCore.so* 
  doins /usr/lib/libQtXml.so*
  doins /usr/lib/libQtNetwork.so*
  doins /usr/lib/libQtGui.so*
  doins /usr/lib/libQtDBus.so*
  doins /usr/lib/libQtWebKit.so*

  # Plugins
  dodir /usr/lib/liteide/plugins
  insinto /usr/lib/liteide/plugins
  doins liteide/lib/liteide/plugins/*.so

  # Documentation
  dodir /usr/share/liteide
  insinto /usr/share/liteide
  doins -r deploy/* os_deploy/linux/*
}

