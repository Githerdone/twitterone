before do

  if authenticated?
    Twitter.configure do |config|
      config.consumer_key = ENV['TWITTER_KEY']
      config.consumer_secret = ENV['TWITTER_SECRET']
      config.oauth_token = current_user.oauth_token
      config.oauth_token_secret = current_user.oauth_secret
    end
  end

end

get '/' do
  erb :index
end

# post '/update_tweets' do

#   user = User.find(session[:id])
#   content_type :json
#   user.fetch_tweets!.to_json
# end

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

# require 'debugger'

# oauth_token=euyc2Xnj7avYwpo2mdmmh6RsMWM4Ylon099FLeLrg&
# oauth_verifier=eG9jk9VV3OdwDDQklvSSdcon0hZ0VdWhFP917wxsEY
get '/auth' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])

  # debugger

  access_token.params
  # {:oauth_token=>"1077873978-b6h0yqcS83AMpUCJRWLWLHkLo79JBQantOMOVJ7", 
  #  "oauth_token"=>"1077873978-b6h0yqcS83AMpUCJRWLWLHkLo79JBQantOMOVJ7", 
  #  :oauth_token_secret=>"mD90EOEFGhHtdo8w6erpmKKuWgjwFciR7ypTYEMDUoI", 
  #  "oauth_token_secret"=>"mD90EOEFGhHtdo8w6erpmKKuWgjwFciR7ypTYEMDUoI", 
  #  :user_id=>"1077873978", 
  #  "user_id"=>"1077873978", 
  #  :screen_name=>"SoEzPz", 
  #  "screen_name"=>"SoEzPz"}

  # our request token is only valid until we use it to get an access token, so let's delete it from our session
  session.delete(:request_token)

  user = User.find_or_create_by_username(access_token.params[:screen_name])  
  user.oauth_token  = access_token.params[:oauth_token]
  user.oauth_secret = access_token.params[:oauth_token_secret]
  user.save!

  # session[:id] = user.id
  self.current_user = user

  # at this point in the code is where you'll need to create your user account and store the access token

  redirect to("/#{user.username}")
  
end

get '/:username' do
  @user = User.find_or_create_by(username: params[:username])
  @tweets = @user.tweets.order("created_at DESC").limit(10)
  erb :index
end

post '/:username/tweets' do
  user = User.find_by_username(params[:username])
  # p '#' * 90
  # variable = user.fetch_tweets!
  # p variable
  tweets = user.fetch_tweets!
  content_type :json
  tweets.to_json
end

