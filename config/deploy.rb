require 'mongrel_cluster/recipes'

set :application, "freeride"
set :repository,  "git@freeride.andrew.cmu.edu:/home/git/freeride.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :use_sudo, false

set :default_environment, {
  'PATH' => "/usr/local/rvm/gems/ruby-1.9.2-p290/bin:/usr/local/rvm/gems/ruby-1.9.2-p290@global/bin:/usr/local/rvm/rubies/ruby-1.9.2-p290/bin:/usr/local/rvm/bin:$PATH",
  'RUBY_VERSION' => 'ruby-1.9.2-p290',
  'GEM_HOME'     => '/usr/local/rvm/gems/ruby-1.9.2-p290',
  'GEM_PATH'     => '/usr/local/rvm/gems/ruby-1.9.2-p290:/usr/local/rvm/gems/ruby-1.9.2-p290@global',
  'BUNDLE_PATH'  => '/usr/local/rvm/gems/ruby-1.9.2-p290'  # If you are using bundler.
}


role :web, "freeride.andrew.cmu.edu"                          # Your HTTP server, Apache/etc
role :app, "freeride.andrew.cmu.edu"                          # This may be the same as your `Web` server
role :db,  "freeride.andrew.cmu.edu", :primary => true # This is where Rails migrations will run
# role :db,  "freeride.andrew.cmu.edu"

default_run_options[:pty] = true

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
