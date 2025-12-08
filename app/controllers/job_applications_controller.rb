class JobApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_job, only: [:new, :create]

  def new
    @job_application = @job.job_applications.build
  end

  def create
    @job_application = @job.job_applications.build(job_application_params)
    @job_application.user = current_user
    if @job_application.save
      Notification.create!(
        recipient: @job.user,
        actor: current_user,
        notifiable: @job_application,
        message: "#{current_user.profile.first_name} #{current_user.profile.last_name} applied to your job '#{@job.title}'"
      )
      redirect_to @job, notice: 'You have successfully applied for this job.'
    else
      render :new
    end
  end

  private

  def set_job
    @job = Job.find(params[:job_id])
  end

  def job_application_params
    params.require(:job_application).permit(:cover_letter)
  end
end
