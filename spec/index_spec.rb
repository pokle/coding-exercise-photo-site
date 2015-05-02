require "generate"

RSpec.describe Generate, ".index" do

  it "contains at most 10 images" do

    def dummy_works(size)
     {
      images: (1..size).collect {|i| Generate::Image.new "t#{i}", "f#{i}", "make-#{i}" },
     }
    end

    expect(Generate.index(dummy_works(0))[:images].count).to eq 0
    expect(Generate.index(dummy_works(9))[:images].count).to eq 9
    expect(Generate.index(dummy_works(10))[:images].count).to eq 10
    expect(Generate.index(dummy_works(11))[:images].count).to eq 10
  end


  it "transforms works into an intermediate view representation for index pages" do

    works = {
      images: [
        sony1 = Generate::Image.new(nil, nil, "sony"),
        sony2 = Generate::Image.new(nil, nil, "sony"),
        leica1 = Generate::Image.new(nil, nil, "leica"),
      ]
    }

    expect(Generate.index(works)).to eq({
      path: "index.html",
      images: [sony1, sony2, leica1],
      navigations: [
        Generate::Navigation.new("sony", "sony.html"),
        Generate::Navigation.new("leica", "leica.html")
      ]
    })

  end

end

RSpec.describe Generate, ".makes" do
  
  it "transforms works into an intermediate representation for make pages" do
    
    works = {
      images: [
        sony1 = Generate::Image.new(nil, nil, "sony"),
        sony2 = Generate::Image.new(nil, nil, "sony"),
        leica1 = Generate::Image.new(nil, nil, "leica"),
      ]
    }

    expect(Generate.makes(works)).to eq(
      [
        {
          path: "sony.html",
          images: [sony1, sony2],
          navigations: []#[Generate::Navigation.new("dx1", "sony-dx1.html")]
        },
        
        {
          path: "leica.html",
          images: [leica1],
          navigations: []#[Generate::Navigation.new("m1", "leica-m1.html")]
        }

      ]
    )

  end
end