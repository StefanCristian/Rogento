# Copyright 2004-2013 Sabayon
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Configures your GPU when autodetection fails do to it"
HOMEPAGE="http://www.rogentos.ro"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc"
IUSE=""

RDEPEND="app-misc/kogaion-live"
DEPEND=""

src_unpack () {
        cd "${WORKDIR}"
        cp "${FILESDIR}"/gpu-configuration . -p
}

src_install () {
	cd "${WORKDIR}"
	exeinto /sbin/
	doexe gpu-configuration
}
