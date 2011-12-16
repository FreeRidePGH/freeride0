set :application, "freeride"
set :repository,  "git@localhost:/home/git/freeride.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

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
