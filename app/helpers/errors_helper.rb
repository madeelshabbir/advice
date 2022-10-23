# frozen_string_literal: true

module ErrorsHelper
  include SharedHelper

  def app_error_path
    "#{app_path}#{error_path}"
  end
end
