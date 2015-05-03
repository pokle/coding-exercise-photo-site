#
# Produces a page model to make templating easier
#
#  [Image...] ==>> {path: '', images: [Image...], navs: [Nav...]}
#
module Page
  Nav = Struct.new :title, :path
  INDEX_NAV = Nav.new 'index', 'index.html'

  class << self
    def nav_to_make(make)
      Nav.new make, "#{make}.html"
    end

    def nav_to_model(make, model)
      Nav.new model, "#{make}-#{model}.html"
    end

    def index(images)
      {
        title:  INDEX_NAV.title,
        path:   INDEX_NAV.path,
        images: images.take(10),
        navs:   images.map(&:make).uniq.map { |make| nav_to_make(make) }
      }
    end

    def make(make, images_of_make)
      {
        title:  make,
        path:   "#{make}.html",
        images: images_of_make.take(10),
        navs:   [INDEX_NAV] +
          images_of_make.map(&:model).uniq.map do |model|
            nav_to_model(make, model)
          end
      }
    end

    def makes(images)
      images
        .group_by(&:make)
        .map { |make, images_of_make| make(make, images_of_make) }
    end

    def model(make, model, images_of_model)
      {
        title:  "#{make} #{model}",
        path:   "#{make}-#{model}.html",
        images: images_of_model,
        navs:   [INDEX_NAV, nav_to_make(make)]
      }
    end

    def models(images)
      images
        .group_by { |image| { make: image.make, model: image.model } }
        .map do |segment, images_of_model|
          model(segment[:make], segment[:model], images_of_model)
        end
    end
  end
end
