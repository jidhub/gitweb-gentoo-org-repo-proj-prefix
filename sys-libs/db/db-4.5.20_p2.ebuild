# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/db/db-4.5.20_p2.ebuild,v 1.24 2008/08/16 03:32:00 robbat2 Exp $

EAPI="prefix"

inherit eutils db flag-o-matic java-pkg-opt-2 autotools

#Number of official patches
#PATCHNO=`echo ${PV}|sed -e "s,\(.*_p\)\([0-9]*\),\2,"`
PATCHNO=${PV/*.*.*_p}
if [[ ${PATCHNO} == "${PV}" ]] ; then
	MY_PV=${PV}
	MY_P=${P}
	PATCHNO=0
else
	MY_PV=${PV/_p${PATCHNO}}
	MY_P=${PN}-${MY_PV}
fi

S="${WORKDIR}/${MY_P}/build_unix"
DESCRIPTION="Oracle Berkeley DB"
HOMEPAGE="http://www.oracle.com/technology/software/products/berkeley-db/index.html"
SRC_URI="http://download-west.oracle.com/berkeley-db/${MY_P}.tar.gz"
for (( i=1 ; i<=${PATCHNO} ; i++ )) ; do
	export SRC_URI="${SRC_URI} http://www.oracle.com/technology/products/berkeley-db/db/update/${MY_PV}/patch.${MY_PV}.${i}"
done

LICENSE="OracleDB"
SLOT="4.5"
KEYWORDS="~ppc-aix ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="tcl java doc nocxx bootstrap"

DEPEND="tcl? ( >=dev-lang/tcl-8.4 )
	java? ( >=virtual/jdk-1.4 )
	|| ( sys-devel/odcctools
		 sys-devel/native-cctools
		 >=sys-devel/binutils-2.16.1
	)"
RDEPEND="tcl? ( dev-lang/tcl )
	java? ( >=virtual/jre-1.4 )"

src_unpack() {
	unpack "${MY_P}".tar.gz
	cd "${WORKDIR}"/"${MY_P}"
	for (( i=1 ; i<=${PATCHNO} ; i++ ))
	do
		epatch "${DISTDIR}"/patch."${MY_PV}"."${i}"
	done

	cd dist || die "Cannot cd to 'dist'"

	# need to upgrade local copy of libtool.m4 (named libtool.ac)
	# for correct shared libs on aix (#213277).
	cp -f "${EPREFIX}"/usr/share/aclocal/libtool.m4 aclocal/libtool.ac \
	|| die "cannot update libtool.ac from libtool.m4"

	# need to upgrade ltmain.sh for AIX,
	# but aclocal.m4 is created in ./s_config,
	# and elibtoolize does not work when there is no aclocal.m4, so:
	libtoolize --force --copy || die "libtoolize failed."
	# now let shipped script do the autoconf stuff, it really knows best.
	sh ./s_config || die "Cannot execute ./s_config"

	epatch "${FILESDIR}"/"${PN}"-"${SLOT}"-libtool.patch

	# use the includes from the prefix
	epatch "${FILESDIR}"/"${PN}"-4.3-jni-check-prefix-first.patch
	epatch "${FILESDIR}"/"${PN}"-4.3-listen-to-java-options.patch

	sed -i \
		-e "s,\(ac_compiler\|\${MAKEFILE_CC}\|\${MAKEFILE_CXX}\|\$CC\)\( *--version\),\1 -dumpversion,g" \
		"${S}"/../dist/configure
}

src_compile() {
	# compilation with -O0 fails on amd64, see bug #171231
	if use amd64; then
		replace-flags -O0 -O2
		is-flag -O[s123] || append-flags -O2
	fi

	local myconf=""

	use amd64 && myconf="${myconf} --with-mutex=x86/gcc-assembly"

	use bootstrap \
		&& myconf="${myconf} --disable-cxx" \
		|| myconf="${myconf} $(use_enable !nocxx cxx)"

	use tcl \
		&& myconf="${myconf} --enable-tcl --with-tcl=${EPREFIX}/usr/$(get_libdir)" \
		|| myconf="${myconf} --disable-tcl"

	myconf="${myconf} $(use_enable java)"
	if use java; then
		myconf="${myconf} --with-java-prefix=${JAVA_HOME}"
		# Can't get this working any other way, since it returns spaces, and
		# bash doesn't seem to want to pass correctly in any way i try
		local javaconf="-with-javac-flags=$(java-pkg_javac-args)"
	fi

	[[ -n ${CBUILD} ]] && myconf="${myconf} --build=${CBUILD}"

	# the entire testsuite needs the TCL functionality
	if use tcl && has test $FEATURES ; then
		myconf="${myconf} --enable-test"
	else
		myconf="${myconf} --disable-test"
	fi

	# Add linker versions to the symbols. Easier to do, and safer than header file
	# mumbo jumbo.
	if [[ ${CHOST} == *-linux-gnu || ${CHOST} == *-solaris* ]] ; then
		# we hopefully use a GNU binutils linker in this case
		append-ldflags -Wl,--default-symver
	fi

	cd "${S}" && ECONF_SOURCE="${S}"/../dist CC=$(tc-getCC) econf \
		--prefix="${EPREFIX}"/usr \
		--mandir="${EPREFIX}"/usr/share/man \
		--infodir="${EPREFIX}"/usr/share/info \
		--datadir="${EPREFIX}"/usr/share \
		--sysconfdir="${EPREFIX}"/etc \
		--localstatedir="${EPREFIX}"/var/lib \
		--libdir="${EPREFIX}"/usr/"$(get_libdir)" \
		--enable-compat185 \
		--without-uniquename \
		--enable-rpc \
		--host="${CHOST}" \
		${myconf} "${javaconf}" || die "configure failed"

	sed -e "s,\(^STRIP *=\).*,\1\"none\"," Makefile > Makefile.cpy \
	    && mv Makefile.cpy Makefile

	# FreeBSD contains a broken version of rpcgen, see 
	# http://lists.freebsd.org/pipermail/freebsd-bugs/2005-August/014086.html
	sed -i -e "s/^extern  \(void db_rpc_serverprog_\)/static \1/" db_server.h || die "failed to fix FreeBSD brokeness"

	emake -j1 || die "make failed"
}

src_install() {

	einstall libdir="${ED}/usr/$(get_libdir)" strip="none" || die

	db_src_install_usrbinslot

	db_src_install_headerslot

	db_src_install_doc

	db_src_install_usrlibcleanup

	dodir /usr/sbin
	mv "${ED}"/usr/bin/berkeley_db_svc "${ED}"/usr/sbin/berkeley_db"${SLOT/./}"_svc

	if use java; then
		java-pkg_regso "${ED}"/usr/"$(get_libdir)"/libdb_java*.so
		java-pkg_dojar "${ED}"/usr/"$(get_libdir)"/*.jar
		rm -f "${ED}"/usr/"$(get_libdir)"/*.jar
	fi
}

pkg_postinst() {
	db_fix_so
}

pkg_postrm() {
	db_fix_so
}
