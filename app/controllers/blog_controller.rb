class BlogController < ApplicationController
  
  before_action :ensure_correct_user_create, {only: [:create, :new]}
  before_action :ensure_correct_user_edit, {only: [:update, :edit, :delete, :destroy]}
  
  def index
    @posts = Post.all.page(params[:page]).per(10)
  end

  def create
    @post = Post.new
  end

  def new
    @post = Post.new(title: params[:title], 
    content: params[:content], 
    user_id: session[:user_id])
    
    @user = User.new(name: params[:name], email: params[:email], 
    password: params[:password], password_confirmation: params[:password_confirmation], 
    image: params[:image])
    @user.save
    
    if @post.save
      flash[:notice] = "ブログを作成しました！"
      redirect_to("/blog")
    else
      render("blog/create")
    end
  end


  def show
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: @post.user_id)
  end

  def update
    @post = Post.find_by(id: params[:id])
  end
  
  def edit
    @post = Post.find_by(id: params[:id])
    if @post.update(post_params)
      flash[:notice] = "編集が完了しました！"
      redirect_to("/blog")
    else
      flash[:notice] = "入力し直してください"
      render("blog/update")
    end
  end

  def delete
    @post = Post.find_by(id: params[:id])
  end
  
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "ブログを削除しました！"
    redirect_to("/blog")
  end
  
  private
    def post_params
      params.require(:post).permit(:title, :content)
    end
    
    def ensure_correct_user_edit
      @post = Post&.find_by(id: params[:id])
      if @current_user.id != @post&.user_id
        flash[:notice] = "権限がありません"
        redirect_to("/blog")
      end
    end
    
    def ensure_correct_user_create
      if @current_user
      else
        flash[:notice] = "権限がありません"
        redirect_to("/blog")
      end
    end

  
end
