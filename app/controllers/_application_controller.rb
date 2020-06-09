require_relative 'concerns/api_errors'

class ApplicationController < Sinatra::Base
  include ::ApiErrors

  configure :development do
    register Sinatra::Reloader
  end
end
