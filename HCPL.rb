require 'curb'
require 'nokogiri'
require 'listing.rb'

class HCPL
  def self.listings(isbn)
    c = Curl::Easy.perform("http://catalog.hcpl.net/ipac20/ipac.jsp?index=ISBNEXH&term=#{isbn}")
    xml = Nokogiri::XML.parse(c.body_str)
    results = xml.css(".tableBackground .tableBackground .tableBackground .tableBackground .tableBackground .tableBackground").collect do |table|
      trs = table.css("tr")
      # mask multiple books as no results
      # see isbn 0887307280
      if(trs[0].css("td")[0].css("a").text =~ /Location/)
        trs[1, trs.length-1].collect do |tr|
          tds = tr.css("td")
          Listing.new(tds[0].text, tds[2].text, tds[3].text, tds[4].text)
        end
      end
    end
    #handle masking
    results = results.select{|x| x}
    results.flatten
  end

  def self.name
    "Harris County Public Library"
  end
end
