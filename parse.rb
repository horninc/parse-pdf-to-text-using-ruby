# gem install pdf-reader
require 'pdf-reader'

# files = Dir["pdfs/*.pdf"]
files = Dir[ 'pdfs/*.pdf' ].select{ |f| File.file? f }.map{ |f| File.basename f }

files.each do |file_name|
	puts "Converting : #{file_name}"

	reader = PDF::Reader.new('pdfs/' + file_name)
	
	reader.pages.each do |page|
	  # puts page.text

	  open('txts/' + file_name + '.txt', 'a') do |f|
	  	f << page.text
	  end
	end

end
