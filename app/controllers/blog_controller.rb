class BlogController < ApplicationController
  
  before_action :ensure_correct_user_access, {only: [:create, :new, :update, :edit, :delete, :destroy, :newComment, :deleteComment]}
  before_action :ensure_correct_user_edit, {only: [:update, :edit, :delete, :destroy]}
  before_action :ensure_admin_access, {only: [:index, :show, :new, :create, :update, :edit, :delete, :destroy, :newComment, :deleteComment]}
  
  #ブログ一覧ページ
  def index
    @post_ransack = Post.ransack(params[:q])
    @posts = @post_ransack.result(distinct: true).page(params[:page]).per(10)
  end

  #ブログ作成ページ(エラーメッセージ取得用)
  def new
    @post = Post.new
  end

  #ブログ作成ページ
  def create
    @post = Post.new(title: params[:title], 
    genre: params[:genre],
    content: params[:content], 
    user_id: session[:user_id],
    user_name: session[:user_name])
    
    if @post.save
      flash[:notice] = "ブログを作成しました！"
      redirect_to("/blogs")
    else
      render("blog/new")
    end
  end


  #ブログ詳細
  def show
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: @post.user_id)
    #コメント表示
    @comments = Comment.where(post_id: @post.id)
    @comments = @comments.order(id: "ASC").page(params[:page]).per(10)
  end
  
  #ブログ詳細(コメント欄)
  def newComment
    @post = Post.find_by(id: params[:id])
    #コメント入力
    @comment = Comment.new(**comment_params,
    user_name: session[:user_name],
    user_id: session[:user_id],
    post_id: @post.id)
    if @comment.save
      flash[:notice] = "コメントを入力しました！"
      redirect_to("/blogs/show/#{@post.id}")
    end
  end
  
  #コメント削除
  def deleteComment
    @post = Post.find_by(id: params[:id])
    @comment = Comment.find_by(id: params[:id])
    if @comment&.user_id == @current_user.id
      @comment.destroy
      flash[:notice] = "コメントを削除しました！"
      redirect_to("/blogs/show/#{@post.id}")
    end
  end

  #ブログ更新ページ
  def update
    @post = Post.find_by(id: params[:id])
  end
  
  #ブログ更新
  def edit
    @post = Post.find_by(id: params[:id])
    
    if @post.update(post_params)
      flash[:notice] = "編集が完了しました！"
      redirect_to("/blogs")
    else
      flash[:alert] = "入力し直してください"
      render("blog/update")
    end
  end

  #ブログ削除ページ
  def delete
    @post = Post.find_by(id: params[:id])
  end
  
  #ブログ削除
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "ブログを削除しました！"
    redirect_to("/blogs")
  end
  
  private
  #ブログパラメータ(アクションテキスト絡み)
    def post_params
      params.permit(:title, :genre, :content)
    end
    
  #コメントパラメータ
    def comment_params
      params.permit(:content)
    end
    
  #ブログ編集・削除権限
    def ensure_correct_user_edit
      @post = Post&.find_by(id: params[:id])
      if @current_user.id != @post&.user_id
        flash[:alert] = "権限がありません!"
        redirect_to("/blogs")
      end
    end
    
  #ブログアクセス権限
    def ensure_correct_user_access
      if !@current_user
        flash[:alert] = "権限がありません!"
        redirect_to("/blogs")
      end
    end
    
  #ブログアクセス権限(管理者)
    def ensure_admin_access
      if @current_user&.admin == true
        flash[:alert] = "権限がありません!"
        redirect_to("/admin/index")
      end
    end
end
