# Copyright 2004-2013 RogentOS
# Distributed under the terms of the GNU General Public License v2

EAPI=5

#EGIT_REPO_URI="git://github.com/Rogentos/rogentos-live.git"
#EGIT_BRANCH="serverconf-test"

inherit eutils

DESCRIPTION="Rogentos live image scripts and tools"
HOMEPAGE="http://www.rogentos.ro"
SRC_URI="http://bpr.bluepink.ro/~rogentos/distro/app-misc/whatever.tar.xz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 arm x86"
IUSE=""

DEPEND=""
RDEPEND="!app-misc/livecd-tools
	app-admin/eselect-opengl
	dev-util/dialog
	sys-apps/gawk
	sys-apps/pciutils
	sys-apps/keyboard-configuration-helpers
	sys-apps/sed"

src_install() {
	ls -la "${WORKDIR}"/
	insinto /usr/libexec/
	doins "${WORKDIR}"/${PN}-"${PV}"/whatever.sh
}
