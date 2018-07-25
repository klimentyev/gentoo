# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
ROS_REPO_URI="https://github.com/ros-simulation/gazebo_ros_pkgs"
KEYWORDS="~amd64"
ROS_SUBDIR=${PN}

inherit ros-catkin eutils

DESCRIPTION="ROS control plugins for gazebo"
LICENSE="BSD"
SLOT="0"
IUSE=""

RDEPEND="
	dev-ros/roscpp
	dev-ros/gazebo_dev
	dev-ros/gazebo_ros
	dev-ros/control_toolbox
	dev-ros/controller_manager
	dev-ros/hardware_interface
	dev-ros/transmission_interface
	dev-ros/pluginlib
		dev-libs/tinyxml2:=
	>=dev-ros/joint_limits_interface-0.11.0
	>=dev-ros/urdf-1.12.3-r1
	dev-libs/urdfdom:=
	sci-electronics/gazebo:=
	dev-libs/boost:=[threads]
	dev-libs/console_bridge:=
"
DEPEND="${RDEPEND}"
SRC_URI="${SRC_URI}
	mirror://gentoo/gazebo-ros-2.7.3-patches-1.tar.bz2"

src_prepare() {
	pushd "${WORKDIR}/gazebo_ros_pkgs-${PV}" || die
	EPATCH_FORCE=yes EPATCH_SUFFIX="patch" epatch "${WORKDIR}/patches"
	popd || die
	ros-catkin_src_prepare
}
