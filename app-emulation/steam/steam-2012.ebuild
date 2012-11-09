# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
 
# (c) 2012 Jonas Jelten
 
EAPI=4
 
inherit eutils
 
DESCRIPTION="Steam for Linux"
 
HOMEPAGE="https://steampowered.com"
 
SRC_URI="http://media.steampowered.com/client/installer/steam.deb"
 
# /usr/portage/licenses/
LICENSE="custom"
SLOT="0"
 
KEYWORDS="~x86 ~amd64"
 
IUSE=""
 
DEPEND=""  #TODO!
 
RDEPEND="${DEPEND}"
 
#S=${WORKDIR}/${P}
 
src_unpack() {
        cd "$WORKDIR"
        echo "ohhai $(pwd)" 1>&2
        #ar x steam.deb
        unpack $A
        tar xf data.tar.gz
        mkdir -p $S #dirty hack, fix pls
}
 
src_install() {
 
 
        mv $WORKDIR/usr $D/
 
        # Replace [ ] with [[ ]] in /usr/bin/steam
        sed "s/\[/\[\[/g" -i $D/usr/bin/steam
        sed "s/\]/\]\]/g" -i $D/usr/bin/steam
}
