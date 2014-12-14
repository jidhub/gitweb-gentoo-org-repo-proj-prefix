# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/gzip/gzip-1.6.ebuild,v 1.2 2014/01/18 01:18:08 vapier Exp $

EAPI="4"

inherit eutils flag-o-matic

DESCRIPTION="Standard GNU compressor"
HOMEPAGE="http://www.gnu.org/software/gzip/"
SRC_URI="mirror://gnu-alpha/gzip/${P}.tar.xz
	mirror://gnu/gzip/${P}.tar.xz
	mirror://gentoo/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~ppc-aix ~x64-freebsd ~x86-freebsd ~hppa-hpux ~ia64-hpux ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"

IUSE="pic static"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.3.8-install-symlinks.patch

	epatch "${FILESDIR}"/${PN}-1.4-asmv.patch
}

src_configure() {
	use static && append-flags -static
	# avoid text relocation in gzip
	use pic && export DEFS="NO_ASM"
	econf
}

src_install() {
	default
	docinto txt
	dodoc algorithm.doc gzip.doc

	# keep most things in /usr, just the fun stuff in /
	dodir /bin
	mv "${ED}"/usr/bin/{gunzip,gzip,uncompress,zcat} "${ED}"/bin/ || die
	sed -e "s:${EPREFIX}/usr:${EPREFIX}:" -i "${ED}"/bin/gunzip || die
}
