# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
ROS_REPO_URI="https://github.com/ros-controls/ros_control"
KEYWORDS="~amd64"
ROS_SUBDIR=${PN}
PYTHON_COMPAT=( python2_7 )

inherit ros-catkin

DESCRIPTION="The controller manager"
LICENSE="BSD"
SLOT="0"
IUSE=""

RDEPEND="
	dev-ros/controller_interface
	>=dev-ros/controller_manager_msgs-0.10.0[${CATKIN_MESSAGES_PYTHON_USEDEP},${CATKIN_MESSAGES_CXX_USEDEP}]
	>=dev-ros/hardware_interface-0.10.0
	dev-ros/realtime_tools
	dev-ros/pluginlib
	dev-ros/rospy[${PYTHON_USEDEP}]
	dev-ros/roslib[${PYTHON_USEDEP}]
	dev-ros/rosparam[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	test? ( dev-ros/rostest[${PYTHON_USEDEP}] )"
