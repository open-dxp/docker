# OpenDXP | Docker Images

Images are based on the official `php:<version>-fpm-trixie` images (Debian 13).

## Tags

A tag names the PHP version, the variant and the version of the image, for example `opendxp/opendxp:php8.5-debug-v1`.
Without a variant, as in `php8.5-v1`, it is the variant `default`.

| Version    | Points to                                            |
|------------|------------------------------------------------------|
| `-v1`      | the newest 1.x release. Use it in a project.         |
| `-v1.1`    | the newest 1.1.x release                             |
| `-latest`  | the newest release of the newest major version       |
| `-v1-dev`  | the branch `1.x`, before its release                 |

The variants are `min`, `default`, `max`, `debug` and `supervisord`. The images of the newest release are rebuilt three
times a week with the updates of Debian and PHP.
