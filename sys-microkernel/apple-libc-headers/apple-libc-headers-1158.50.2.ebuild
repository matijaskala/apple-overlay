# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Apple Libc"
HOMEPAGE="https://opensource.apple.com/"
SRC_URI="https://opensource.apple.com/tarballs/Libc-${PV}.tar.gz"

LICENSE="APSL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}/Libc-${PV}

src_install() {
	local ddir
	if [[ ${CATEGORY} == sys-microkernel ]] ; then
		ddir=
	else
		ddir=/usr/${CATEGORY#cross-}
	fi
	DSTROOT="${ED}"${ddir}/usr/include SRCROOT="$(pwd)" xcodescripts/headers.sh || die
}
