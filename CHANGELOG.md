# Changelog

## v1.1.1
- [SECURITY] Packages are installed without their apt "Recommends", which removes Java, systemd, GStreamer, the MariaDB/Firebird/PostgreSQL client libraries and other packages nothing in the images uses. What OpenDXP needs is installed explicitly: the AVIF/HEIC encoder plugins, the ImageMagick extra coders (SVG), fonts, `openssh-client` and the optional exiftool Perl modules.
- [SECURITY] The `max` variant installs the headless LibreOffice packages (`libreoffice-{writer,calc,impress,draw}-nogui`) instead of the full `libreoffice`. Document conversion with `soffice --headless` works as before; the GUI, Python/Java macros and LibreOffice Base are no longer included.
- [SECURITY] `curl`, `libcurl` and their QUIC/HTTP3 libraries (`ngtcp2`, `nghttp3`) come from `trixie-backports`, because the open curl CVEs of Debian 13 are only fixed there. Their updates come from backports uploads instead of Debian security updates. The backports source and its apt pin stay in the images, so downstream images get these packages from backports as well. Scanners like Trivy still report these CVEs, because they only check the status of Debian 13 itself.
- [SECURITY] ImageMagick's EXR coder is disabled by policy, because OpenEXR in Debian 13 has unfixed critical CVEs (CVE-2026-42216, CVE-2026-42217) that a crafted `.exr` upload reaches through thumbnail generation. Uploaded `.exr` assets no longer get thumbnails.
- [SECURITY] Build-only headers are removed at the end of each build stage: every `*-dev` package, `libc6-dev` and `linux-libc-dev`. The runtime libraries PHP and its extensions link against stay installed.
  - BC: Downstream images that compile PHP extensions must install the build tools and `-dev` packages they need, e.g. `apt-get install build-essential libpng-dev`.
  - The `debug` variant keeps the build toolchain (`build-essential`, `autoconf`, `pkg-config`, ...), so extensions without external libraries can be compiled ad hoc, e.g. `pecl install pcov`.

## v1.1.0
- [SECURITY] The images are based on Debian 13 (trixie) instead of Debian 12 (bookworm), whose open CVEs mostly get no fix anymore.
  - The `php8.x-*` tags stay the same.
  - Downstream images that install bookworm package names (e.g. `libicu72`, `libssl3`) must switch to the trixie names (e.g. `libicu76`, `libssl3t64`).
- [CHORE] The `max` variant no longer contains `libc-client-dev` and `libkrb5-dev`, because Debian 13 dropped the unmaintained UW IMAP library. `ext-imap` was never part of the images. Downstream images that build it themselves can install `libc-client2007e-dev` from [packages.sury.org](https://packages.sury.org/php/) plus `libkrb5-dev`, then use `docker-php-ext-install imap` (PHP 8.3) or `pecl install imap` (PHP 8.4+).
- [CHORE] The test workflow fails on PHP extensions that cannot load, the AVIF check fails on errors, and Trivy also scans the `max` variant.
