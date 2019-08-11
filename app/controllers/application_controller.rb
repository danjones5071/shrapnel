class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  #rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
end
