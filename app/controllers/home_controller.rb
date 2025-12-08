class HomeController < ApplicationController
  def index
    if user_signed_in? && !current_user.profile_completed
      redirect_to edit_profile_path(current_user.profile), alert: "Please complete your profile first."
      return
    end

    if user_signed_in? && current_user.applicant?
      @applied_jobs = current_user.job_applications.includes(:job).map(&:job)
    elsif user_signed_in? && current_user.recruiter?
      @active_jobs = current_user.jobs.active
      @expired_jobs = current_user.jobs.expired
    end
  end
end
