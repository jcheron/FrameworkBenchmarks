<?php
namespace controllers\utils;

trait DbTrait {

	private $counts = [];

	private function _getCount($queries) {
		$count = 1;
		if ($queries > 1) {
			if (($count = $queries) > 500) {
				$count = 500;
			}
		}
		return $this->counts[$queries] = $count;
	}

	public function getCount($queries) {
		return $this->counts[$queries] ?? $this->_getCount($queries);
	}
}
