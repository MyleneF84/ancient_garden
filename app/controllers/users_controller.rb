class UsersController < ApplicationController
  def profile
  end

  def update
    if current_user.update(user_params)
      redirect_to profile_path
    else
      render json: { errors: current_user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:address, :avatar)
  end
end
