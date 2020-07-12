class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    comment.save
    redirect_to post_path(params.permit(:post_id)["post_id"].to_i)
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :user_id, :post_id)
  end
end
