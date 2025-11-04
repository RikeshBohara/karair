class HomeController < ApplicationController
  def index
    if user_signed_in? && !current_user.profile_completed
      redirect_to edit_profile_path(current_user.profile), alert: "Please complete your profile first."
      return
    end
  end
end
