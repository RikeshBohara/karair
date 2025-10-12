class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_user!

  protect_from_forgery with: :exception

  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }

  before_action :adjust_format_for_api

  private

  def adjust_format_for_api
    request.format = :json if request.headers["Content-Type"]&.include?("application/json")
  end
end
