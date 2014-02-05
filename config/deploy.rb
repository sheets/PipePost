require 'bundler/capistrano'
require "rvm/capistrano"
server "162.243.146.200", :web, :app, :db, primary: true
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :application, 'pipepost'
set :user, 'root'
set :deploy_to, "/home/rails"
set :deploy_via, :remote_cache
set :use_sudo, false
set :rails_env, "production"
set :rvm_ruby_string, 'ruby-1.9.3-p429@global'
set :rvm_bin_path,'/usr/local/rvm/bin'
set :rvm_path,'/usr/local/rvm'
# set :stages, %w[staging production] 
# set :default_stage, 'production'

set :bundle_without, [:development, :test]

set :scm, :git
set :repository,  "git@github.com:sheets/PipePost.git"
set :branch, "staging"
set :scm_verbose, true
set :git_shallow_clone, 1
set :git_enable_submodules, 1
# set :scm_command, "/opt/local/bin/git"
# set :local_scm_command, "git"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids  tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 10
# namespace :bundle do
#   task :install do
#     run "bundle install"
#   end 
# end
# before 'deploy:assets:precompile','bundle:install'
before 'deploy:assets:precompile', 'create_symlink:database_yml'
after 'deploy:restart','unicorn:restart'
after "deploy", "deploy:cleanup" 
namespace :create_symlink do
  task :database_yml do
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
  end
end
# namespace :bundle do
#   task :install do
#     run "cd #{current_path} && RAILS_ENV=production bundle install"
#   end
# end
namespace :deploy do
  
  namespace :assets do

    task :precompile, :roles => :web do
      from = source.next_revision(current_revision)
      if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ lib/assets/ app/assets/ | wc -l").to_i > 0
        # run_locally("rake assets:clean && rake assets:precompile")
        # run_locally "cd public && tar -jcf assets.tar.bz2 assets"
        # run "cd #{shared_path} && rm assets.tar.bz2"
        top.upload "public/assets.tar.bz2", "#{shared_path}", :via => :scp
        run "cd #{shared_path} && tar -jxf assets.tar.bz2 && rm assets.tar.bz2"
        run_locally "rm public/assets.tar.bz2"
        run_locally("rake assets:clean")  
      else
        logger.info "Skipping asset precompilation because there were no asset changes"
      end
    end

    # task :symlink, roles: :web do
    #   run ("rm -rf #{latest_release}/public/assets &&
    #         mkdir -p #{latest_release}/public &&
    #         mkdir -p #{shared_path}/assets &&
    #         ln -s #{shared_path}/assets #{latest_release}/public/assets")
    # end
  end


  desc 'Restart application'
  task :restart do
   
  end

  after :finishing, 'deploy:cleanup'

end

namespace :unicorn do
  desc 'stop unicorn'
  task :stop do
    run "/etc/init.d/unicorn stop"
    run "cd #{current_path}/tmp && rm -rf pids"
  end
  task :start do
    run "cd #{current_path} && RAILS_ENV=production bundle exec unicorn_rails -c /home/unicorn/unicorn.conf -D"
  end

  task :restart do
    run "/etc/init.d/unicorn stop"
    run "cd #{current_path}/tmp && rm -rf pids"
    run "cd #{current_path} && RAILS_ENV=production bundle exec unicorn_rails -c /home/unicorn/unicorn.conf -D"
  end


end
