require 'amazon/aws'
require 'search.rb' #replace with amazon/aws/search after bug fix for listlookups over multiple pages

class WishList

  def initialize
    @all_items = []
  end
  
  def parse(id)
    req = Amazon::AWS::Search::Request.new()
    ls = Amazon::AWS::ListLookup.new(id,"WishList", :IsOmitPurchasedItems => 1)
    rg = Amazon::AWS::ResponseGroup.new('ItemAttributes','ListItems')
    req.search(ls, rg, :ALL_PAGES) do |r|
      @all_items += r.list_lookup_response[0].lists[0].list[0].list_item
    end
  end
 
  def list
    @all_items.collect {|b| [title(b), isbn(b)]}
  end

  private
  def title(b) 
    c = b.item[0].item_attributes[0].title
    c[0]['__val__'] if c
  end

  def isbn(b) 
    c = b.item[0].item_attributes[0].isbn
    c[0]['__val__'] if c
  end
end
