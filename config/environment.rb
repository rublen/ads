ENV['SINATRA_ENV'] ||= 'development'
APP_ROOT = File.expand_path('..', __dir__)

require 'bundler/setup' #require bundler
Bundler.require(:default, ENV['SINATRA_ENV']) # load gems, using bundler

require 'sinatra/reloader'
require 'sinatra/json'
require_all 'app' # require all MVC files in the app folder
