# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3

DESCRIPTION="MJPG-streamer takes JPGs from Linux-UVC compatible webcams"
HOMEPAGE="https://sourceforge.net/projects/mjpg-streamer"
EGIT_REPO_URI="https://github.com/jacksonliam/mjpg-streamer"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~arm"

INPUT_PLUGINS="input_testpicture input_control input_file input_uvc"
OUTPUT_PLUGINS="output_file output_udp output_http output_autofocus output_rtsp"
IUSE_PLUGINS="${INPUT_PLUGINS} ${OUTPUT_PLUGINS}"
IUSE="input_testpicture input_control +input_file input_uvc output_file
	output_udp +output_http output_autofocus output_rtsp
	www v4l"
REQUIRED_USE="|| ( ${INPUT_PLUGINS} )
	|| ( ${OUTPUT_PLUGINS} )
	v4l? ( input_uvc )"

RDEPEND="virtual/jpeg
	v4l? ( input_uvc? ( media-libs/libv4l ) )"
DEPEND="${RDEPEND}
	input_testpicture? ( media-gfx/imagemagick )"

src_prepare() {
    mv mjpg-streamer-experimental/* .
	rm -rf mjpg-streamer-experimental
	default
}

pkg_postinst() {
	elog "Remember to set an input and output plugin for mjpg-streamer."

	if use www ; then
		echo
		elog "An example webinterface has been installed into"
		elog "/usr/share/mjpg-streamer/www for your usage."
	fi
}
