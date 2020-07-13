class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to post_path(post_params)
    else
      @post = Post.find(post_params)
      @comments = @post.comments
      render "posts/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :user_id, :post_id)
  end

  def post_params
    params.permit(:post_id)["post_id"].to_i
  end
end
