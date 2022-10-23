# frozen_string_literal: true

module ErrorHandler
  extend ActiveSupport::Concern

  GENERIC_MESSAGED_ERROR_CLASSES = [
    ActiveRecord::RecordInvalid,
    ActiveRecord::ReadOnlyRecord,
    StandardError
  ].freeze

  CUSTOM_MESSAGED_ERROR_CLASSES = [
    ActiveRecord::RecordNotUnique,
    ShopifyAPI::Errors::NoActiveSessionError,
    ShopifyAPI::Errors::HttpResponseError
  ].freeze

  included do
    include ErrorsHelper

    protected

      rescue_from ActiveRecord::RecordNotFound do |resource|
        redirect_to_error_path(I18n.t('errors.record_not_found', resource: resource.model))
      end

      rescue_from ActionController::ParameterMissing do |e|
        missing_params = e.message.split(':').map(&:strip).drop(1).join(', ')
        redirect_to_error_path(I18n.t('errors.parameter_missing', parameters: missing_params))
      end

      rescue_from(*CUSTOM_MESSAGED_ERROR_CLASSES) do |e|
        redirect_to_error_path(I18n.t("errors.#{e.class.name.demodulize.underscore}"))
      end

      rescue_from(*GENERIC_MESSAGED_ERROR_CLASSES) do |e|
        redirect_to_error_path(e.message)
      end

      def redirect_to_error_path(message)
        LogNotifier.error(message, *resource_and_action, **params.as_json.with_indifferent_access)
        redirect_to(app_error_path, error: message)
      end

      def resource_and_action
        [controller_path.classify, action_name]
      end
  end
end
