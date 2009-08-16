require 'rubygems'
require 'sinatra'
require 'haml'

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

not_found do
  haml :fourohfour
end

get '/' do
  haml :index
end

post '/stats/' do
  @twitter_stats = StatsAssembler.new(params[:username],params[:password])
  @twitter_stats.connect()
  haml :stats, :locals => { :twitter_stats => @twitter_stats }
end