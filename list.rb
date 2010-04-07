require "HoustonLibrarySearch"
require 'wishlist.rb'

if ARGV.length != 1
  puts "This script requires one argument, the wishlist id."
else
  w = WishList.new
  w.parse(ARGV[0])
  w.list.each do |a|
    if a[1]
      puts "#{a[0]}"
      parser = HoustonLibrarySearch::ISBN.new
			parser.search(a[1]).each do |library, listings|
				unless listings.empty?
        	puts "  #{library}:"
        	listings.each {|l| puts "    #{l.location} #{l.call_number} #{l.status} #{l.due_date}"}
				end
      end
      puts
    end
  end
end

