class UserController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_name: params[:user_name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect_to("/blog/index")
    else
      render :new
    end
  end


  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to("/blog/index")
    else
      render("user/login")
    end
  end
  
  def logout
    session[:user_id] = nil
    redirect_to("/blog/login")
  end
  
  
end
