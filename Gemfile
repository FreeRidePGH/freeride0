source 'http://rubygems.org'

gem 'rails', '3.1.0'


# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'


gem 'passenger'

gem 'therubyracer'
gem 'will_paginate'
gem 'paperclip'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :production do
  # Use PostgreSQL for Heroku deployment
  gem 'pg'

  # Use MySQL as the database
  # gem 'ruby-mysql'
  # gem 'mysql2'
end


group :development do
  gem 'sqlite3' 
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'sqlite3' 
end
