# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ApplicationHelper
  include Pagy::Backend
  include ErrorHandler
end
