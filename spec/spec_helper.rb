ENV['RACK_ENV'] = ENV['SINATRA_ENV'] = 'test'

require './config/environment'

abort('The Sinatra environment is running in production mode!') if production?
abort('The Sinatra environment is running in development mode!') if development?

Dir[[APP_ROOT, 'spec', 'support', '*.rb'].join('/')].each { |f| require f }
Dir[[APP_ROOT, 'spec', 'factories', '*.rb'].join('/')].each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.include Rack::Test::Methods, type: :request

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
