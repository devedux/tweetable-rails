class CommentsController < ApplicationController
  def create
    @tweet = Tweet.find(params[:tweet_id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.tweet = @tweet
    @comment.save
    redirect_to @tweet
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
