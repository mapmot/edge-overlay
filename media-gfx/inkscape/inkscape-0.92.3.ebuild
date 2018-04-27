# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_6 )
PYTHON_REQ_USE="xml"

inherit autotools eutils flag-o-matic gnome2-utils fdo-mime toolchain-funcs python-single-r1

MY_P=${P/_/}

DESCRIPTION="A SVG based generic vector-drawing program"
HOMEPAGE="https://inkscape.org/"
SRC_URI="https://inkscape.global.ssl.fastly.net/media/resources/file/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86"
IUSE="cdr dia dbus exif gnome imagemagick openmp postscript inkjar jpeg latex"
IUSE+=" lcms nls spell static-libs visio wpg"

DEPEND="
	>=dev-cpp/cairomm-1.9.8
	>=dev-cpp/glibmm-2.48
	>=dev-libs/boehm-gc-6.4
	sci-libs/gsl:=
	>=dev-cpp/gtkmm-2.18.0:2.4
"

PATCHES=(
	"${FILESDIR}/${PN}-0.92.1-automagic.patch"
	"${FILESDIR}/${PN}-0.91_pre3-cppflags.patch"
	"${FILESDIR}/${PN}-0.92.1-desktop.patch"
	"${FILESDIR}/${PN}-0.91_pre3-exif.patch"
	"${FILESDIR}/${PN}-0.91_pre3-sk-man.patch"
	"${FILESDIR}/${PN}-0.48.4-epython.patch"
)

S=${WORKDIR}/${MY_P}

RESTRICT="test"

pkg_pretend() {
	if use openmp; then
		tc-has-openmp || die "Please switch to an openmp compatible compiler"
	fi
}

src_prepare() {
	default

	sed -i "s#@EPYTHON@#${EPYTHON}#" \
		src/extension/implementation/script.cpp || die

	eautoreconf

	# bug 421111
	python_fix_shebang share/extensions
}

src_configure() {
	# aliasing unsafe wrt #310393
	append-flags -fno-strict-aliasing

	econf \
		$(use_enable static-libs static) \
		$(use_enable nls) \
		$(use_enable openmp) \
		$(use_enable exif) \
		$(use_enable jpeg) \
		$(use_enable lcms) \
		--enable-poppler-cairo \
		$(use_enable wpg) \
		$(use_enable visio) \
		$(use_enable cdr) \
		$(use_enable dbus dbusapi) \
		$(use_enable imagemagick magick) \
		$(use_with gnome gnome-vfs) \
		$(use_with inkjar) \
		$(use_with spell gtkspell) \
		$(use_with spell aspell)
}

src_compile() {
	emake AR="$(tc-getAR)"
}

src_install() {
	default

	prune_libtool_files
	python_optimize "${ED}"/usr/share/${PN}/extensions
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	fdo-mime_desktop_database_update
}
