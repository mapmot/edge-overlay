# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=Yes

inherit git-r3 distutils-r1 user

DESCRIPTION="OctoPrint is a Python based web-app providing a 3D printing server"
HOMEPAGE="http://http://octoprint.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0" # Not required for webapps

KEYWORDS="~arm ~x86 ~amd64"

EGIT_REPO_URI="git://github.com/foosel/OctoPrint.git"

RDEPEND="
        dev-python/awesome-slugify[${PYTHON_USEDEP}]
	dev-python/pylru[${PYTHON_USEDEP}]
	=dev-python/sarge-0.1.4[${PYTHON_USEDEP}]
	=dev-python/pyyaml-3.12[${PYTHON_USEDEP}]
	=dev-python/sockjs-tornado-1.0.3[${PYTHON_USEDEP}]

        =www-servers/tornado-4.4.3[${PYTHON_USEDEP}]
	=dev-python/werkzeug-0.11.15[${PYTHON_USEDEP}]

	dev-python/setuptools[${PYTHON_USEDEP}]

        >=dev-python/flask-0.12.2[${PYTHON_USEDEP}]
	>=dev-python/flask-login-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/flask-principal-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/flask-babel-0.11.2[${PYTHON_USEDEP}]
	=dev-python/Flask-Assets-0.12[${PYTHON_USEDEP}]

	>=dev-python/markdown-2.6.4[${PYTHON_USEDEP}]
	>=dev-python/pyserial-2.7[${PYTHON_USEDEP}]
	=dev-python/requests-2.13.0[${PYTHON_USEDEP}]
	>=dev-python/netifaces-0.10[${PYTHON_USEDEP}]
	>=dev-python/netaddr-0.7.17[${PYTHON_USEDEP}]
	>=dev-python/watchdog-0.8.3[${PYTHON_USEDEP}]

	>=dev-python/rsa-3.2[${PYTHON_USEDEP}]
	>=dev-python/pkginfo-1.2.1[${PYTHON_USEDEP}]
	>=dev-python/semantic_version-2.4.2[${PYTHON_USEDEP}]
	=dev-python/psutil-5.1.3[${PYTHON_USEDEP}]
        >=dev-python/feedparser-5.2.1[${PYTHON_USEDEP}]
	"

#	>=dev-python/werkzueg-0.8.3[${PYTHON_USEDEP}]
#       =dev-python/flask[${PYTHON_USEDEP}]

pkg_setup() {
	python-single-r1_pkg_setup
}

src_install() {
	distutils-r1_src_install
}

python_install() {
	keepdir /var/lib/octoprint
	distutils-r1_python_install
}

