class UserController < ApplicationController
  before_action :authenticate_user, {only: [:edit, :update]}
  before_action :forbid_login_user, {only: [:new, :create, :login, :login_form]}
  before_action :ensure_correct_user, {only: [:edit, :update]}
  
  #ユーザー作成
  def new
    @user = User.new
  end
  
  #ユーザー作成
  def create
    @user = User.new
    @user.image = "default.jpg"
    @user = User.new(name: params[:name], email: params[:email], 
    password: params[:password], password_confirmation: params[:password_confirmation], 
    image: params[:image])
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました！"
      redirect_to("/blogs")
    else
      render("user/new")
    end
  end
  
  #ログイン
  def login_form
  end

  #ログイン
  def login
    @user = User.find_by(email: params[:email],)
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました！"
      redirect_to("/blogs")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("user/login_form")
    end
  end
  
  #ログアウト
  def logout
    session[:user_id] = nil
      flash[:notice] = "ログアウトしました！"
    redirect_to("/blogs/login")
  end
  
  #ユーザー詳細
  def show
    @user = User.find_by(id: params[:id])
    @posts = Post.all.page(params[:page]).per(5)
  end
  
  #ユーザー編集
  def edit
    @user = User.find_by(id: params[:id])
  end
  
  #ユーザー編集
  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    @user.url = params[:url]
    @user.content = params[:content]
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]
    @user.image = params[:image]
    
    if @user.save
      flash[:notice] = "ユーザー情報を更新しました！"
      redirect_to("/blogs/user/#{@user.id}")
    else
      render("user/edit")
    end
  end
  
  #ユーザー一覧
  def index
    @users = User.all.page(params[:page]).per(10)
  end
  
  #ユーザー権限
  def ensure_correct_user
     if @current_user.id != params[:id].to_i
         flash[:notice] = "権限がありません！"
         redirect_to("/blogs")
     end
  end
  
end
