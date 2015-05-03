
#
# Helps you go from a list of images to a page model that's suitable for templating
#
#  [Image...] ==>> {path: '', images: [Image...], navigations: [Navigation...]}
#
module Page

  Navigation = Struct.new :title, :path

  INDEX_NAV = Navigation.new 'index', 'index.html'

  class << self

    def nav_to_make(make)
      Navigation.new make, "#{make}.html"
    end

    def nav_to_model(image)
      Navigation.new image.model, "#{image.make}-#{image.model}.html"
    end

    def index(images)
      {
        title:       INDEX_NAV.title,
        path:        INDEX_NAV.path,
        images:      images.take(10),
        navigations: images.collect(&:make).uniq.collect{|make| nav_to_make(make)}
      }
    end

    def make(images, make)
      images_of_make = images.find_all{|image| image.make == make}
      {
        title:       make,
        path:        "#{make}.html",
        images:      images_of_make.take(10),
        navigations: [INDEX_NAV] + images_of_make.uniq(&:model).collect {|image| nav_to_model(image)}
      }
    end

    def makes(images)
      images.collect(&:make).uniq.collect {|make_name| make(images, make_name)}
    end

    def model(images_of_model, make, model)
      {
        title: "#{make} #{model}",
        path:  "#{make}-#{model}.html",
        images: images_of_model,
        navigations: [INDEX_NAV, nav_to_make(make)]
      }
    end

    def models(images)
      images
      .group_by{|image| {make: image.make, model: image.model}}
      .collect{|segment, images| model(images, segment[:make], segment[:model])}
    end

  end
end