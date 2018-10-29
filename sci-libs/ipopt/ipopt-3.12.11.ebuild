# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

FORTRAN_NEEDED="mumps"

inherit fortran-2 toolchain-funcs

MY_PN=${PN^}
MY_P=${MY_PN}-${PV}

DESCRIPTION="Interior-Point Optimizer for large-scale nonlinear optimization"
HOMEPAGE="https://projects.coin-or.org/Ipopt/"
SRC_URI="http://www.coin-or.org/download/source/${MY_PN}/${MY_P}.tgz"

LICENSE="EPL-1.0 hsl? ( HSL )"
SLOT="0/1"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples hsl lapack mpi mumps test"

RDEPEND="
	virtual/blas
	hsl? ( sci-libs/coinhsl:0= )
	lapack? ( virtual/lapack )
	mumps? ( sci-libs/mumps:0=[mpi=] )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen[dot] )
	test? ( sci-libs/coinor-sample sci-libs/mumps )"

S="${WORKDIR}/${MY_PN}-${PV}/${MY_PN}"

src_prepare() {
	if use mpi ; then
		export CXX=mpicxx FC=mpif77 F77=mpif77 CC=mpicc
	fi
	default
}

src_configure() {
	# needed for the --with-coin-instdir
	dodir /usr
	local myeconfargs
	if use lapack; then
		myeconfargs+=( --with-lapack="$($(tc-getPKG_CONFIG) --libs lapack)" )
	else
		myeconfargs+=( --without-lapack )
	fi
	if use mumps; then
		local mumps_include="${EPREFIX}"/usr/include
		! use mpi && mumps_include="${EPREFIX}/usr/include/mpiseq/"
		myeconfargs+=(
			--with-mumps-incdir="$mumps_include"
			--with-mumps-lib="-lmumps_common -ldmumps -lzmumps -lsmumps -lcmumps" )
	else
		myeconfargs+=( --without-mumps )
	fi
	if use hsl; then
		myeconfargs+=(
			--with-hsl-incdir="${EPREFIX}"/usr/include
			--with-hsl-lib="$($(tc-getPKG_CONFIG) --libs coinhsl)" )
	else
		myeconfargs+=( --without-hsl )
	fi

	econf \
		--enable-dependency-linking \
		--with-coin-instdir="${ED%/}"/usr \
		$(use_with doc dot) \
		"${myeconfargs[@]}"
}

src_compile() {
	emake all $(use doc && echo doxydoc)
}

src_test() {
	emake test
}

src_install() {
	default

	use doc && HTML_DOCS=("doxydocs/html/.")
	use examples && DOCS+=( examples )
	einstalldocs

	rm -rf "${ED%/}"/usr/share/coin || die
}
