require 'scrape.rb'
require 'HCPL.rb'
require 'HPL.rb'

if ARGV.length != 1
  puts "This script requires one argument, the wishlist id."
else
  w = WishList.new
  w.parse(ARGV[0])
  w.list.each do |a|
    if a[1]
      puts "#{a[0]}"
      [HCPL, HPL].each do |x|
        puts "  #{x.name}:"
        x.listings(a[1]).each {|l| puts "    #{l.location} #{l.call_number} #{l.status} #{l.due_date}"}
      end
      puts
    end
  end
end

