require 'parse'
require 'page'
require 'render'

RSpec.describe Render do
  it 'renders the page title' do
    page = { title: 'the-title' }
    rendering = Render.page(Render::TEMPLATE, page)
    expect(rendering).to match '<title>the-title</title>'
  end

  it 'renders the page images' do
    page = {
      images:
      [
        Parse::Image.new('thumb1', 'full1'),
        Parse::Image.new('thumb2', 'full2')
      ]
    }

    rendering = Render.page(Render::TEMPLATE, page)

    expect(rendering).to match '<a href="full1"><img src="thumb1"></a>'
    expect(rendering).to match '<a href="full2"><img src="thumb2"></a>'
  end

  it 'renders the page nav' do
    page = {
      navs:
      [
        Page::Nav.new('nav1', 'http://nav1'),
        Page::Nav.new('nav2', 'http://nav2')
      ]
    }

    rendering = Render.page(Render::TEMPLATE, page)

    expect(rendering).to match '<a href="http://nav1">nav1</a>'
    expect(rendering).to match '<a href="http://nav2">nav2</a>'
  end
end
