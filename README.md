# coding-exercise-photo-site

Generates a static web site about your photos, camera makes and models

# Running

	bundle exec ruby generate.rb works.xml output-dir

That produces a static site based on works.xml into output-dir

# How?

The works.xml file contains information about a collection of photographic works.

    <works>
	  <work/>...
	</works>

generate.rb generates several HTML pages:

- index.html 
  - Thumbnails of the first 10 photos, and...
  - links to all camera makes
- One html file per camera make, each with:
   - Thumbnails of the first 10 photos of that make, and...
   - links to all that make's models
   - link back to the index page
- One html file per camera make-model combo, each with:
   - Thumbnails of all the photos of that make-model combination
   - link back to the make page
   - link back to the index page

# Tests

[![Circle CI](https://circleci.com/gh/pokle/coding-exercise-photo-site.svg?style=svg)](https://circleci.com/gh/pokle/coding-exercise-photo-site)

Tests are run at CircleCI. You can run them locally with:

	bundle install
	bundle rspec
