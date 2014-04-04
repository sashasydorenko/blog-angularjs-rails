class SessionsController < Devise::SessionsController
  respond_to :json

  def create
    user = User.find_for_database_authentication(email: params[:user][:email])
    if user && user.valid_password?(params[:user][:password])
      scope = Devise::Mapping.find_scope!(:user)
      sign_in(scope, user)
      render json: { success: true,
                     user: user }
    else
      render json: { success: false,
                     errors: 'Invalid email or password' },
                     status: 401
    end
  end

  def destroy
    redirect_path = after_sign_out_path_for(resource_name)
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message(:notice, :signed_out)

    render json: { status: :success }
  end
end
