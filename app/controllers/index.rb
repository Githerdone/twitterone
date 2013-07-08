get '/' do
	# if @user.tweets.empty?

	# @tweets = @user.tweets
  # @tweets = Twitter.user_timeline.first(10)
  
  erb :index
end

get '/:username' do
	@user = User.find_by_username('soezpz')
	p "*" * 80
	p @user.tweets.empty?
	if @user.tweets.empty?
		@tweets = @user.fetch_tweets!
  elsif @user.tweets_stale?
  	@tweets = @user.fetch_tweets!
  elsif !@user.tweets.empty? 
    @tweets = @user.tweets  
  end

  erb :index
end