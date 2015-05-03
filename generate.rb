#!/usr/bin/env bundle exec ruby

$LOAD_PATH << __dir__ + '/lib'
require 'parse'
require 'page'
require 'render'

def gen_page(output_dir, page)
  rendered = Render.page(Render::TEMPLATE, page)
  out_file = File.join(output_dir, page[:path])
  IO.write(out_file, rendered)
  puts "Generated #{out_file}"
end

def gen_site(works_file, output_dir)
  FileUtils.mkdir_p output_dir
  images = Parse.works(IO.read(works_file))

  gen_page(output_dir, Page.index(images))
  Page.makes(images).each  { |make_page| gen_page(output_dir, make_page) }
  Page.models(images).each { |model_page| gen_page(output_dir, model_page) }
end

if ARGV.length == 2
  gen_site(*ARGV)
else
  STDERR.puts 'usage: WORKS-FILE OUTPUT-DIR'
  exit 1
end
