# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :html, :json

  # POST /users/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    @resource = resource

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Signed in successfully" }
      format.json { render :create, status: :ok }
    end
  end

  # DELETE /users/sign_out
  def destroy
    sign_out(resource_name)
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Signed out successfully." }
      format.json { head :no_content }
    end
  end

  private

  def respond_to_on_destroy
    respond_to do |format|
      format.html { redirect_to new_session_path(resource_name) }
      format.json { render json: { message: "Already signed out or session not found" }, status: :unauthorized }
    end
  end
end
