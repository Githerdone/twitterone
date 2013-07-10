helpers do

	def current_user?
		!session[:id].empty?
	end
	
  def set_current_user(useranme)
    @user = User.find_by_username(username)
  end
  

  def repeat_tweet?(tweets_new)
    tweets_new.each do |tweet|
      tweets_new.delete(tweet) if Tweet.find_by_tweet(tweet.text)
    end
    @tweets_new
  end

  def get_fresh_tweets
  	Twitter.user_timeline.select { |tweet| tweet if tweet.created_at > Time.now.ago(900) }
  end
end
