require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SuperPortfolio
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.load_defaults 5.2

    config.action_view.default_form_builder = 'ApplicationFormBuilder'
    config.assets.prefix = '/static/assets'

    # Add fonts to asset pipeline
    config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')
    config.assets.precompile << /\.(?:svg|eot|woff|ttf)$/

    # Add validators to autoload
    config.autoload_paths << Rails.root.join('lib', 'validators')
  end
end
