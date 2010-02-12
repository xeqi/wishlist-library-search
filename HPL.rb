require 'curb'
require 'nokogiri'
require 'listing.rb'

class HPL
  def self.listings(isbn)
    c = Curl::Easy.perform("http://catalog.houstonlibrary.org/search~S0/?searchtype=i&searcharg=#{isbn}")
    xml = Nokogiri::XML.parse(c.body_str)
    xml.css('.bibItemsEntry').collect do |x|
      due = ''
      row = x.css('td')
      status = row[3].text.strip
      if status =~ /DUE/
        due = status[4, 8]
        status = "Checked out"
      end
      Listing.new(row[0].text.strip, row[2].text.strip, status.capitalize, due)
    end
  end
  def self.name
    "Houston Public Library"
  end
end
