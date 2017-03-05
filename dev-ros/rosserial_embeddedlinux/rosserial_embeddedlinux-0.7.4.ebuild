# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
ROS_REPO_URI="https://github.com/ros-drivers/rosserial"
KEYWORDS="~amd64 ~arm"
PYTHON_COMPAT=( python2_7 )
ROS_SUBDIR=${PN}

inherit ros-catkin

DESCRIPTION="Libraries and examples for ROSserial usage on Embedded Linux Enviroments"
LICENSE="BSD"
SLOT="0"
IUSE=""

RDEPEND="
	dev-ros/std_msgs[${CATKIN_MESSAGES_PYTHON_USEDEP}]
	dev-ros/geometry_msgs[${CATKIN_MESSAGES_PYTHON_USEDEP}]
	dev-ros/sensor_msgs[${CATKIN_MESSAGES_PYTHON_USEDEP}]
	dev-ros/nav_msgs[${CATKIN_MESSAGES_PYTHON_USEDEP}]
	dev-ros/rosserial_client[${PYTHON_USEDEP}]
	dev-ros/rospy[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
