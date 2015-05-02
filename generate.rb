

module Generate

  Image = Struct.new :thumb, :full, :make, :model
  Navigation = Struct.new :title, :path

  #
  # Images
  #
  def Generate.distinct_makes(images) 
    images.collect(&:make).uniq
  end

  def Generate.images_with_make(images, make)
    images.find_all {|image| make == image.make }
  end

  #
  # Navigations
  #
  def Generate.navigate_to_make(make)
    Navigation.new(make, "#{make}.html")
  end

  def Generate.navigate_to_model(image)
    Navigation.new(image.model, "#{image.make}-#{image.model}.html")
  end

  #
  # Pages
  #
  def Generate.index(images)
    {
      path: "index.html",
      images: images.take(10),
      navigations:  distinct_makes(images)
                    .collect{|make| navigate_to_make(make)}
    }
  end

  def Generate.makes(images)
    distinct_makes(images)
      .collect do |make| 
        {
          path:   "#{make}.html",
          images: images_with_make(images, make).take(10),
          navigations: images_with_make(images, make)
                        .uniq(&:model)
                        .collect {|image| navigate_to_model(image)}
        }
      end
  end

end

