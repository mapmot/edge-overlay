# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit git-r3 autotools

DESCRIPTION="MTD userspace tools"
HOMEPAGE="http://git.infradead.org/mtd-utils.git"
EGIT_REPO_URI="git://git.infradead.org/mtd-utils.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~arm"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}
