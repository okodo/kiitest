ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'devise'
require 'vcr'
require 'capybara/poltergeist'
require 'capybara/rspec'
require 'capybara/rails'
require 'site_prism'
require 'sidekiq/testing'
require 'rspec/active_job'
require 'shoulda/matchers'
::Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :active_record
    with.library :active_model
  end
end
require 'factory_girl_rails'
require 'ffaker'
require 'database_cleaner'
require 'fakeredis/rspec'
require 'headless'
require 'approvals/rspec'


Sidekiq::Testing.inline!

ActiveRecord::Migration.maintain_test_schema!

Capybara.server do |app, port|
  require 'rack/handler/thin'
  Rack::Handler::Thin.run(app, Port: port)
end


Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: false, phantomjs_options: ['--load-images=no'])
end

Capybara::Webkit.configure do |config|
  config.ignore_ssl_errors
  config.allow_unknown_urls
  config.allow_url('test.rficb.ru')
end

Capybara.configure do |config|
  config.javascript_driver = ENV['IN_BROWSER'].try(:to_sym).presence || :poltergeist
  config.default_max_wait_time = 20
  config.match = :one
  config.exact_options = true
  config.ignore_hidden_elements = true
  config.visible_text_only = true
  config.default_selector = :css
end

Dir[Rails.root.join('spec/support/**/*.rb')].each {|f| require f }
Dir[Rails.root.join('spec/support/features/**/*.rb')].sort.each {|f| require f }


RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.include FactoryGirl::Syntax::Methods
  config.include Devise::TestHelpers, type: :controller
  config.include Warden::Test::Helpers, type: :feature

  config.before(:all) do
    DeferredGarbageCollection.start
  end
  config.after(:all) do
    DeferredGarbageCollection.reconsider
  end
  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation, { except: %w(exchange_rates) }
    # It makes capybara tests faster by 50 seconds
    # DatabaseCleaner.strategy = :deletion, { except: %w(exchange_rates) }
    # It makes capybara tests faster by 40 seconds
    # DatabaseCleaner.strategy = :truncation, { pre_count: true, reset_ids: false, except: %w(exchange_rates) }
  end
  config.around(:each) do |example|
    DatabaseCleaner.start
    example.run
    DatabaseCleaner.clean
  end

  config.before :suite do
    Warden.test_mode!
  end
end
