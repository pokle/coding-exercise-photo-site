Image = Struct.new :thumb, :full, :make, :model
Navigation = Struct.new :title, :path

def nav_to_make(make)
  Navigation.new make, "#{make}.html"
end

def nav_to_model(image)
  Navigation.new image.model, "#{image.make}-#{image.model}.html"
end

module Page

  def self.index(images)
    {
      path:        "index.html",
      images:      images.take(10),
      navigations: images.collect(&:make).uniq.collect{|make| nav_to_make(make)}
    }
  end

  def self.make(images, make)
    images_of_make = images.find_all{|image| image.make == make}
    {
      path:        "#{make}.html",
      images:      images_of_make.take(10),
      navigations: images_of_make.uniq(&:model).collect {|image| nav_to_model(image)}
    }
  end

  def self.makes(images)
    images.collect(&:make).uniq.collect {|make_name| make(images, make_name)}
  end

end