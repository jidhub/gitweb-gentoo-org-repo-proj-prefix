# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/actionwebservice/actionwebservice-1.2.4.ebuild,v 1.1 2007/10/06 16:31:47 graaff Exp $

EAPI="prefix"

inherit ruby gems

DESCRIPTION="Simple Support for Web Services APIs for Rails"
HOMEPAGE="http://rubyforge.org/projects/aws/"

LICENSE="MIT"
SLOT="1.2"
KEYWORDS="~amd64 ~ia64 ~ppc-macos ~x86 ~x86-macos ~x86-solaris"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.5
	=dev-ruby/actionpack-1.13.4
	=dev-ruby/activerecord-1.15.4
	=dev-ruby/activesupport-1.4.3"
