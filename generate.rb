

module Generate

  Image = Struct.new :thumb, :full, :make, :model
  Navigation = Struct.new :title, :path

  def Generate.distinct_makes(works) 
    works.collect(&:make).uniq
  end

  def Generate.index(works)
    {
      path: "index.html",
      images: works.take(10),
      navigations:  distinct_makes(works)
                    .collect{|make| Navigation.new(make, "#{make}.html")}
    }
  end

  def Generate.makes(works)
    distinct_makes(works)
      .collect do |make| 
        {
          path:   "#{make}.html",
          images: works.find_all {|image| make == image.make },
          navigations: []
        }
      end
  end

end

