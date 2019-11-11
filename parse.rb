puts RUBY_PLATFORM, RUBY_VERSION

# gem install pdf-reader
# gem install concurrent-ruby
# gem install benchmark
# gem install origami
require 'pdf-reader'
require 'concurrent'
require 'benchmark'
require 'yomu'

def main_with_promises
	time = Benchmark.measure {

		files = Dir[ 'pdfs/*.pdf' ].select{ |f| File.file? f }.map{ |f| File.basename f }

		puts "---"
		puts "A total of : #{files.length} files found."
		puts "---"

		promises = []

		files.each do |file_name|
			promises << Concurrent::Promise.execute do 
		   		puts "Converting : #{file_name}"
				parse_pooled_file(file_name)
			end
		end

		Concurrent::Promise.zip(*promises).value!
	}
 	puts time.real
end

def main_raw
	time = Benchmark.measure {

		files = Dir[ 'pdfs/*.pdf' ].select{ |f| File.file? f }.map{ |f| File.basename f }

		puts "---"
		puts "A total of : #{files.length} files found."
		puts "---"

		promises = []

		files.each do |file_name|
			
			reader = PDF::Reader.new('pdfs/' + file_name)
			puts "Converting : #{file_name} | #{reader.page_count} pages long."
			reader.pages.each do |page|
			  # puts page.text

			  open('txts/' + file_name + '.txt', 'a') do |f|
			  	f << page.text
			  end
			end
		end
	}
 	puts time.real
end

def main_with_yomu
    time = Benchmark.measure {

		files = Dir[ 'pdfs/*.pdf' ].select{ |f| File.file? f }.map{ |f| File.basename f }

		puts "---"
		puts "A total of : #{files.length} files found."
		puts "---"

		promises = []

		files.each do |file_name|
			
			reader = Yomu.new('pdfs/' + file_name)
			puts "Converting : #{file_name}"
			
            open('txts/' + file_name + '.txt', 'a') do |f|
                f << reader.text
			end
		end
	}
 	puts time.real
end

def parse_pooled_file(file_name)

	reader = PDF::Reader.new('pdfs/' + file_name)
		
	reader.pages.each do |page|
	  # puts page.text

	  open('txts/' + file_name + '.txt', 'a') do |f|
	  	f << page.text
	  end
	end
end

# main_with_promises()
#main_with_yomu()

# Still the fastest option at the moment. 
main_raw()