require 'bundler/capistrano'

$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'rvm/capistrano'
set :rvm_ruby_string, '1.9.2'

# set :rvm_bin_path, "/usr/local/bin"

set :application, "eforogt"
set :user, "ubuntu"
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")]

set :applicationdir, "/home/ubuntu/public_html/#{application}"
set :deploy_to, "/home/ubuntu/public_html/#{application}"

set :repository,  "git@github.com:jalvarezsamayoa/EForoGt.git"

set :scm, :git
set :deploy_via, :remote_cache
set :use_sudo, false
set :branch, "master"
set :deploy_env, 'production'
set :rails_env, "production"

set :location, "ec2-184-72-81-42.compute-1.amazonaws.com"

role :web, location
role :app, location
role :db,  location, :primary => true

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
