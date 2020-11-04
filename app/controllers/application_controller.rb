class ApplicationController < ActionController::Base
    before_action :set_current_user
    before_action :admin_user

  #現在のユーザー
    def set_current_user
       @current_user = User.find_by(id: session[:user_id])
    end

  #ログイン確認
    def authenticate_user
       if @current_user == nil
          flash[:alert] = "ログインが必要です！"
          redirect_to("/blogs/login")
       end
    end
    
  #ログイン済み確認
    def forbid_login_user
        if @current_user
            flash[:alert] = "既にログインしています！"
            redirect_to("/blogs")
        end
    end
    
    #管理者ユーザー
    def admin_user
       @admin_user = User.find_by(name: "管理者")
    end
end
