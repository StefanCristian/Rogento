# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/trac-git/trac-git-20111119.ebuild,v 1.2 2012/02/22 02:24:56 idl0r Exp $

EAPI="4"

inherit distutils

DESCRIPTION="RubyTribe Ruby"
HOMEPAGE="https://rvm.io/rvm/install/"
SRC_URI="https://rvm.io/rvm/install/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-util/pkgconfig"
RDEPEND="dev-vcs/git"

src_prepare() {
	exec curl -L get.rvm.io | bash -s stable || die "They didn't download"
}

src_install() {
	exec source /etc/profile.d/rvm.sh || die "Source didn't work"
	exec rvm install 1.9.3 || die "Install failed"
}
