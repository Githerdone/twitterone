get '/' do
  erb :index
end

get '/:username' do
	@user = User.find_or_create_by_username(params[:username])  
  session[:id] = @user.id
  @tweets = @user.tweets.order("created_at DESC").limit(10)
  erb :index
end

post '/update_tweets' do
  user = User.find(session[:id])
  content_type :json
  user.fetch_tweets!.to_json
end

post '/post_tweet' do
  Twitter.update(params[:comments])
  content_type :json
  {key: 'tweet_posted'}.to_json
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  # our request token is only valid until we use it to get an access token, so let's delete it from our session
  session.delete(:request_token)

  # at this point in the code is where you'll need to create your user account and store the access token

  erb :index
  
end
