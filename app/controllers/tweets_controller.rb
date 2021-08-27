class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[show edit update]

  def index
    @tweet = Tweet.new
    @tweets = Tweet.all
  end

  def edit; end

  def update
    if @tweet.update(tweet_params)
      redirect_to @tweet
    else
      render :edit
    end
  end

  def show
    @comment = Comment.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    return render :index unless @tweet.save

    redirect_to :root
  end

  private

  def tweet_params
    params.require(:tweet).permit(:body)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
