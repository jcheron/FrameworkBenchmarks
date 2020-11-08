<?php
namespace controllers\utils;

trait DbTrait {

	private $counts = [];

	public function getCount($queries) {
		if (isset($this->counts[$queries])) {
			return $this->counts[$queries];
		}
		$count = 1;
		if ($queries > 1) {
			if (($count = $queries) > 500) {
				$count = 500;
			}
		}
		return $this->counts[$queries] = $count;
	}
}
