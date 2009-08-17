require 'rubygems'
require 'sinatra'
require 'haml'

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

enable :sessions

helpers do 
  def flash(args={}) 
    session[:flash] = args 
  end 
  
  def flash_now(args={}) 
    @flash = args 
  end 
end

before do 
  @flash = session[:flash] || {} 
  session[:flash] = nil 
end

not_found do
  haml :fourohfour
end

get '/' do
  haml :index
end

post '/stats/' do
  begin
    @twitter_stats = StatsAssembler.new(params[:username],params[:password])
    @twitter_stats.connect()
    haml :stats, :locals => { :twitter_stats => @twitter_stats }
  rescue Twitter::Unauthorized
    flash(:error => "Your username/password was invalid. Please try again.")
    redirect '/'
  end
end