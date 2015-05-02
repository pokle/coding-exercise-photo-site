require "parse"

RSpec.describe "parser" do

  it "parses an empty set of works as an empty list" do
    expect(Parse::works("<somewhere><works/></somewhere>")).to eq([])
  end

  it "parses a single work into a list containing a single Parse::image" do
    expect(Parse::works(%q{
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
    })).to eq([Parse::Image.new('http://small', 'http://large', 'the-make', 'the-model')])
  end

  it "parses a multiple works into a list" do
    expect(Parse::works(%q{
      <works>
        <work>
          <urls>
            <url type='small'>http://small1</url>
            <url type='large'>http://large1</url>
          </urls>
          <exif>
            <make>the-make-1</make>
            <model>the-model-1</model>
          </exif>
        </work>
        <work>
          <urls>
            <url type='small'>http://small2</url>
            <url type='large'>http://large2</url>
          </urls>
          <exif>
            <make>the-make-2</make>
            <model>the-model-2</model>
          </exif>
        </work>
      </works>
    })).to eq([
      Parse::Image.new('http://small1', 'http://large1', 'the-make-1', 'the-model-1'),
      Parse::Image.new('http://small2', 'http://large2', 'the-make-2', 'the-model-2')
    ])
  end

end