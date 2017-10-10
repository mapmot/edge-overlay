# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/avrdude/avrdude-5.11.1.ebuild,v 1.9 2012/05/30 07:29:42 jdhore Exp $

EAPI="4"

inherit eutils autotools git-r3

if [[ ${PV} == *9999 ]] ; then
	EGIT_REPO_URI="git://github.com/kcuzner/avrdude.git"
fi

DESCRIPTION="AVR Downloader/UploaDEr"
HOMEPAGE="http://savannah.nongnu.org/projects/avrdude"

if [[ ${PV} == *9999 ]] ; then
	SRC_URI=""
else
	SRC_URI="mirror://nongnu/${PN}/${P}.tar.gz
		doc? (
			mirror://nongnu/${PN}/${PN}-doc-${PV}.tar.gz
			mirror://nongnu/${PN}/${PN}-doc-${PV}.pdf
		)"
fi

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~arm"
IUSE="doc ftdi ncurses readline linuxgpio"

RDEPEND="virtual/libusb:1
	ftdi? ( dev-embedded/libftdi )
	ncurses? ( sys-libs/ncurses )
	readline? ( sys-libs/readline )"
DEPEND="${RDEPEND}"

DOCS="AUTHORS ChangeLog* NEWS README"

src_prepare() {
    mv avrdude/* .
	rm -rf avrdude
	epatch "${FILESDIR}"/More_pins_on_embedded.patch
	epatch "${FILESDIR}"/Fix_GPIO0_export.patch
	# let the build system re-generate these, bug #120194
	rm -f lexer.c config_gram.c config_gram.h
	[[ ${PV} == *9999 ]] && eautoreconf
}

src_configure() {
	export ac_cv_lib_ftdi_ftdi_usb_get_strings=$(usex ftdi)
	export ac_cv_lib_ncurses_tputs=$(usex ncurses)
	export ac_cv_lib_readline_readline=$(usex readline)
	econf $(use_enable linuxgpio)
}

src_compile() {
	# The automake target for these files does not use tempfiles or create
	# these atomically, confusing a parallel build. So we force them first.
	emake lexer.c config_gram.c config_gram.h
	emake
}

src_install() {
	default

	if use doc ; then
		newdoc "${DISTDIR}/${PN}-doc-${PV}.pdf" avrdude.pdf
		dohtml -r "${WORKDIR}/avrdude-html/"
	fi
}
