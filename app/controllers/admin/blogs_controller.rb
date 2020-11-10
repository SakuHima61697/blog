class Admin::BlogsController < ApplicationController
    
before_action :admin_user_access, {only: [:index, :destroy]}

    layout "admin"

    #ブログ一覧
    def index
        @blogs = Post.all.order(created_at: "ASC").page(params[:page]).per(10)
    end
    
    #ブログ削除処理
    def destroy
       @blog = Post.find_by(id: params[:id])
       @blog.destroy
       flash[:alert] = "ブログを削除しました！"
       redirect_to("/admin/blogs")
    end
    
private
    #管理者アクセス制限
    def admin_user_access
      if  !@current_user || @current_user&.admin == false
        redirect_to("/blogs")
        flash[:alert] = "権限がありません！"
      end
    end
end