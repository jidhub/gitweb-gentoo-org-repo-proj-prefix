# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-latex/texlive-latex-2007.ebuild,v 1.5 2007/10/25 15:34:32 corsair Exp $

EAPI="prefix"

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-basic
"
TEXLIVE_MODULE_CONTENTS="ae amscls amsltx2 amsmath amsrefs babel babelbib bin-latex carlisle colortbl fancyhdr geometry graphics hyperref latex latex-fonts latexconfig ltxmisc mfnfss natbib pdftex-def pslatex psnfss pspicture tools collection-latex
"
inherit texlive-module
DESCRIPTION="TeXLive Basic LaTeX packages"

LICENSE="GPL-2 LPPL-1.3c"
SLOT="0"
KEYWORDS="~ia64 ~ppc-macos ~x86"
