# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('SUPPORT_EMAIL')
  layout 'mailer'

  protected

    def resource_and_action
      [controller_path.classify, action_name]
    end
end
