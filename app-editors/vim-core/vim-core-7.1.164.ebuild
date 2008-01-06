# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/vim-core/vim-core-7.1.164.ebuild,v 1.1 2007/11/30 06:15:03 hawking Exp $

EAPI="prefix"

inherit vim autotools

VIM_VERSION="7.1"
VIM_GENTOO_PATCHES="vim-${VIM_VERSION}-gentoo-patches.tar.bz2"
VIM_ORG_PATCHES="vim-patches-${PV}.tar.gz"
VIMRC_FILE_SUFFIX="-r3"
MACVIM_PATCHVER="1"

SRC_URI="ftp://ftp.vim.org/pub/vim/unix/vim-${VIM_VERSION}.tar.bz2
	ftp://ftp.vim.org/pub/vim/extra/vim-${VIM_VERSION}-lang.tar.gz
	ftp://ftp.vim.org/pub/vim/extra/vim-${VIM_VERSION}-extra.tar.gz
	mirror://gentoo/${VIM_GENTOO_PATCHES}
	mirror://gentoo/${VIM_ORG_PATCHES}
	aqua? ( http://dev.gentoo.org/~grobian/distfiles/macvim-${PV}-${MACVIM_PATCHVER}.tar.bz2 )"

S="${WORKDIR}/vim${VIM_VERSION/.}"
DESCRIPTION="vim and gvim shared files"
KEYWORDS="~amd64 ~ia64 ~x86 ~ppc-aix ~x86-fbsd ~ia64-hpux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""
DEPEND="${DEPEND}"
PDEPEND="!livecd? ( app-vim/gentoo-syntax )"
