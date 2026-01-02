class JobApplicationsController < ApplicationController
  respond_to :html, :json
  before_action :authenticate_user!
  before_action :set_job, only: [ :index, :new, :create ]
  before_action :set_job_application, only: [ :show ]

  def index
    @job_applications = @job.job_applications
    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @job_application = JobApplication.find(params[:id])
    respond_to do |format|
      format.html
      format.json
    end
  end

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
      respond_to do |format|
        format.html { redirect_to @job, notice: "You have successfully applied for this job." }
        format.json { render :show, status: :created }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { errors: @job_application.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_job
    @job = Job.find(params[:job_id])
  end

  def job_application_params
    params.require(:job_application).permit(:cover_letter)
  end

  def set_job_application
    @job_application = JobApplication.find(params[:id])
  end
end
