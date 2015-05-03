# coding-exercise-photo-site

Generates a static web site about your photos, camera makes and models

## Running it

Drive a sample site here: [http://pokle.github.io/coding-exercise-photo-site/](http://pokle.github.io/coding-exercise-photo-site/)

Or generate it yourself:

    bundle install --path vendor/bundle
	./generate.rb works.xml output-dir

## Design choices

I hadn't written any Ruby for about a couple of years, and it has moved out of my L1 cache. I've been working a lot in Clojure recently, and you'll have to forgive me for trying to achive a functional style in what I would now consider a classical Object Oriented language with mutability running rife. 

So here are some of the choices I made:

- Write pure functions where possible
  - Don't hold on to state in Objects
  - Take all your inputs as a parameter
  - Don't modify anything you're sent - it isn't yours  
  - Return your outputs
- This is a classic data transformation excercise with multiple stages feeding intermediate results to the next
  - Don't let downstream concerns flow upstream
  - Where possibly, use maps and lists - universal data types that can be consumed and transformed using universal functions that work on data (collect, find_all, group, uniq, ...)


# How does it work?

The data flows from left to right in the following sequence:

    works.xml *1 ==>> [Parser *2]  ==>> Page model *3 ==>> [Renderer *4] ==>> html *5


1. The works.xml file contains information about a collection of photographic works.


	    <works>
	       <work>
	         <urls>
	           <url type='small'>http://small-image.jpg</url>
	           <url type='large'>http://large-image.jpg</url>
	         </urls>
	         <exif>
	           <make>Camera Make</make>
	           <model>Camera Model</model>
	         </exif>
	       </work>
	       …
	     </works>

2. lib/parse.rb extracts just enough from that XML file as a list of images
3. lib/page.rb transforms the images into a representation of pages grouped by makes and models.
4. The renderer renders HTML documents by tying the page model with a mustache template (lib/template.html)
5. Finally, generate.rb writes out the HTML to files

## Spec
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
