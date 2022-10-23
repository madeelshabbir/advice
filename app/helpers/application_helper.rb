# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend
  include SharedHelper

  def pagy_url_for(pagy, page, absolute: false, html_escaped: false)
    path = url_for({ pagy.vars[:page_param] => page, only_path: !absolute })
    "#{app_path}#{html_escaped ? path.gsub('&', '&amp;') : path}"
  end

  def svg(name)
    file_path = Rails.root.join('app', 'assets', 'images', "#{name}.svg")
    File.read(file_path).html_safe if File.exist?(file_path) # rubocop:disable Rails/OutputSafety
  end
end
