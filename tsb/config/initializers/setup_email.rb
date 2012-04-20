ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.smtp_settings = {
  :address => "smtp.sendgrid.net",
  :port => "587",
  :domain => "thestashbox.com",
  :authentication => :plain,
  :user_name => "sherif@thestashbox.com",
  :password => "tsbtsb61"
}
