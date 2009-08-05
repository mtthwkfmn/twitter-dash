require 'gchart'

class BaseBuilder
  
  attr_accessor :count
    
  def initialize(updates, count = 0)
    @updates = updates
    @count = count
    @sparkline_data = Array.new(30) { |i| 0 }
  end
  
  def sparkline
    Gchart.sparkline(:data => @sparkline_data,:size => '120x40')
  end
  
end