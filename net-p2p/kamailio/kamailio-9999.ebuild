# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit git-2 autotools

DESCRIPTION="fuse module for access to iphone and ipod touch without jailbreak"
HOMEPAGE="http://matt.colyer.name/projects/iphone-linux/"
EGIT_REPO_URI="git://git.sip-router.org/kamailio"

LICENSE="GPLv2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="app-pda/libimobiledevice
	>=sys-fs/fuse-2.7.0
	dev-libs/glib:2"
RDEPEND="${DEPEND}"

S="${WORKDID}"/${PN}

src_unpack() {
	git-2_src_unpack
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
