class StatisticBuilder < BaseBuilder
  
  def initialize(updates, count = 0)
    super(updates, count)
    build_sparkline_data
  end
  
  def build_sparkline_data
    @updates.each do |update|
      day = (Date.today - Date.parse(update.created_at)).to_i
      if day.between?(0,29)
        @sparkline_data[day] += 1
        @count += 1
      end  
    end
  end
  
end