require 'rubygems'
require 'sinatra'
require 'haml'

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

get '/' do
  haml :index
end

post '/stats/' do
  @twitter_stats = StatsAssembler.new(params[:username],params[:password])
  haml :stats, :locals => { :twitter_stats => @twitter_stats }
end