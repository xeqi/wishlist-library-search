
class Listing

  attr_reader :location, :call_number, :status, :due_date

  def initialize(location, call_number, status, due_date) 
    @location = location
    @call_number = call_number
    @status = status
    @due_date = due_date
  end
end
