# Changelog

## v1.1.1
- [ENHANCEMENT] Every release is published as `-v1`, `-v1.<minor>` and `-latest`, for example `php8.5-debug-v1`. `-latest` no longer follows the `1.x` branch, which is published as `-v1-dev` only. The images of the newest release are rebuilt three times a week with the updates of Debian and PHP. A rebuild is published only without a fixable critical or high vulnerability.

## v1.1.0
- [SECURITY] The images are based on Debian 13 (trixie) instead of Debian 12 (bookworm), whose open CVEs mostly get no fix anymore.
  - The `php8.x-*` tags stay the same.
  - Downstream images that install bookworm package names (e.g. `libicu72`, `libssl3`) must switch to the trixie names (e.g. `libicu76`, `libssl3t64`).
- [CHORE] The `max` variant no longer contains `libc-client-dev` and `libkrb5-dev`, because Debian 13 dropped the unmaintained UW IMAP library. `ext-imap` was never part of the images. Downstream images that build it themselves can install `libc-client2007e-dev` from [packages.sury.org](https://packages.sury.org/php/) plus `libkrb5-dev`, then use `docker-php-ext-install imap` (PHP 8.3) or `pecl install imap` (PHP 8.4+).
- [CHORE] The test workflow fails on PHP extensions that cannot load, the AVIF check fails on errors, and Trivy also scans the `max` variant.
