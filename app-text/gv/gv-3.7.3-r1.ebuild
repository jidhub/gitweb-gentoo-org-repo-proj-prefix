# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gv/gv-3.7.3-r1.ebuild,v 1.5 2012/05/04 03:33:17 jdhore Exp $

EAPI=4
inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Viewer for PostScript and PDF documents using Ghostscript"
HOMEPAGE="http://www.gnu.org/software/gv/"
SRC_URI="mirror://gnu/gv/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="unicode xinerama"

RDEPEND="app-text/ghostscript-gpl
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	>=x11-libs/libXaw3d-1.6-r1[unicode?]
	x11-libs/libXext
	x11-libs/libXmu
	x11-libs/libXpm
	x11-libs/libXt
	xinerama? ( x11-libs/libXinerama )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	x11-proto/xproto"

DOCS="AUTHORS ChangeLog NEWS README"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-3.7.3-libXaw3d-1.6.patch
}

src_configure() {
	# Grab -DXAW_INTERNATIONALIZATION if needed
	append-cppflags "$($(tc-getPKG_CONFIG) --cflags xaw3d)"

	export ac_cv_lib_Xinerama_main=$(usex xinerama)

	econf \
		--enable-scrollbar-code \
		$(use_enable unicode international)
}

src_install() {
	emake appdefaultsdir="${EPREFIX}/etc/X11/app-defaults" DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README

	doicon "${FILESDIR}"/gv_icon.xpm
	make_desktop_entry gv GhostView gv_icon "Graphics;Viewer"
}