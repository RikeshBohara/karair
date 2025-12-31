class ProfilesController < ApplicationController
  respond_to :html, :json

  before_action :authenticate_user!
  before_action :set_profile
  before_action :authorize_profile!, only: [ :edit, :update ]
  before_action :require_profile_completed!, only: [ :show ]

  def show
    respond_with(@profile.user.id)
  end

  def edit
    @hide_navbar = true
    respond_with(@profile.user.id)
  end

  def update
    @hide_navbar = true
    if @profile.update(profile_params)
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Profile updated successfully." }
        format.json { render :show, status: :ok }
      end
    else
      respond_with(@profile) do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: { errors: @profile.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_profile
    @profile = Profile.find_by(user_id: params[:id].to_i)
  end

  def authorize_profile!
    redirect_to profile_path(@profile.user.id), alert: "Not authorized" unless @profile.user == current_user
  end

  def require_profile_completed!
    if @profile.user == current_user && !current_user.profile_completed
      redirect_to edit_profile_path(@profile.user.id), alert: "Please complete your profile first."
    end
  end

  def profile_params
    permitted = [ :first_name, :last_name, :headline, :location, :photo, :company_name, :contact ]
    permitted << :resume if current_user.applicant?
    params.require(:profile).permit(permitted)
  end
end
