source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'sinatra'
gem 'sinatra-contrib', require: false

gem 'activerecord'
gem 'activesupport'
gem 'pg', '>= 0.18', '< 2.0'
gem 'sinatra-activerecord'

gem 'rake'
gem 'require_all'

gem 'dry-initializer', '~> 3.0.3'
gem 'fast_jsonapi', '~> 1.5'

group :development, :test do
  gem 'factory_bot'
  gem 'pry'
  gem 'rspec'
  gem 'rubocop', require: false
  gem 'tux'
end

group :test do
  gem 'database_cleaner-active_record', '~> 1.8.0'
  gem 'rack-test'
end
