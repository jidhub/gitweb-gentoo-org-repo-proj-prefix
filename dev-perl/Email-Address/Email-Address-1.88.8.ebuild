# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Address/Email-Address-1.88.8.ebuild,v 1.4 2007/08/09 15:04:54 gustavoz Exp $

EAPI="prefix"

inherit perl-module versionator

MY_PV="$(delete_version_separator 2)"
MY_P="${PN}-${MY_PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="Email::Address - RFC 2822 Address Parsing and Creation"
HOMEPAGE="http://search.cpan.org/~rjbs/"
SRC_URI="mirror://cpan/authors/id/R/RJ/RJBS/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86 ~x86-macos"
IUSE="test"
SRC_TEST="do"

DEPEND="test? ( virtual/perl-Test-Simple
		>=dev-perl/Test-Pod-1.14
		>=dev-perl/Test-Pod-Coverage-1.08 )
	dev-lang/perl"
