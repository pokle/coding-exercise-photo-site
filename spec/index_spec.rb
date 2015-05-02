require "page"

RSpec.describe Page, ".index" do

  it "contains at most 10 images" do

    def number_of_images_on_index_page_with_x_images(count)
      images = (1..count).collect {|i| Image.new "t#{i}", "f#{i}", "make-#{i}" }
      Page.index(images)[:images].count
    end

    expect(number_of_images_on_index_page_with_x_images( 0)).to eq  0
    expect(number_of_images_on_index_page_with_x_images( 9)).to eq  9
    expect(number_of_images_on_index_page_with_x_images(10)).to eq 10
    expect(number_of_images_on_index_page_with_x_images(11)).to eq 10
  end

  it "transforms images into an intermediate view representation for index pages" do

    images = [
      sony1 = Image.new(nil, nil, "sony"),
      sony2 = Image.new(nil, nil, "sony"),
      leica1 = Image.new(nil, nil, "leica"),
    ]

    expect(Page.index(images)).to eq({
      path: "index.html",
      images: [sony1, sony2, leica1],
      navigations: [
        Navigation.new("sony", "sony.html"),
        Navigation.new("leica", "leica.html")
      ]
      })

  end

end

RSpec.describe Page, ".makes" do

  it "contains at most 10 images" do

    def number_of_images_on_a_makes_page_with_x_works(num)
      images = (1..num).collect {|i| Image.new nil, nil, "sony", "x1" }
      Page.makes(images)[0][:images].size
    end

    expect(number_of_images_on_a_makes_page_with_x_works( 9)).to eq  9
    expect(number_of_images_on_a_makes_page_with_x_works(10)).to eq 10
    expect(number_of_images_on_a_makes_page_with_x_works(11)).to eq 10
  end


  it "transforms images into an intermediate representation for make pages" do

    images = [
      sony1 = Image.new(nil, nil, "sony", "dx1"),
      sony2 = Image.new(nil, nil, "sony", "dx1"),
      leica1 = Image.new(nil, nil, "leica", "m1"),
      leica2 = Image.new(nil, nil, "leica", "m2"),
    ]  

    expect(Page.makes(images)).to eq(
      [
        {
          path: "sony.html",
          images: [sony1, sony2],
          navigations: [Navigation.new("dx1", "sony-dx1.html")]
          },

          {
            path: "leica.html",
            images: [leica1, leica2],
            navigations: [
              Navigation.new("m1", "leica-m1.html"),
              Navigation.new("m2", "leica-m2.html")
            ]
          }
        ]
        )

  end
end