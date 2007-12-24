# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/apr/apr-1.2.12.ebuild,v 1.1 2007/12/15 14:24:41 hollow Exp $

EAPI="prefix"

inherit autotools

DESCRIPTION="Apache Portable Runtime Library"
HOMEPAGE="http://apr.apache.org/"
SRC_URI="mirror://apache/apr/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="1"
KEYWORDS="~amd64 ~ia64 ~ia64-hpux ~ppc-aix ~ppc-macos ~sparc-solaris ~sparc64-solaris ~x86 ~x86-fbsd ~x86-macos ~x86-solaris"
IUSE="doc ipv6 urandom debug"
RESTRICT="test"

DEPEND="doc? ( app-doc/doxygen )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# the included libtool.m4 is causing big trouble, use the system one
	rm -f build/libtool.m4
	epatch "${FILESDIR}"/${PN}-1.2.8-libtool.patch

	# for some reason not all the .m4 files that are referenced in 
	# configure.in exist, so we remove all references and include every
	# .m4 file in build using aclocal via eautoreconf
	# See bug 135463
	sed -i -e '/sinclude/d' configure.in

	AT_M4DIR="build" eautoreconf

	epatch "${FILESDIR}"/config.layout.patch
}

src_compile() {
	# For now we always enable ipv6. Testing has shown that is still works
	# correctly in ipv4 systems, and currently, the ipv4-only support
	# is broken in apr. (ipv6 is enabled by default)
	#myconf="${myconf} $(use_enable ipv6)"

	if use urandom; then
		myconf="${myconf} --with-devrandom=/dev/urandom"
	else
		myconf="${myconf} --with-devrandom=/dev/random"
	fi

	if use debug; then
		myconf="${myconf} --enable-maintainer-mode"
		myconf="${myconf} --enable-pool-debug=all"
	fi

	# We pre-load the cache with the correct answer!  This avoids
	# it violating the sandbox.  This may have to be changed for
	# non-Linux systems or if sem_open changes on Linux.  This
	# hack is built around documentation in /usr/include/semaphore.h
	# and the glibc (pthread) source
	# See bugs 24215 and 133573
	echo 'ac_cv_func_sem_open=${ac_cv_func_sem_open=no}' >> "${S}"/config.cache

	econf --enable-layout=gentoo \
		--enable-threads \
		--enable-nonportable-atomics \
		${myconf}

	emake || die "Make failed"

	if use doc; then
		emake dox || die "make dox failed"
	fi
}

src_install() {
	# rules.mk is copied over, so make reference to libtool correct
	sed -i \
		-e 's/^top_builddir=.*$/top_builddir=$(apr_builddir)/' \
		build/apr_rules.mk

	make DESTDIR="${D}" install || die "make install failed"

	# This file is only used on AIX systems, which gentoo is not,
	# and causes collisions between the SLOTs, so kill it
	rm "${ED}"/usr/$(get_libdir)/apr.exp

	dodoc CHANGES NOTICE

	if use doc; then
		dohtml docs/dox/html/* || die
	fi
}

pkg_postinst() {
	ewarn "We are now using the system's libtool rather then bundling"
	ewarn "our own. You will need to rebuild Apache and possibly other"
	ewarn "software if you get a message similiar to the following:"
	ewarn
	ewarn "   /usr/share/apr-1/build-1/libtool: No such file or directory"
	ewarn
}
