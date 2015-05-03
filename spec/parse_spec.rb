require 'parse'

RSpec.describe Parse do
  it 'parses an empty set of works as an empty list' do
    expect(Parse.works('<somewhere><works/></somewhere>')).to eq([])
  end

  it 'parses a single work into a list containing a single Parse::Image' do
    expect(Parse.works("
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
    ")).to eq([
      Parse::Image.new('http://small', 'http://large', 'the-make', 'the-model')
    ])
  end

  it 'parses a multiple works into a list' do
    expect(Parse.works("
      <works>
        <work>
          <urls>
            <url type='small'>http://s1</url>
            <url type='large'>http://l1</url>
          </urls>
          <exif>
            <make>the-make-1</make>
            <model>the-model-1</model>
          </exif>
        </work>
        <work>
          <urls>
            <url type='small'>http://s2</url>
            <url type='large'>http://l2</url>
          </urls>
          <exif>
            <make>the-make-2</make>
            <model>the-model-2</model>
          </exif>
        </work>
      </works>
    ")).to eq([
      Parse::Image.new('http://s1', 'http://l1', 'the-make-1', 'the-model-1'),
      Parse::Image.new('http://s2', 'http://l2', 'the-make-2', 'the-model-2')
    ])
  end

  it 'parses missing exif information with blanks' do
    EMPTY_IMAGE = Parse::Image.new('', '', '', '')
    expect(Parse.works('<works><work/></works>')).to eq([EMPTY_IMAGE])
  end
end
