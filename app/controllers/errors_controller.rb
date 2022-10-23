# frozen_string_literal: true

class ErrorsController < ApplicationController
  def show
    @support_email = ENV.fetch('SUPPORT_EMAIL')
    render :show, content_type: 'application/liquid'
  end
end
