class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.save

    Tag.multiple_tag_save(tag_params, post)
    redirect_to root_path
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
  end

  private

  def post_params
    params.require(:post).permit(
      :title,
      :text
      # tags_attributes: [:tag]
      ).merge(user_id: current_user.id)
  end

  def tag_params
    params.require(:post)["tags_attributes"]["0"]["tag"].split
  end
end
