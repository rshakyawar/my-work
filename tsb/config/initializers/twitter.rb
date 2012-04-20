Twitter.configure do |config|
  config.consumer_key = Settings.twitter_consumer_key
  config.consumer_secret = Settings.twitter_consumer_secret
  config.oauth_token = Settings.twitter_oauth_token
  config.oauth_token_secret = Settings.twitter_oauth_token_secret
end
