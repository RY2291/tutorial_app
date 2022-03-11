class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user.activated?
      login(@user)
      params[:session][:remember_me] == "1" ? remember(@user) : forget(@user)
      redirect_back_or(@user)
    else
      message = "Account not activated."
      message += "Check your email for the activation link."
      flash[:warnig] = message
      redirect_to root_path
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
