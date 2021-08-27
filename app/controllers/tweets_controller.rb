class TweetsController < ApplicationController
  def index
    @tweet = Tweet.new
    @tweets = Tweet.all
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
end
