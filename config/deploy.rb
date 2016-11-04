lock '3.6.1'

set :application, 'evemonk'
set :repo_url, 'git@github.com:biow0lf/evemonk.git'

set :rbenv_type, :user
set :rbenv_ruby, File.read('.ruby-version').strip

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
end
