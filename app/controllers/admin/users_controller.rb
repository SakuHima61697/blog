class Admin::UsersController < ApplicationController

before_action :admin_user_access, {only: [:index, :destroy]}    

  #ログイン処理
  def login
    @user = User.find_by(email: params[:email],)
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      session[:admin] = @user.admin
      flash[:notice] = "ログインしました！"
      redirect_to("/admin")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end
  
  #ログアウト処理
  def logout
    session[:user_id] = nil
    session[:admin] = nil
      flash[:notice] = "ログアウトしました！"
    redirect_to("/admin/login")
  end
  
  #ユーザー一覧
  def index
    @users = User.all.order(created_at: "ASC").page(params[:page]).per(5)
  end
  
  #ユーザー削除
  def destroy
    @user = User.find_by(id: params[:id])
    @posts = Post.where(user_id: @user.id)
    @posts.destroy_all
    @user.destroy
    flash[:alert] = "ユーザーを削除しました！"
    redirect_to("/admin")
  end
  
  private
    def admin_user_access
      flash[:alert] = "権限がありません！"
      redirect_to("/blogs") unless @current_user.admin?
    end
  
end
