require 'nokogiri'

Image = Struct.new :thumb, :full, :make, :model

def parse_works(xml_source)
	Nokogiri::XML(xml_source)
	.xpath("//works/work")
	.collect{|w| Image.new(
		w.xpath("urls/url[@type='small']").text,
		w.xpath("urls/url[@type='large']").text,
		w.xpath("exif/make").text,
		w.xpath("exif/model").text
	 )}
end