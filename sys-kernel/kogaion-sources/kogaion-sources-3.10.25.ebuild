# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit eutils

SLOT=$PVR
CKV=3.10.25
KV_FULL=${PN}-${PVR}
EXTRAVERSION=kogaion
KERNEL_ARCHIVE="linux-${PV}.tar.xz"
PATCH_ARCHIVE="linux-${PV}-kogaion.tar.gz"
RESTRICT="binchecks strip mirror"
LICENSE="GPL-2"
KEYWORDS="amd64 x86"
IUSE=""
DEPEND=""
RDEPEND=""
DESCRIPTION="Kogaion Linux Kernel Sources"
HOMEPAGE="http://www.debian.org"
SRC_URI="https://www.kernel.org/pub/linux/kernel/v3.x/${KERNEL_ARCHIVE} https://dl.dropboxusercontent.com/u/6539285/SRC/${PATCH_ARCHIVE}"
S="$WORKDIR/linux-${CKV}"

pkg_setup() {
	export REAL_ARCH="$ARCH"
	unset ARCH ; unset LDFLAGS #will interfere with Makefile if set
}

src_prepare() {

	cd ${S}
	for p in $(ls ${WORKDIR}/linux-${PV}-kogaion/patches/debian); do
		epatch -p1 "${WORKDIR}/linux-${PV}-kogaion/patches/debian/$p"
	done

	for p in $(ls ${WORKDIR}/linux-${PV}-kogaion/patches/desktop); do
		epatch -p1 "${WORKDIR}/linux-${PV}-kogaion/patches/desktop/$p"
	done

	rm -f .config >/dev/null
	cp -a "${WORKDIR}"/linux-${PV}-kogaion "${T}"
}

src_compile() {
	einfo "Preparing kernel sources for real-world use" || die
	make -s mrproper || die "make mrproper failed"
}

src_install() {
	dodir /usr/src
	cp -a ${S} ${D}/usr/src/linux-${PV}-kogaion || die
	cd ${D}/usr/src/linux-${PV}-kogaion
	make mrproper || die
}
