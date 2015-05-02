class Image

  attr_accessor :thumb, :full, :make

  def initialize thumb, full, make
    @thumb = thumb
    @full = full
    @make = make
  end

end

module Generate

  def Generate.index(works)
    {
      images: works[:images].take(10).collect(&:thumb),
      makes:  works[:images].collect(&:make).uniq
    }
  end

end

