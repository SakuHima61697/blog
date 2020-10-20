class UserController < ApplicationController
  before_action :authenticate_user, {only: [:edit, :update]}
  before_action :forbid_login_user, {only: [:new, :create, :login, :login_form]}
  before_action :ensure_correct_user, {only: [:edit, :update]}
  
  after_action :clear_flash
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new
    @user.image = "沼津写真.jpg"
    @user = User.new(name: params[:name], email: params[:email], 
    password: params[:password], password_confirmation: params[:password_confirmation], 
    image: params[:image])
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました！"
      redirect_to("/blog")
    else
      render("user/new")
    end
  end
  
  def login_form
  end


  def login
    @user = User.find_by(email: params[:email],)
    if @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました！"
      redirect_to("/blog")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("user/login_form")
    end
  end
  
  def logout
    session[:user_id] = nil
      flash[:notice] = "ログアウトしました！"
    redirect_to("/blog/login")
  end
  
  def show
    @user = User.find_by(id: params[:id])
    @posts = Post.all.page(params[:page]).per(6)
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
  
  def clear_flash
    flash[:notice] = nil
  end
  
  def ensure_correct_user
     if @current_user.id != params[:id].to_i
         flash[:notice] = "権限がありません！"
         redirect_to("/blog")
     end
  end
  
end
