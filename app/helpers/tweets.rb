helpers do
  def fresh_tweets?
  	Twitter.user_timeline.any? { |tweet| (tweet.user.created_at) < Time.now.ago(900) }
  end

  def get_fresh_tweets
  	Twitter.user_timeline.select { |tweet| (tweet.user.created_at) > Time.now.ago(900) }
  end
end
