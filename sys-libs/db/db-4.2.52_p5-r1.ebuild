# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=0

inherit eutils db flag-o-matic java-pkg-opt-2 autotools multilib

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
HOMEPAGE="http://www.oracle.com/technetwork/database/database-technologies/berkeleydb/overview/index.html"
SRC_URI="http://download.oracle.com/berkeley-db/${MY_P}.tar.gz"
for (( i=1 ; i<=${PATCHNO} ; i++ )) ; do
	export SRC_URI="${SRC_URI} http://www.oracle.com/technology/products/berkeley-db/db/update/${MY_PV}/patch.${MY_PV}.${i}"
done

LICENSE="Sleepycat"
SLOT="4.2"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="tcl java doc cxx rpc"

DEPEND="tcl? ( >=dev-lang/tcl-8.4 )
	java? ( >=virtual/jdk-1.4 )"
RDEPEND="tcl? ( dev-lang/tcl )
	java? ( >=virtual/jre-1.4 )"

src_unpack() {
	unpack "${MY_P}".tar.gz
	cd "${WORKDIR}"/"${MY_P}"
	for (( i=1 ; i<=${PATCHNO} ; i++ ))
	do
		epatch "${DISTDIR}"/patch."${MY_PV}"."${i}"
	done
	epatch "${FILESDIR}"/"${PN}"-4.2.52_p2-TXN.patch
	epatch "${FILESDIR}"/"${PN}"-"${SLOT}"-libtool.patch

	# use the includes from the prefix
	epatch "${FILESDIR}"/"${PN}"-"${SLOT}"-jni-check-prefix-first.patch
	epatch "${FILESDIR}"/"${PN}"-"${SLOT}"-listen-to-java-options.patch
	epatch "${FILESDIR}"/"${PN}"-4.0.14-fix-dep-link.patch

	sed -e "/^DB_RELEASE_DATE=/s/%B %e, %Y/%Y-%m-%d/" -i dist/RELEASE

	# Include the SLOT for Java JAR files
	# This supersedes the unused jarlocation patches.
	sed -r -i \
		-e '/jarfile=.*\.jar$/s,(.jar$),-$(LIBVERSION)\1,g' \
		"${S}"/../dist/Makefile.in

	# START of 4.5+earlier specific
	# Upstream sucks, they normally concat these
	cd "${S}"/../dist/aclocal
	for i in *; do ln -s $i ${i%.ac}.m4 ; done ;
	cd "${S}"/../dist/aclocal_java
	for i in *; do ln -s $i ${i%.ac}.m4 ; done ;
	# END of 4.5+earlier specific
	cd "${S}"/../dist
	rm -f aclocal/libtool.{m4,ac} aclocal.m4
	sed -i \
		-e '/AC_PROG_LIBTOOL$/aLT_OUTPUT' \
		configure.ac
	sed -i \
		-e '/^AC_PATH_TOOL/s/ sh, missing_sh/ bash, missing_sh/' \
		aclocal/programs.m4
	AT_M4DIR="aclocal aclocal_java" eautoreconf
	# Upstream sucks - they do autoconf and THEN replace the version variables.
	. ./RELEASE
	sed -i \
		-e "s/__EDIT_DB_VERSION_MAJOR__/$DB_VERSION_MAJOR/g" \
		-e "s/__EDIT_DB_VERSION_MINOR__/$DB_VERSION_MINOR/g" \
		-e "s/__EDIT_DB_VERSION_PATCH__/$DB_VERSION_PATCH/g" \
		-e "s/__EDIT_DB_VERSION_STRING__/$DB_VERSION_STRING/g" \
		-e "s/__EDIT_DB_VERSION_UNIQUE_NAME__/$DB_VERSION_UNIQUE_NAME/g" \
		-e "s/__EDIT_DB_VERSION__/$DB_VERSION/g" configure
}

src_compile() {
	local myconf=""

	use amd64 && myconf="${myconf} --with-mutex=x86/gcc-assembly"

	myconf="${myconf} $(use_enable cxx)"

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
	if use tcl && use test; then
		myconf="${myconf} --enable-test"
	else
		myconf="${myconf} --disable-test"
	fi

	cd "${S}" && ECONF_SOURCE="${S}"/../dist econf \
		--prefix="${EPREFIX}"/usr \
		--mandir="${EPREFIX}"/usr/share/man \
		--infodir="${EPREFIX}"/usr/share/info \
		--datadir="${EPREFIX}"/usr/share \
		--sysconfdir="${EPREFIX}"/etc \
		--localstatedir="${EPREFIX}"/var/lib \
		--libdir="${EPREFIX}"/usr/"$(get_libdir)" \
		--enable-compat185 \
		--with-uniquename \
		$(use_enable rpc) \
		--host="${CHOST}" \
		${myconf} "${javaconf}" || die "configure failed"

	# This isn't safe for prefix (Darwin should be .jnilib), but I can't get the
	# build system to behave itself, it generates libtool too late.
	sed -i \
		-e 's/-shrext  $(SOFLAGS)/-shrext .so $(SOFLAGS)/g' \
		Makefile
	emake || die "make failed"
}

src_install() {
	einstall libdir="${ED}/usr/$(get_libdir)" strip="${ED}/bin/strip" || die

	db_src_install_usrbinslot

	db_src_install_headerslot

	db_src_install_doc

	db_src_install_usrlibcleanup

	dodir /usr/sbin
	# This file is not always built, and no longer exists as of db-4.8
	[[ -f "${ED}"/usr/bin/berkeley_db_svc ]] && \
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
