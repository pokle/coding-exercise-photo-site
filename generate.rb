

module Generate

  Image = Struct.new :thumb, :full, :make, :model
  Navigation = Struct.new :title, :path

  def Generate.distinct_makes(images) 
    images.collect(&:make).uniq
  end

  def Generate.index(images)
    {
      path: "index.html",
      images: images.take(10),
      navigations:  distinct_makes(images)
                    .collect{|make| Navigation.new(make, "#{make}.html")}
    }
  end

  def Generate.makes(images)
    distinct_makes(images)
      .collect do |make| 
        {
          path:   "#{make}.html",
          images: images.find_all {|image| make == image.make },
          navigations: []
        }
      end
  end

end

