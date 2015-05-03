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

    def nav_to_model(make, model)
      Navigation.new model, "#{make}-#{model}.html"
    end

    def index(images)
      {
        title:       INDEX_NAV.title,
        path:        INDEX_NAV.path,
        images:      images.take(10),
        navigations: images.collect(&:make).uniq.collect{|make| nav_to_make(make)}
      }
    end

    def make(make, images_of_make)
      {
        title:       make,
        path:        "#{make}.html",
        images:      images_of_make.take(10),
        navigations: [INDEX_NAV] + images_of_make.collect(&:model).uniq.collect{|model| nav_to_model(make, model)}
      }
    end

    def makes(images)
      images
      .group_by(&:make)
      .collect {|make,images_of_make| make(make, images_of_make)}
    end

    def model(make, model, images_of_model)
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
      .collect{|segment, images_of_model| model(segment[:make], segment[:model], images_of_model)}
    end

  end
end