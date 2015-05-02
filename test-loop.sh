#!/usr/bin/env bash

LAST_SAID=''
say_when_changed() {
	local text=$1
	if [ "$LAST_SAID" != "$text" ]; then
		say "$text"
		LAST_SAID="$text"
	fi
}

run_tests() {
	bundle exec rspec && say_when_changed "fixed" || say_when_changed "broken"
	echo -n 'watching changes: '
}

run_tests
fswatch --exclude .git --one-per-batch . | while read change; do
	echo changed: $change
	run_tests
done