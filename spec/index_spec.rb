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

  it "contains a list of distinct make names" do

    works = {
      images: [
        Generate::Image.new("", "", "sony"),
        Generate::Image.new("", "", "sony"),
        Generate::Image.new("", "", "leica")
      ]
    }

    expect(Generate.index(works)[:makes]).to eq ["sony", "leica"]

  end

end