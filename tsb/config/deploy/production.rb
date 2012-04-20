task :production do
  set :branch, :master
  set :stage, "production"
  set :user, "deployer"
  set :runner, "deployer"
  set :domain, "50.57.147.73"
  set :rails_env, "production"
  set :port, 22
  role :web, domain
  role :app, *%w(50.57.147.73 50.57.147.107 50.57.148.175)
  role :db, domain, :primary => true
  role :crontab_host, "50.57.147.73"
end
