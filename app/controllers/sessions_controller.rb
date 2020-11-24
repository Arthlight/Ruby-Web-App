class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by email: params[:session][:email].downcase
    if @user&.authenticate params[:session][:password]
      if @user.activated?
        forward_url = session[:forward_url]
        reset_session
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        log_in @user
        redirect_to forward_url || @user
      else
        message = "Account not activated, check your email for the activation link"
        flash[:warning] = message
        redirect_to root_url
      end
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
