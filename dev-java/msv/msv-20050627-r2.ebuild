# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/msv/msv-20050627-r2.ebuild,v 1.5 2008/05/06 14:55:38 opfer Exp $

EAPI="prefix 1"
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 eutils java-ant-2

DESCRIPTION="Multi-Schema XML Validator, a Java tool for validating XML documents"
HOMEPAGE="http://www.sun.com/software/xml/developers/multischema/ https://msv.dev.java.net/"
SRC_URI="mirror://gentoo/${PN}.${PV}.zip"

LICENSE="BSD Apache-1.1"
SLOT="0"
KEYWORDS="~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~x86-macos"
IUSE=""

RDEPEND=">=virtual/jre-1.4
	dev-java/iso-relax:0
	dev-java/relaxng-datatype:0
	dev-java/xml-commons-resolver:0
	dev-java/xerces:2
	dev-java/xsdlib:0"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	${RDEPEND}"

JAVA_PKG_FILTER_COMPILER="jikes"

src_unpack() {
	unpack ${A}
	cd "${S}"
	cp -i "${FILESDIR}/build-${PVR}.xml" build.xml || die
	rm -v *.jar || die

	mkdir lib && cd lib
	java-pkg_jar-from iso-relax,relaxng-datatype,xerces-2,xml-commons-resolver,xsdlib
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar dist/${PN}.jar

	dodoc README.txt ChangeLog.txt || die

	use doc && java-pkg_dojavadoc dist/doc/api
	use source && java-pkg_dosrc src/*
}
