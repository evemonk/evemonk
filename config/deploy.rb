# frozen_string_literal: true

lock '3.10.1'

set :application, 'evemonk'
set :repo_url, 'git@github.com:biow0lf/evemonk.git'

set :rbenv_type, :user
set :rbenv_ruby, File.read('.ruby-version').strip

set :linked_files, ['config/database.yml', 'config/newrelic.yml', '.env']
set :linked_dirs, ['bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/assets']
set :config_files, ['database.yml']

set :deploy_to, '/home/evemonkapp/www'

set :keep_releases, 2

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'systemd:restart'
end
