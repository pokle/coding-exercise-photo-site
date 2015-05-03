require 'mustache'

#
# Minimalistic wrapper around mustache for our template
#
module Render
  TEMPLATE = IO.read(__dir__ + '/template.html')

  class << self
    def page(template, page)
      Mustache.render template, page
    end
  end
end
