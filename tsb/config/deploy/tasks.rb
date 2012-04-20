task :disable_web, :roles => :app do
  run "ln -nfs #{shared_path}/system/maintenance.html #{current_path}/public/maintenance.html"
end
task :enable_web, :roles => :app do
  run "rm #{current_path}/public/maintenance.html"
end

## tails log on all members of the cluster
desc 'tails the log'
task :tail_logs, :roles => :app do
  run "tail -f #{shared_path}/log/#{rails_env.downcase}.log" do |channel, stream, data|
    puts  # for an extra line break before the host name
    puts "#{channel[:host]}: #{data}"
    break if stream == :err
  end
end

## remote console
desc "remote console"
task :console, :roles => :console_host do
  input = ''
  run "cd #{current_path} && ./script/console #{rails_env}" do |channel, stream, data|
    next if data.chomp == input.chomp || data.chomp == ''
    print data
    channel.send_data(input = $stdin.gets) if data =~ /^(>|\?)>/
  end
end

namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
end

task :copy_config_files, :roles => :app do
  run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
end

after "deploy:restart", "deploy:cleanup"
after "deploy:update_code", :copy_config_files
