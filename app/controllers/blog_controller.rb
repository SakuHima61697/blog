class BlogController < ApplicationController
  
  before_action :ensure_correct_user_create, {only: [:create, :new]}
  before_action :ensure_correct_user_edit, {only: [:update, :edit, :delete, :destroy]}
  
  #ブログ一覧
  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).page(params[:page]).per(10)
    @users = User.all
  end

  #ブログ作成ページ
  def new
    @post = Post.new
  end

  #ブログ作成
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
      flash[:notice] = "入力し直してください"
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
    
  #ブログ編集権限
    def ensure_correct_user_edit
      @post = Post&.find_by(id: params[:id])
      if @current_user.id != @post&.user_id
        flash[:notice] = "権限がありません"
        redirect_to("/blogs")
      end
    end
    
  #ブログ作成権限
    def ensure_correct_user_create
      if !@current_user
        flash[:notice] = "権限がありません"
        redirect_to("/blogs")
      end
    end
end
