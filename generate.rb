

module Generate

  Image = Struct.new :thumb, :full, :make, :model
  Navigation = Struct.new :title, :path

  def Generate.distinct_makes(images) 
    images.collect(&:make).uniq
  end

  def Generate.navigate_to_make(make)
    Navigation.new(make, "#{make}.html")
  end

  def Generate.index(images)
    {
      path: "index.html",
      images: images.take(10),
      navigations:  distinct_makes(images)
                    .collect{|make| navigate_to_make(make)}
    }
  end

  def Generate.navigate_to_model(image)
    Navigation.new(image.model, "#{image.make}-#{image.model}.html")
  end

  def Generate.makes(images)
    distinct_makes(images)
      .collect do |make| 
        images_of_this_make = images.find_all {|image| make == image.make }
        {
          path:   "#{make}.html",
          images: images_of_this_make,
          navigations: images_of_this_make
                        .uniq(&:model)
                        .collect {|image| navigate_to_model(image)}
        }
      end
  end

end

