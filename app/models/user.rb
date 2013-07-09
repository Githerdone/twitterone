class User < ActiveRecord::Base
  has_many :tweets

  def fetch_tweets!
    self.tweets.destroy_all
  	Twitter.user_timeline.first(10).each do |tweet|
  		self.tweets.create(tweet: tweet.text, created: tweet.user.created_at)
  	end
  	self.tweets
  end

  def tweets_stale?
    self.tweets.any? { |tweet| (Time.now - tweet.created.to_time).ceil > 15 }
  end

 
end