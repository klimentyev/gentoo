# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{2_7,3_{4,5,6}} )
DISTUTILS_OPTIONAL=1

inherit check-reqs cmake-utils distutils-r1 python-r1 udev user systemd \
	readme.gentoo-r1 flag-o-matic

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ceph/ceph.git"
	SRC_URI=""
else
	SRC_URI="https://download.ceph.com/tarballs/${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

DESCRIPTION="Ceph distributed filesystem"
HOMEPAGE="https://ceph.com/"

LICENSE="LGPL-2.1 CC-BY-SA-1.0 GPL-2 BSD Boost-1.0 MIT"
SLOT="0"

CPU_FLAGS_X86=(sse{,2,3,4_1,4_2} ssse3)

IUSE="babeltrace cephfs fuse jemalloc ldap lttng +mgr nss +radosgw +ssl"
IUSE+=" static-libs systemd +tcmalloc test xfs zfs"
IUSE+=" $(printf "cpu_flags_x86_%s\n" ${CPU_FLAGS_X86[@]})"

# unbundling code commented out pending bugs 584056 and 584058
#>=dev-libs/jerasure-2.0.0-r1
#>=dev-libs/gf-complete-2.0.0
COMMON_DEPEND="
	app-arch/bzip2:=[static-libs?]
	app-arch/lz4:=[static-libs?]
	app-arch/snappy:=[static-libs?]
	app-arch/zstd:=[static-libs?]
	app-misc/jq:=[static-libs?]
	dev-libs/boost:=[threads,context,static-libs?,${PYTHON_USEDEP}]
	dev-libs/crypto++:=[static-libs?]
	dev-libs/leveldb:=[snappy,static-libs?]
	dev-libs/libaio:=[static-libs?]
	dev-libs/libxml2:=[static-libs?]
	sys-apps/keyutils:=[static-libs?]
	sys-apps/util-linux:=[static-libs?]
	sys-libs/zlib:=[static-libs?]
	babeltrace? ( dev-util/babeltrace )
	ldap? ( net-nds/openldap:=[static-libs?] )
	lttng? ( dev-util/lttng-ust:= )
	nss? ( dev-libs/nss:= )
	fuse? ( sys-fs/fuse:0=[static-libs?] )
	ssl? ( dev-libs/openssl:=[static-libs?] )
	xfs? ( sys-fs/xfsprogs:=[static-libs?] )
	zfs? ( sys-fs/zfs:=[static-libs?] )
	radosgw? (
		dev-libs/expat:=[static-libs?]
		dev-libs/openssl:=[static-libs?]
		net-misc/curl:=[static-libs?]
	)
	jemalloc? ( dev-libs/jemalloc:=[static-libs?] )
	!jemalloc? ( >=dev-util/google-perftools-2.4:=[static-libs?] )
	${PYTHON_DEPS}
	"
DEPEND="${COMMON_DEPEND}
	app-arch/cpio
	dev-lang/yasm
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/sphinx
	dev-util/gperf
	dev-util/valgrind
	sys-apps/which
	sys-devel/bc
	virtual/pkgconfig
	test? (
		dev-python/tox[${PYTHON_USEDEP}]
		dev-python/virtualenv[${PYTHON_USEDEP}]
		sys-apps/grep[pcre]
		sys-fs/btrfs-progs
	)"
RDEPEND="${COMMON_DEPEND}
	net-misc/socat
	sys-apps/gptfdisk
	sys-block/parted
	sys-fs/cryptsetup
	!<sys-apps/openrc-0.26.3
	dev-python/cherrypy[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/pecan[${PYTHON_USEDEP}]
	dev-python/prettytable[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/werkzeug[${PYTHON_USEDEP}]
	"
REQUIRED_USE="
	$(python_gen_useflags 'python2*')
	${PYTHON_REQUIRED_USE}
	?? ( ssl nss )
	?? ( jemalloc tcmalloc )
	"

# radosgw seems to be required to actually build
REQUIRED_USE+=" radosgw"

RESTRICT="test? ( userpriv )"

# distribution tarball does not include everything needed for tests
RESTRICT+=" test"

STRIP_MASK="/usr/lib*/rados-classes/*"

UNBUNDLE_LIBS=(
	src/erasure-code/jerasure/jerasure
	src/erasure-code/jerasure/gf-complete
)

PATCHES=(
	"${FILESDIR}/${PN}-12.2.0-use-provided-cpu-flag-values.patch"

	# pull in some bugfixes from upstream
	"${FILESDIR}/${PN}-12.2.0-fix_two_stray_get_health_callers.patch"
)

check-reqs_export_vars() {
	if use amd64; then
		CHECKREQS_DISK_BUILD="12G"
		CHECKREQS_DISK_USR="460M"
	else
		CHECKREQS_DISK_BUILD="1400M"
		CHECKREQS_DISK_USR="450M"
	fi

	export CHECKREQS_DISK_BUILD CHECKREQS_DISK_USR
}

user_setup() {
	enewgroup ceph ${CEPH_GID:--1}
	enewuser ceph "${CEPH_UID:--1}" -1 /var/lib/ceph ceph
}

pkg_pretend() {
	check-reqs_export_vars
	check-reqs_pkg_pretend
}

pkg_setup() {
	python_setup 'python2*'
	check-reqs_export_vars
	check-reqs_pkg_setup
	user_setup
}

src_prepare() {
	default

	# remove tests that need root access
	rm src/test/cli/ceph-authtool/cap*.t

	#rm -rf "${UNBUNDLE_LIBS[@]}"
}

ceph_src_configure() {
	local flag
	local mycmakeargs=(
		-DWITH_BABELTRACE=$(usex babeltrace)
		-DWITH_CEPHFS=$(usex cephfs)
		-DWITH_FUSE=$(usex fuse)
		-DWITH_LTTNG=$(usex lttng)
		-DWITH_MGR=$(usex mgr)
		-DWITH_NSS=$(usex nss)
		-DWITH_OPENLDAP=$(usex ldap)
		-DWITH_RADOSGW=$(usex radosgw)
		-DWITH_SSL=$(usex ssl)
		-DWITH_SYSTEMD=$(usex systemd)
		-DWITH_TESTS=$(usex test)
		-DWITH_XFS=$(usex xfs)
		-DWITH_ZFS=$(usex zfs)
		-DENABLE_SHARED=$(usex static-libs '' 'yes' 'no')
		-DALLOCATOR=$(usex tcmalloc 'tcmalloc' '' "$(usex jemalloc 'jemalloc' '' 'libc' '')" '')
		-DWITH_SYSTEM_BOOST=yes
		-DWITH_RDMA=no
	)
	if use amd64 || use x86; then
		for flag in ${CPU_FLAGS_X86[@]}; do
			mycmakeargs+=("$(usex cpu_flags_x86_${flag} "-DHAVE_INTEL_${flag^^}=1")")
		done
	fi

	rm -f "${BUILD_DIR:-${S}}/CMakeCache.txt"
	cmake-utils_src_configure
}

src_configure() {
	ceph_src_configure
}

python_compile() {
	local CMAKE_USE_DIR="${S}"

	ceph_src_configure
	pushd "${BUILD_DIR}/src/pybind" >/dev/null || die
	emake VERBOSE=1 all

	# python modules are only compiled with "make install" so we need to do this to
	# prevent doing a bunch of compilation in src_install
	DESTDIR="${T}" emake VERBOSE=1 install
	popd >/dev/null || die
}

src_compile() {
	cmake-utils_src_make all

	# we have to do this here to prevent from building everything multiple times
	BUILD_DIR="${CMAKE_BUILD_DIR}" python_copy_sources
	python_foreach_impl python_compile
}

src_test() {
	make check || die "make check failed"
}

python_install() {
	local CMAKE_USE_DIR="${S}"
	pushd "${BUILD_DIR}/src/pybind" >/dev/null || die
	DESTDIR="${D}" emake install
	popd >/dev/null || die
}

src_install() {
	cmake-utils_src_install
	python_foreach_impl python_install

	prune_libtool_files --all

	exeinto /usr/$(get_libdir)/ceph
	newexe "${CMAKE_BUILD_DIR}/bin/init-ceph" ceph_init.sh

	insinto /etc/logrotate.d/
	newins "${FILESDIR}"/ceph.logrotate ${PN}

	keepdir /var/lib/${PN}{,/tmp} /var/log/${PN}/stat

	fowners -R ceph:ceph /var/lib/ceph /var/log/ceph

	newinitd "${FILESDIR}/rbdmap.initd" rbdmap
	newinitd "${FILESDIR}/${PN}.initd-r5" ${PN}
	newconfd "${FILESDIR}/${PN}.confd-r3" ${PN}

	insinto /etc/sysctl.d
	newins "${FILESDIR}"/sysctld 90-${PN}.conf

	use tcmalloc && newenvd "${FILESDIR}"/envd-tcmalloc 99${PN}-tcmalloc

	systemd_install_serviced "${FILESDIR}/ceph-mds_at.service.conf" "ceph-mds@.service"
	systemd_install_serviced "${FILESDIR}/ceph-osd_at.service.conf" "ceph-osd@.service"

	udev_dorules udev/*.rules

	readme.gentoo_create_doc

	python_setup 'python2*'
	python_fix_shebang "${ED}"/usr/{,s}bin/

	# python_fix_shebang apparently is not idempotent
	sed -i -r  's:(/usr/lib/python-exec/python[0-9]\.[0-9]/python)[0-9]\.[0-9]:\1:' \
		"${ED}"/usr/{sbin/ceph-disk,bin/ceph-detect-init} || die "sed failed"
}

pkg_postinst() {
	readme.gentoo_print_elog
}
