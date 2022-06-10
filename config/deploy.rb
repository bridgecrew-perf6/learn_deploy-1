# config valid for current version and patch releases of Capistrano
lock "~> 3.17.0"

set :application, "trackerr"
set :repo_url, "git@github.com:nguyensiviet1999/learn_deploy.git"
set :ssh_options, { 
  forward_agent: true, 
  auth_methods: %w[publickey],
  keys: %w[/home/viet/.ssh/test_deploy.pub]
}


set :user, 'ubuntu'

set :pty,             true
set :use_sudo,        true
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/var/www/#{fetch(:application)}"
set :branch, 'master'

append :linked_files, "config/master.key", "config/database.yml", "config/application.yml"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "public/uploads", "tmp/sockets", "vendor/bundle", "public/system", "public/uploads", "storage"

namespace :deploy do
  task :puma_restart do
    invoke 'puma:config'
    invoke 'puma:stop'
    invoke 'puma:start' 
  end

  after :publishing, :restart
  after :finished, :cleanup
  after :finished, :puma_restart
end
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
