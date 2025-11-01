class ProfilesController < ApplicationController
  respond_to :html, :json

  before_action :authenticate_user!
  before_action :set_profile
  before_action :authorize_profile!, only: [ :edit, :update ]

  def show
    respond_with(@profile)
  end

  def edit
    respond_with(@profile)
  end

  def update
    if @profile.update(profile_params)
      respond_with(@profile, notice: "Profile updated successfully.")
    else
      respond_with(@profile) do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: { errors: @profile.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def authorize_profile!
    redirect_to profile_path(@profile), alert: "Not authorized" unless @profile.user == current_user
  end

  def profile_params
    permitted = [ :first_name, :last_name, :headline, :location, :photo, :company_name, :contact ]
    permitted << :resume if current_user.applicant?
    params.require(:profile).permit(permitted)
  end
end
