# coding-exercise-photo-site

Generates a static web site about your photos, camera makes and models

# Running

	bundle exec ruby generate.rb works.xml output-dir

That produces a static site based on works.xml into output-dir

# Tests

[![Circle CI](https://circleci.com/gh/pokle/coding-exercise-photo-site.svg?style=svg)](https://circleci.com/gh/pokle/coding-exercise-photo-site)

Tests are run at CircleCI. You can run them locally with:

	bundle install
	bundle rspec
