class BlogController < ApplicationController
  
  before_action :ensure_correct_user, {only: [:create, :new, :update, :delete]}
  
  def index
    @posts = Post.all
  end

  def create
    @post = Post.new
  end

  def new
    @post = Post.new(title: params[:title], content: params[:content])
    @post.user_id = @current_user.id
    if @post.save!
      flash[:notice] = "ブログを作成しました！"
      redirect_to("/blog/index")
    else
      render("blog/create")
    end
  end


  def show
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
  end
  
  def edit
    @post = Post.find_by(id: params[:id])
    @post.title = params[:title]
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "編集が完了しました！"
      redirect_to("/blog/index")
    else
      flash[:notice] = "入力し直してください"
      render("blog/update")
    end
  end

  def delete
    @post = Post.find_by(id: params[:id])
    if @post.try(:user_id) == @current_user.id
      
    end
  end
  
  private
    def post_params
      params.require(:post).permit(:title, :content)
    end
    
    def ensure_correct_user
      @post = Post&.find_by(id: params[:id])
      if @post.try(:user_id) != @current_user.id
        flash[:notice] = "権限がありません"
        redirect_to("/blog/index")
      end
    end

  
end
