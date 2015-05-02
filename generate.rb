

Image = Struct.new :thumb, :full, :make, :model do
  def self.distinct_makes(images) 
    images.collect(&:make).uniq
  end

  def self.by_make(images, make)
    images.find_all {|image| make == image.make }
  end
end

Navigation = Struct.new :title, :path do
  def self.to_index
    new "index", "index.html"  
  end

  def self.to_make(make)
    new make, "#{make}.html"
  end

  def self.to_model(image)
    new image.model, "#{image.make}-#{image.model}.html"
  end
end

module Page

  def self.index(images)
    {
      path: "index.html",
      images: images.take(10),
      navigations:  Image.distinct_makes(images).collect{|make| Navigation.to_make(make)}
    }
  end

  def self.makes(images)
    Image.distinct_makes(images).collect do |make| 
      {
        path:   "#{make}.html",
        images: Image.by_make(images, make).take(10),
        navigations: Image.by_make(images, make).uniq(&:model).collect {|image| Navigation.to_model(image)}
      }
    end
  end

end

