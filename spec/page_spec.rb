require 'page'

RSpec.describe Page, '.index' do
  it 'contains at most 10 images' do
    def number_of_images_on_index_page_with_x_images(count)
      images = (1..count).map do |i|
        Parse::Image.new "t#{i}", "f#{i}", "make-#{i}"
      end
      Page.index(images)[:images].count
    end

    expect(number_of_images_on_index_page_with_x_images(0)).to eq 0
    expect(number_of_images_on_index_page_with_x_images(9)).to eq 9
    expect(number_of_images_on_index_page_with_x_images(10)).to eq 10
    expect(number_of_images_on_index_page_with_x_images(11)).to eq 10
  end

  it 'generates `index` page objects from images' do
    images = [
      sony1 = Parse::Image.new(nil, nil, 'sony'),
      sony2 = Parse::Image.new(nil, nil, 'sony'),
      leica1 = Parse::Image.new(nil, nil, 'leica')
    ]

    expect(Page.index(images)).to eq(
      title:       'index',
      path:        'index.html',
      images:      [sony1, sony2, leica1],
      navs: [
        Page::Nav.new('sony', 'sony.html'),
        Page::Nav.new('leica', 'leica.html')
      ]
    )
  end
end

RSpec.describe Page, '.makes' do
  it 'contains at most 10 images' do
    def number_of_images_on_a_makes_page_with_x_works(num)
      images = (1..num).map { Parse::Image.new nil, nil, 'sony', 'x1' }
      Page.makes(images)[0][:images].size
    end

    expect(number_of_images_on_a_makes_page_with_x_works(9)).to eq 9
    expect(number_of_images_on_a_makes_page_with_x_works(10)).to eq 10
    expect(number_of_images_on_a_makes_page_with_x_works(11)).to eq 10
  end

  it 'generates `make` page objects from images' do
    images = [
      sony1 = Parse::Image.new(nil, nil, 'sony', 'dx1'),
      sony2 = Parse::Image.new(nil, nil, 'sony', 'dx1'),
      leica1 = Parse::Image.new(nil, nil, 'leica', 'm1'),
      leica2 = Parse::Image.new(nil, nil, 'leica', 'm2')
    ]

    expect(Page.makes(images)).to eq(
      [
        {
          title:       'sony',
          path:        'sony.html',
          images:      [sony1, sony2],
          navs: [Page::INDEX_NAV, Page::Nav.new('dx1', 'sony-dx1.html')]
        },
        {
          title:       'leica',
          path:        'leica.html',
          images:      [leica1, leica2],
          navs: [
            Page::INDEX_NAV,
            Page::Nav.new('m1', 'leica-m1.html'),
            Page::Nav.new('m2', 'leica-m2.html')
          ]
        }
      ])
  end
end

RSpec.describe Page, '.models' do
  it 'generates model page for each model' do
    images = [
      sony1 = Parse::Image.new('s1', nil, 'sony', 'dx1'),
      sony2 = Parse::Image.new('s2', nil, 'sony', 'dx1'),
      leica1 = Parse::Image.new('l1', nil, 'leica', 'm1'),
      leica2 = Parse::Image.new('l2', nil, 'leica', 'm2')
    ]

    expect(Page.models(images)).to eq([
      {
        title:  'sony dx1',
        path:   'sony-dx1.html',
        images: [sony1, sony2],
        navs:   [Page::INDEX_NAV, Page::Nav.new('sony', 'sony.html')]
      },

      {
        title: 'leica m1',
        path:   'leica-m1.html',
        images: [leica1],
        navs:   [Page::INDEX_NAV, Page::Nav.new('leica', 'leica.html')]
      },

      {
        title:  'leica m2',
        path:   'leica-m2.html',
        images: [leica2],
        navs:   [Page::INDEX_NAV, Page::Nav.new('leica', 'leica.html')]
      }

    ])
  end
end
