class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit]
  before_action :set_tweet, only: %i[edit update]

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.tweet = @tweet
    @comment.save
    redirect_to @tweet
  end

  def edit; end

  def update
    @comment = @tweet.comments.find(params[:id])
    if @comment.update(comment_params)
      redirect_to @tweet
    else
      render :edit
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end
end
