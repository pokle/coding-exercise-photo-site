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

def generate_site(works_file, output_dir)
    FileUtils.mkdir_p output_dir
    images = Parse::works(IO::read(works_file))

    render_and_write_out(output_dir, Page::index(images))    
    Page::makes(images).each {|make_page| render_and_write_out(output_dir, make_page)}
    Page::models(images).each {|model_page| render_and_write_out(output_dir, model_page)}
end

if ARGV.length == 2
    generate_site *ARGV
else
    STDERR.puts "usage: WORKS-FILE OUTPUT-DIR"
    exit 1
end

