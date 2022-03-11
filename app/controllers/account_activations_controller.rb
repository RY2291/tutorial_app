class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    # byebug
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      login(user)
      flash[:success] = "Account activated!"
      redirect_to  user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to  root_path
    end
  end
end
