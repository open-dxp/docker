<?php

try {
    $tmpFile = __DIR__ . '/imagick-format-support-detection-' . uniqid('avif', true) . '.avif';
    $image = new \Imagick();
    $image->newImage(1, 1, new \ImagickPixel('red'));
    $image->writeImage('avif' . ':' . $tmpFile);
    unlink($tmpFile);

    exit(0);
} catch (\Exception $e) {
    exit(1);
}