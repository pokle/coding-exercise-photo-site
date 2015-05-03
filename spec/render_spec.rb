require 'render'

RSpec.describe Render do

    it "renders a template based on the page model" do

        page = {
            title: 'the-title',
            images: [],
            navigations: []
        }

        rendering = Render::page(Render::TEMPLATE, page)

        expect(rendering).to match %q{<title>the-title</title>}

    end


end