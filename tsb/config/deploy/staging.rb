task :staging do
  set :branch, :staging
  set :stage, "staging"
  set :user, "deployer"
  set :runner, "deployer"
  set :domain, "50.57.132.233"
  set :rails_env, "staging"
  set :port, 22
  role :web, domain
  role :app, "50.57.132.233"
  role :db, domain, :primary => true
  role :crontab_host, "50.57.132.233"
end
