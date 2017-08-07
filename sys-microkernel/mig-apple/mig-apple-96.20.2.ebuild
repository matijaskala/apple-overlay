# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="Apple Mach Interface Generator"
HOMEPAGE="https://opensource.apple.com/"
SRC_URI="
	https://opensource.apple.com/tarballs/bootstrap_cmds-${PV}.tar.gz
	https://opensource.apple.com/tarballs/libpthread/libpthread-218.51.1.tar.gz
	https://opensource.apple.com/tarballs/xnu/xnu-3789.51.2.tar.gz"

LICENSE="APSL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}/bootstrap_cmds-${PV}/migcom.tproj

src_prepare() {
	default
	cp "${FILESDIR}"/Makefile . || die
	cp -r "${FILESDIR}"/include . || die
	sed -i /linux/d type.h || die
	sed -i "s/MIG_VERSION/\"${PV}\"/" utils.c || die
	cp -r "${WORKDIR}"/libpthread-218.51.1/sys include || die
	cp "${WORKDIR}"/xnu-3789.51.2/EXTERNAL_HEADERS/Availability.h include || die
	cp "${WORKDIR}"/xnu-3789.51.2/EXTERNAL_HEADERS/AvailabilityInternal.h include || die
	cp -r "${WORKDIR}"/xnu-3789.51.2/bsd/machine include || die
	cp -r "${WORKDIR}"/xnu-3789.51.2/bsd/sys/_types* include/sys || die
	cp "${WORKDIR}"/xnu-3789.51.2/bsd/sys/appleapiopts.h include/sys || die
	cp -r "${WORKDIR}"/xnu-3789.51.2/libkern/libkern include || die
	cp -r "${WORKDIR}"/xnu-3789.51.2/osfmk/mach include || die
}

src_install() {
	local ctarget_prefix
	if [[ ${CATEGORY} == sys-microkernel ]] ; then
		ctarget_prefix=
	else
		ctarget_prefix=${CATEGORY#cross-}-
	fi
	newbin mig.sh ${ctarget_prefix}mig
	exeinto ${ddir}/usr/libexec
	newexe migcom ${ctarget_prefix}migcom
	insinto ${ddir}/usr/share/man/man1
	newins mig.1 ${ctarget_prefix}mig.1
	newins migcom.1 ${ctarget_prefix}migcom.1
}
