# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils cuda flag-o-matic toolchain-funcs

DESCRIPTION="Fast approximate nearest neighbor searches in high dimensional spaces"
HOMEPAGE="http://www.cs.ubc.ca/research/flann/"
SRC_URI="https://github.com/mariusmuja/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="cuda doc examples mpi openmp octave static-libs"

RDEPEND="
	cuda? ( >=dev-util/nvidia-cuda-toolkit-5.5 )
	mpi? (
		sci-libs/hdf5[mpi]
		dev-libs/boost:=[mpi]
	)
	!mpi? ( !sci-libs/hdf5[mpi] )
	octave? ( >=sci-mathematics/octave-3.6.4-r1 )"
DEPEND="${RDEPEND}
	app-arch/unzip
	doc? ( dev-tex/latex2html )"
# TODO:
# readd dependencies for test suite,
# requires multiple ruby dependencies

PATCHES=(
	"${FILESDIR}"/flann-1.9.1-cmake-3.11.patch
)

pkg_pretend() {
	[[ ${MERGE_TYPE} != binary ]] && use openmp && tc-check-openmp
}

pkg_setup() {
	[[ ${MERGE_TYPE} != binary ]] && use openmp && tc-check-openmp
}

src_prepare() {
	# bug #302621
	use mpi && export CXX=mpicxx
	# produce pure octave files
	# octave gentoo installation for .m files respected
	sed -i \
		-e 's/--mex//' \
		-e 's/\.mex/\.oct/' \
		-e '/FILES/s/${MEX_FILE}//' \
		-e 's:share/flann/octave:share/octave/site/m:' \
		-e "/CUSTOM_TARGET/a\INSTALL(FILES \${MEX_FILE} DESTINATION libexec/octave/site/oct/${CHOST})" \
		src/matlab/CMakeLists.txt || die
	use cuda && cuda_src_prepare

	cmake-utils_src_prepare
}

src_configure() {
	append-cxxflags -std=c++11

	# python bindings are split
	# off into dev-python/pyflann
	local mycmakeargs=(
		-DBUILD_C_BINDINGS=ON
		-DBUILD_PYTHON_BINDINGS=OFF
		-DPYTHON_EXECUTABLE=
		-DDOCDIR=share/doc/${PF}
		-DBUILD_CUDA_LIB=$(usex cuda)
		-DBUILD_EXAMPLES=$(usex examples)
		-DBUILD_DOC=$(usex doc)
		-DBUILD_TESTS=OFF
		-DBUILD_MATLAB_BINDINGS=$(usex octave)
		-DUSE_MPI=$(usex mpi)
		-DUSE_OPENMP=$(usex openmp)
	)
	use cuda && mycmakeargs+=(
		-DCUDA_NVCC_FLAGS="${NVCCFLAGS} --linker-options \"-arsch\""
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	if ! use static-libs; then
		find "${D}" -name 'lib*.a' -delete || die
	fi
}
