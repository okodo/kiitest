class UsersController < ApplicationController

  before_filter :authenticate_user!

  def update
    current_user.update_attributes(filtered_params)
    render json: current_user.reload, serializer: UserSerializer
  end

  private

  def filtered_params
    params.require(:user).permit(:fullname, :email, :password, :password_confirmation)
  end

end
