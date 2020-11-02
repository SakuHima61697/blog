class UserController < ApplicationController
  before_action :authenticate_user, {only: [:edit, :update, :delete, :destroy]}
  before_action :forbid_login_user, {only: [:new, :create, :login, :login_form]}
  before_action :ensure_correct_user, {only: [:edit, :update, :delete, :destroy]}
  
  #ユーザー作成(エラーメッセージ取得用)
  def new
    @user = User.new
  end
  
  #ユーザー作成処理
  def create
    @user = User.new
    @user.image = "default.jpg"
    
    @user = User.new(name: params[:name], email: params[:email], 
    url: params[:url], content: params[:content],
    password: params[:password], password_confirmation: params[:password_confirmation], 
    image: params[:image])
    
    if @user.save
      session[:user_id] = @user.id
      session[:user_name] = @user.name
      flash[:notice] = "ユーザー登録が完了しました！"
      redirect_to("/blogs")
    else
      render("user/new")
    end
  end
  
  #ログイン
  def login_form
  end

  #ログイン処理
  def login
    @user = User.find_by(email: params[:email],)
    
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      session[:user_name] = @user.name
      
      flash[:notice] = "ログインしました！"
      redirect_to("/blogs")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("user/login_form")
    end
  end
  
  #ログアウト処理
  def logout
    session[:user_id] = nil
    session[:user_name] = nil
      flash[:notice] = "ログアウトしました！"
    redirect_to("/blogs/login")
  end
  
  #ユーザー一覧
  def index
    @users = User.all.page(params[:page]).per(5)
  end
  
  #ユーザー詳細
  def show
    @user = User.find_by(id: params[:id])
    @posts = Post.where(user_id: @user.id).page(params[:page]).per(5)
  end
  
  #ユーザー編集(ユーザー情報表示)
  def edit
    @user = User.find_by(id: params[:id])
  end
  
  #ユーザー編集処理
  def update
    @user = User.find_by(id: params[:id])
    @posts = Post.where(user_id: session[:user_id])
    
    if @user.update(user_params)
      if @posts
        @posts.update_all(user_name: @user.name)
      end
      flash[:notice] = "ユーザー情報を更新しました！"
      redirect_to("/blogs/user/#{@user.id}")
    else
      render("user/edit")
    end
  end
  
  #ユーザー削除(ユーザー情報表示)
  def delete
    @user = User.find_by(id: params[:id])
    @posts = Post.where(user_id: @user.id).page(params[:page]).per(5)
  end
  
  #ユーザー削除処理
  def destroy
    @user = User.find_by(id: params[:id])
    @posts = Post.where(user_id: session[:user_id])
    
    @posts.destroy_all
    @user.destroy
    
    session[:user_id] = nil
    session[:user_name] = nil
    
    flash[:alert] = "ユーザーを削除しました！"
    redirect_to("/blogs")
  end
  
  
  private
  #ユーザー権限
  def ensure_correct_user
     if @current_user.id != params[:id].to_i
         flash[:alert] = "権限がありません！"
         redirect_to("/blogs")
     end
  end
  
  #ユーザーパラメータ
  def user_params
    params.permit(:name, :email, :url, :content, :password, :password_confirmation, :image)
  end
  
end
