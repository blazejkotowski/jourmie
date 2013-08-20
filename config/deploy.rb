require "bundler/capistrano"

# server "198.211.121.82", :web, :app, :db, primary: true
server "178.216.201.28", :web, :app, :db, primary: true

set :application, "jourmie"
set :user, "deployer"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:blaziko/#{application}.git"
set :branch, "master"

default_run_options[:pty] = true
default_run_options[:shell] = '/bin/bash --login'
set :nginx_server_name, false

ssh_options[:forward_agent] = true

set :stage, "production"
set :nginx_server_name, false

set(:runner) { "RAILS_ENV=#{fetch(:stage)} bundle exec" }

load 'config/recipes/base.rb'
# load 'config/recipes/whenever.rb'
load 'config/recipes/unicorn.rb'
load 'config/recipes/nginx.rb'
load 'config/recipes/postgresql.rb'


after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  desc "Create necessary directories to perform setup"
  task :create_directories do
    run "mkdir -p #{shared_path}/config"
  end  
  before "deploy:setup", "deploy:create_directories"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end
