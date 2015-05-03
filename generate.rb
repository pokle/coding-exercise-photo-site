#!/usr/bin/env bundle exec ruby

$: << __dir__ + '/lib'
require 'parse'
require 'page'
require 'render'


def render_and_write_out(output_dir, page)
    rendered = Render::page(Render::TEMPLATE, page)
    out_file = File.join(output_dir, page[:path])
    IO::write(out_file, rendered) 
    puts "Generated #{out_file}"
end


if ARGV.length != 2
    STDERR.puts "usage: WORKS-FILE OUTPUT-DIR"
    exit 1
end

(works_file, output_dir) = ARGV
FileUtils.mkdir_p output_dir



    
images = Parse::works(IO::read(works_file))
render_and_write_out(output_dir, Page::index(images))