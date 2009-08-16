require 'twitter'
require 'activesupport'

Dir[File.dirname(__FILE__) + '*.rb'].each {|file| require file }

class StatsAssembler
  
  attr_reader :updates, :mentions, :followers, :friends, :links, :hashtags
  
  def initialize(username,password)
    @username = username
    @password = password
  end
  
  def connect()
    httpauth = Twitter::HTTPAuth.new(@username,@password)
    @client = Twitter::Base.new(httpauth)
    
    @tweets = get_tweets(@client)
    @updates = StatisticBuilder.new(@tweets)
    
    @replies = get_mentions(@client)
    @mentions = StatisticBuilder.new(@replies)
    
    @followers = FollowerBuilder.new(@tweets)
    @friends = FriendBuilder.new(@tweets)
    @links = LinkBuilder.new(@tweets)
    @hashtags = HashtagBuilder.new(@tweets)
  end
  
  private
  
  def get_tweets(client)
    tweets = client.user_timeline
    page = 2

    while Time.parse(tweets.last.created_at) > 30.days.ago
      tweets += client.user_timeline(:page => page)
      page += 1
    end

    tweets
  end

  def get_mentions(client)
    mentions = client.replies
    page = 2

    while Time.parse(mentions.last.created_at) > 30.days.ago
      mentions += client.replies(:page => page)
      page += 1
    end

    mentions
  end
  
end