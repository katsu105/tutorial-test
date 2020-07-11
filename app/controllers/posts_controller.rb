class PostsController < ApplicationController
  def index
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.save
    redirect_to root_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :text).merge(user_id: current_user.id)
  end
end
