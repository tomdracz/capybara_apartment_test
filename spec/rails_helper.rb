# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= "test"
require "spec_helper"
require File.expand_path("../../config/environment", __FILE__)

# Maintain the test schema BEFORE any test code to prevent connection fubars
ActiveRecord::Migration.maintain_test_schema!

require "rspec/rails"
require "capybara/rspec"
require "capybara/rails"
require "capybara/poltergeist"
require "transactional_capybara/rspec"

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

Capybara.raise_server_errors = true
Capybara.server_port = "33333"
Capybara.javascript_driver = :poltergeist

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include TransactionalCapybara::AjaxHelpers
  config.include Warden::Test::Helpers
  config.include ApplicationHelper, type: :feature

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
    @site = FactoryGirl.create(:site)
    Capybara.app_host = "http://" + @site.domain + ":33333"
    Apartment::Tenant.switch!(@site.parameterized_name)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.after :each do
    Warden.test_reset!
  end

  config.after(:suite) do
    Apartment::Tenant.each { |t| Apartment::Tenant.drop t }
  end

  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
