# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

# Seems we don't need to depend on jmf-bin, the classes ant imports are in J2SE
# API since version 1.3.
ANT_TASK_DEPNAME=""

inherit ant-tasks

DESCRIPTION="Apache Ant's optional tasks for the Java Media Framework (JMF)"

KEYWORDS="amd64 ppc64 x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
