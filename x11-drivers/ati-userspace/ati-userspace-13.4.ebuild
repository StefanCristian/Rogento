# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils multilib toolchain-funcs versionator pax-utils

DESCRIPTION="Ati precompiled drivers for Radeon Evergreen (HD5000 Series) and newer chipsets"
HOMEPAGE="http://www.amd.com"
MY_V=( $(get_version_components) )
#RUN="${WORKDIR}/amd-driver-installer-9.00-x86.x86_64.run"
SLOT="1"
[[ "${MY_V[2]}" =~  beta.* ]] && BETADIR="beta/" || BETADIR="linux/"
if [[ legacy != ${SLOT} ]]; then
	DRIVERS_URI="http://www2.ati.com/drivers/${BETADIR}amd-catalyst-${PV/_beta/-beta}-linux-x86.x86_64.zip"
else
	DRIVERS_URI="http://www2.ati.com/drivers/legacy/amd-driver-installer-catalyst-$(get_version_component_range 1-2)-$(get_version_component_range 3)-legacy-linux-x86.x86_64.zip"
fi
XVBA_SDK_URI="http://developer.amd.com/wordpress/media/2012/10/xvba-sdk-0.74-404001.tar.gz"
SRC_URI="${DRIVERS_URI} ${XVBA_SDK_URI}"
FOLDER_PREFIX="common/"
IUSE="debug multilib x-multilib static-libs +disable-watermark pax_kernel"

LICENSE="AMD GPL-2 QPL-1.0"
KEYWORDS="-* ~amd64 ~x86"
RESTRICT="bindist test"

RDEPEND="<=x11-base/xorg-server-1.13.49[-minimal]
	!x11-drivers/ati-drivers:0
	!x11-apps/ati-drivers-extra
	>=app-eselect/eselect-opengl-1.0.7
	app-eselect/eselect-opencl
	sys-power/acpid
	x11-apps/xauth
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libXrender
	x-multilib? (
			app-emulation/emul-linux-x86-opengl
			app-emulation/emul-linux-x86-xlibs
	)
	!<x11-drivers/ati-userspace-${PV}
	!>x11-drivers/ati-userspace-${PV}"

DEPEND="${RDEPEND}
	x11-proto/inputproto
	x11-proto/xf86miscproto
	x11-proto/xf86vidmodeproto
	x11-proto/xineramaproto
	x11-libs/libXtst
	sys-apps/findutils
	app-misc/pax-utils
	app-arch/unzip
"

EMULTILIB_PKG="true"

S="${WORKDIR}"

# QA Silencing
QA_TEXTRELS="
	usr/lib*/opengl/ati/lib/libGL.so.1.2
	usr/lib*/libatiadlxx.so
	usr/lib*/xorg/modules/glesx.so
	usr/lib*/libaticaldd.so
	usr/lib*/dri/fglrx_dri.so
"

QA_EXECSTACK="
	opt/bin/atiode
	opt/bin/amdcccle
	usr/lib*/opengl/ati/lib/libGL.so.1.2
	usr/lib*/dri/fglrx_dri.so
"

QA_WX_LOAD="
	usr/lib*/opengl/ati/lib/libGL.so.1.2
	usr/lib*/dri/fglrx_dri.so
"

QA_PRESTRIPPED="
	usr/lib\(32\|64\)\?/libXvBAW.so.1.0
	usr/lib\(32\|64\)\?/opengl/ati/lib/libGL.so.1.2
	usr/lib\(32\|64\)\?/opengl/ati/extensions/libglx.so
	usr/lib\(32\|64\)\?/xorg/modules/glesx.so
	usr/lib\(32\|64\)\?/libAMDXvBA.so.1.0
	usr/lib\(32\|64\)\?/libaticaldd.so
	usr/lib\(32\|64\)\?/dri/fglrx_dri.so
"

QA_SONAME="
	usr/lib\(32\|64\)\?/libatiadlxx.so
	usr/lib\(32\|64\)\?/libaticalcl.so
	usr/lib\(32\|64\)\?/libaticaldd.so
	usr/lib\(32\|64\)\?/libaticalrt.so
	usr/lib\(32\|64\)\?/libamdocl\(32\|64\)\?.so
"

QA_DT_HASH="
	opt/bin/amdcccle
	opt/bin/aticonfig
	opt/bin/atiodcli
	opt/bin/atiode
	opt/bin/clinfo
	opt/bin/fglrxinfo
	opt/sbin/atieventsd
	opt/sbin/amdnotifyui
	usr/lib\(32\|64\)\?/libaticalcl.so
	usr/lib\(32\|64\)\?/libaticalrt.so
	usr/lib\(32\|64\)\?/libatiuki.so.1.0
	usr/lib\(32\|64\)\?/libatiadlxx.so
	usr/lib\(32\|64\)\?/libfglrx_dm.so.1.0
	usr/lib\(32\|64\)\?/libXvBAW.so.1.0
	usr/lib\(32\|64\)\?/libAMDXvBA.so.1.0
	usr/lib\(32\|64\)\?/xorg/modules/amdxmm.so
	usr/lib\(32\|64\)\?/xorg/modules/glesx.so
	usr/lib\(32\|64\)\?/xorg/modules/linux/libfglrxdrm.so
	usr/lib\(32\|64\)\?/xorg/modules/drivers/fglrx_drv.so
	usr/lib\(32\|64\)\?/libaticaldd.so
	usr/lib\(32\|64\)\?/dri/fglrx_dri.so
	usr/lib\(32\|64\)\?/opengl/ati/extensions/libglx.so
	usr/lib\(32\|64\)\?/opengl/ati/extensions/fglrx-libglx.so
	usr/lib\(32\|64\)\?/opengl/ati/lib/fglrx-libGL.so.1.2
	usr/lib\(32\|64\)\?/opengl/ati/lib/libGL.so.1.2
	usr/lib\(32\|64\)\?/OpenCL/vendors/amd/libamdocl\(32\|64\)\?.so
	usr/lib\(32\|64\)\?/OpenCL/vendors/amd/libOpenCL.so.1
"

pkg_setup() {
	# get the xorg-server version and set BASE_DIR for that
	BASE_DIR="${S}/xpic"

	# amd64/x86
	if use amd64 ; then
		MY_BASE_DIR="${BASE_DIR}_64a"
		PKG_LIBDIR=lib64
		ARCH_DIR="${S}/arch/x86_64"
	else
		MY_BASE_DIR="${BASE_DIR}"
		PKG_LIBDIR=lib
		ARCH_DIR="${S}/arch/x86"
	fi

	elog
	elog "Please note that this driver only supports graphic cards based on"
	elog "Evergreen chipset and newer."
	elog "This includes the AMD Radeon HD 5400+ series at this moment."
	elog
	elog "If your card is older then use ${CATEGORY}/xf86-video-ati"
	elog "For migration information please refer to:"
	elog "http://www.gentoo.org/proj/en/desktop/x/x11/ati-migration-guide.xml"
	einfo
}

src_unpack() {
	local DRIVERS_DISTFILE XVBA_SDK_DISTFILE
	DRIVERS_DISTFILE=${DRIVERS_URI##*/}
	XVBA_SDK_DISTFILE=${XVBA_SDK_URI##*/}

	if [[ ${DRIVERS_DISTFILE} =~ .*\.tar\.gz ]]; then
		unpack ${DRIVERS_DISTFILE}
	else
		#please note, RUN may be insanely assigned at top near SRC_URI
		if [[ ${DRIVERS_DISTFILE} =~ .*\.zip ]]; then
			unpack ${DRIVERS_DISTFILE}
			[[ -z "$RUN" ]] && RUN="${S}/${DRIVERS_DISTFILE/%.zip/.run}"
		else
			RUN="${DISTDIR}/${DRIVERS_DISTFILE}"
		fi
		sh ${RUN} --extract "${S}" 2>&1 > /dev/null || die
	fi

	mkdir xvba_sdk
	cd xvba_sdk
	unpack ${XVBA_SDK_DISTFILE}
}

src_prepare() {
	# These are the userspace utilities that we also have source for.
	# We rebuild these later.
	rm \
		"${ARCH_DIR}"/usr/X11R6/bin/fgl_glxgears \
		|| die "bin rm failed"

        # amdcccle is shipped separately
        rm "${ARCH_DIR}"/usr/X11R6/bin/amdcccle || die "cannot rm amdcccle"

	# ACPI fixups
	sed -i \
		-e "s:/var/lib/xdm/authdir/authfiles/:/var/run/xauth/:" \
		-e "s:/var/lib/gdm/:/var/gdm/:" \
		"${S}/${FOLDER_PREFIX}etc/ati/authatieventsd.sh" \
		|| die "sed failed."

	# Since "who" is in coreutils, we're using that one instead of "finger".
	sed -i -e 's:finger:who:' \
		"${S}/${FOLDER_PREFIX}usr/share/doc/fglrx/examples/etc/acpi/ati-powermode.sh" \
		|| die "Replacing 'finger' with 'who' failed."
	# Adjust paths in the script from /usr/X11R6/bin/ to /opt/bin/ and
	# add function to detect default state.
	epatch "${FILESDIR}"/ati-powermode-opt-path-3.patch

	# see http://ati.cchtml.com/show_bug.cgi?id=495
	#epatch "${FILESDIR}"/ati-drivers-old_rsp.patch
	# first hunk applied upstream second (x32 related) was not
	epatch "${FILESDIR}"/ati-drivers-x32_something_something.patch

	# compile fix for AGP-less kernel, bug #435322
	epatch "${FILESDIR}"/ati-drivers-12.9-KCL_AGP_FindCapsRegisters-stub.patch

	# Compile fix, https://bugs.gentoo.org/show_bug.cgi?id=454870
	use pax_kernel && epatch "${FILESDIR}/const-notifier-block.patch"

	cd "${S}"
	mkdir extra || die "mkdir failed"
	cd extra
	unpack ./../${FOLDER_PREFIX}usr/src/ati/fglrx_sample_source.tgz

	# Get rid of watermark. Oldest known reference:
	# http://phoronix.com/forums/showthread.php?19875-Unsupported-Hardware-watermark
	if use disable-watermark; then
		ebegin "Disabling watermark"
		driver="${MY_BASE_DIR}"/usr/X11R6/${PKG_LIBDIR}/modules/drivers/fglrx_drv.so
		for x in $(objdump -d ${driver}|awk '/call/&&/EnableLogo/{print "\\x"$2"\\x"$3"\\x"$4"\\x"$5"\\x"$6}'); do
		sed -i "s/${x/x5b/\x5b}/\x90\x90\x90\x90\x90/g" ${driver} || break 1
		done
		eend $? || die "Disabling watermark failed"
	fi
}

src_compile() {
	ebegin "Building fgl_glxgears"
	cd "${S}"/extra/fgl_glxgears
	# These extra libs/utils either have an Imakefile that does not
	# work very well without tweaking or a Makefile ignoring CFLAGS
	# and the like. We bypass those.
	# The -DUSE_GLU is needed to compile using nvidia headers
	# according to a comment in ati-drivers-extra-8.33.6.ebuild.
	"$(tc-getCC)" -o fgl_glxgears ${CFLAGS} ${LDFLAGS} -DUSE_GLU \
		-I"${S}"/${FOLDER_PREFIX}usr/include fgl_glxgears.c \
		-lGL -lGLU -lX11 -lm || die "fgl_glxgears build failed"
	eend $?
}

src_test() { :; } # no tests present

src_install() {
	# We can do two things here, and neither of them is very nice.

	# For direct rendering libGL has to be able to load one or more
	# dri modules (files ending in _dri.so, like fglrx_dri.so).
	# Gentoo's mesa looks for these files in the location specified by
	# LIBGL_DRIVERS_PATH or LIBGL_DRIVERS_DIR, then in the hardcoded
	# location /usr/$(get_libdir)/dri. Ati's libGL does the same
	# thing, but the hardcoded location is /usr/X11R6/lib/modules/dri
	# on x86 and amd64 32bit, /usr/X11R6/lib64/modules/dri on amd64
	# 64bit. So we can either put the .so files in that (unusual,
	# compared to "normal" mesa libGL) location or set
	# LIBGL_DRIVERS_PATH. We currently do the latter. See also bug
	# 101539.

	# The problem with this approach is that LIBGL_DRIVERS_PATH
	# *overrides* the default hardcoded location, it does not extend
	# it. So if ati-drivers is merged but a non-ati libGL is selected
	# and its hardcoded path does not match our LIBGL_DRIVERS_PATH
	# (because it changed in a newer mesa or because it was compiled
	# for a different set of multilib abis than we are) stuff breaks.

	# We create one file per ABI to work with "native" multilib, see
	# below.

	echo "COLON_SEPARATED=LIBGL_DRIVERS_PATH" > "${T}/03ati-colon-sep"
	doenvd "${T}/03ati-colon-sep" || die

	# All libraries that we have a 32 bit and 64 bit version of on
	# amd64 are installed in src_install-libs. Everything else
	# (including libraries only available in native 64bit on amd64)
	# goes in here.

	# There used to be some code here that tried to detect running
	# under a "native multilib" portage ((precursor of)
	# http://dev.gentoo.org/~kanaka/auto-multilib/). I removed that, it
	# should just work (only doing some duplicate work). --marienz
	if has_multilib_profile && use multilib; then
		local OABI=${ABI}
		for ABI in $(get_install_abis); do
			src_install-libs
		done
		ABI=${OABI}
		unset OABI
	else
		src_install-libs
	fi

	# This is sorted by the order the files occur in the source tree.

	# X modules.
	exeinto /usr/$(get_libdir)/xorg/modules/drivers
	doexe "${MY_BASE_DIR}"/usr/X11R6/${PKG_LIBDIR}/modules/drivers/fglrx_drv.so
	exeinto /usr/$(get_libdir)/xorg/modules/linux
	doexe "${MY_BASE_DIR}"/usr/X11R6/${PKG_LIBDIR}/modules/linux/libfglrxdrm.so
	exeinto /usr/$(get_libdir)/xorg/modules
	doexe "${MY_BASE_DIR}"/usr/X11R6/${PKG_LIBDIR}/modules/{glesx.so,amdxmm.so}

	# Arch-specific files.
	# (s)bin.
	into /opt
	dosbin "${ARCH_DIR}"/usr/sbin/atieventsd
	dobin "${ARCH_DIR}"/usr/bin/clinfo
	# We cleaned out the compilable stuff in src_unpack
	dobin "${ARCH_DIR}"/usr/X11R6/bin/*

	# Common files.
	# etc.
	insinto /etc/ati
	exeinto /etc/ati
	# Everything except for the authatieventsd.sh script.
	doins ${FOLDER_PREFIX}etc/ati/{logo*,control,atiogl.xml,signature,amdpcsdb.default}
	doexe ${FOLDER_PREFIX}etc/ati/authatieventsd.sh

	# include.
	insinto /usr
	doins -r ${FOLDER_PREFIX}usr/include
	insinto /usr/include/X11/extensions

	# Just the atigetsysteminfo.sh script.
	into /usr
	dosbin ${FOLDER_PREFIX}usr/sbin/*

	# doc.
	dohtml -r ${FOLDER_PREFIX}usr/share/doc/fglrx

	doman ${FOLDER_PREFIX}usr/share/man/man8/atieventsd.8

	pushd ${FOLDER_PREFIX}usr/share/doc/fglrx/examples/etc/acpi > /dev/null

	exeinto /etc/acpi
	doexe ati-powermode.sh
	insinto /etc/acpi/events
	doins events/*

	popd > /dev/null

	# Done with the "source" tree. Install tools we rebuilt:
	dobin extra/fgl_glxgears/fgl_glxgears
	newdoc extra/fgl_glxgears/README README.fgl_glxgears

	# Gentoo-specific stuff:
	newinitd "${FILESDIR}"/atieventsd.init atieventsd
	echo 'ATIEVENTSDOPTS=""' > "${T}"/atieventsd.conf
	newconfd "${T}"/atieventsd.conf atieventsd

	# PowerXpress stuff
	exeinto /usr/$(get_libdir)/fglrx
	doexe "${FILESDIR}"/switchlibGL || die "doexe switchlibGL failed"
	cp "${FILESDIR}"/switchlibGL "${T}"/switchlibglx
	doexe "${T}"/switchlibglx || die "doexe switchlibglx failed"
}

src_install-libs() {
	if [[ "${ABI}" == "amd64" ]]; then
		local EX_BASE_DIR="${BASE_DIR}_64a"
		local pkglibdir=lib64
		local MY_ARCH_DIR="${S}/arch/x86_64"
		local oclsuffix=64
	else
		local EX_BASE_DIR="${BASE_DIR}"
		local pkglibdir=lib
		local MY_ARCH_DIR="${S}/arch/x86"
		local oclsuffix=32
	fi
	einfo "ati tree '${pkglibdir}' -> '$(get_libdir)' on system"

	local ATI_ROOT=/usr/$(get_libdir)/opengl/ati
	# To make sure we do not miss a spot when these change.
	local libmajor=1 libminor=2
	local libver=${libmajor}.${libminor}

	# The GLX libraries
	# (yes, this really is "lib" even on amd64/multilib --marienz)
	exeinto ${ATI_ROOT}/lib
	newexe "${MY_ARCH_DIR}"/usr/X11R6/${pkglibdir}/fglrx/fglrx-libGL.so.${libver} \
		libGL.so.${libver}
	dosym libGL.so.${libver} ${ATI_ROOT}/lib/libGL.so.${libmajor}
	dosym libGL.so.${libver} ${ATI_ROOT}/lib/libGL.so

	exeinto ${ATI_ROOT}/extensions
	doexe "${EX_BASE_DIR}"/usr/X11R6/${pkglibdir}/modules/extensions/fglrx/fglrx-libglx.so
	mv "${D}"/${ATI_ROOT}/extensions/{fglrx-,}libglx.so

	# other libs
	exeinto /usr/$(get_libdir)
	# Everything except for the libGL.so installed some row above
	doexe $(find "${MY_ARCH_DIR}"/usr/X11R6/${pkglibdir} \
		-maxdepth 1 -type f -name '*.so*' -not -name '*libGL.so*')
	insinto /usr/$(get_libdir)
	doins $(find "${MY_ARCH_DIR}"/usr/X11R6/${pkglibdir} \
		-maxdepth 1 -type f -not -name '*.so*')

	# DRI modules, installed into the path used by recent versions of mesa.
	exeinto /usr/$(get_libdir)/dri
	doexe "${MY_ARCH_DIR}"/usr/X11R6/${pkglibdir}/modules/dri/fglrx_dri.so

	# AMD Cal and OpenCL libraries
	exeinto /usr/$(get_libdir)/OpenCL/vendors/amd
	doexe "${MY_ARCH_DIR}"/usr/${pkglibdir}/libamdocl*.so*
	doexe "${MY_ARCH_DIR}"/usr/${pkglibdir}/libOpenCL*.so*
	dosym libOpenCL.so.${libmajor} /usr/$(get_libdir)/OpenCL/vendors/amd/libOpenCL.so
	exeinto /usr/$(get_libdir)
	doexe "${MY_ARCH_DIR}"/usr/${pkglibdir}/libati*.so*

	# OpenCL vendor files
	insinto /etc/OpenCL/vendors/
	cat > "${T}"/amdocl${oclsuffix}.icd <<-EOF
		/usr/$(get_libdir)/OpenCL/vendors/amd/libamdocl${oclsuffix}.so
	EOF
	doins "${T}"/amdocl${oclsuffix}.icd

	local envname="${T}"/04ati-dri-path
	if [[ -n ${ABI} ]]; then
		envname="${envname}-${ABI}"
	fi
	echo "LIBGL_DRIVERS_PATH=/usr/$(get_libdir)/dri" > "${envname}"
	doenvd "${envname}"

	# Silence the QA notice by creating missing soname symlinks
	for so in $(find "${D}"/usr/$(get_libdir) -maxdepth 1 -name *.so.[0-9].[0-9])
	do
		local soname=${so##*/}
		local soname_one=${soname%.[0-9]}
		local soname_zero=${soname_one%.[0-9]}
		dosym ${soname} /usr/$(get_libdir)/${soname_one}
		dosym ${soname_one} /usr/$(get_libdir)/${soname_zero}
	done

	# See https://bugs.gentoo.org/show_bug.cgi?id=443466
	dodir /etc/revdep-rebuild/
	echo "SEARCH_DIRS_MASK=\"/opt/bin/clinfo\"" > "${ED}/etc/revdep-rebuild/62-ati-drivers"

	#remove static libs if not wanted
	use static-libs || rm -rf "${D}"/usr/$(get_libdir)/libfglrx_dm.a

	#install xvba sdk headers
	doheader xvba_sdk/include/amdxvba.h

	if use pax_kernel; then
		pax-mark m "${D}"/usr/lib*/opengl/ati/lib/libGL.so.1.2 || die "pax-mark failed"
	fi
}

pkg_postinst() {
	elog "To switch to AMD OpenGL, run \"eselect opengl set ati\""
	elog "To change your xorg.conf you can use the bundled \"aticonfig\""
	elog
	elog "If you experience unexplained segmentation faults and kernel crashes"
	elog "with this driver and multi-threaded applications such as wine,"
	elog "set UseFastTLS in xorg.conf to either 0 or 1, but not 2."
	elog
	elog "Fully rebooting the system after an ${PN} update is recommended"
	elog "Stopping Xorg, reloading fglrx kernel module and restart Xorg"
	elog "might not work"
	elog
	elog "Some cards need acpid running to handle events"
	elog "Please add it to boot runlevel with rc-update add acpid boot"
	elog

	"${ROOT}"/usr/bin/eselect opengl set --use-old ati
	"${ROOT}"/usr/bin/eselect opencl set --use-old amd

	if has_version ">=x11-drivers/xf86-video-intel-2.20.3"; then
		ewarn "It is reported that xf86-video-intel-2.20.3 and later cause the X server"
		ewarn "to crash on systems that use hybrid AMD/Intel graphics. If you experience"
		ewarn "this crash, downgrade to xf86-video-intel-2.20.2 or earlier."
		ewarn "For details, see https://bugs.gentoo.org/show_bug.cgi?id=430000"
	fi
}

pkg_prerm() {
	"${ROOT}"/usr/bin/eselect opengl set --use-old xorg-x11
}

pkg_postrm() {
	"${ROOT}"/usr/bin/eselect opengl set --use-old xorg-x11
}
