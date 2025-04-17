class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    posts_path
  end
  
  before_action :debug_auth

  def debug_auth
    Rails.logger.debug "🔐 current_user: #{current_user.inspect}"
    Rails.logger.debug "🔁 Request path: #{request.path}"
  end
end
