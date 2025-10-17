require "debug"
class Users::SessionsController < Devise::SessionsController
  respond_to :html, :json
  skip_before_action :verify_signed_out_user

  # POST /users/sign_in
  def create
    @resource = User.find_by(email: params[:user][:email])

    if @resource&.valid_password?(params[:user][:password])
      sign_in(@resource)

      respond_to do |format|
      format.html { redirect_to root_path, notice: "Signed in successfully" }
      format.json { render :create, status: :ok }
      end
    else
      respond_to do |format|
        format.json { render json: { error: "Invalid email or password." }, status: :unauthorized }
      end
    end
  end

  # DELETE /users/sign_out
  def destroy
    if user_signed_in?
      sign_out(resource_name)
      respond_to do |format|
        format.html { redirect_to new_user_session_path, notice: "Signed out successfully." }
        format.json { render json: { message: "Logged out successfully" }, status: :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to new_user_session_path, alert: "No user signed in." }
        format.json { render json: { error: "No user signed in." }, status: :unauthorized }
      end
    end
  end
end
