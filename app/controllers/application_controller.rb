class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  # protect_from_forgery with: :null_session
  protect_from_forgery unless: -> { request.format.json? }

end
