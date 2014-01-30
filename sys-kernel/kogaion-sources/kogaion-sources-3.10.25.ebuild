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
SRC_URI="https://www.kernel.org/pub/linux/kernel/v3.x/${KERNEL_ARCHIVE}"

S="$WORKDIR/linux-${CKV}"

pkg_setup() {
	export REAL_ARCH="$ARCH"
	unset ARCH ; unset LDFLAGS #will interfere with Makefile if set
}

src_prepare() {

	cd ${S} || die
	for p in $(ls "${WORKDIR}"); do
		epatch -p1 "${WORKDIR}/$p" || die
	done

	for p in $(ls "${FILESDIR}"); do
		epatch -p1 "${FILESDIR}/$p" || die
	done

	rm -f .config || die
	# doins -a "${FILESDIR}"/linux-${PV}-kogaion "${T}" # doins here
}

src_compile() {
	einfo "Preparing kernel sources for real-world use" || die
	make -s mrproper || die "make mrproper failed"
}

src_install() {
	dodir /usr/src
	# cp -a ${S} ${D}/usr/src/linux-${PV}-kogaion || die # doins in  loc de cp
	cd ${D}/usr/src/linux-${PV}-kogaion
	make mrproper || die
}
