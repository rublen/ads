class ApplicationController < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    'Welcome to Ads App'
  end
end
