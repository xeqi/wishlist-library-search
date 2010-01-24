require 'curb'
require 'nokogiri'

class HPL
  def self.parse(isbn)
    c = Curl::Easy.perform("http://catalog.houstonlibrary.org/search~S0/?searchtype=i&searcharg=#{isbn}")
    xml = Nokogiri::XML.parse(c.body_str)
    xml.css('.bibItemsEntry').collect {|x| x.css('td').collect {|x| x.text}}
  end
end
