require 'json'

puts "Start destroy all tables"
Authentication.destroy_all
User.destroy_all
Tweet.destroy_all
puts "Finish destroy all tables"


def json_parse data
  JSON.parse(data, symbolize_names: true)
end

def load_data name
  File.read("./db/data/#{name}.json")
end

def file_open(name)
  File.open("app/assets/images/#{name}.png")
end

def formatted_user(user)
  user.slice(:email, :username, :name, :password)
end

def formatted_tweet(tweet, user)
  { body: tweet[:body], user: user }
end

def formatted_comment(tweet, user)
  { tweet: tweet, user: user, body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque interdum rutrum sodales. Nullam mattis fermentum libero, non volutpat." }
end


def create_avatar_user(user, name)
  user.avatar.attach(io: file_open(name), filename: "#{name}.png")
end

def create_user(user, avatar_name)
  new_user = User.new(user)
  create_avatar_user(new_user, avatar_name) if avatar_name
  return new_user if new_user.save

  puts "#{new_user.username} not created. Errors: #{new_user.errors.full_messages}"
end

def create_tweet(tweet, user)
  new_tweet = Tweet.new(tweet)
  return new_tweet if new_tweet.save

  puts "#{new_tweet.id} not created of #{user.username}. Errors: #{new_tweet.errors.full_messages}"
end


def create_comment(tweet)
  new_comment = Comment.new(tweet)
  return new_comment if new_comment.save

  puts "#{new_comment.id} not created. Errors: #{new_comment.errors.full_messages}"
end

def create_each_user(users)
  users.each do |user|
    new_user = create_user formatted_user(user), user[:avatar]

    tweets_parsed = json_parse load_data('tweets')
    create_each_tweets(tweets_parsed, new_user)
  end
end

def create_each_tweets(tweets, user)
  tweets.each do |tweet|
    if tweet[:user] == user.username      
      new_tweet = create_tweet(formatted_tweet(tweet, user), user)
      users_parsed = json_parse load_data('users')
      user_commented = User.find_by(username: users_parsed.sample[:username])
      create_comment(formatted_comment(new_tweet, user_commented)) if user_commented
    end
  end
end

puts "Start seeding Tweeteable"
users_parsed = json_parse load_data('users')
create_each_user users_parsed
puts "Finish seeding Tweeteable"