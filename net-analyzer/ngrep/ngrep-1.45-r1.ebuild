# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ngrep/ngrep-1.45-r1.ebuild,v 1.11 2008/11/09 12:11:47 vapier Exp $

inherit eutils autotools

DESCRIPTION="A grep for network layers"
HOMEPAGE="http://ngrep.sourceforge.net/"
SRC_URI="mirror://sourceforge/ngrep/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="ipv6 pcre"

DEPEND="virtual/libc
	net-libs/libpcap
	pcre? ( dev-libs/libpcre )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}.patch
	epatch "${FILESDIR}"/${P}-Makefile.in.patch
	epatch "${FILESDIR}"/${P}-prefix.patch
	eautoreconf
}

src_compile() {
	econf --with-dropprivs-user=ngrep \
		$(use_enable pcre) \
		$(use_enable ipv6) || die "econf failed"
	emake || die "emake failed"
}

pkg_preinst() {
	enewgroup ngrep
	enewuser ngrep -1 -1 -1 ngrep
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc doc/*.txt
}
