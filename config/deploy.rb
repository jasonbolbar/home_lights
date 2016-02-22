# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'home_lights'
set :deploy_to, '/home/pi/home_lights'
set :repo_url, 'git@github.com:jasonbolbar/home_lights.git'
set :rvm_ruby_version, '2.1.2@home_lights'
set :bundle_path, nil
set :bundle_binstubs, nil
set :bundle_flags, '--system'
set :log_level, :info
set :linked_files, fetch(:linked_files, []).push('config/secrets.yml')
set :keep_releases, 3
set :pty, true

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      on roles(:app), in: :sequence, wait: 1 do
        execute :sudo, "service apache2 restart"
      end
    end
  end

end
