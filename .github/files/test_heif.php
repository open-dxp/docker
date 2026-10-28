<?php

declare(strict_types=1);

try {
    foreach (['avif', 'heic'] as $format) {
        $tmpFile = __DIR__ . '/imagick-format-support-detection-' . uniqid($format, true) . '.' . $format;
        $image = new \Imagick();
        $image->newImage(1, 1, new \ImagickPixel('red'));
        $image->writeImage($format . ':' . $tmpFile);

        $readBack = new \Imagick($tmpFile);
        unlink($tmpFile);

        if ($readBack->getImageWidth() !== 1) {
            exit(1);
        }
    }

    exit(0);
} catch (\Exception $e) {
    exit(1);
}
