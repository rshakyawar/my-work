require 'bundler/capistrano'

load "config/deploy/production.rb"

load "config/deploy/staging.rb"

load "config/deploy/settings.rb"

load "config/deploy/tasks.rb"

load "config/deploy/notifications.rb"

require 'hoptoad_notifier/capistrano'

require './config/boot'
require 'airbrake/capistrano'
