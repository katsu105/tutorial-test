class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      Tag.multiple_tag_save(tag_params, @post)
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
  end

  def search
    keyword = search_params
    if keyword.present?
      @posts = []
      @posts += Post.where('title LIKE(?)', "%#{keyword}%")
      @posts += Post.where('text LIKE(?)',  "%#{keyword}%")
      comments = Comment.where('text LIKE(?)', "%#{keyword}%")
      @posts += comments.map{|comment| comment.post }
    else
      @posts = Post.all
      @erros = '検索欄が空白です'
      render 'index'
    end
  end

  private

  def post_params
    params.require(:post).permit(
      :title,
      :text
      ).merge(user_id: current_user.id)
  end

  def tag_params
    params.require(:post)["tags_attributes"]["0"]["tag"].split
  end

  def search_params
    params.permit(:keyword)["keyword"]
  end
end
