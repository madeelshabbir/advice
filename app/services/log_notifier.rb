# frozen_string_literal: true

class LogNotifier
  %i(info error).each do |method|
    define_singleton_method(method) do |message, resource, action, **params|
      Rails.logger.send(method, full_message(method, message, resource, action, **params))
    end
  end

  def self.full_message(method, message, resource, action, **params)
    [
      I18n.t("notifications.#{method}", resource:, action:),
      message.presence,
      params.to_json
    ].compact.join(', ')
  end

  private_class_method :full_message
end
