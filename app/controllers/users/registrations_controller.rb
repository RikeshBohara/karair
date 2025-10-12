class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :html, :json

  # POST /users
  def create
    build_resource(sign_up_params)

    respond_to do |format|
      if resource.save
        sign_up(resource_name, resource)

        format.html { redirect_to after_sign_up_path_for(resource), notice: "Signed up successfully" }
        format.json { render :show, status: :created }
      else
        clean_up_passwords resource
        set_minimum_password_length

        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: resource.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Strong params for Devise sign-up
  def sign_up_params
    params.require(:users).permit(:email, :password, :password_confirmation)
  end
end
