# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Apple Architecture headers"
HOMEPAGE="https://opensource.apple.com/"
SRC_URI="https://opensource.apple.com/tarballs/${P}.tar.gz"

LICENSE="APSL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	local ddir
	if [[ ${CATEGORY} == sys-microkernel ]] ; then
		ddir=
	else
		ddir=/usr/${CATEGORY#cross-}
	fi
	emake install DSTROOT="${ED}"${ddir}
}
