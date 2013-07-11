class User < ActiveRecord::Base
  has_many :tweets

  def fetch_tweets!
    tweets = remove_already_tweeted(tweets_from_twitter)
  	tweets.map do |tweet|
  		self.tweets.create(tweet: tweet.text, created: tweet.created_at)
  	end
  end

  def remove_already_tweeted(tweets)
    tweets.reject do |repeat|
      self.tweets.find_by_tweet(repeat.text)
    end
  end

  def tweets_from_twitter
    Twitter.user_timeline
  end
end
