<?php
/* Autoloader for dev-php/symfony-debug and its dependencies */

if (!class_exists('Fedora\\Autoloader\\Autoload', false)) {
    require_once '/usr/share/php/Fedora/Autoloader/autoload.php';
}

\Fedora\Autoloader\Autoload::addPsr4('Symfony\\Component\\Debug\\', __DIR__);

$vendorDir = '/usr/share/php';

// Dependencies
\Fedora\Autoloader\Dependencies::required(array(
	$vendorDir . '/Psr/Log/autoload.php',
));
