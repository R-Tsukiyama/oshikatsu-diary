require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module OshikatsuDiary
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.i18n.default_locale = :ja
    # Configuration for the application, engines, and railties goes here.
        config.action_view.field_error_proc = Proc.new do |html_tag, instance|
      if instance.kind_of?(ActionView::Helpers::Tags::Label)
        html_tag.html_safe
      else
        "<div class=\"has-error\">#{html_tag}<span class=\"help-block\">#{instance.error_message.first}</span></div>".html_safe
      end
    end
    config.active_storage.replace_on_assign_to_many = false
    
    config.assets.paths << Rails.root.join('node_modules')
    config.assets.precompile += %w( flatpickr/dist/flatpickr.min.css )
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
