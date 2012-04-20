# Deployment email notifications
require 'cap_gun'
set :cap_gun_action_mailer_config, {
  :address => "smtp.gmail.com",
  :port => 587,
  :user_name => "techsvcs@thestashbox.com",
  :password => "st4shbox",
  :authentication => :plain
}

set :cap_gun_email_envelope, {
  :from => "techsvcs@thestashbox.com",
  :recipients => %w[ryan@thestashbox.com sherif@thestashbox.com taylor@thestashbox.com]
}
#after "deploy:restart", "cap_gun:email"
