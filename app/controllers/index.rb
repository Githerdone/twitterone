get '/' do
	# if @user.tweets.empty?

	# @tweets = @user.tweets
  # @tweets = Twitter.user_timeline.first(10)
  
  erb :index
end

get '/:username' do
	@user = User.find_by_username('soezpz')
  if @user
    session[:id] = @user.id
  end
  if @user.tweets.empty? 
	  @tweets = @user.fetch_tweets!
  elsif !@user.tweets.empty? 
    @tweets = @user.tweets  
  end
  erb :index
end

post '/update_tweets' do
  array = []
	

  if fresh_tweets?
  	@tweets_new = get_fresh_tweets
    @tweets_new = repeat_tweet?(@tweets_new)
    if @tweets_new
      @tweets_new.length.times do |tweet|
        @user.tweets.destroy.first
      end
      @tweets_new.each do |tweet|
        @user.tweets.create(tweet: tweet.text, created: tweet.created_at)
        array << {tweet: tweet.text, created: tweet.created_at}
      end
    end
  end
  content_type :json
  array.to_json
end

post '/post_tweet' do

  Twitter.update(params[:comments])
  content_type :json
  {key: 'tweet_posted'}.to_json
end
