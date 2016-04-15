require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Kiitest
  class Application < Rails::Application

    config.time_zone = 'Berlin'
    config.i18n.default_locale = :de
    config.i18n.available_locales = %i(de)
    config.active_record.raise_in_transactional_callbacks = true

    # Bower asset paths
    root.join('vendor', 'assets', 'bower_components').to_s.tap do |bower_path|
      config.sass.load_paths << bower_path
      config.assets.paths << bower_path
    end
    # Precompile Bootstrap fonts
    config.assets.precompile << %r{bootstrap-sass/assets/fonts/bootstrap/[\w-]+\.(?:eot|svg|ttf|woff2?)$}
    config.assets.precompile << %r{font-awesome-sass/assets/fonts/font-awesome/[\w-]+\.(?:eot|otf|svg|ttf|woff2?)$}

    # Minimum Sass number precision required by bootstrap-sass
    ::Sass::Script::Value::Number.precision = [8, ::Sass::Script::Value::Number.precision].max
    config.sass.preferred_syntax = :sass
    config.sass.syntax = :sass

  end
end
