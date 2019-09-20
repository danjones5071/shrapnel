module Rescuable
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :not_found_error
  end

  def not_found_error
    render_json_error(:not_found, "Not found")
  end

  def render_json_error(status, message, errors = nil)
    status = Rack::Utils::SYMBOL_TO_STATUS_CODE[status] if status.is_a? Symbol
    json = {code: status, message: message, errorsDetails: errors }.compact
    render json: json, status: status
  end
end