Image = Struct.new :thumb, :full, :make

module Generate

  def Generate.index(works)
    {
      images: works[:images].take(10).collect(&:thumb),
      makes:  works[:images].collect(&:make).uniq
    }
  end

end

