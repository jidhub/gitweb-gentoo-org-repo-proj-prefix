# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-latexextra/texlive-latexextra-2007.ebuild,v 1.20 2008/09/09 18:33:45 aballier Exp $

EAPI="prefix"

TEXLIVE_MODULES_DEPS="dev-texlive/texlive-latex
dev-texlive/texlive-fontsrecommended
!dev-tex/currvita
!dev-tex/g-brief
!dev-tex/ha-prosper
!dev-tex/prosper
!dev-tex/texpower
!dev-tex/cdcover
!dev-tex/leaflet
!dev-tex/latex-calendar
!dev-tex/achemso"
TEXLIVE_MODULE_CONTENTS="ESIEEcv GuIT HA-prosper Tabbing a0poster abstract achemso acronym adrconv adrlist akletter altfont answers appendix arcs arrayjob assignment attachfile authorindex autotab begriff beton bez123 bezos bin-perltex bin-ppower4 binomexp bizcard blindtext boites booklet bophook boxhandler breakurl bussproofs calendar calrsfs calxxxx captcont casyl cbcoptic ccaption cd cd-cover cdpbundl cellspace changebar chappg chapterfolder china2e circ cjw clefval clock cmdtrack cmsd codepage colorinfo combine comment concprog contour cooking cool coollist coolstr cooltooltips coordsys count1to courseoutline coursepaper coverpage crossreference crosswrd csquotes csvtools cuisine currvita cursor cv cwpuzzle dashbox dashrule dateiliste datenumber datetime decimal deleq diagnose dialogl dichokey dinbrief directory dk-bib dnaseq docmfp dotseqn dpfloat draftcopy draftwatermark dropping dtk dvdcoll eCards easy ebezier eemeir egplot ellipsis elmath elpres em empheq emulateapj endfloat endheads engpron engrec enumitem envbig envlab epigraph epiolmec eqlist eqname eqparbox esdiff esint esint-type1 etaremune europecv everypage exam examdesign examplep exercise expdlist expl3 export extract facsimile fancybox fancynum fax figbib figsize filecontents fink fixfoot fixme flabels flagderiv flashcards flippdf floatrow flowfram fmp fmtcount fnbreak fncychap foilhtml footmisc footnpag forloop formlett formular fribrief fullblck fullpict fundus g-brief gauss genmpage geomsty ginpenc gloss glossary gmdoc gmiflink gmutils gmverb graphicx-psmin grfpaste grnumalt hanging harpoon hc hhtensor hilowres histogr hitec hpsdiss hvfloat hyper hyperxmp hyphenat ifmslide interactiveworkbook invoice ipa iso iso10303 isodate isorot isotope kalender kastrup kerntest keystroke labbook labelcas labels lastpage latex-tds layouts lazylist lcd lcg leaflet leftidx lettre lettrine lewis lhelp limap lipsum listliketab listofsymbols lkproof localloc logpap lsc ltablex ltabptch ltxindex mailing makebox makecell makecirc makecmds makedtx makeglos manfnt manuscript mapcodes maple marginnote maybemath mcaption mceinleger mcite menu method metre mff mftinc minipage-marginpar minitoc minutes misc209 mla-paper moderncv modroman morehelp moresize moreverb movie15 mparhack msc msg mslapa mtgreek multenum multibbl multicap multirow multitoc mwrite nag namespc ncclatex ncctools newfile newlfm newthm newvbtm niceframe noitcrul nomencl nomentbl nonfloat notes ntabbing ntheorem numprint ocr-latex octavo oldstyle onlyamsmath opcit outline outliner overpic oxford pageno pagenote paper papercdcase papertex paralist paresse patch patchcmd pauldoc pawpict pbox pbsheet pdfcprot pdfscreen pdfslide pdfsync pdfwin pecha perltex permute photo pittetd placeins plates plweb polyglot polynom polytable postcards ppower4 ppr-prv prelim2e preprint prettyref preview probsoln progkeys program progress prosper protocol psfragx pst-pdf qcm qsymbols quotchap ragged2e randtext rccol rcsinfo rectopma refcheck refman refstyle regcount register relenc repeatindex resume rlepsf rmpage robustcommand robustindex romannum rotfloat rotpages rst rtkinenc sauerj savefnmark savesym savetrees scale scalebar schedule sciwordconv script sectionbox sectsty semantic semioneside seqsplit sf298 sffms shadbox shadethm shapepar shortlst shorttoc showdim showexpl showlabels sidecap slantsc slashbox slidenotes smalltableof smartref smflatex snapshot soul sparklines splitbib splitindex spotcolor sprite srcltx sseq ssqquote stack statistik stdclsdv stdpage sttools subeqn subeqnarray subfigure subfloat substr supertabular svgcolor svn svn-multi svninfo syntax syntrace synttree tableaux tabto-ltx tabulary talk taupin tcldoc technics texlogos texmate texpower texshade textcase textfit textmerg textpos thumb ticket timesht timing titlefoot titlesec titling tocbibind tocloft tocvsec2 todo tokenizer toolbox topfloat totpages tracking trfsigns trsym twoup type1cm typedref typogrid ulsy umoline underlin undertilde units upquote ushort varindex vector versions vhistory vita vmargin volumes vpe vrsion wallpaper warning warpcol was webeq williams wordcount wordlike wrapfig xbmc xdoc xifthen xmpincl xytree yafoot yplan zed-csp collection-latexextra
"
inherit texlive-module
DESCRIPTION="TeXLive LaTeX supplementary packages"

LICENSE="GPL-2 LPPL-1.3c Artistic"
SLOT="0"
KEYWORDS="~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
