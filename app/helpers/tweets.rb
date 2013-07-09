helpers do

	def current_user?
		!session[:id].empty?
	end
	
  def fresh_tweets?
  	Twitter.user_timeline.any? { |tweet| tweet.created_at < Time.now.ago(900) }
  end

  def get_fresh_tweets
  	Twitter.user_timeline.select { |tweet| tweet if tweet.created_at > Time.now.ago(900) }
  end
end
