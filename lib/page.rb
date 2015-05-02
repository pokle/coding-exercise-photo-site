
# Functions that can transform a parsed set of images to a page model
# suitable for consumption by an HTML templating engine
module Page

  Navigation = Struct.new :title, :path

  class << self

    def nav_to_make(make)
      Navigation.new make, "#{make}.html"
    end

    def nav_to_model(image)
      Navigation.new image.model, "#{image.make}-#{image.model}.html"
    end

    def index(images)
      {
        path:        "index.html",
        images:      images.take(10),
        navigations: images.collect(&:make).uniq.collect{|make| nav_to_make(make)}
      }
    end

    def make(images, make)
      images_of_make = images.find_all{|image| image.make == make}
      {
        path:        "#{make}.html",
        images:      images_of_make.take(10),
        navigations: images_of_make.uniq(&:model).collect {|image| nav_to_model(image)}
      }
    end

    def makes(images)
      images.collect(&:make).uniq.collect {|make_name| make(images, make_name)}
    end

  end
end