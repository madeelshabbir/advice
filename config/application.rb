# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module AdviceShopify
  class Application < Rails::Application
    config.load_defaults 7.0
    config.active_job.queue_adapter = :sidekiq
    config.eager_load_paths.push(Rails.root.join('lib'))
  end
end
