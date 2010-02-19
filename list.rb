begin
  # Try to require the preresolved locked set of gems.
  require File.expand_path('../.bundle/environment', __FILE__)
rescue LoadError
  # Fall back on doing an unlocked resolve at runtime.
  require "rubygems"
  require "bundler"
  Bundler.setup
end

require 'HoustonLibrarySearch'
require 'scrape.rb'

if ARGV.length != 1
  puts "This script requires one argument, the wishlist id."
else
  w = WishList.new
  w.parse(ARGV[0])
  w.list.each do |a|
    if a[1]
      puts "#{a[0]}"
      HoustonLibrarySearch.search(a[1]).each do |library, listings|
        puts "  #{library}:"
        listings.each {|l| puts "    #{l.location} #{l.call_number} #{l.status} #{l.due_date}"}
      end
      puts
    end
  end
end

