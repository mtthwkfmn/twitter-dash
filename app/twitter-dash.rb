require 'rubygems'
require 'sinatra'
require 'haml'
require 'twitter'

def connect(username, password)
  httpauth = Twitter::HTTPAuth.new(username,password)
  Twitter::Base.new(httpauth)
end

def get_tweets
  client = connect
  tweets = client.user_timeline
  page = 2
  
  while Time.parse(tweets.last.created_at) > 30.days.ago
    tweets += client.user_timeline(:page => page)
    page += 1
  end
  
  tweets
end

def get_mentions
  client = connect
  mentions = client.replies
  page = 2
  
  while Time.parse(mentions.last.created_at) > 30.days.ago
    mentions += client.replies(:page => page)
    page += 1
  end
  
  mentions
end

get '/' do
  haml :index
end

post '/stats/' do
  username = params[:username]
  password = params[:password]
  session
  haml :stats, :locals => { :username => params[:username] }
end