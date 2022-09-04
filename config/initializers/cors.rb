# frozen_string_literal: true

REQUEST_METHODS = %i(get post put patch delete options head).freeze

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: REQUEST_METHODS
  end
end
