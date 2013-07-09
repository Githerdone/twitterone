get '/' do
	# if @user.tweets.empty?

	# @tweets = @user.tweets
  # @tweets = Twitter.user_timeline.first(10)
  
  erb :index
end

get '/:username' do
	@user = User.find_by_username('soezpz')
	if @user.tweets.empty?
		@tweets = @user.fetch_tweets!
  elsif @user.tweets_stale?
  	@tweets = @user.fetch_tweets!
  elsif !@user.tweets.empty? 
    @tweets = @user.tweets  
  end

  erb :index
end

post '/update_tweets' do
	
  if fresh_tweets?
  	@tweets_new = get_fresh_tweets
  	p @tweets_new[0]
  end
  
  @tweets_new
  # 
end