class ApplicationController < ActionController::Base
  include Rescuable
  
  protect_from_forgery with: :null_session
end
