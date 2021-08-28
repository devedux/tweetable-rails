class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit]
  before_action :set_tweet, only: %i[edit update destroy create]

  def create
    @comment = @tweet.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @tweet, notice: 'Comment was successfully created.'
    else
      render @tweet
    end
  end

  def edit; end

  def update
    @comment = @tweet.comments.find(params[:id])
    if @comment.update(comment_params)
      redirect_to @tweet, notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @comment = @tweet.comments.destroy(params[:id])
    redirect_to @tweet, notice: 'Comment was successfully destroyed.'
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
