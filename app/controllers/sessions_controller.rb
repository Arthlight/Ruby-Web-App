class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      # log in the user
    else
      flash.now[:danger] = "Incorrect Email/Password combination"
      render 'new'
    end
  end

  def destroy
  end
end
