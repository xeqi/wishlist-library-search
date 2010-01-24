require 'scrape.rb'
require 'HPL.rb'

if ARGV.length != 1
  puts "This script requires one argument, the wishlist id."
else
  w = WishList.new
  w.parse(ARGV[0])
  w.list.each do |a|
    if a[1]
      puts a[0]
      puts HPL.parse(a[1]).collect {|x| x.join.sub(/\n/, '')}
      puts
    end
  end
end

