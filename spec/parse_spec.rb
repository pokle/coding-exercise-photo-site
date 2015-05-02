require "parse"

RSpec.describe "parser" do

  it "parses an empty set of works as an empty list" do
    expect(parse_works("<somewhere><works/></somewhere>")).to eq([])
  end

  it "parses a single work into an image" do
    expect(parse_works("
      <works>
        <work>
          <urls>
            <url type='small'>http://small</url>
            <url type='large'>http://large</url>
          </urls>
          <exif>
            <make>the-make</make>
            <model>the-model</model>
          </exif>
        </work>
      </works>
    ")).to eq([Image.new('http://small', 'http://large', 'the-make', 'the-model')])
  end

end