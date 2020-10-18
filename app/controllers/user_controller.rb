class UserController < ApplicationController
  before_action :authenticate_user, {only: [:edit, :update]}
  before_action :forbid_login_user, {only: [:new, :create, :login,]}
  before_action :ensure_correct_user, {only: [:edit, :update]}
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(name: params[:name], email: params[:email], 
    password: params[:password], password_confirmation: params[:password_confirmation], 
    image: params[:image])
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました！"
      redirect_to("/blog/index")
    else
      render :new
    end
  end


  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました！"
      redirect_to("/blog/index")
    else
      render("user/login")
    end
  end
  
  def logout
    session[:user_id] = nil
      flash[:notice] = "ログアウトしました！"
    redirect_to("/blog/login")
  end
  
  def show
    @user = User.find_by(id: params[:id])
  end
  
  def edit
    @user = User.find_by(id: params[:id])
  end
  
  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]
    @user.image = params[:image]
    
    if @user.save
      flash[:notice] = "ユーザー情報を更新しました！"
      redirect_to("/blog/user/#{@user.id}")
    else
      render("user/edit")
    end
  end
  
  def index
    @users = User.all
  end
  
end
