# coding-exercise-photo-site

Generates a static web site about your photos, camera makes and models

## Running it

Drive a sample site here: [http://pokle.github.io/coding-exercise-photo-site/](http://pokle.github.io/coding-exercise-photo-site/)

Or generate it yourself:

    bundle install --path vendor/bundle
	./generate.rb works.xml output-dir

## Design choices

I hadn't written any Ruby for a couple of years, and it has moved out of my L1 cache. I've been working a lot in Clojure recently, and you'll have to forgive me for trying to achive a functional style in what I would now consider a classical Object Oriented language with mutability running rife. 

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

	                       +-------------+                                     
	                       | generate.rb |                                     
	                       +-------------+                                     
	                           controls                                   
	  work .xml                  the                             HTML     
	      +                    data flow                                  
	      |                                                        ^      
	      |                                                        |      
	      |                                                        |      
	+-----v--------+          +------------+               +-------+-----+
	|              | [Image…] |lib/page.rb | {images: […], |             |
	| lib/parse.rb |          |            |  navs: […]…}  |lib/render.rb|
	|              |          |makes a page|               |             |
	|              +---------->    model   +--------------->             |
	+--------------+          +------------+               +-------------+
	

## Spec
works.xml has information about images:

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

Tests are run at CircleCI.com. You can also run them locally with:

	bundle install
	bundle exec rake

----
[My other coding exercises](https://github.com/search?q=user%3Apokle+coding-exercise)
