class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  respond_to :html, :json
  allow_browser versions: :modern
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }
  before_action :adjust_format_for_api
  before_action :configure_permitted_parameters, if: :devise_controller?

  def status
    if current_user
      render json: { loggedIn: true, user: current_user.as_json(only: [ :id, :email, :role, :profile_completed ]) }
    else
      render json: { loggedIn: false }
    end
  end

  private

  def adjust_format_for_api
    request.format = :json if request.headers["Content-Type"]&.include?("application/json")
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :role ])
  end
end
