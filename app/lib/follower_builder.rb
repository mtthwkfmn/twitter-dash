class FollowerBuilder < BaseBuilder
  
  def initialize(updates, count = 0)
    super(updates, count)
    build_sparkline_data
    @count = updates.first.user.followers_count - updates.last.user.followers_count
  end
  
  def build_sparkline_data
    @updates.each do |update|
      day = (Date.today - Date.parse(update.created_at)).to_i
      if day.between?(0,29)
        # Always use the highest number of followers for each day.
        if update.user.followers_count > @sparkline_data[day]
          @sparkline_data[day] = update.user.followers_count
        end
      end  
    end
    
    # Skip days we didn't tweet.
    @sparkline_data.delete_if { |x| x == 0 }
    
  end
  
end