class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by email: params[:session][:email].downcase
    if @user&.authenticate params[:session][:password]
      forward_url = session[:forward_url]
      reset_session
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      log_in @user
      redirect_to forward_url || @user
    else
      flash.now[:danger] = "Incorrect Email/Password combination"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
