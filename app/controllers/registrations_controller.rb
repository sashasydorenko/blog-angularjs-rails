class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  skip_before_filter :require_no_authentication, only: :create

  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: :created, location: user
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.fetch(:user, {}).permit(:email, :password, :password_confirmation)
  end
end
