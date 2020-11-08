<?php
namespace controllers\utils;

trait DbTrait {

	private $counts = [];

	public function getCount($queries) {
		return $this->counts[$queries] ??= \min(\max($queries, 1), 500);
	}
}
