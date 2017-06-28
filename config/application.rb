require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CapybaraApartmentTest
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.active_job.queue_adapter = :sidekiq

    config.load_defaults 5.1
    config.time_zone = "UTC"
    config.active_record.default_timezone = :utc
    config.action_dispatch.default_headers = {
        'X-Frame-Options' => 'ALLOWALL'
    }

    config.assets.paths << Rails.root.join("app", "assets", "fonts")

    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: true,
        routing_specs: true,
        controller_specs: false,
        request_specs: true
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
