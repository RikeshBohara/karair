class JobsController < ApplicationController
  respond_to :html, :json
  before_action :authenticate_user!
  before_action :set_job, only: [ :show, :edit, :update, :destroy, :send_interview_email ]
  before_action :authorize_job_owner, only: [ :edit, :update, :destroy ]

  def index
    @jobs = Job.active
    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @job_applications = @job.job_applications
    respond_to do |format|
      format.html
      format.json
    end
  end

  def new
    @job = Job.new
  end

  def create
    @job = current_user.jobs.build(job_params)
    if @job.save
      respond_to do |format|
        format.html { redirect_to @job, notice: "Job was successfully created." }
        format.json { render :show, status: :created }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { errors: @job.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    if @job.update(job_params.except(:remove_image))
      respond_to do |format|
        format.html { redirect_to @job, notice: "Job was successfully updated." }
        format.json { render :show, status: :ok }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: { errors: @job.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: "Job was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def send_interview_email
    unless current_user.profile&.company_name.present?
      redirect_to @job, alert: "Please complete your profile, including your company name, before sending interview emails."
      return
    end

    @job_application = JobApplication.find(params[:application_id])
    if InterviewMailer.interview_email(@job, @job_application.user, current_user).deliver_now
      @job_application.emailed!
      redirect_to @job, notice: "Interview email sent to #{@job_application.user.email}."
    else
      redirect_to @job, alert: "Failed to send interview email."
    end
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def authorize_job_owner
    unless @job.user == current_user
      redirect_to jobs_path, alert: "You are not authorized to perform this action."
    end
  end

  def job_params
    params.require(:job).permit(:title, :description, :location, :job_type, :image, :remove_image, :end_date)
  end
end
