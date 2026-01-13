class ApplicationController < ActionController::Base
  helper_method :current_user
  allow_browser versions: :modern
  stale_when_importmap_changes

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
