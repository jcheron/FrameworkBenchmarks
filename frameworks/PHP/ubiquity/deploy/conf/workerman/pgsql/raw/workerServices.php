<?php
\Ubiquity\cache\CacheManager::startProd($config);

\Ubiquity\cache\CacheManager::warmUpControllers([
	\controllers\DbRaw::class,
	\controllers\FortunesRaw::class
]);

$workerServer->onWorkerStart = function () use ($config) {
	$db = \Ubiquity\db\Database::start('pgsql', $config);
	\controllers\DbRaw::warmup($db);
	\controllers\FortunesRaw::warmup($db);
};