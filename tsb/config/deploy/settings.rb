set :application, "thestashbox"
set :deploy_to, "/var/www/apps/thestashbox.com"
default_run_options[:pty] = true
set :use_sudo, false
set :ssh_options, { :forward_agent => true }
ssh_options[:keys]
set :keep_releases, 5
set :scm, :git
set :scm_verbose, true
set :repository, "git@github.com:TSB/tsb.git"
set :scm_username, "deployer"
#set :git_enable_submodules, :true
#set :deploy_via, :remote_cache
set :migrate_target, 'current'
