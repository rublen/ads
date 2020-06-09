ENV['SINATRA_ENV'] ||= 'development'
APP_ROOT = File.expand_path('..', __dir__)

require 'bundler/setup' #require bundler
Bundler.require(:default, ENV['SINATRA_ENV']) # load gems, using bundler

require 'i18n'
I18n.load_path = Dir[File.join(APP_ROOT, 'config', 'locales', '**', '*.yml')]
I18n.config.available_locales = %i[en ru]
I18n.config.default_locale = :ru

require 'sinatra/reloader'
require 'sinatra/json'

require_all 'app' # require all MVC files in the app folder
